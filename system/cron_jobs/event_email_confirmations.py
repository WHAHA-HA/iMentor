#!/usr/bin/env python
# -*- coding: iso8859-15 -*-
import os,sys
import pprint
import logging
import smtplib
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
from tasks.tasks_utils import send_rsvp_confirmations

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def send_confirmations():

    y_y_rsvp_confirmations_count = send_rsvp_confirmations('Y:Y')
    y_n_rsvp_confirmations_count = send_rsvp_confirmations('Y:N')
    y_mnr_rsvp_confirmations_count = send_rsvp_confirmations('Y:MNR')

    # We consolidate the summary information into an email for staff.
    notification_summary = []
    notification_summary.append('Total mentor recipients of "yes mentor, yes mentee": %d' % y_y_rsvp_confirmations_count)
    notification_summary.append('Total mentor recipients of "yes mentor, no mentee": %d' % y_n_rsvp_confirmations_count)
    notification_summary.append('Total mentor recipients of "yes mentor, maybe or no response mentee": %d' % y_mnr_rsvp_confirmations_count)

    message = MIMEMultipart()
    message['From'] = EMAIL_HOST_USER
    message['Subject'] = "Latest event email confirmation summary"
    message.preamble = "Latest event email confirmation summary"
    body = MIMEText("Following are the results of our daily event confirmations to mentors from Joey through email.\n\n%s" % '\n\n'.join(notification_summary), _subtype="plain", _charset="utf-8")
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
    send_confirmations()