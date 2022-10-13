#!/usr/bin/env python
# -*- coding: iso8859-15 -*-
import os,sys
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

from config.settings import DEFAULT_DAYS_BEFORE_EVENT
from config.project_globals import (app,db,DBSession,
    get_scoped_session,DOGPILE_CACHE_REGION)
from config.caching_query import CachingQuery,FromCache
from config.settings import (EMAIL_USE_TLS,EMAIL_HOST,EMAIL_HOST_USER,
    EMAIL_HOST_PASSWORD,EMAIL_PORT)
from sqlalchemy import (BigInteger, Boolean, Column, Date, DateTime,
    Float, ForeignKey, Index, Integer, Numeric, SmallInteger,
    String, Table, Text, Time, text, cast)
from sqlalchemy.dialects.postgresql.base import INET, TSVECTOR
from sqlalchemy.orm import relationship
from sms_notifications.sms_utils import get_tentative_rsvp_mentors
from sms_notifications.sms_outbound import process_notifications
from sms_notifications.models import SMSStop, SMSInvalidResponse, SMSMessage
from legacy_models.iuser import IuserUser, IuserPersona, IuserPersonaPartner
from legacy_models.partners import PartnersPartner
from utils.user_details import get_admin_obj_for_user

DATE_FORMAT = '%-m/%-d/%y'

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def send_notifications():

    # First, we send the SMS notifications to mentors.
    process_notifications(DEFAULT_DAYS_BEFORE_EVENT)

    # Next, we retrieve a count of mentor notification recipients, prior to the stop filter.
    tentative_rsvp_mentors = get_tentative_rsvp_mentors(DEFAULT_DAYS_BEFORE_EVENT)

    # Finally, we consolidate the summary information into an email for staff.
    notification_summary = []
    notification_summary.append('Total recipients of event SMS notifications, prior to the stop filter: %d' % len(tentative_rsvp_mentors))
    notification_summary.append('\n\nAll stop requests:')

    stop_results = DBSession.query(
        SMSStop.from_phone.label('phone'),
        SMSStop.date_stopped.label('date'),
        IuserUser.id.label('user_id'),
        IuserUser.first_name.label('first_name'),
        IuserUser.last_name.label('last_name'),
        IuserUser.email.label('email'),
        PartnersPartner.name.label('class_name')).\
        options(FromCache(DOGPILE_CACHE_REGION)).\
        join(IuserUser, SMSStop.user_id == IuserUser.id).\
        join(IuserPersona, IuserUser.id == IuserPersona.user_id).\
        join(IuserPersonaPartner, IuserPersona.id == IuserPersonaPartner.persona_id).\
        join(PartnersPartner, IuserPersonaPartner.partner_id == PartnersPartner.id).\
        filter(IuserPersona.match_status == 'M').\
        order_by(SMSStop.date_stopped.desc()).\
        all()

    if stop_results:
        for result in stop_results:      
            notification_summary.append(result.first_name + ' ' + result.last_name)
            notification_summary.append('\t' + result.date.strftime(DATE_FORMAT))
            notification_summary.append('\t' + result.email + ' and ' + str(result.phone).strip())

            mentor_admin = get_admin_obj_for_user(result.user_id, filtered = False)
            if mentor_admin:
                notification_summary.append('\t' + mentor_admin.email + ' and ' + result.class_name)
            else:
                notification_summary.append('\tNo staff and class information here, chief.')
    else:
        notification_summary.append('None yet, boss!')

    notification_summary.append('\n\nRecent invalid responses to event and lesson SMS notifications:')

    lookback_date = datetime.date.today() - datetime.timedelta(days = 7)
    invalid_results = DBSession.query(
        SMSInvalidResponse.response.label('response'),
        cast(SMSInvalidResponse.date_received, Date).label('date'),
        IuserUser.id.label('user_id'),
        IuserUser.first_name.label('first_name'),
        IuserUser.last_name.label('last_name'),
        IuserUser.email.label('email'),
        SMSInvalidResponse.from_phone.label('phone'),
        PartnersPartner.name.label('class_name')).\
        options(FromCache(DOGPILE_CACHE_REGION)).\
        join(IuserUser, SMSInvalidResponse.user_id == IuserUser.id).\
        join(IuserPersona, IuserUser.id == IuserPersona.user_id).\
        join(IuserPersonaPartner, IuserPersona.id == IuserPersonaPartner.persona_id).\
        join(PartnersPartner, IuserPersonaPartner.partner_id == PartnersPartner.id).\
        filter(IuserPersona.match_status == 'M').\
        filter(SMSInvalidResponse.date_received >= lookback_date).\
        order_by(SMSInvalidResponse.date_received.desc()).\
        all()

    if invalid_results:
        for result in invalid_results:
            notification_summary.append(result.response.strip())
            notification_summary.append('\t' + result.first_name + ' ' + result.last_name)
            notification_summary.append('\t' + result.date.strftime(DATE_FORMAT))
            notification_summary.append('\t' + result.email + ' and ' + result.phone)

            mentor_admin = get_admin_obj_for_user(result.user_id, filtered = False)
            if mentor_admin:
                notification_summary.append('\t' + mentor_admin.email + ' and ' + result.class_name)
            else:
                notification_summary.append('\tNo staff and class information here, chief.')
    else:
        notification_summary.append('Nothing to see here yet, boss!')

    message = MIMEMultipart()
    message['From'] = EMAIL_HOST_USER
    message['Subject'] = "Latest event and lesson SMS notification summary"
    message.preamble = "Latest event and lesson SMS notification summary"
    body = MIMEText("Following are the results of our event SMS notifications through Joey and our lesson SMS notifications through staff.\n\n%s" % '\n\n'.join(notification_summary), _subtype="plain", _charset="utf-8")
    message.attach(body)
    SEND_TO = ['technotifications@imentor.org', 'ktoale@imentor.org', 'jgrobe@imentor.org', 'mbrandon@imentor.org']
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
