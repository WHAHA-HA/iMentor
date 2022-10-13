#!/usr/bin/env python
# -*- coding: iso8859-15 -*-
import os,sys
import pprint
import logging
import smtplib
import datetime
from email.mime.application import MIMEApplication
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.utils import COMMASPACE, formatdate

appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'../..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import (app,db,DBSession,
    get_scoped_session,DOGPILE_CACHE_REGION)
from config.caching_query import CachingQuery,FromCache
from config.settings import (EMAIL_USE_TLS,EMAIL_HOST,EMAIL_HOST_USER,
    EMAIL_HOST_PASSWORD,EMAIL_PORT,FROM_EMAIL)
from sqlalchemy import (BigInteger, Boolean, Column, Date, DateTime,
    Float, ForeignKey, Index, Integer, Numeric, SmallInteger,
    String, Table, Text, Time, text, func)
from sqlalchemy.dialects.postgresql.base import INET, TSVECTOR
from sqlalchemy.orm import relationship
from snapshot.snapshot_utils import get_delinquent_mentors
from legacy_models.iuser import IuserUser
from utils.user_details import get_latest_mentee_for_mentor
from legacy_models.mailer import MailerMessage
from conversations.models import Conversation

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def send_notifications():

    local_db_session = get_scoped_session()
    delinquent_mentors = get_delinquent_mentors()
    
    for mentor in delinquent_mentors:

        if mentor.member_id in [1, 197, 244, 248]:
            member_name = 'iMentor'
        # No messages for Pittsburgh.
        elif mentor.member_id in [233,]:
            continue
        else:
            member_name = 'mentor2.0'
            
        latest_counterparty = get_latest_mentee_for_mentor(mentor.user_id)
        if latest_counterparty:
            mentee_details = DBSession.query(
                IuserUser.first_name.label('first_name'),
                IuserUser.id.label('user_id')).\
                options(FromCache(DOGPILE_CACHE_REGION)).\
                filter(IuserUser.id == latest_counterparty.mentee_user_id).\
                first()
                
            mentee_name = mentee_details.first_name.capitalize()
        else:
            mentee_name = 'Your upcoming mentee'

        # We don't limit the Conversations recipient to the mentee, just in case the mentor isn't matched yet.
        conversation_details = DBSession.query(
            Conversation.id.label('conversation_id')).\
            options(FromCache(DOGPILE_CACHE_REGION)).\
            filter(Conversation.user_id == mentor.user_id).\
            filter(Conversation.received_by_server >= mentor.lesson_start).\
            filter(Conversation.received_by_server < mentor.lesson_end).\
            all()

        # Chicago doesn't want the conv-but-no-lesson message.
        if len(conversation_details) == 0 or mentor.member_id in [244,]:
            notification_body = '''Hi %s,

This is a friendly reminder to sign into the %s Platform and complete this week's Canvas lesson titled "%s" before our next class. %s will read and respond then!

Thank you,
%s Team''' % (mentor.first_name, member_name, mentor.lesson_description, mentee_name, mentor.class_name)

        else:

            notification_body = '''Hi %s,

We noticed that you and %s are using Conversations. Thank you! While Conversations is a great way to keep in touch, please prioritize the Canvas lesson to ensure %s has access to the right resources and considers the right questions at the right time.

Please sign into the %s Platform to complete this week's Canvas lesson titled %s before our next class. %s will read and respond then!

Thank you,
%s Team''' % (mentor.first_name, mentee_name, mentee_name, member_name, mentor.lesson_description, mentee_name, mentor.class_name)

        mailermsg = MailerMessage(
            to_address = mentor.email,
            when_added = datetime.datetime.now(),
            from_address = FROM_EMAIL,
            subject = 'Lesson participation reminder: "%s"' % mentor.lesson_description,
            message_body = notification_body,
            priority = 2,
            content_subtype = ''
            )
    
        local_db_session.add(mailermsg)
        local_db_session.commit()
        local_db_session.begin()

    # Finally, we consolidate the summary information into an email for staff.
    notification_summary = []
    notification_summary.append('Total mentor recipients: %d' % len(delinquent_mentors))

    message = MIMEMultipart()
    message['From'] = EMAIL_HOST_USER
    message['Subject'] = "Latest lesson participation notification summary"
    message.preamble = "Latest lesson participation notification summary"
    body = MIMEText("Following are the results of our daily lesson participation notifications to mentors from Joey through email.\n\n%s" % '\n\n'.join(notification_summary), _subtype="plain", _charset="utf-8")
    message.attach(body)
    SEND_TO = ['technotifications@imentor.org', 'ktoale@imentor.org']
    message['To'] = COMMASPACE.join(SEND_TO)

    smtp = smtplib.SMTP(EMAIL_HOST,EMAIL_PORT)
    try:
        if EMAIL_USE_TLS:
            smtp.starttls()
        smtp.ehlo()
        smtp.login(EMAIL_HOST_USER,EMAIL_HOST_PASSWORD)
        smtp.sendmail(EMAIL_HOST_USER,SEND_TO,message.as_string())
    finally:
        smtp.quit()

if __name__ == '__main__':
    send_notifications()
