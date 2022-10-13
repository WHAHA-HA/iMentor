# -*- coding: iso8859-15 -*-
import os,sys
import pprint
import logging
import re
import datetime
import pymongo
from num2words import num2words

appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import (db,Base,metadata,DBSession,
    get_scoped_session,DOMAIN)

from config.settings import (ENV_TYPE,LOGIN_DISABLED,DEFAULT_TEST_USER_ID,
    TWILIO_AUTH_TOKEN)

from twilio.util import RequestValidator
from sms_notifications.models import SMSMessage
from legacy_models.iuser import IuserUser

from flask import Flask, Response, request, abort
from flask.views import MethodView
from flask_restful import Resource, Api
from auth import app,api
#from simplexml import dumps
from config.project_globals import DigestAuthDB 

from sms_notifications.models import (
    SMSMessage,SMSInvalidResponse,SMSStop)
from config.settings import (MONGO_HOST,MONGO_PORT,
    MONGO_DBNAME_LOGS,MONGO_GENERIC_LOGQUEUE_COLLNAME)
from config.project_globals import (app,db,DBSession,
    get_scoped_session,DOGPILE_CACHE_REGION,DOMAIN)
from config.caching_query import CachingQuery,FromCache
from config.settings import TWILIO_PHONE_NUMBER
from sqlalchemy import (BigInteger, Boolean, Column, Date, DateTime, 
    Float, ForeignKey, Index, Integer, Numeric, SmallInteger, 
    String, Table, Text, Time, text, func, or_, and_, update)
from sqlalchemy.orm.exc import NoResultFound
from sqlalchemy.orm import relationship, aliased
from legacy_models.iuser import IuserUser, IuserPersona, IuserPersonaPartner, IuserMatchhistory
from legacy_models.partners import PartnersPartner
from legacy_models.member import MemberMember
from legacy_models.calendars import CalendarsEvent, CalendarsEventtype, CalendarsInvitation
from legacy_models.mailer import MailerMessage
from legacy_models.log import CONTENT_TYPE_USER
from new_platform.utils import user_details
from sms_notifications.sms_utils import (get_most_recent_invitation,
    get_event_details,send_mail)

from config.settings import DEFAULT_DAYS_BEFORE_EVENT

mongo_connection = pymongo.mongo_client.MongoClient(MONGO_HOST,MONGO_PORT)
database = pymongo.database.Database(mongo_connection,MONGO_DBNAME_LOGS)
generic_logq_coll = database[MONGO_GENERIC_LOGQUEUE_COLLNAME]

BASE_URL='/sms'

Validator = RequestValidator(TWILIO_AUTH_TOKEN)


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def update_event_attendance(from_phone, to_phone, body, invite):

    local_db_session = get_scoped_session()
    if body == 'AY':
        attended = True
    else:
        raise Exception("Shouldn't be here. Result was checked before reaching this point. Crashing. from:{0}, to:{1}, body:{2}, matching invite id: {3}".format(
            from_phone, to_phone, body, invite.rsvp_id))

    local_db_session.query(CalendarsInvitation).\
        filter(CalendarsInvitation.id == invite.rsvp_id).\
        update({'attended': attended})
    local_db_session.commit()

def update_event_rsvp(from_phone, to_phone, body, invite):

    local_db_session = get_scoped_session()
    if body == 'RY':
        rsvp_resp = 'Y'
    elif body == 'RN':
        rsvp_resp = 'N'
    else:
        raise Exception("Shouldn't be here. Result was checked before reaching this point. Crashing. from:{0}, to:{1}, body:{2}, matching invite id: {3}".format(
            from_phone, to_phone, body, invite.rsvp_id))

    app.logger.warning("Not a warning: update_event_rsvp() is updating invitation id {0} with this response: {1}".format(
        invite.rsvp_id,rsvp_resp))

    local_db_session.query(CalendarsInvitation).\
        filter(CalendarsInvitation.id == invite.rsvp_id).\
        update({'rsvp': rsvp_resp})
    local_db_session.commit()
    local_db_session.begin()

    event_details = get_event_details(invite.rsvp_id)

    app.logger.debug('mentee email is {0}... sending email'.format(event_details.mentee_email))

    # We're adjusting case here, but plan to do so in the database soon.
    party_name = event_details.mentor_first_name.capitalize()
    counterparty_name = event_details.mentee_first_name.capitalize()

    if rsvp_resp == 'Y':
        rsvp_phrase = 'is going'
        rsvp_closing = "We'll see you both there! Thanks so much."
    elif rsvp_resp == 'N':
        rsvp_phrase = "isn't going"
        rsvp_closing = "Let's try again next time. Thanks so much."

    mail_subject = 'You have a new event RSVP from %s!' % party_name
    mail_body = 'Hi, %s. %s %s to the event named %s on %s at %s. %s' % (counterparty_name, party_name, rsvp_phrase, event_details.event_name, event_details.event_date.strftime("%-m/%-d/%y"), event_details.event_time.strftime("%-I:%M %p"), rsvp_closing)

    send_mail(local_db_session,'notifications@imentor.org', event_details.mentee_email, mail_subject, mail_body)

    # use utility method instead of related object to make sure any
    # additional business rules are run
    # The email confirmation below isn't necessary at this time, since staff send confirmations
    # just before the event. In the future, we may decide to automate this aspect as well.
    '''
    app.logger.debug('mentor email is {0}... sending email'.format(mentor.email))
    send_mail(local_db_session,'notifications@imentor.org', mentor.email, 'Your RSVP Repsonse', rsvp_resp)
    '''

    local_db_session.commit()

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

