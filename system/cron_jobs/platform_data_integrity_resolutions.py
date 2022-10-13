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

from config.project_globals import db,Base,metadata,DBSession
from config.settings import (EMAIL_USE_TLS,EMAIL_HOST,EMAIL_HOST_USER,
    EMAIL_HOST_PASSWORD,EMAIL_PORT)
from sqlalchemy import (BigInteger, Boolean, Column, Date, DateTime,
    Float, ForeignKey, Index, Integer, Numeric, SmallInteger,
    String, Table, Text, Time, text, func)
from sqlalchemy.dialects.postgresql.base import INET, TSVECTOR
from sqlalchemy.orm import relationship

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def count_orphan_curriculum_copy():
    result = db.session.execute(
        '''
        SELECT
            cc.id
        FROM canvas_curriculum_copy AS cc
        LEFT OUTER JOIN canvas_set_copy AS cs ON cs.curriculum_id = cc.id
        WHERE cc.grade_id IS NOT NULL --We ignore sample lessons without any grade.
            AND cs.id IS NULL;
        '''
        )

    return result

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def resolve_orphan_curriculum_copy():
    db.session.execute(
        '''
        DELETE FROM canvas_curriculum_copy *
        WHERE id IN (
            SELECT
                cc.id
            FROM canvas_curriculum_copy AS cc
            LEFT OUTER JOIN canvas_set_copy AS cs ON cs.curriculum_id = cc.id
            WHERE cc.grade_id IS NOT NULL --We ignore sample lessons without any grade.
                AND cs.id IS NULL
            );
        '''
        )
    db.session.commit()

    return

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def count_duplicate_responses():
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
def resolve_duplicate_responses():
    db.session.execute(
        '''
        DELETE FROM canvas_content_user_response *
        WHERE id IN (
            SELECT DISTINCT ON (user_id)
                NTH_VALUE(id, 1) OVER x AS "id"
            FROM canvas_content_user_response
            WHERE marker_id IN (
                SELECT
                    marker_id
                FROM canvas_content_user_response
                GROUP BY
                    user_id,
                    marker_id
                HAVING COUNT(*) > 1
            )
            WINDOW x AS (PARTITION BY user_id ORDER BY words ASC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
        );
        '''
        )
    db.session.commit()

    return

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def count_duplicate_reflections():
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
def resolve_duplicate_reflections():
    db.session.execute(
        '''
        DELETE FROM portfolio_reflection_user_response *
        WHERE id IN (
            SELECT DISTINCT ON (user_id)
                NTH_VALUE(id, 1) OVER x AS "id"
            FROM portfolio_reflection_user_response
            WHERE reflection_user_details_id IN (
                SELECT
                    reflection_user_details_id
                FROM portfolio_reflection_user_response
                GROUP BY
                    user_id,
                    reflection_user_details_id
                HAVING COUNT(*) > 1
            )
            WINDOW x AS (PARTITION BY user_id ORDER BY words ASC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
        );
        '''
        )
    db.session.commit()

    return

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def count_duplicate_messages():
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
def resolve_duplicate_messages():
    db.session.execute(
        '''
        DELETE FROM conversation *
        WHERE id IN (
            SELECT
                id
            FROM (
                SELECT
                    id,
                    ROW_NUMBER() OVER (PARTITION BY user_id, recipient_user_id, "data" ORDER BY id ASC) AS rnum
                FROM conversation
            ) x
            WHERE x.rnum > 1
        );
        '''
        )
    db.session.commit()

    return

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def count_missing_mentor_marker_reference_copy():
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
def resolve_missing_mentor_marker_reference_copy():
    db.session.execute(
        '''
        WITH missing_response_marker AS (
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
                AND rc.other_marker_id = 0
            )
        UPDATE canvas_widget_content_marker_reference_copy AS rc
        SET other_marker_id = mrm.response_marker_copy_id
        FROM missing_response_marker AS mrm
        WHERE rc.id = mrm.marker_ref_copy_id;
        '''
        )
    db.session.commit()

    return

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def count_missing_mentee_marker_reference_copy():
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
def resolve_missing_mentee_marker_reference_copy():
    db.session.execute(
        '''
        WITH missing_response_marker AS (
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
                AND rc.other_marker_id = 0
            )
        UPDATE canvas_widget_content_marker_reference_copy AS rc
        SET other_marker_id = mrm.response_marker_copy_id
        FROM missing_response_marker AS mrm
        WHERE rc.id = mrm.marker_ref_copy_id;
        '''
        )
    db.session.commit()

    return

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def count_active_users_without_personas():
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
def resolve_active_users_without_personas():
    result = db.session.execute(
        '''
        update iuser_user
        set status = 'ID'
        where id in (
            select
                iu.id
            from iuser_user as iu
            left outer join iuser_persona as ip on ip.user_id = iu.id
            where ip.id is null
                and iu.status != 'ID'
        );
        '''
        )
    db.session.commit()
    
    return result

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def count_users_with_multiple_active_personas():
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
def resolve_users_with_multiple_active_personas():
    result = db.session.execute(
        '''
        WITH multiple_active_personas AS (
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
            ORDER BY ip.user_id DESC
            )
        UPDATE iuser_persona AS ip
        SET match_status = 'C'
        FROM multiple_active_personas AS map
        WHERE ip.user_id = map.user_id
            AND ip.match_status = 'RTBM';
        '''
        )
    db.session.commit()
    
    return result

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def count_unscrubbed_cell_phone_numbers():
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
def resolve_unscrubbed_cell_phone_numbers():
    result = db.session.execute(
        '''
        WITH unscrubbed_cell_phone_numbers AS (
            SELECT
                id AS "user_id",
                cell_phone AS "original_cell",
                REGEXP_REPLACE(REGEXP_REPLACE(cell_phone, '^[1]', '', ''), '[^0-9]', '', 'g') AS "scrubbed_cell"
            FROM iuser_user
            WHERE status IN ('A','SI','AI')
                AND (cell_phone ~ '^[1]' OR cell_phone ~ '[^0-9]')
            )
        UPDATE iuser_user AS iu
        SET cell_phone = ucpn.scrubbed_cell
        FROM unscrubbed_cell_phone_numbers AS ucpn
        WHERE iu.id = ucpn.user_id;
        '''
        )
    db.session.commit()

    return result

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def run_resolutions():

    resolution_results = []

    resolution_results.append('\n\nConversations resolutions')
    duplicate_messages_count_pre = count_duplicate_messages()
    if duplicate_messages_count_pre.rowcount > 0:
        resolve_duplicate_messages()
        duplicate_messages_count_post = count_duplicate_messages()
        resolution_results.append('\tDuplicate message records: from %d to %d' % (duplicate_messages_count_pre.rowcount, duplicate_messages_count_post.rowcount))
    else:
        resolution_results.append('\tDuplicate message records: from 0 to 0')

    resolution_results.append('\n\nPortfolio resolutions')
    duplicate_reflections_count_pre = count_duplicate_reflections()
    if duplicate_reflections_count_pre.rowcount > 0:
        duplicate_reflections_count_post = count_duplicate_reflections()
        while (duplicate_reflections_count_post.rowcount > 0):
            resolve_duplicate_reflections()
            duplicate_reflections_count_post = count_duplicate_reflections()
        resolution_results.append('\tDuplicate reflection records: from %d to %d' % (duplicate_reflections_count_pre.rowcount, duplicate_reflections_count_post.rowcount))
    else:
        resolution_results.append('\tDuplicate reflection records: from 0 to 0')

    resolution_results.append('\n\nCanvas resolutions')
    # Only one response marker ID per user ID exists.
    # Likewise, only one unit reflection ID per user ID exists.
    # We're very careful with this code, since it deletes user responses and reflections deemed duplicative.
    duplicate_responses_count_pre = count_duplicate_responses()
    if duplicate_responses_count_pre.rowcount > 0:
        duplicate_responses_count_post = count_duplicate_responses()
        while (duplicate_responses_count_post.rowcount > 0):
            resolve_duplicate_responses()
            duplicate_responses_count_post = count_duplicate_responses()
        resolution_results.append('\tDuplicate user response records: from %d to %d' % (duplicate_responses_count_pre.rowcount, duplicate_responses_count_post.rowcount))
    else:
        resolution_results.append('\tDuplicate user response records: from 0 to 0')

    # Every curriculum has a valid set, and vice versa.
    orphan_curriculum_count_pre = count_orphan_curriculum_copy()
    if orphan_curriculum_count_pre.rowcount > 0:
        resolve_orphan_curriculum_copy()
        orphan_curriculum_count_post = count_orphan_curriculum_copy()
        resolution_results.append('\tCopy curriculum records without sets: from %d to %d' % (orphan_curriculum_count_pre.rowcount, orphan_curriculum_count_post.rowcount))
    else:
        resolution_results.append('\tCopy curriculum records without sets: from 0 to 0')

    # Although 0s are expected and valid under certain circumstances for the other marker ID column of marker reference copies,
    # they should not persist after the mentor and mentee of the match both have a copy of the lesson
    # and therefore both have the response marker copy and its marker reference copy.
    # Therefore, any 0s in the check below are an issue with the conversion of these 0s to the response marker copy ID.
    missing_mentor_marker_reference_copy_count_pre = count_missing_mentor_marker_reference_copy()
    if missing_mentor_marker_reference_copy_count_pre.rowcount > 0:
        resolve_missing_mentor_marker_reference_copy()
        missing_mentor_marker_reference_copy_count_post = count_missing_mentor_marker_reference_copy()
        resolution_results.append('\tCopy marker reference records for mentors with persistent 0s in place of response marker copy IDs: from %d to %d' % (missing_mentor_marker_reference_copy_count_pre.rowcount, missing_mentor_marker_reference_copy_count_post.rowcount))
    else:
        resolution_results.append('\tCopy marker reference records for mentors with persistent 0s in place of response marker copy IDs: from 0 to 0')

    missing_mentee_marker_reference_copy_count_pre = count_missing_mentee_marker_reference_copy()
    if missing_mentee_marker_reference_copy_count_pre.rowcount > 0:
        resolve_missing_mentee_marker_reference_copy()
        missing_mentee_marker_reference_copy_count_post = count_missing_mentee_marker_reference_copy()
        resolution_results.append('\tCopy marker reference records for mentees with persistent 0s in place of response marker copy IDs: from %d to %d' % (missing_mentee_marker_reference_copy_count_pre.rowcount, missing_mentee_marker_reference_copy_count_post.rowcount))
    else:
        resolution_results.append('\tCopy marker reference records for mentees with persistent 0s in place of response marker copy IDs: from 0 to 0')

    resolution_results.append('\n\nOther resolutions')
    # Every active user has a persona.
    active_users_without_personas_count_pre = count_active_users_without_personas()
    if active_users_without_personas_count_pre.rowcount > 0:
        resolve_active_users_without_personas()
        active_users_without_personas_count_post = count_active_users_without_personas()
        resolution_results.append('\tActive users without personas: from %d to %d' % (active_users_without_personas_count_pre.rowcount, active_users_without_personas_count_post.rowcount))
    else:
        resolution_results.append('\tActive users without personas: from 0 to 0')
        
    # Every user has one active and matched persona,
    # except for the few users who will have multiple personas.
    # This resolution may conflict with our desire to create a second active "RTBM" persona,
    # so we'll upgrade this code as necessary soon.
    users_with_multiple_active_personas_count_pre = count_users_with_multiple_active_personas()
    if users_with_multiple_active_personas_count_pre.rowcount > 0:
        resolve_users_with_multiple_active_personas()
        users_with_multiple_active_personas_count_post = count_users_with_multiple_active_personas()
        resolution_results.append('\tUsers with multiple active personas ("M" and "RTBM"): from %d to %d' % (users_with_multiple_active_personas_count_pre.rowcount, users_with_multiple_active_personas_count_post.rowcount))
    else:
        resolution_results.append('\tUsers with multiple active personas ("M" and "RTBM"): from 0 to 0')

    # We ensure cell phone numbers do not have leading 1s and contain only digits.        
    unscrubbed_cell_phone_numbers_count_pre = count_unscrubbed_cell_phone_numbers()
    if unscrubbed_cell_phone_numbers_count_pre.rowcount > 0:
        resolve_unscrubbed_cell_phone_numbers()
        unscrubbed_cell_phone_numbers_count_post = count_unscrubbed_cell_phone_numbers()
        resolution_results.append('\tUnscrubbed cell phone numbers (leading 1s and non-digits): from %d to %d' % (unscrubbed_cell_phone_numbers_count_pre.rowcount, unscrubbed_cell_phone_numbers_count_post.rowcount))
    else:
        resolution_results.append('\tUnscrubbed cell phone numbers (leading 1s and non-digits): from 0 to 0')

    message = MIMEMultipart()
    message['From'] = EMAIL_HOST_USER
    message['Subject'] = "Latest platform data integrity resolutions"
    message.preamble = "Latest platform data integrity resolutions"
    body = MIMEText("Following are the results of our weekly platform data integrity resolutions.\n\n%s" % '\n\n'.join(resolution_results), _subtype="plain", _charset="utf-8")
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
    run_resolutions()