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
from datetime import datetime

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
from tasks.tasks_utils import get_low_ratings, get_ratings_drops, get_ratings_differences

DATE_FORMAT = '%-m/%-d/%y'

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_admins():
    # We get all administrators of our.
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
        JOIN member_member AS mm ON mm.id = iu.member_id
        WHERE pp.status_id = 1
            AND pp.is_alumni = FALSE
            AND pp.member_contact_id IS NOT NULL
            AND iu.status = 'A'
            AND mm.status_id = 1 -- <== Active member
            AND iu.first_name NOT IN ('iMentor', 'Volunteer')
            AND iu.member_id NOT IN (233) -- <== Not Pittsburg
        '''
        )

    return result

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def send_report():

    report_count = 0
    mentor_low_rating_count = 0
    mentee_low_rating_count = 0
    mentor_ratings_drop_count = 0
    mentee_ratings_drop_count = 0
    pair_ratings_difference_count = 0
    
    admin_list = get_admins()
    for admin in admin_list:
        notification_summary = []
        
        # We begin with low ratings.
        mentor_low_ratings = get_low_ratings('mentor', admin[3])
        mentee_low_ratings = get_low_ratings('mentee', admin[3])

        notification_summary.append('Mentors with ratings at 4 or below:')
        if mentor_low_ratings:
            for mentor in mentor_low_ratings:
                notification_summary.append(mentor.first_name + ' ' + mentor.last_name)
                notification_summary.append('\t' + str(mentor.rating) + ' on ' + mentor.rating_date.strftime(DATE_FORMAT))
                notification_summary.append('\t' + mentor.email)
                notification_summary.append('\t' + mentor.class_name)
                
                mentor_low_rating_count += 1
        else:
            notification_summary.append('None yet, boss!')
        
        notification_summary.append('\n\nMentees with ratings at 4 or below:')
        if mentee_low_ratings:
            for mentee in mentee_low_ratings:
                notification_summary.append(mentee.first_name + ' ' + mentee.last_name)
                notification_summary.append('\t' + str(mentee.rating) + ' on ' + mentee.rating_date.strftime(DATE_FORMAT))
                notification_summary.append('\t' + mentee.email)
                notification_summary.append('\t' + mentee.class_name)
                
                mentee_low_rating_count += 1
        else:
            notification_summary.append('Nothing to see here!')

        # We then detect ratings drops.
        mentor_ratings_drops = get_ratings_drops('mentor', admin[3])
        mentee_ratings_drops = get_ratings_drops('mentee', admin[3])

        notification_summary.append('\n\nMentors with ratings drops of 3 or more:')
        if mentor_ratings_drops:
            for mentor in mentor_ratings_drops:
                notification_summary.append(mentor[0] + ' ' + mentor[1])
                notification_summary.append('\t' + str(mentor[2]) + ' on ' + mentor[3].strftime(DATE_FORMAT) + ' to ' + str(mentor[4]) + ' on ' + mentor[5].strftime(DATE_FORMAT))
                notification_summary.append('\t' + mentor[6])
                notification_summary.append('\t' + mentor[7])
                
                mentor_ratings_drop_count += 1
        else:
            notification_summary.append('No problems here!')

        notification_summary.append('\n\nMentees with ratings drops of 3 or more:')
        if mentee_ratings_drops:
            for mentee in mentee_ratings_drops:
                notification_summary.append(mentee[0] + ' ' + mentee[1])
                notification_summary.append('\t' + str(mentee[2]) + ' on ' + mentee[3].strftime(DATE_FORMAT) + ' to ' + str(mentee[4]) + ' on ' + mentee[5].strftime(DATE_FORMAT))
                notification_summary.append('\t' + mentee[6])
                notification_summary.append('\t' + mentee[7])
                
                mentee_ratings_drop_count += 1
        else:
            notification_summary.append('All good, boss!')

        # We end with ratings differences.
        pair_ratings_differences = get_ratings_differences(admin[3])

        notification_summary.append('\n\nPairs with ratings differences of 4 or more:')
        if pair_ratings_differences:
            for pair in pair_ratings_differences:
                notification_summary.append('Mentor ' + pair[0] + ' ' + pair[1] + ' and mentee ' + pair[2] + ' ' + pair[3])
                notification_summary.append('\t' + str(pair[4]) + ' on ' + pair[5].strftime(DATE_FORMAT) + ' compared with ' + str(pair[6]) + ' on ' + pair[7].strftime(DATE_FORMAT))
                notification_summary.append('\t' + pair[8] + ' and ' + pair[9])
                notification_summary.append('\t' + pair[10])
                
                pair_ratings_difference_count += 1
        else:
            notification_summary.append("Couldn't be better, chief!")

        # Now we send staff their reports via email.
        message = MIMEMultipart()
        message['From'] = EMAIL_HOST_USER
        message['Subject'] = "Latest ratings issues"
        message.preamble = "Latest ratings issues"
        # A UTF-8 charset argument is necessary for administrator first names that may include characters outside of the ASCII range.
        
        body = MIMEText("Hi, %s! Below are the mentors and mentees in your cohort with ratings issues this month. Thanks as always.\n\n%s"
            % (admin[0], '\n\n'.join(notification_summary)), _subtype="plain", _charset="utf-8")
        
        message.attach(body)
        SEND_TO = ['%s' % admin[4]]
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

        report_count += 1
        
        # We delete the variables below to prevent duplicate attachments.
        del message

    # And of course, we send the platform team a summary email with aggregated data.
    send_confirmation(report_count, mentor_low_rating_count, mentee_low_rating_count,
        mentor_ratings_drop_count, mentee_ratings_drop_count, pair_ratings_difference_count)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def send_confirmation(report_count, mentor_low_rating_count,
    mentee_low_rating_count, mentor_ratings_drop_count, mentee_ratings_drop_count,
    pair_ratings_difference_count):

    message = MIMEMultipart()
    message['From'] = EMAIL_HOST_USER
    message['Subject'] = "Confirmation: latest ratings issues"
    message.preamble = "Confirmation: latest ratings issues"

    if report_count == 1:
        correct_staff_word = "MA"
    else:
        correct_staff_word = "MAs"

    if mentor_low_rating_count == 1:
        correct_mentor_low_rating_word = "mentor"
    else:
        correct_mentor_low_rating_word = "mentors"
        
    if mentee_low_rating_count == 1:
        correct_mentee_low_rating_word = "mentee"
    else:
        correct_mentee_low_rating_word = "mentees"
        
    if mentor_ratings_drop_count == 1:
        correct_mentor_ratings_drop_word = "mentor"
    else:
        correct_mentor_ratings_drop_word = "mentors"
        
    if mentee_ratings_drop_count == 1:
        correct_mentee_ratings_drop_word = "mentee"
    else:
        correct_mentee_ratings_drop_word = "mentees"
        
    if pair_ratings_difference_count == 1:
        correct_pair_ratings_difference_word = "pair"
    else:
        correct_pair_ratings_difference_word = "pairs"

    body = MIMEText("Today we sent the latest ratings issues to %d %s, which included the following details:\n\n\t%d %s and %d %s with low ratings\n\n\t%d %s and %d %s with ratings drops\n\n\t%d %s with ratings differences\n\nNice work!"
        % (report_count, correct_staff_word, mentor_low_rating_count, correct_mentor_low_rating_word,
            mentee_low_rating_count, correct_mentee_low_rating_word, mentor_ratings_drop_count,
            correct_mentor_ratings_drop_word, mentee_ratings_drop_count, correct_mentee_ratings_drop_word,
            pair_ratings_difference_count, correct_pair_ratings_difference_word), _subtype="plain", _charset="utf-8")

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
    send_report()