class SMSReplyHandler(MethodView):
    response = {
        'RY':"""<?xml version="1.0" encoding="UTF-8" ?>
<Response>
    <Message>Great. We'll see you then!</Message>
</Response>
        """,
        'RN':"""<?xml version="1.0" encoding="UTF-8" ?>
<Response>
    <Message>No problem. Let's try again next time!</Message>
</Response>
        """,
        'AY':"""<?xml version="1.0" encoding="UTF-8" ?>
<Response>
    <Message>Welcome to the event! We just updated your attendance.</Message>
</Response>
        """,
        'HELP_DEFAULT':"""<?xml version="1.0" encoding="UTF-8" ?>
<Response>
    <Message>iMentor Program Alerts: Help at support@imentor.org. Msg/data rates may apply. 1 message/user request. Text STOP to cancel.</Message>
</Response>
        """,
        'HELP':"""<?xml version="1.0" encoding="UTF-8" ?>
<Response>
    <Message>Sure thing. If you contact your Program Manager as usual, you'll receive help right away.</Message>
</Response>
        """,
        'STOP_DEFAULT':"""<?xml version="1.0" encoding="UTF-8" ?>
<Response>
    <Message>You are unsubscribed from iMentor Program Alerts. No more messages will be sent. Reply HELP for help or contact support@imentor.org.</Message>
</Response>
        """,
        'STOP':"""<?xml version="1.0" encoding="UTF-8" ?>
<Response>
    <Message>Certainly. We'll ensure you no longer receive these SMS notifications. If you change your mind, just respond with start.</Message>
</Response>
        """,
        'START':"""<?xml version="1.0" encoding="UTF-8" ?>
<Response>
    <Message>Welcome back! If you'd prefer not to receive these SMS notifications after all, just respond with stop.</Message>
</Response>
        """,
        'I':"""<?xml version="1.0" encoding="UTF-8" ?>
<Response>
    <Message>I'm sorry, I didn't get that. Please try again with the instructed response that begins with "#", or contact your Program Manager for help.</Message>
</Response>
        """
        }

    '''
    def get(self):
        return Response(self.response,  mimetype='application/xml')
    '''

    #@DigestAuthDB.requires_auth
    def post(self):
        local_db_session = get_scoped_session()

        # Verify that Twilio is the source. Our load balancers strips off SSL.
        # Add it back.
        twilio_signature=request.headers['X-Twilio-Signature']
        valid = Validator.validate(request.url.replace('http:','https:'),
            request.form,twilio_signature)
            
        if not valid:
            app.logger.exception("Inbound Twilio request faild validation. This may not be from Twilio, rejecting: url: {0}, signature: {1}, {2}".format(
                request.url,twilio_signature,pprint.pformat(request.form)))
            abort(403)
        
        # send to dispatcher
        print "In reply handler"
        app.logger.warning("incoming request, including body:")
        app.logger.warning("request.form %s" % request.form)
        app.logger.warning("request.headers %s" % request.headers)
        app.logger.warning("request.form['Body'] %s" % request.form.get('Body'))
        from_phone = request.form.get('From').strip()
        to_phone = request.form.get('To').strip()
        body = request.form.get('Body').strip()

        result = dispatch(local_db_session,from_phone,to_phone,body)
        local_db_session.commit()

        # Don't reply to people who aren't in the system and din't send HELP/STOP.
        # result is null in that case.
        return Response(self.response[result] if result else '',  mimetype='application/xml')


