#!/usr/bin/env python
# -*- coding: iso8859-15 -*-
import os,sys
import pprint
import logging
import io
import string, random
import smtplib
from email.mime.application import MIMEApplication
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.utils import COMMASPACE, formatdate

appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import (Base,metadata,
    DBSession,get_scoped_session)
from config.settings import (EMAIL_USE_TLS,EMAIL_HOST,EMAIL_HOST_USER,
    EMAIL_HOST_PASSWORD,EMAIL_PORT)


from sqlalchemy import (BigInteger, Boolean, Column, Date, DateTime,
    Float, ForeignKey, Index, Integer, Numeric, SmallInteger,
    String, Table, Text, Time, text, func)
from sqlalchemy.dialects.postgresql.base import INET, TSVECTOR
from sqlalchemy.orm import relationship

# This is formal because we used to CC Qualtrics on these errors.
# Their platform is unstable, and CCing them did not help, unfortuantely.
def send_crash_report(code,req,resp):

    SEND_TO = ['technotifications@imentor.org']

    message = MIMEMultipart()
    message['From'] = EMAIL_HOST_USER
    message['To'] = COMMASPACE.join(SEND_TO)
    message['Subject'] = "Qualtrics Service Outage reported by iMentor: Connection Timeout, Incident {0}".format(
        ''.join(random.SystemRandom().choice(string.ascii_uppercase + string.digits) for _ in range(10)))
    message.preamble = 'iMentor accessed a particular process at Qualtrics which is nonresponsive.'

    body = MIMEText('''
iMentor accessed a process wich is DOWN on one of your Qualtrics ReSTful API servers. 
This happens periodically, and due to it's inconsistent nature, we'll be tracking and reporting all incidents until the issue is resolved.

In lay terms: Even though your ReSTful service may appear to be up and running, one of your processes is DOWN, and NEEDS TO BE TAKEN OUT OF THE PROCESS POOL OR RESTARTED by Apache, on your Apache web services machine(s).

See the enclosed header information for details.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Return Code: {0}

Request: {1}

Response: {2}

    '''.format(code,pprint.pformat(req),pprint.pformat(resp)), _subtype="plain")

    message.attach(body)

    smtp = smtplib.SMTP(EMAIL_HOST,EMAIL_PORT)
    try:
        #smtp.set_debuglevel(5)
        if EMAIL_USE_TLS:
            smtp.starttls()
        smtp.ehlo()
        smtp.login(EMAIL_HOST_USER,EMAIL_HOST_PASSWORD)
        smtp.sendmail(EMAIL_HOST_USER,SEND_TO,message.as_string())
    finally:
        smtp.quit()

