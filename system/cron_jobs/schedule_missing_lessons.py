#!/usr/bin/env python
# -*- coding: iso8859-15 -*-
import os,sys
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

from config.settings import (EMAIL_USE_TLS,EMAIL_HOST,EMAIL_HOST_USER,
    EMAIL_HOST_PASSWORD,EMAIL_PORT)
from lesson_management.lesson_mgmt_utils import schedule_missing_lessons
from auth import app

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def send_report():

    #app.debug = True
    class_count, user_count = schedule_missing_lessons()

    if class_count == 1:
        correct_class_word = 'class'
    else:
        correct_class_word = 'classes'

    if user_count == 1:
        correct_user_word = 'user'
    else:
        correct_user_word = 'users'

    # Now we send staff their reports via email.
    message = MIMEMultipart()
    message['From'] = EMAIL_HOST_USER
    message['Subject'] = "Confirmation: latest missing lessons"
    message.preamble = "Confirmation: latest missing lessons"    
    body = MIMEText("Just now we attempted to schedule missing lessons for %d %s across %d %s.\n\nWe may not be able to schedule lessons for all of these users, depending on the following factors: match status, bad persona data, and lesson availability for all user types. In any case, someone hit the easy button!"
        % (user_count, correct_user_word, class_count, correct_class_word), _subtype="plain", _charset="utf-8")    
    message.attach(body)
    SEND_TO = ['technotifications@imentor.org']
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
    send_report()