SMS_RESPONSES = {
    ('#rsvpyes'):'RY',
    ('#rsvpno'):'RN',
    ('#here'):'AY',
    ('help', 'help.', 'help!'):'HELP',
    ('stop', 'stop.', 'stop!'):'STOP',
    ('start', 'start.', 'start!'):'START'
}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def dispatch(local_db_session,from_phone,to_phone,body):
    """Route to the appropriate function to handle incoming sms message"""

    # This forces a contiguous numeric value, no '(', no '-', no '+1'.
    from_phone = re.sub(r'^\+1', '', from_phone)
    from_phone = re.sub(r'[^\d]+', '', from_phone)

    if (len(from_phone) != 10 or len(to_phone) != 5): 
        raise ValueError('Phone number is not 10 or 5 digits long: from: {0}, to: {1}, body: {2}'.format(
            from_phone,to_phone,body))

    #app.logger.debug('Req params... from: {0}, to: {1}, body: {2}'\
    #        .format(from_phone, to_phone, body))

    message = ''
    for k, v in SMS_RESPONSES.items():
        if body.lower() in k:
            message = v
            break;

    user = DBSession.query(IuserUser).filter(or_(
        IuserUser.cell_phone.like(from_phone),
        IuserUser.home_phone.like(from_phone),
        IuserUser.work_phone.like(from_phone)
        )).first()

    if message == 'HELP':
        # Non-users could be compliance messages.
        if user:
            return message
        else:
            return "HELP_DEFAULT"
     
        app.logger.warning('No user match for this sms. Phone: {0}, received this message: {1}'.format(
            from_phone, body))
        return

    if message in ('STOP','START'):
        if user:
            stopped = DBSession.query(SMSStop).filter(
                SMSStop.user_id == user.id).first()
            if not stopped:
                if message == 'STOP':
                    smsstop = SMSStop(user_id = user.id, from_phone = from_phone)
                    local_db_session.add(smsstop)
                    local_db_session.commit()
                    local_db_session.begin()

                    msg='User {0} issued an SMS STOP. We honored it.'.format(user.email)

                    # For Django user reporting. This should either go away or be improved.
                    log_data = {'content_type':{'id':CONTENT_TYPE_USER},
                        'object_id':user.id,
                        'message':msg,
                        'category':'sms',
                        'datetime':datetime.datetime.now()
                    }
                    new_id = generic_logq_coll.insert_one(log_data)

            else: # stopped
                if message == 'START':
                    local_db_session.query(SMSStop).filter(
                        SMSStop.user_id == user.id).delete()
                    local_db_session.commit()
                    local_db_session.begin()

                    msg='User {0} issued an SMS START. We honored it.'.format(user.email)

                    # For Django user reporting. This should either go away or be improved.
                    log_data = {'content_type':{'id':CONTENT_TYPE_USER},
                        'object_id':user.id,
                        'message':msg,
                        'category':'sms',
                        'datetime':datetime.datetime.now()
                    }
                    new_id = generic_logq_coll.insert_one(log_data)

            return message

        else:
            # Non-users could be compliance messages.
            if message == 'STOP':
                return "STOP_DEFAULT"

            app.logger.warning('No user match for this sms. Phone: {0}, received this message: {1}'.format(
                from_phone, body))
            return
            

    '''
    Note that we don't always expect a response to every message we send, such as
    lesson reminders. 
    We also don't expect an SMS for every response we receive. We instead 
    match SMS resoonses to platform data like events, etc.
    '''
    if user:
        if message in ('RY','RN'):
            invitation = get_most_recent_invitation(user)
            if invitation:
                update_event_rsvp(from_phone, to_phone, message, invitation)
                return message

            invalid_resp = SMSInvalidResponse(
                user_id=user.id,
                status="No matching event invitation found",
                response=body,
                from_phone=from_phone
                )
            local_db_session.add(invalid_resp)
            local_db_session.commit()
            local_db_session.begin()
        elif message == 'AY':
            invitation = get_most_recent_invitation(user)
            if invitation:
                update_event_attendance(from_phone, to_phone, message, invitation)
                return message

            invalid_resp = SMSInvalidResponse(
                user_id=user.id,
                status="No matching event invitation found",
                response=body,
                from_phone=from_phone
                )
            local_db_session.add(invalid_resp)
            local_db_session.commit()
            local_db_session.begin()
        else:
            invalid_resp = SMSInvalidResponse(
                user_id=user.id,
                status="Unrecognized response",
                response=body,
                from_phone=from_phone
                )
            local_db_session.add(invalid_resp)
            local_db_session.commit()
            local_db_session.begin()

        return 'I'
    else:
        app.logger.exception('Can\'t find matching invitation for this response, from unidentified user,  phone: {0}, message: {1}'.format(
            from_phone, body))

        return None


app.add_url_rule('{0}/'.format(BASE_URL), view_func=SMSReplyHandler.as_view('inbound_sms_notifications'))


if __name__ == "__main__":
    local_db_session = get_scoped_session()
    result = dispatch(local_db_session,'8565065622','65029','#rsvpyes')
    if result:
        print SMSReplyHandler().response[result]
