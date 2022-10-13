# -*- coding: iso8859-15 -*-

import socket
from threading import Thread
from flask_ocketio import disconnect, SocketIO, emit, join_room, leave_room
from flask import  current_app, request, redirect, render_template

import functools
import pdb
import pprint
import copy
import os,sys
import json
from dateutil import tz
from datetime import datetime
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import get_scoped_session,Base,metadata,DBSession
from config.settings import (ENV_TYPE,LOGIN_DISABLED,
    DEFAULT_TEST_USER_ID,SUPERUSER_ANNOUNCER_ID)

from flask_sqlalchemy import SQLAlchemy
import sqlalchemy
from sqlalchemy import desc
from sqlalchemy.sql.expression import func, or_, not_, and_
from sqlalchemy.orm import sessionmaker
from sqlalchemy.orm.exc import NoResultFound, MultipleResultsFound

#Import 'app' object from auth as well
from auth import api, app, verify_session_id

from new_platform.utils.roles import Role
from new_platform.utils import user_details
from conversations.models import Conversation,ConversationAutoSave
from legacy_models.iuser import IuserUser
from utils.authz import check_authz
from utils.strip_html import strip_tags
from utils.strip_html import strip_tags
from utils.user_details import user_timezone
from conversations.conversation_utils import (superuser_announcer,
    get_chunk_of_messages,post_messages)

BASE_URL = '/websocket/chat'

socketio = SocketIO(app)

def background_thread():
    """Example of how to send server generated events to clients."""
    while True:
        time.sleep(5)
        socketio.emit('gateway_events',{'data':
            {  u'_id': 'BOGUS',
               u'gateway_device_id': u'00000000-00000000-00000000-00000000',
               u'msg_string': u'Websockect Client Test',
               u'msg_type': 100,
               u'timestamp': 1410902423.32245
               }
            })

        socketio.emit('gateway_events','emitted from socket daemon thread',
            namespace='')
        count = 0

        #print "Sleeping, last obj id: %s" % last_object_id
        if not last_object_id:
            objs = [x for x in gateway_event_coll.find().sort([('_id',pymongo.DESCENDING)]).limit(1)]
        else:
            objs =[x for x in gateway_event_coll.find({'_id':{'$gt':ObjectId(last_object_id)}})]

        #if objs:
            #print "Found objs"

        for record in objs:
            for field,value in record.items():
                record[field] = string_objid(value)

        data = [x for x in objs]

        last_object_id = objs[-1]['_id'] if objs else last_object_id

        if data:
            print("data:%s" % pprint.pformat(data))
            #socketio.emit('gateway_events',{'data':data},namespace='/test')
            socketio.emit('gateway_events',{'data':data},
                namespace='')
        '''
        socketio.emit('my response',
                      {'data': 'Server generated event', 'count': count},
                      namespace='/test')
        '''

#thread = Thread(target=background_thread)
#thread.start()

def check_user_login(user_id,session_id):
    user_id = verify_session_id(session_id)
    raise Exception("Here...")
    if not user_id:
        abort(403)
    return user_id

def inbound_join(message=None):
    from flask_login import current_user

    if LOGIN_DISABLED:
        current_user = DBSession.query(IuserUser).filter(
            IuserUser.id==DEFAULT_TEST_USER_ID).one()

    import pdb;pdb.set_trace()
    print "Join: {0}".format(pprint.pformat(message))
    #user_id = check_user_login(message['sessionid'])


def inbound_msg(message):
    from flask_login import current_user

    if LOGIN_DISABLED:
        current_user = DBSession.query(IuserUser).filter(
            IuserUser.id==DEFAULT_TEST_USER_ID).one()

    import pdb;pdb.set_trace()
    print "message: {0}".format(pprint.pformat(message))
    #user_id = check_user_login(message['sessionid'])
    result = post_messages(current_user,{
        'data':message['msg'],
        'sent':True,
        'recipient_user_id':Role(current_user.id).get_matching_mentor_mentee().id
        })

def inbound_leave(message):
    from flask_login import current_user

    if LOGIN_DISABLED:
        current_user = DBSession.query(IuserUser).filter(
            IuserUser.id==DEFAULT_TEST_USER_ID).one()

    raise Exception("Here...")
    print "leave: {0}".format(pprint.pformat(message))


def namespace(from_user_id):
    # Make sure user is logged in and has a match.
    matching_user = Role(from_user_id).get_matching_mentor_mentee()
    ns = '/{0}_{1}'.format(from_user_id,matching_user.id)
    socketio.on('joined',namespace=ns)(inbound_join)
    socketio.on('message',namespace=ns)(inbound_msg)
    return ns

@app.route(BASE_URL + "/namespace/")
def wsionamespace():
    from flask_login import current_user

    if LOGIN_DISABLED:
        current_user = DBSession.query(IuserUser).filter(
            IuserUser.id==DEFAULT_TEST_USER_ID).one()

    if hasattr(current_user,'id'):
        ns = namespace(current_user.id)
        # Don't allow no namespace.
        if not ns:
            abort(403)

        return ns

    
@app.route(BASE_URL + "/")
def wsiochat():
    from flask_login import current_user

    if LOGIN_DISABLED:
        current_user = DBSession.query(IuserUser).filter(
            IuserUser.id==DEFAULT_TEST_USER_ID).one()

    if hasattr(current_user,'id'):
        return render_template("chat_socketio/index.html")

    return redirect("/")
    

