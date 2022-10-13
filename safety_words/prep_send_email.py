# -*- coding: iso8859-15 -*-
import pdb
import psycopg2
import pprint
import copy
import os,sys
import csv
import time
import smtplib
import datetime
from email.mime.application import MIMEApplication
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.utils import COMMASPACE, formatdate
from legacy_models.iuser import IuserPersonaPartner
from legacy_models.partners import PartnersPartner
from config.project_globals import app
from config.caching_query import CachingQuery,FromCache

appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.settings import (ENV_TYPE,EMAIL_USE_TLS,EMAIL_HOST,EMAIL_HOST_USER,
    EMAIL_HOST_PASSWORD,EMAIL_PORT,FROM_EMAIL)

from safety_words.models import SAFETY_APPS,SAFETY_FREQUENCY,SAFETY_APP_NAMES

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def send_results(results_by_admin,local_app,freq):

    outbound_msgs = []
    admin_count = 0

    for admin_email in results_by_admin:
        dbody = []
        # Key = record id, to avoid dups. value = full data set.
        for result in results_by_admin[admin_email].values():
            user = result['user']
            full_name = user['first_name'] + ' ' + user['last_name']
            user_id = str(user['id'])
            admin_first_name = result['admin_first_name']

            dbody.append(full_name + ' at ' + user['email'] + ' in ' + result['_source']['class_name'])
            dbody.append(result['url'])
            dbody.append(result['highlight'] + '\n\n')

        message = MIMEMultipart()
        message['From'] = EMAIL_HOST_USER
        message['Subject'] = "Latest {0} safety alerts for {1}".format(
            SAFETY_FREQUENCY[freq].lower(),SAFETY_APP_NAMES[local_app])
        message.preamble = "Latest {0} safety alerts for {1}".format(
            SAFETY_FREQUENCY[freq].lower(),SAFETY_APP_NAMES[local_app])
        #body = MIMEText(dbody, _subtype="plain", _charset="utf-8")
        body = MIMEText("Hi, %s. Below are the mentors and mentees in your cohort with safety alerts. Please review them carefully and contact your manager, as necessary.\n\n\n\n%s"
            % (admin_first_name, '\n\n'.join(dbody)), _subtype="plain", _charset="utf-8")
        message.attach(body)
        SEND_TO = [admin_email]
    
        if ENV_TYPE != 'Production':
            SEND_TO = ['testemails@imentor.org']
            message['Subject'] = 'Redirected to TEST for {0}: {1}'.format(
                admin_email,message['Subject'])
    
        message['To'] = COMMASPACE.join(SEND_TO)
        outbound_msgs.append({'TO':SEND_TO,'MSG':message})
        
        admin_count += 1

    smtp = smtplib.SMTP(EMAIL_HOST,EMAIL_PORT)
    try:
        if EMAIL_USE_TLS:
            smtp.starttls()
        smtp.ehlo()
        smtp.login(EMAIL_HOST_USER,EMAIL_HOST_PASSWORD)
        for o in outbound_msgs:
            smtp.sendmail(EMAIL_HOST_USER,o['TO'],o['MSG'].as_string())
    finally:
        smtp.quit()

    # We send the platform team a summary email with aggregated data.
    if admin_count > 0:
        send_confirmation(local_app, admin_count)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def send_confirmation(local_app, admin_count):

    message = MIMEMultipart()
    message['From'] = EMAIL_HOST_USER
    message['Subject'] = "Confirmation: latest %s safety alerts" % SAFETY_APP_NAMES[local_app]
    message.preamble = "Confirmation: latest %s safety alerts" % SAFETY_APP_NAMES[local_app]
    if admin_count == 1:
        correct_word = "MA"
    else:
        correct_word = "MAs"
    body = MIMEText("Just now we sent the latest %s safety alerts to %d %s. Nice work!"
        % (SAFETY_APP_NAMES[local_app], admin_count, correct_word), _subtype="plain", _charset="utf-8")
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