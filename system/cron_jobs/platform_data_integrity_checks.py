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

from config.project_globals import db,Base,metadata,DBSession
from config.settings import (EMAIL_USE_TLS,EMAIL_HOST,EMAIL_HOST_USER,
    EMAIL_HOST_PASSWORD,EMAIL_PORT)
from sqlalchemy import (BigInteger, Boolean, Column, Date, DateTime,
    Float, ForeignKey, Index, Integer, Numeric, SmallInteger,
    String, Table, Text, Time, text, func)
from sqlalchemy.dialects.postgresql.base import INET, TSVECTOR
from sqlalchemy.orm import relationship

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def check_orphan_curriculum_master():
    result = db.session.execute(
        '''
        SELECT
            cc.id AS "Curriculum ID",
            cs.id AS "Set ID"
        FROM canvas_curriculum AS cc
        LEFT OUTER JOIN canvas_set AS cs ON cs.curriculum_id = cc.id
        WHERE cc.grade_id IS NOT NULL
            AND cs.id IS NULL;
        '''
        )

    return result

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def check_orphan_set_master():
    result = db.session.execute(
        '''
        SELECT
            cs.id AS "Set ID",
            cc.id AS "Curriculum ID"
        FROM canvas_set AS cs
        LEFT OUTER JOIN canvas_curriculum AS cc ON cc.id = cs.curriculum_id
        WHERE cc.grade_id IS NOT NULL
            AND cc.id IS NULL;
        '''
        )

    return result
    
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def check_orphan_curriculum_copy():
    result = db.session.execute(
        '''
        SELECT
            cc.id AS "Curriculum ID",
            cs.id AS "Set ID"
        FROM canvas_curriculum_copy AS cc
        LEFT OUTER JOIN canvas_set_copy AS cs ON cs.curriculum_id = cc.id
        WHERE cc.grade_id IS NOT NULL
            AND cs.id IS NULL;
        '''
        )

    return result
    
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def check_orphan_set_copy():
    result = db.session.execute(
        '''
        SELECT
            cs.id AS "Set ID",
            cc.id AS "Curriculum ID"
        FROM canvas_set_copy AS cs
        LEFT OUTER JOIN canvas_curriculum_copy AS cc ON cc.id = cs.curriculum_id
        WHERE cc.grade_id IS NOT NULL
            AND cc.id IS NULL;
        '''
        )

    return result
    
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def check_orphan_response_marker_master():
    result = db.session.execute(
        '''
        SELECT
            cwcrm.id AS "Response Marker ID",
            cwc.id AS "Widget Content ID"
        FROM canvas_widget_content_response_marker AS cwcrm
        LEFT OUTER JOIN canvas_widget_content AS cwc ON cwc.id = cwcrm.widget_content_id
        WHERE cwc.id IS NULL;
        '''
        )

    return result
    
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def check_orphan_response_marker_copy():
    result = db.session.execute(
        '''
        SELECT
            cwcrm.id AS "Response Marker ID",
            cwc.id AS "Widget Content ID"
        FROM canvas_widget_content_response_marker_copy AS cwcrm
        LEFT OUTER JOIN canvas_widget_content_copy AS cwc ON cwc.id = cwcrm.widget_content_id
        WHERE cwc.id IS NULL;
        '''
        )

    return result
    
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def check_orphan_marker_reference_master():
    result = db.session.execute(
        '''
        SELECT
            cwcmr.id AS "Marker Reference ID",
            cwc.id AS "Widget Content ID"
        FROM canvas_widget_content_marker_reference AS cwcmr
        LEFT OUTER JOIN canvas_widget_content AS cwc ON cwc.id = cwcmr.widget_content_id
        WHERE cwc.id IS NULL;
        '''
        )

    return result
    
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def check_orphan_marker_reference_copy():
    result = db.session.execute(
        '''
        SELECT
            cwcmr.id AS "Marker Reference ID",
            cwc.id AS "Widget Content ID"
        FROM canvas_widget_content_marker_reference_copy AS cwcmr
        LEFT OUTER JOIN canvas_widget_content_copy AS cwc ON cwc.id = cwcmr.widget_content_id
        WHERE cwc.id IS NULL;
        '''
        )

    return result
    
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def check_duplicate_responses():
    result = db.session.execute(
        '''
        SELECT
            user_id,
            marker_id,
            COUNT(*)
        FROM canvas_content_user_response
        GROUP BY
            user_id,
            marker_id
        HAVING COUNT(*) > 1;
        '''
        )

    return result
    
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def check_orphan_marker_reference_master2():
    result = db.session.execute(
        '''
        SELECT
            cwcmr.id AS "Marker Reference ID",
            cwcrm.id AS "Response Marker ID"
        FROM canvas_widget_content_marker_reference AS cwcmr
        LEFT OUTER JOIN canvas_widget_content_response_marker AS cwcrm ON cwcrm.id = cwcmr.other_marker_id
        WHERE cwcrm.id IS NULL;
        '''
        )

    return result
    
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def check_orphan_marker_reference_copy2():
    result = db.session.execute(
        '''
        SELECT
            cwcmr.id AS "Marker Reference ID",
            cwcmr.other_marker_id AS "Marker Reference Other Marker ID",
            cwcmr.parent_id AS "Marker Reference Parent ID",
            cwcmr.user_id AS "User ID",
            ip.id AS "Persona ID",
            ip.match_status AS "Match Status",
            cwcrm.id AS "Response Marker ID"
        FROM canvas_widget_content_marker_reference_copy AS cwcmr
        JOIN iuser_persona AS ip ON ip.user_id = cwcmr.user_id
        LEFT OUTER JOIN canvas_widget_content_response_marker_copy AS cwcrm ON cwcrm.id = cwcmr.other_marker_id
        WHERE cwcrm.id IS NULL
            AND ip.status = 'A'
            AND ip.match_status = 'M'
            AND cwcmr.other_marker_id != 0;
        '''
        )

    return result
    
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def check_orphan_response():
    result = db.session.execute(
        '''
        SELECT
            ccur.id AS "User Response ID",
            cwcrm.id AS "Response Marker ID"
        FROM canvas_content_user_response AS ccur
        LEFT OUTER JOIN canvas_widget_content_response_marker_copy AS cwcrm ON cwcrm.id = ccur.marker_id
        WHERE cwcrm.id IS NULL;
        '''
        )

    return result
    
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def check_google_sharing_master():
    result = db.session.execute(
        '''
        SELECT
            id AS "Widget Content ID",
            url AS "Google Resource"
        FROM canvas_widget_content
        WHERE content_type = 6 --6 is the Google content type.
            AND url NOT ILIKE '%?usp=sharing'
            AND url NOT ILIKE '%embed%';
        '''
        )

    return result
    
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def check_google_sharing_copy():
    result = db.session.execute(
        '''
        SELECT
            id AS "Widget Content ID",
            url AS "Google Resource",
            user_id AS "User ID"
        FROM canvas_widget_content_copy
        WHERE content_type = 6 --6 is the Google content type.
            AND url NOT ILIKE '%?usp=sharing'
            AND url NOT ILIKE '%embed%'
            AND new_doc_id IS NULL;
        '''
        )

    return result
    
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def check_lesson_labels_master():
    result = db.session.execute(
        '''
        SELECT
            id AS "Curriculum ID",
            canvas_type AS "Lesson Type",
            curriculum_number AS "Lesson Number"
        FROM canvas_curriculum
        WHERE (canvas_type = 2 AND curriculum_number != 1)
            OR (canvas_type = 1 AND curriculum_number = 1)
            OR (canvas_type = 3 AND curriculum_number = 1
                AND id NOT IN (111));
        '''
        )

    return result

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def check_lesson_labels_copy():
    result = db.session.execute(
        '''
        SELECT
            id AS "Curriculum ID",
            parent_id AS "Curriculum Parent ID",
            canvas_type AS "Lesson Type",
            curriculum_number AS "Lesson Number"
        FROM canvas_curriculum_copy
        WHERE (canvas_type = 2 AND curriculum_number != 1)
            OR (canvas_type = 1 AND curriculum_number = 1)
            OR (canvas_type = 3 AND curriculum_number = 1
                AND parent_id NOT IN (111));
        '''
        )

    return result
    
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def check_duplicate_reflections():
    result = db.session.execute(
        '''
        SELECT
            user_id,
            reflection_user_details_id,
            COUNT(*)
        FROM portfolio_reflection_user_response
        GROUP BY
            user_id,
            reflection_user_details_id
        HAVING COUNT(*) > 1;
        '''
        )

    return result

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def check_duplicate_messages():
    result = db.session.execute(
        '''
        SELECT
            id
        FROM (
            SELECT
                id,
                ROW_NUMBER() OVER (PARTITION BY user_id, recipient_user_id, "data" ORDER BY id ASC) AS rnum
            FROM conversation
        ) x
        WHERE x.rnum > 1;
        '''
        )

    return result

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def check_missing_mentor_marker_reference_copy():
    result = db.session.execute(
        '''
        SELECT
            rc.id AS "marker_ref_copy_id",
            rc.parent_id AS "marker_ref_id",
            rc.other_marker_id AS "other_marker_copy_id",
            mr.other_marker_id AS "other_marker_id",
            mc.id AS "response_marker_copy_id",
            mc.parent_id AS "response_marker_id",
            rc.user_id AS "mentor_user_id",
            rc.persona_id AS "mentor_persona_id",
            mc.user_id AS "mentee_user_id",
            mc.persona_id AS "mentee_persona_id"
        FROM canvas_widget_content_marker_reference_copy AS rc
        JOIN iuser_persona AS ip ON ip.id = rc.persona_id
        JOIN iuser_user AS iu ON iu.id = ip.user_id
        JOIN iuser_matchhistory AS mh ON mh.mentor_id = ip.id
        JOIN canvas_widget_content_marker_reference AS mr ON mr.id = rc.parent_id
        JOIN canvas_widget_content_response_marker_copy AS mc ON mc.parent_id = mr.other_marker_id AND mc.persona_id = mh.mentee_id
        WHERE ip.match_status = 'M'
            AND ip.status = 'A'
            AND iu.status = 'A'
            AND rc.other_marker_id = 0;
        '''
        )

    return result

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def check_missing_mentee_marker_reference_copy():
    result = db.session.execute(
        '''
        SELECT
            rc.id AS "marker_ref_copy_id",
            rc.parent_id AS "marker_ref_id",
            rc.other_marker_id AS "other_marker_copy_id",
            mr.other_marker_id AS "other_marker_id",
            mc.id AS "response_marker_copy_id",
            mc.parent_id AS "response_marker_id",
            rc.user_id AS "mentee_user_id",
            rc.persona_id AS "mentee_persona_id",
            mc.user_id AS "mentor_user_id",
            mc.persona_id AS "mentor_persona_id"
        FROM canvas_widget_content_marker_reference_copy AS rc
        JOIN iuser_persona AS ip ON ip.id = rc.persona_id
        JOIN iuser_user AS iu ON iu.id = ip.user_id
        JOIN iuser_matchhistory AS mh ON mh.mentee_id = ip.id
        JOIN canvas_widget_content_marker_reference AS mr ON mr.id = rc.parent_id
        JOIN canvas_widget_content_response_marker_copy AS mc ON mc.parent_id = mr.other_marker_id AND mc.persona_id = mh.mentor_id
        WHERE ip.match_status = 'M'
            AND ip.status = 'A'
            AND iu.status = 'A'
            AND rc.other_marker_id = 0;
        '''
        )

    return result

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def check_active_users_without_personas():
    result = db.session.execute(
        '''
        select
            iu.last_modified_date,
            iu.last_login,
            iu.first_name,
            iu.last_name,
            iu.email,
            iu.member_id,
            iu.status
        from iuser_user as iu
        left outer join iuser_persona as ip on ip.user_id = iu.id
        where ip.id is null
            and iu.status != 'ID';
        '''
        )

    return result

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def check_users_with_multiple_active_personas():
    result = db.session.execute(
        '''
        SELECT
            ip.user_id AS "user_id",
            COUNT(*)
        FROM iuser_persona AS ip
        JOIN iuser_user AS iu ON iu.id = ip.user_id
        WHERE ip.status = 'A'
            AND ip.match_status IN ('M', 'RTBM')
            AND iu.status = 'A'
            AND iu.member_id IN (1,191,196,233,245,244,246,237,231,195,247,236,234)
            AND ip.user_id NOT IN (
                SELECT
                    ip.user_id AS "user_id"
                FROM iuser_persona AS ip
                JOIN iuser_user AS iu ON iu.id = ip.user_id
                WHERE ip.status = 'A'
                    AND ip.match_status = 'M'
                    AND iu.status = 'A'
                    AND iu.member_id IN (1,191,196,233,245,244,246,237,231,195,247,236,234)
                GROUP BY ip.user_id
                HAVING COUNT(*) > 1
                ORDER BY ip.user_id DESC
                )
        GROUP BY ip.user_id
        HAVING COUNT(*) > 1
        ORDER BY ip.user_id DESC;
        '''
        )

    return result

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def check_users_with_multiple_matched_personas():
    result = db.session.execute(
        '''
        SELECT
            ip.user_id AS "user_id",
            COUNT(*)
        FROM iuser_persona AS ip
        JOIN iuser_user AS iu ON iu.id = ip.user_id
        WHERE ip.status = 'A'
            AND ip.match_status = 'M'
            AND iu.status = 'A'
            AND iu.member_id IN (1,191,196,233,245,244,246,237,231,195,247,236,234)
        GROUP BY ip.user_id
        HAVING COUNT(*) > 1
        ORDER BY ip.user_id DESC;
        '''
        )

    return result
    
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def check_unscrubbed_cell_phone_numbers():
    result = db.session.execute(
        '''
        SELECT
            id AS "user_id",
            cell_phone AS "original_cell"
        FROM iuser_user
        WHERE status IN ('A','SI','AI')
            AND (cell_phone ~ '^[1]' OR cell_phone ~ '[^0-9]');
        '''
        )

    return result

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def run_checks():

    orphan_curriculum_master = check_orphan_curriculum_master()
    orphan_set_master = check_orphan_set_master()
    orphan_curriculum_copy = check_orphan_curriculum_copy()
    orphan_set_copy = check_orphan_set_copy()
    orphan_response_marker_master = check_orphan_response_marker_master()
    orphan_response_marker_copy = check_orphan_response_marker_copy()
    orphan_marker_reference_master = check_orphan_marker_reference_master()
    orphan_marker_reference_copy = check_orphan_marker_reference_copy()
    duplicate_responses = check_duplicate_responses()
    duplicate_reflections = check_duplicate_reflections()
    duplicate_messages = check_duplicate_messages()
    orphan_marker_reference_master2 = check_orphan_marker_reference_master2()
    orphan_marker_reference_copy2 = check_orphan_marker_reference_copy2()
    orphan_response = check_orphan_response()
    google_sharing_master = check_google_sharing_master()
    google_sharing_copy = check_google_sharing_copy()
    lesson_labels_master = check_lesson_labels_master()
    lesson_labels_copy = check_lesson_labels_copy()
    missing_mentor_marker_reference_copy = check_missing_mentor_marker_reference_copy()
    missing_mentee_marker_reference_copy = check_missing_mentee_marker_reference_copy()
    active_users_without_personas = check_active_users_without_personas()
    users_with_multiple_active_personas = check_users_with_multiple_active_personas()
    users_with_multiple_matched_personas = check_users_with_multiple_matched_personas()
    unscrubbed_cell_phone_numbers = check_unscrubbed_cell_phone_numbers()
    
    check_results = []

    check_results.append('\n\nConversations checks')
    check_results.append('\tDuplicate message records: %d' % duplicate_messages.rowcount)

    check_results.append('\n\nPortfolio checks')
    check_results.append('\tDuplicate reflection records: %d' % duplicate_reflections.rowcount)

    check_results.append('\n\nCanvas checks')
    # Only one response marker ID per user ID exists.
    # Likewise, only one unit reflection ID per user ID exists.
    check_results.append('\tDuplicate user response records: %d' % duplicate_responses.rowcount)

    # Every user response has a valid response marker.
    check_results.append('\tUser responses without response markers: %d' % orphan_response.rowcount)
    
    # Every curriculum has a valid set, and vice versa.
    check_results.append('\tMaster curriculum records without sets: %d' % orphan_curriculum_master.rowcount)
    check_results.append('\tCopy curriculum records without sets: %d' % orphan_curriculum_copy.rowcount)
    check_results.append('\tMaster set records without curricula: %d' % orphan_set_master.rowcount)
    check_results.append('\tCopy set records without curricula: %d' % orphan_set_copy.rowcount)
    
    # All Google resources in edit mode have sharing enabled.
    check_results.append('\tMaster Google resources without sharing enabled: %d' % google_sharing_master.rowcount)
    check_results.append('\tCopy Google resources without sharing enabled: %d' % google_sharing_copy.rowcount)
    
    # Ensure opening, interim, and closing lessons are correctly labelled,
    # excluding exception lessons with only one lesson in the unit such as curriculum ID 111.
    check_results.append('\tMaster lesson records with incorrect opening, interim, and closing labels: %d' % lesson_labels_master.rowcount)
    check_results.append('\tCopy lesson records with incorrect opening, interim, and closing labels: %d' % lesson_labels_copy.rowcount)
    
    # Every response marker has a valid widget.
    check_results.append('\tMaster response marker records without widgets: %d' % orphan_response_marker_master.rowcount)
    check_results.append('\tCopy response marker records without widgets: %d' % orphan_response_marker_copy.rowcount)
    
    # Every marker reference has a valid widget.
    check_results.append('\tMaster marker reference records without widgets: %d' % orphan_marker_reference_master.rowcount)
    check_results.append('\tCopy marker reference records without widgets: %d' % orphan_marker_reference_copy.rowcount)
    
    # Every marker reference has a valid response marker.
    # Every marker reference copy for matched users should eventually have a response marker copy.
    # Therefore, we should see only a few records here for matched users whose match didn't get a copy yet.
    # Finally, 0 is the default other marker ID, before the match creates a response marker, so 0s are expected and valid.
    check_results.append('\tMaster marker reference records without response markers: %d' % orphan_marker_reference_master2.rowcount)
    check_results.append('\tCopy marker reference records without response markers: %d' % orphan_marker_reference_copy2.rowcount)
    
    # Although 0s are expected and valid under certain circumstances for the other marker ID column of marker reference copies,
    # they should not persist after the mentor and mentee of the match both have a copy of the lesson
    # and therefore both have the response marker copy and its marker reference copy.
    # Therefore, any 0s in the check below are an issue with the conversion of these 0s to the response marker copy ID.
    check_results.append('\tCopy marker reference records for mentors with persistent 0s in place of response marker copy IDs: %d' % missing_mentor_marker_reference_copy.rowcount)
    check_results.append('\tCopy marker reference records for mentees with persistent 0s in place of response marker copy IDs: %d' % missing_mentee_marker_reference_copy.rowcount)

    check_results.append('\n\nOther checks')    
    # It is a rare situation, but some active users have no personas, which is bad data and indicative of a bug.
    check_results.append('\tActive users without personas: %d' % active_users_without_personas.rowcount)
    # We exclude multple matched personas, since multiple matches may be possible again at iMentor
    # in the 2016-17 program year.
    # The corner case that we'll miss here is mutiple matches and an RTBM as well.
    # If we encounter it, we'll upgrade this code.
    check_results.append('\tUsers with multiple active personas ("M" and "RTBM"): %d' % users_with_multiple_active_personas.rowcount)
    # Multiple matches may be possible again at iMentor in the 2016-17 program year,
    # so we simply note the count here and do not attempt to resolve it.
    check_results.append('\tUsers with multiple matched personas ("M"): %d' % users_with_multiple_matched_personas.rowcount)
    # We ensure cell phone numbers do not have leading 1s and contain only digits.
    check_results.append('\tUnscrubbed cell phone numbers (leading 1s and non-digits): %d' % unscrubbed_cell_phone_numbers.rowcount)

    message = MIMEMultipart()
    message['From'] = EMAIL_HOST_USER
    message['Subject'] = "Latest platform data integrity checks"
    message.preamble = "Latest platform data integrity checks"
    body = MIMEText("Following are the results of our daily platform data integrity checks. 0s are expected, except in the cases of multiple matched personas and Canvas copy marker reference records without response markers, since iMentor is considering multiple matches in the 2016-17 program year and since some users may receive a lesson copy before their counterparties receive it.\n\n%s" % '\n\n'.join(check_results), _subtype="plain", _charset="utf-8")
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
    run_checks()