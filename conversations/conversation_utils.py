# -*- coding: iso8859-15 -*-
import pdb
import pprint
import copy
import os,sys
import pymongo
import time
import re
from dateutil import tz
from datetime import datetime,timedelta
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import get_scoped_session,Base,metadata,DBSession
from config.settings import (ENV_TYPE,LOGIN_DISABLED,
    DEFAULT_TEST_USER_ID,SUPERUSER_ANNOUNCER_ID,MONGO_HOST,MONGO_PORT,
    MONGO_DBNAME_ES_CONVERSATION,MONGO_ES_CONVERSATION_ADDINDEX_COLLNAME,
    ESEARCH_INDEXED_APPS)

from flask import Response, json, jsonify, make_response, url_for, abort
from flask import  current_app, request, redirect, render_template
from flask.views import View, MethodView
from flask_sqlalchemy import SQLAlchemy
import sqlalchemy
from sqlalchemy import desc
from sqlalchemy.sql.expression import func, or_, not_, and_
from sqlalchemy.orm import sessionmaker 
from sqlalchemy.orm.exc import NoResultFound, MultipleResultsFound

from flask_login import (current_user,
                             login_user, logout_user, UserMixin,
                             confirm_login, fresh_login_required)
from flask_restful import Resource, Api, fields, marshal_with
#from flask_wtf import Form, RadioField

#Import 'app' object from auth as well
from auth import api, app, login_required

from new_platform.utils.roles import Role
from new_platform.utils import user_details
from conversations.models import (Conversation,ConversationAutoSave,
    ConversationLatestPoll)
from legacy_models.iuser import IuserUser
from new_platform.utils.authz import check_authz
from new_platform.utils.strip_html import strip_tags
from new_platform.utils.user_details import user_timezone,get_persona_obj_for_user
from legacy_updates import update_legacy_dependencies_upon_finish
from mobile_notifications.mnutils import send_push_notification

QUEUE_FIELD = ESEARCH_INDEXED_APPS['conversation']['queue_field']

