# -*- coding: iso8859-15 -*-
import os,sys
import pprint
import logging
import re
import datetime
import argparse
import pymongo
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)
from sms_notifications.twilio_client import TwilioClient
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

from config.settings import DEFAULT_DAYS_BEFORE_EVENT

from sms_utils import (find_cell, should_send, get_most_recent_invitation,
    get_tentative_rsvp_mentors, get_event_details, send_mail)

mongo_connection = pymongo.mongo_client.MongoClient(MONGO_HOST,MONGO_PORT)
database = pymongo.database.Database(mongo_connection,MONGO_DBNAME_LOGS)
generic_logq_coll = database[MONGO_GENERIC_LOGQUEUE_COLLNAME]


SMS_TEMPLATES = {
    "mentor_event_rsvp": "Hi, %s! Will you be attending the %s event at %s on %s at %s? To RSVP, please reply to this text with #rsvpyes or #rsvpno. If you have any questions, please reach out to your Program Manager at %s. Thank you!",
    "lesson_reminder": "Hi from %s, %s! %s's class is coming up. You can complete the lesson right here on your phone by tapping %s! If you have any questions, please reach out to your Program Manager at %s."
}
SMS_RESPONSES = {
    ('#rsvpyes'): 'RY',
    ('#rsvpno'):'RN',
    ('#here'):'AY',
    ('help', 'help.', 'help!'):'HELP',
    ('stop', 'stop.', 'stop!'):'STOP',
    ('start', 'start.', 'start!'):'START'
}


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def send_sms_lesson_reminder_message(user_lesson_tuples):
    '''
    This bulk-sends messages to mentors/mentees to finish particular canvas lessons.
    This is triggered by an admin from snapshot, and maybe other admin screens.
    '''
    foreign_table = 'canvas_set'
    tc = TwilioClient()
    local_db_session = get_scoped_session()
    
    for l in user_lesson_tuples:
        mentor_or_mentee_id = l[0]
        lesson_id = l[1]
        counterparty_first_name = l[2]
        staff_email = l[3]

        # Skip non-matched
        if mentor_or_mentee_id == 'NA' or lesson_id == 'NA' or counterparty_first_name == 'NA':
            continue

        # Look for already sent texts for this lesson and user. Don't resend.
        mentor_or_mentee = DBSession.query(IuserUser).filter(
            IuserUser.id==mentor_or_mentee_id).one()

        # Skip Pittsburgh. They want this turned off.
        if mentor_or_mentee.member_id == 233:
            continue

        if not should_send(foreign_table,lesson_id,mentor_or_mentee.id):
            continue

        to_phone = find_cell(mentor_or_mentee)

        # Cron executes this, so we can't derive the domain from an incoming response.
        lesson_link ='https://{0}.{1}/#/?next=/canvas/lesson/{2}/'.format(
            mentor_or_mentee.member.url_name,DOMAIN,lesson_id)

        msg = SMS_TEMPLATES['lesson_reminder'] % (mentor_or_mentee.member.name, 
            mentor_or_mentee.first_name.capitalize(), counterparty_first_name.capitalize(), lesson_link, staff_email)

        app.logger.debug('Sending message: %s %s %s' % (
                to_phone,
                TWILIO_PHONE_NUMBER,
                msg
        ))
        sid,crash_msg = tc.send_message(to_phone, TWILIO_PHONE_NUMBER, msg)

        # if we receive an sid back, then we can assume that a message
        # was successfully sent
        if sid:
            sms_message = SMSMessage(
                    text=msg, 
                    to_phone=to_phone, 
                    from_phone=TWILIO_PHONE_NUMBER, 
                    recipient_id=mentor_or_mentee.id, 
                    foreign_table_name=foreign_table,
                    foreign_table_id=lesson_id,
                    sid=sid
            )
            local_db_session.add(sms_message)
            local_db_session.commit()
            local_db_session.begin()

        else: # Twilio crashed
            app.logger.exception(
                "SMS send to this user: {0} failed, skipping this user and continuing, not crashing. Here's the error: {1}".format(
                mentor_or_mentee.id,crash_msg))
   
    local_db_session.commit()

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def send_sms_event_messages(days, mentors):
    """Send sms message for each row in query result collection passed in
    """

    local_db_session = get_scoped_session()

    tc = TwilioClient()
    foreign_table = "calendars_invitation"

    for mentor in mentors:

        if not should_send(foreign_table,mentor.rsvp_id,mentor.user_id):
            continue

        to_phone = find_cell(mentor)

        event_details = get_event_details(mentor.rsvp_id)

        msg = SMS_TEMPLATES['mentor_event_rsvp'] % (event_details.mentor_first_name.capitalize(),
            mentor.member_site_name, event_details.event_address, event_details.event_date.strftime("%-m/%-d/%y"),
            event_details.event_time.strftime("%-I:%M %p"), event_details.staff_email)

        app.logger.debug('Sending message: %s %s %s' % (
                to_phone,
                TWILIO_PHONE_NUMBER,
                msg
        ))
        sid,crash_msg = tc.send_message(to_phone, TWILIO_PHONE_NUMBER, msg)

        # if we receive an sid back, then we can assume that a message
        # was successfully sent
        if sid:
            sms_message = SMSMessage(
                    text=msg, 
                    to_phone=to_phone, 
                    from_phone=TWILIO_PHONE_NUMBER, 
                    recipient_id=mentor.user_id, 
                    foreign_table_name=foreign_table,
                    foreign_table_id=mentor.rsvp_id,
                    sid=sid
            )
            local_db_session.add(sms_message)
            local_db_session.commit()
            local_db_session.begin()

        else: # Twilio crashed
            app.logger.exception(
                "SMS send to this user: {0} failed, skipping this user and continuing, not crashing. Here's the error: {1}".format(
                mentor.user_id,crash_msg))

    local_db_session.commit()


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def process_notifications(days, dry_run=False):

    '''
    Determine which mentors should receive a notification for a pending 
    event, and send an sms message if appropriate.
    Mantors and member sites which are on the "do not send"
    list are filtered out in the first function.
    '''
    mentors = get_tentative_rsvp_mentors(days)
    app.logger.debug(mentors)
    if not dry_run:
        send_sms_event_messages(days, mentors)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
if __name__ == "__main__":
    process_notifications(7, False)
