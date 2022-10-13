#!/usr/bin/env python
# -*- coding: iso8859-15 -*-
import os,sys
import pprint
import logging
import io
import csv
import smtplib
from email.mime.application import MIMEApplication
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.utils import COMMASPACE, formatdate
import datetime

appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'../..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import db,Base,metadata,DBSession
from config.settings import (EMAIL_USE_TLS,EMAIL_HOST,EMAIL_HOST_USER,
    EMAIL_HOST_PASSWORD,EMAIL_PORT)
from sqlalchemy import (BigInteger, Boolean, Column, Date, DateTime,
    Float, ForeignKey, Index, Integer, Numeric, SmallInteger,
    String, Table, Text, Time, text, func)
from sqlalchemy.dialects.postgresql.base import INET, TSVECTOR
from sqlalchemy.orm import relationship

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Utah (231), Pittsburgh (233), Charlotte (234) are filtered out.
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_admins():
    now = datetime.datetime.utcnow()
    now1 = datetime.datetime.utcnow().replace(year=now.year+1)
    now2 = datetime.datetime.utcnow().replace(year=now.year+2)
    if now.month >= 8:
        year1 = now1.year
        year2 = now2.year
    else:
        year1 = now.year
        year2 = now1.year

    # We get all administrators of classes with graduating seniors.
    result = db.session.execute(
        '''
        SELECT DISTINCT
            iu.first_name AS "Admin First Name",
            iu.last_name AS "Admin Last Name",
            iu.id AS "Admin User ID",
            ip.id as "Admin Persona ID",
            iu.email AS "Admin Email"
        FROM partners_partner AS pp
        JOIN iuser_persona AS ip ON ip.id = pp.member_contact_id
        JOIN iuser_user AS iu ON iu.id = ip.user_id
        JOIN member_school AS mm ON mm.id = pp.graduating_class_id
        JOIN member_member AS mmm ON mmm.id = iu.member_id
        WHERE pp.status_id = 1
            AND pp.is_alumni = FALSE
            AND pp.member_contact_id IS NOT NULL
            AND iu.status = 'A'
            AND mmm.status_id = 1 -- <== Active member site
            AND iu.member_id != 231 -- <== Don't send to Utah
            AND iu.member_id != 233 -- <== Don't send to Pittsburgh
            AND iu.member_id != 234 -- <== Don't send to Charlotte
            AND iu.first_name NOT IN ('iMentor', 'Volunteer')
            AND mm.graduating_class IN ({0}, {1});
        '''.format(year1,year2)
        )

    return result

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_progress(admin_persona_id):
    result = db.session.execute(
        '''
        SELECT
            REGEXP_REPLACE(mm.name, ',', ';', 'g') AS "Program Name",
            REGEXP_REPLACE(pp.name, ',', ';', 'g') AS "Partner Site Name",
            REGEXP_REPLACE(iu.first_name, ',', ';', 'g') AS "Mentee First Name",
            REGEXP_REPLACE(iu.last_name, ',', ';', 'g') AS "Mentee Last Name",
            iu.email AS "Mentee Email",
            iu.id AS "Mentee User ID",
            ip.id AS "Mentee Persona ID",
            REGEXP_REPLACE(uc.name, ',', ';', 'g') AS "College Name",
            REGEXP_REPLACE(uc.uni_system_name, ',', ';', 'g') AS "College System",
            REGEXP_REPLACE(uc.county_name, ',', ';', 'g') AS "College County",
            cca.name AS "College Category",
            app_deadline AS "Application Deadline",
            (CASE
                WHEN app_completion = 1 THEN 'Yes'
                WHEN app_completion = 2 THEN 'No'
                WHEN app_completion = 3 THEN 'NA'
                ELSE NULL
                END) AS "Application Completion",
            (CASE
                WHEN app_review = 1 THEN 'Yes'
                WHEN app_review = 2 THEN 'No'
                WHEN app_review = 3 THEN 'NA'
                ELSE NULL
                END) AS "Application Review",
            app_submission::DATE AS "Application Submission Date",
            (CASE
                WHEN fee_payment = 1 THEN 'Yes'
                WHEN fee_payment = 2 THEN 'No'
                WHEN fee_payment = 3 THEN 'NA'
                ELSE NULL
                END) AS "Fee Payment",
            (CASE
                WHEN transcript_submission = 1 THEN 'Yes'
                WHEN transcript_submission = 2 THEN 'No'
                WHEN transcript_submission = 3 THEN 'NA'
                ELSE NULL
                END) AS "Transcript Submission",
            (CASE
                WHEN test_submission = 1 THEN 'Yes'
                WHEN test_submission = 2 THEN 'No'
                WHEN test_submission = 3 THEN 'NA'
                ELSE NULL
                END) AS "Test Submission",
            (CASE
                WHEN essay_submission = 1 THEN 'Yes'
                WHEN essay_submission = 2 THEN 'No'
                WHEN essay_submission = 3 THEN 'NA'
                ELSE NULL
                END) AS "Essay Submission",
            (CASE
                WHEN recommendation_submission = 1 THEN 'Yes'
                WHEN recommendation_submission = 2 THEN 'No'
                WHEN recommendation_submission = 3 THEN 'NA'
                ELSE NULL
                END) AS "Recommendation Submission",
            (CASE
                WHEN fafsa_submission = 1 THEN 'Yes'
                WHEN fafsa_submission = 2 THEN 'No'
                WHEN fafsa_submission = 3 THEN 'NA'
                ELSE NULL
                END) AS "FAFSA Submission",
            (CASE
                WHEN result = 1 THEN 'Accepted'
                WHEN result = 2 THEN 'Rejected'
                WHEN result = 3 THEN 'Waitlisted'
                ELSE NULL
                END) AS "Result",
            (CASE
                WHEN choice = 1 THEN 'Going'
                WHEN choice = 2 THEN 'Not going'
                ELSE NULL
                END) AS "Choice"
        FROM br_temp_latest_partner_sites AS btlps
        JOIN br_temp_latest_personas AS btlp ON btlp.persona_id = btlps.persona_id
        JOIN iuser_persona AS ip ON ip.id = btlp.persona_id
        JOIN iuser_user AS iu ON iu.id = ip.user_id
        JOIN college_checklist AS cc ON cc.user_id = iu.id
        JOIN college_category AS cca ON cca.id = cc.category_id
        JOIN utils_college AS uc ON uc.id = cc.college_id
        JOIN iuser_assignedusertype AS iaut ON iaut.id = ip.assigned_usertype_id
        JOIN iuser_usertype AS iut ON iut.id = iaut.usertype_id
        JOIN partners_partner AS pp ON pp.id = btlps.partner_id
        JOIN member_member AS mm ON mm.id = iu.member_id
        WHERE iut.id = 5
            AND pp.member_contact_id = %d
            AND iu.member_id != 231 -- <== Don't send to Utah
            AND iu.member_id != 233 -- <== Don't send to Pittsburgh
            AND iu.member_id != 234 -- <== Don't send to Charlotte
        ORDER BY
            mm.name,
            pp.name,
            iu.first_name,
            iu.last_name ASC;
        ''' % admin_persona_id
        )

    return result

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def send_report():

    report_count = 0
    admin_list = get_admins()
    for admin in admin_list:
        message = MIMEMultipart()
        message['From'] = EMAIL_HOST_USER
        message['Subject'] = "Latest College Checklist progress"
        message.preamble = "Latest College Checklist progress"
        # A UTF-8 charset argument is necessary for administrator first names that may include characters outside of the ASCII range.
        body = MIMEText("Hi, %s! Check out the attachment for the latest progress on the College Checklist from your mentors and mentees. Thanks as always." % admin[0], _subtype="plain", _charset="utf-8")
        message.attach(body)
        if admin[4] in ['slake@imentor.org', 'jsimon@imentor.org', 'dfreeman@imentor.org', 'fquasarano@imentor.org']:
            SEND_TO = ['%s' % admin[4], 'smedeiros@imentor.org']
        else:
            SEND_TO = ['%s' % admin[4]]
        message['To'] = COMMASPACE.join(SEND_TO)

        progress = get_progress(admin[3])
        output = io.BytesIO()
        writer = csv.writer(output, delimiter='|')
        output.write('Program Name|Parnter Site Name|Mentee First Name|Mentee Last Name|Mentee Email|Mentee User ID|Mentee Persona ID|College Name|College System|College County|College Category|Application Deadline|Application Completion|Application Review|Application Submission Date|Fee Payment|Transcript Submission|Test Submission|Essay Submission|Recommendation Submission|FAFSA Submission|Result|Choice\n')
        for college in progress:
            writer.writerow([c.encode('utf-8') if type(c) in (str, unicode) else c for c in college])

        attachment = MIMEText(output.getvalue(), _subtype="csv")
        attachment.add_header("Content-Disposition", "attachment", filename='college_checklist_progress.csv')
        message.attach(attachment)

        smtp = smtplib.SMTP(EMAIL_HOST,EMAIL_PORT)
        try:
            if EMAIL_USE_TLS:
                smtp.starttls()
            smtp.ehlo()
            smtp.login(EMAIL_HOST_USER,EMAIL_HOST_PASSWORD)
            smtp.sendmail(EMAIL_HOST_USER,SEND_TO,message.as_string())
        finally:
            smtp.quit()

        # We delete the variables below to prevent duplicate attachments.
        del output
        del message
        report_count += 1
        
    send_confirmation(report_count)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def send_confirmation(report_count = 0):

    message = MIMEMultipart()
    message['From'] = EMAIL_HOST_USER
    message['Subject'] = "Confirmation: latest College Checklist progress"
    message.preamble = "Confirmation: latest College Checklist progress"
    if report_count == 1:
        correct_word = "MA"
    else:
        correct_word = "MAs"
    body = MIMEText("Today we sent the latest progress on the College Checklist to %d %s. Nice work!" % (report_count, correct_word), _subtype="plain", _charset="utf-8")
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