mongo_connection = pymongo.mongo_client.MongoClient(MONGO_HOST,MONGO_PORT)
database = pymongo.database.Database(mongo_connection,MONGO_DBNAME_ES_CONVERSATION)
conversation_coll = database[MONGO_ES_CONVERSATION_ADDINDEX_COLLNAME]

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
superuser_announcer = DBSession.query(IuserUser).filter(
        IuserUser.id==SUPERUSER_ANNOUNCER_ID).one()

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def is_match_online(current_user,user_id):
    if user_id: # Ignore OBO user requests.
        return False

    user_role = Role(current_user.id)
    matching_mentor_mentee = user_role.get_matching_mentor_mentee()

    if not matching_mentor_mentee:
        app.logger.warning("User {0} tried to get conversations but they have no mentor/mentee match, skipping.".format(
            current_user.id))
        return False

    latest = DBSession.query(ConversationLatestPoll).filter(
        ConversationLatestPoll.user_id==matching_mentor_mentee.id).first()
    if latest and (int(time.time()) - latest.latest_poll_timestamp <= 60):
        return True     

    return False
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def is_match_live_in_chat(current_user,user_id):
    if user_id: # Ignore OBO user requests.
        return False

    user_role = Role(current_user.id)
    matching_mentor_mentee = user_role.get_matching_mentor_mentee()

    if not matching_mentor_mentee:
        app.logger.warning("User {0} tried to get conversations but they have no mentor/mentee match, skipping.".format(
            current_user.id))
        return False

    latest = DBSession.query(ConversationLatestPoll).filter(
        ConversationLatestPoll.user_id==matching_mentor_mentee.id).first()
    if latest and (int(time.time()) - latest.latest_live_get_timestamp <= 15):
        print "User is live in chat"
        return True     

    print "User is not live in chat"
    return False
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def update_ts(current_user,poll=True,live=False):
    local_db_session = get_scoped_session()
    latest = local_db_session.query(ConversationLatestPoll).filter(
        ConversationLatestPoll.user_id==current_user.id).first()

    t = int(time.time())
    if latest:
        if poll and live:
            local_db_session.query(ConversationLatestPoll).filter(
                ConversationLatestPoll.user_id==current_user.id).update({
                'latest_poll_timestamp':t,'latest_live_get_timestamp':t})
        elif poll:
            local_db_session.query(ConversationLatestPoll).filter(
                ConversationLatestPoll.user_id==current_user.id).update({
                'latest_poll_timestamp':t})
        elif live:
            local_db_session.query(ConversationLatestPoll).filter(
                ConversationLatestPoll.user_id==current_user.id).update({
                'latest_live_get_timestamp':t})

        local_db_session.commit()
    else:
        # New users don't have a poll time.
        clp = ConversationLatestPoll(
            user_id = current_user.id,
            latest_poll_timestamp = t,
            latest_live_get_timestamp = t
            )
        local_db_session.add(clp)

        # Check for parallel post creating this timestamp in this short time.
        # If this happens, all is well.
        try:
            local_db_session.commit()
        except sqlalchemy.exc.IntegrityError as e:
            if 'duplicate' not in str(e.orig):
                raise

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_chunk_of_messages(base_url,current_user,from_id,to_id,from_datetime,msg_limit,dmy_start,dmy_end,
    search_string,user_id,live):
    '''
    This is designed to be used to grab all conversation history between two or more parties,
    in the order in which it happened.
    If this is done live, unseen messages are marked as seen.
    Note: an OBO user can't see messages on behalf of a mentor/mentee, so nothing will
    be marked as seen in this case.
    '''
    local_db_session = get_scoped_session()
    doing_search = False
    do_reverse = False

    # Get role before current_user is replaced.
    # Current_user is replaced if OBO.
    role = Role(current_user.id)
    member_site_name = current_user.member.name
    to_tz = user_timezone(current_user.id)

    orig_user_id = None
    if user_id: # If current user is admin, and other user's id was passed in (OBO)
        # Operate as the other user if the admin has permissions to do so.
        orig_user_id = current_user.id
        current_user = check_authz(current_user,user_id,replace_user=True)
        if not current_user:
            abort(403)

    user_role = Role(current_user.id)
    current_persona_id = get_persona_obj_for_user(current_user.id,ignore_match_status=True).id
    matching_mentor_mentee = user_role.get_matching_mentor_mentee()
    if not matching_mentor_mentee:
        app.logger.warning("User {0} tried to get conversations but they have no mentor/mentee match, skipping.".format(
            current_user.id))
        return [],0,0

    msg_limit = 1000 if msg_limit > 1000 else msg_limit

    # Get unseen messages from other party/ies.
    unseen_count = DBSession.query(Conversation).filter(
        and_(
            Conversation.sent_to_recipient==None,
            Conversation.recipient_user_id==current_user.id,
            Conversation.recipient_persona_id==current_persona_id,
            or_(Conversation.user_id==matching_mentor_mentee.id,
                Conversation.user_id==superuser_announcer.id)
            )
        ).count()

    msg_limit += unseen_count

    # If from_id or to_id, find the corresponding timestamp, to get all history from/to that point.
    peek_timestamp = None
    if from_id:
        peek_timestamp = DBSession.query(Conversation).filter(
            and_(Conversation.user_id==current_user.id,Conversation.id>=from_id
            )).order_by(Conversation.id).first()
        if peek_timestamp:
            peek_timestamp = peek_timestamp.received_by_server
    elif to_id:
        peek_timestamp = DBSession.query(Conversation).filter(
            and_(Conversation.user_id==current_user.id,Conversation.id<=to_id
            )).order_by(Conversation.id.desc()).first()
        if peek_timestamp:
            peek_timestamp = peek_timestamp.received_by_server

    if not peek_timestamp:
        # Parameters passed in may be bad: try to give them 
        # something useful anyway.
        peek_timestamp = datetime.utcnow() - timedelta(days=1)

    # Only messages sent from/to mentor-mentee, and announcements/msgs from admins.
    results = DBSession.query(Conversation).filter(or_(
        and_(Conversation.user_id==current_user.id,Conversation.recipient_user_id==matching_mentor_mentee.id),
        and_(Conversation.recipient_user_id==current_user.id,Conversation.user_id==matching_mentor_mentee.id),
        and_(Conversation.recipient_user_id==current_user.id,Conversation.user_id==superuser_announcer.id)))

    # Searches are ORed, not ANDed here.
    if from_id:
        doing_search = True
        msg_limit = 20 if not msg_limit else msg_limit
        results = results.filter(Conversation.received_by_server >= peek_timestamp)
        results = results.order_by(Conversation.received_by_server)

    elif to_id:
        doing_search = True
        do_reverse = True
        msg_limit = 20 if not msg_limit else msg_limit
        results = results.filter(Conversation.received_by_server <= peek_timestamp)
        results = results.order_by(Conversation.received_by_server.desc())

    elif from_datetime:
        doing_search = True

        # Convert datetime from user's time zone to UTC to do the search.
        from_tz = user_timezone(current_user.id)
        #2016-04-20T19:00:12.717849 sometimes without the decimal ms
        if '.' not in from_datetime:
            from_dt = datetime.strptime(from_datetime,"%Y-%m-%dT%H:%M:%S").replace(tzinfo=from_tz).astimezone(tz.gettz('UTC'))
        else:
            from_dt = datetime.strptime(from_datetime,"%Y-%m-%dT%H:%M:%S.%f").replace(tzinfo=from_tz).astimezone(tz.gettz('UTC'))

        results = results.filter(Conversation.received_by_server>=from_datetime)
        msg_limit = 20 if not msg_limit else msg_limit
        results = results.order_by(Conversation.received_by_server)

    elif dmy_start and dmy_end:
        doing_search = True
        d = int(dmy_start[:2])
        m = int(dmy_start[2:4])
        y = int(dmy_start[4:])
        start_date = datetime(day=d,month=m,year=y)
        d = int(dmy_end[:2])
        m = int(dmy_end[2:4])
        y = int(dmy_end[4:])
        end_date = datetime(day=d,month=m,year=y,hour=23,minute=59,second=59)

        results = results.filter(Conversation.received_by_server.between(start_date,end_date))
        results = results.order_by(Conversation.received_by_server)

    elif search_string:
        doing_search = True
        results = results.filter(Conversation.data.ilike(search_string))
        results = results.order_by(Conversation.received_by_server)

    else:
        # When not doing search, get the last messages.
        do_reverse = True
        results = results.order_by(Conversation.received_by_server.desc())

    results = results.limit(msg_limit)

    if doing_search:
        # Make an empty query set.
        autosave_results = DBSession.query(ConversationAutoSave,IuserUser).filter(
            sqlalchemy.sql.false())
    else:
        autosave_results = DBSession.query(ConversationAutoSave).filter(
            and_(ConversationAutoSave.user_id==current_user.id,
                ConversationAutoSave.recipient_user_id==matching_mentor_mentee.id)
            ).order_by(ConversationAutoSave.received_by_server)

    if results.count() <= 0 and autosave_results.count() <= 0:
        return [],0,0

    outbound = []

    admin_saw_these = []
    user_saw_these = []

    '''
    There could be admin messages in here, but we're not tracking their sequence.
    Sequence tracking is only really useful if the same user is logged in twice,
    and has two chats running simultaneously. We're then checking the user's sequence,
    not the recipient or admin.
    '''
    highest_sequence = {current_user.id:None, matching_mentor_mentee.id:None}
    res = [x for x in results.all()]
    if res:
        if do_reverse:
            res.reverse()
        for conv in res:
            c = conv.__dict__
            cuser = conv.user.__dict__
            del c['_sa_instance_state']
            del c['user']
            c['received_show_date'] = c['received_by_server'].replace(tzinfo=tz.gettz('UTC')).astimezone(to_tz).strftime('%a, %B %d, %I:%M%p')
            ''' For mobile: Parse out image names like this: img src="/muser_content/151865/image-W3FAVC.jpg" '''
            if base_url[1] in ('m','M'): # mobile, 0th position is '/'
                img_url = re.search(r'img\s+',c['data'])
                if img_url:
                    findsrc = c['data'].split()
                    for fsrc in findsrc:
                        if 'src=' in fsrc or 'src =' in fsrc:
                            fsrc = re.sub(r'src\s*=',r'',fsrc)
                            fsrc = re.sub(r'(\'|\")',r'',fsrc)
                            # NOTE: hard-coded URL here.
                            c['image_url'] = re.sub(r'/[mM]?user_content/',r'/',fsrc)
                            break
    
            outbound.append(c)
            outbound[-1]['first_name'] = cuser['first_name'] if cuser['id'] != SUPERUSER_ANNOUNCER_ID \
                else member_site_name
            outbound[-1]['auto_saved'] = False

            highest_sequence[outbound[-1]['user_id']] = outbound[-1]['sequence']
    
            if user_id: # OBO
                admin_saw_these.append(c['id'])
    
            # Live "get" by actual user of messages sent to them but not yet seen.
            # Make sure this "get" is not being done by the OBO admin, on behalf of the user.
            elif not doing_search and live and \
                c['sent_to_recipient'] in (None,'') and \
                c['recipient_user_id']==current_user.id and \
                not orig_user_id:
                user_saw_these.append(c['id'])

    for conv in autosave_results.all():
        c = conv.__dict__
        cuser = conv.user.__dict__
        del c['_sa_instance_state']
        del c['user']
        #print "retrieving autosave: {0}".format(
        #    c['data'].encode('utf-8','ignore').decode('ascii'))
        outbound.append(c)
        outbound[-1]['first_name'] = cuser['first_name']
        outbound[-1]['auto_saved'] = True

    # OBO
    if user_id and admin_saw_these:
        # Other admins may see this. Check for the responsible one.
        if role.is_this_the_admin_for_this_user(user_id):
            local_db_session.query(Conversation).filter(Conversation.id.in_(admin_saw_these)).update(
                {'admin_last_viewed':datetime.utcnow()},synchronize_session=False)

    # Live, and not doing a search of any kind.
    if user_saw_these:
        local_db_session.query(Conversation).filter(
            Conversation.id.in_(user_saw_these)).filter(
            Conversation.sent_to_recipient==None).update(
            {'sent_to_recipient':datetime.utcnow()},synchronize_session=False)

    # If no messages for sender/recipient retrieved this round, still make sure
    # highest sequence is accurate.
    if not highest_sequence[current_user.id]:
        highest = DBSession.query(Conversation).filter(
            Conversation.user_id==current_user.id).order_by(
                Conversation.received_by_server.desc()).first()
        if highest:
            highest_sequence[current_user.id] = highest.sequence

    if not highest_sequence[matching_mentor_mentee.id]:
        highest = DBSession.query(Conversation).filter(
            Conversation.user_id==matching_mentor_mentee.id).order_by(
                Conversation.received_by_server.desc()).first()
        if highest:
            highest_sequence[matching_mentor_mentee.id] = highest.sequence

    local_db_session.commit()

    return outbound,unseen_count,highest_sequence

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def post_messages(current_user,post_args,user_id):
    '''
    Two types of "sends": autosave and user hitting send.
    '''
    local_db_session = get_scoped_session()

    orig_user_id = None
    if user_id:
        orig_user_id = current_user.id
        current_user = check_authz(current_user,user_id,replace_user=True)
        if not current_user:
            abort(403)

    recipient_role = Role(post_args['recipient_user_id'])
    if recipient_role.is_matching_mentor_mentee(current_user.id) or \
        recipient_role.is_some_admin_for_site_id(current_user.member.id):

        # Not autosaved, user hit the send button
        if 'sent' in post_args and post_args['sent']:
            words = strip_tags(post_args['data']).split()
            word_count = len(words)
            # looks like strip_tags is failing sometimes, len = 0 at times.
            if not word_count and post_args['data'] not in (None,[],""):
                word_count=1

            srec = local_db_session.query(Conversation).filter(
                Conversation.user_id == current_user.id
                ).order_by(Conversation.received_by_server.desc()).limit(1).first()
            if srec:

                # Check for duplicate post. Allow short duplicates.
                if len(srec.data) > 9 and srec.data == post_args['data']:
                    app.logger.warning("Found duplicate conversation POST, ignoring: {0}".format(
                        pprint.pformat(post_args)))

                    local_db_session.commit()
                    return True

                sequence = srec.sequence + 1
            else:
                sequence = 1

            mtc = Conversation(
                user_id=current_user.id,
                obo_user_posted=orig_user_id,
                persona_id=get_persona_obj_for_user(current_user.id,ignore_match_status=True).id,
                sent_to_recipient=None, # recipient didn't see it yet.
                data=post_args['data'],
                word_count = word_count,
                recipient_user_id=post_args['recipient_user_id'],
                recipient_persona_id=get_persona_obj_for_user(
                    post_args['recipient_user_id'],ignore_match_status=True).id,
                sequence = sequence
                )

            # Clean out all previous autosaved messages.
            local_db_session.query(ConversationAutoSave).filter(
                ConversationAutoSave.user_id==current_user.id).delete()

            local_db_session.add(mtc)
            local_db_session.commit()

            local_db_session.begin()

            # Queue for elasticsearch indexing.
            conversation_coll.insert_one({'action':'insert',QUEUE_FIELD:mtc.id})

            update_legacy_dependencies_upon_finish(local_db_session,current_user,mtc)
            local_db_session.commit()
            
            # If recipient is not live in chat, send push notification.
            if not is_match_live_in_chat(current_user,user_id): # past 15 seconds
                outbound = strip_tags(post_args['data'])
                outbound = outbound[:30] + ' ...' if len(outbound) > 30 else outbound
                send_push_notification(post_args['recipient_user_id'],outbound,testing=True)

            return True

        else: # autosave to temp table.
            #print "Autosaving {0}".format(post_args['data'])
            mtc = ConversationAutoSave(
                user_id=current_user.id,
                obo_user_posted=orig_user_id,
                data=post_args['data'],
                recipient_user_id=post_args['recipient_user_id']
                )

            local_db_session.query(ConversationAutoSave).filter(
                ConversationAutoSave.user_id==current_user.id).delete()

            local_db_session.add(mtc)
            local_db_session.commit()
            return True

    local_db_session.commit()
    return False
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Add the Welcome message at this time as well.
def add_conv_welcome_msg(user_id,user_persona_id):
    local_db_session = get_scoped_session()

    # Ignore persona id parameter, only work with current persona.
    try:
        current_user_persona_id = get_persona_obj_for_user(user_id,ignore_match_status=True).id
    except:
        return

    conv = local_db_session.query(Conversation).filter(
        Conversation.recipient_user_id == user_id).filter(
        Conversation.recipient_persona_id == current_user_persona_id).first()

    if conv:
        local_db_session.close()
        return

    wmsg = Conversation(
        user_id = SUPERUSER_ANNOUNCER_ID,
        persona_id = get_persona_obj_for_user(SUPERUSER_ANNOUNCER_ID,ignore_match_status=True).id,
        recipient_user_id = user_id,
        recipient_persona_id = current_user_persona_id,
        received_by_server = datetime.utcnow().date(),
        sent_to_recipient = None,
        admin_last_viewed = datetime.utcnow().date(),
        data = """
        Welcome to Conversations! This is your tool to exchange messages as a pair. New message notifications will appear on the Conversations icon at the top right of your screen. Click the chat icon to open Conversations, click the paperclip icon to attach files and click the paper airplane icon to send your message. If you want to learn more, click the “Need help” link near the search icon above.
           """,
        word_count = 69,
        sequence = 1)

    local_db_session.add(wmsg)
    local_db_session.commit()
    print "new conv id: {0}".format(wmsg.id)

    # Django has trouble letting these fall out of scope. Close it to assist.
    local_db_session.close()

