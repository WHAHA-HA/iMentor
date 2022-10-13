# -*- coding: iso8859-15 -*-
import os,sys
import logging
import datetime

appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'../..'))
projdir2 = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)
    sys.path.append(projdir2)

from config.project_globals import (db,Base,metadata,
    DBSession,DOGPILE_CACHE_REGION)
from config.caching_query import CachingQuery,FromCache
from sqlalchemy import (BigInteger, Boolean, Column, Date, DateTime, 
    Float, ForeignKey, Index, Integer, Numeric, SmallInteger, 
    String, Table, Text, Time, text, func, or_)
from sqlalchemy.sql.expression import func, or_, not_, and_
from sqlalchemy.orm import sessionmaker, aliased
from attendance.models import Attendance, AttendanceDetail
from dateutil import tz
from legacy_models.member import MemberMember
from legacy_models.utils import UtilsTimezone
from utils.user_details import user_timezone, get_latest_mentor_user_for_mentee
from legacy_models.iuser import (IuserUser, IuserPersona, IuserPersonaPartner, ACTIVE_PERSONA_STATUS,
    IuserAssignedusertype, IuserUsertype)
from legacy_models.partners import PartnersPartner, PartnersSession
from canvas.models import PartnersSessionCurriculum
from decimal import Decimal
from legacy_models.mailer import MailerMessage
from config.settings import FROM_EMAIL

DATE_DISPLAY_FORMAT = '%-m/%-d/%y'

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_class_roster(partner_id):

    # We obtain data from the perspective of all mentees receiving iMentor services.
    class_mentees = DBSession.query(
        IuserUser.id.label('mentee_user_id'),
        IuserPersona.id.label('mentee_persona_id'),
        IuserUser.first_name.label('mentee_first_name'),
        IuserUser.last_name.label('mentee_last_name'),
        IuserPersonaPartner.partner_id.label('partner_id'),
        IuserUser.email.label('mentee_email')).\
        options(FromCache(DOGPILE_CACHE_REGION)).\
        join(IuserPersona, IuserUser.id == IuserPersona.user_id).\
        join(IuserPersonaPartner, IuserPersona.id == IuserPersonaPartner.persona_id).\
        join(IuserAssignedusertype, IuserPersona.assigned_usertype_id == IuserAssignedusertype.id).\
        join(IuserUsertype, IuserAssignedusertype.usertype_id == IuserUsertype.id).\
        filter(IuserUsertype.id == 5).\
        filter(IuserPersona.status == ACTIVE_PERSONA_STATUS).\
        filter(IuserPersona.match_status != 'C').\
        filter(IuserUser.status.in_(['A', 'SI'])).\
        filter(IuserPersonaPartner.partner_id == partner_id).\
        order_by(IuserPersona.match_status.asc()).\
        order_by(IuserUser.first_name.asc()).\
        order_by(IuserUser.last_name.asc()).\
        all()

    outer_list = []
    for mentee in class_mentees:
        inner_list = []
        
        inner_list.append(mentee.mentee_first_name)
        inner_list.append(mentee.mentee_last_name)
        inner_list.append(mentee.mentee_user_id)
        inner_list.append(mentee.mentee_persona_id)
        
        mentee_profile_link = '/iuser/backend_profile/' + str(mentee.mentee_persona_id) + '/'
        inner_list.append(mentee_profile_link)
        
        inner_list.append(mentee.mentee_email)

        outer_list.append(tuple(inner_list))

    return outer_list

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_lesson(partner_id, period, user_id):

    # This is a bit weird because we have a date when canvas changed drastically, and we made new masters:
    # Nov 20, 2016. We could have overlaps in lesson dates because of this, and it should not be a problem.
    # Under normal circumstances it is impossible to overlap. The code adjusts the end dates
    # to accommodate the newly scheduled class.

    if period == 'current_minus_1':
        limit = 2
    elif period == 'current_minus_2':
        limit = 3
    else: limit = 1

    # Get one or more "current" lessons, including all wierd overlaps first. Then try for older
    # lessons when these are no longer found.
    result = [x for x in DBSession.query(
            PartnersSessionCurriculum.curr_id.label('curriculum_id'),
            PartnersSession.description.label('lesson_description'),
            PartnersSession.start.label('lesson_start'),
            PartnersSession.end_date.label('lesson_end')).\
            options(FromCache(DOGPILE_CACHE_REGION)).\
            join(PartnersSession, PartnersSessionCurriculum.p_session_id == PartnersSession.id).\
            filter(PartnersSession.partner_id == partner_id).\
            filter(PartnersSession.end_date > datetime.datetime.utcnow()).\
            filter(PartnersSession.start <= datetime.datetime.utcnow()).\
            order_by(PartnersSession.start.desc()).\
            limit(limit).\
            all()]

    index = limit - 1
    limit -= len(result)
    if limit <= 0:
        result = result[index] # Found result
    else:
        index = limit - 1

        result = [x for x in DBSession.query(
            PartnersSessionCurriculum.curr_id.label('curriculum_id'),
            PartnersSession.description.label('lesson_description'),
            PartnersSession.start.label('lesson_start'),
            PartnersSession.end_date.label('lesson_end')).\
            options(FromCache(DOGPILE_CACHE_REGION)).\
            join(PartnersSession, PartnersSessionCurriculum.p_session_id == PartnersSession.id).\
            filter(PartnersSession.partner_id == partner_id).\
            filter(PartnersSession.end_date < datetime.datetime.utcnow()).\
            order_by(PartnersSession.end_date.desc()).\
            limit(limit).\
            all()]

        if result:
            if (len(result) - 1) < index:
                result = result[-1]
            else:
                result = result[index]


    inner_list = []

    if result:
        inner_list.append(result.curriculum_id)
        inner_list.append(result.lesson_description)
        
        to_tz = user_timezone(user_id)
        start_display = result.lesson_start.replace(tzinfo=tz.gettz('UTC')).astimezone(to_tz).replace(tzinfo=None)
        end_display = result.lesson_end.replace(tzinfo=tz.gettz('UTC')).astimezone(to_tz).replace(tzinfo=None)
        
        inner_list.append(start_display.strftime(DATE_DISPLAY_FORMAT))
        inner_list.append(end_display.strftime(DATE_DISPLAY_FORMAT))
    else:
        inner_list.append('NA')
        inner_list.append('NA')
        inner_list.append('NA')
        inner_list.append('NA')

    return tuple(inner_list)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_attendance(partner_id, curriculum_id):

    class_roster = get_class_roster(partner_id)
    outer_list = []
    for mentee in class_roster:
        inner_list = []
        attendance_details = get_attendance_details(partner_id, mentee[2], curriculum_id)

        # We confirm whether attendance data is available for this class, mentee, and lesson.
        if attendance_details:
            inner_list.append(attendance_details.description)
        else:
            inner_list.append('NA')

        outer_list.append(tuple(inner_list))

    return outer_list

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_attendance_statistics(partner_id, curriculum_id):

    class_roster = get_class_roster(partner_id)
    statistics_mentee_count = 0
    statistics_mentee_present_count = 0
    inner_list = []

    for mentee in class_roster:     
        # We reset these flags to prevent spillover from previous mentees.
        statistics_mentee_count += 1

        attendance_details = get_attendance_details(partner_id, mentee[2], curriculum_id)

        # We confirm whether attendance data is available for this class, mentee, and lesson.
        if attendance_details:
            # We confirm whether the lesson was completed on time.
            # Detail ID 2 is "present".
            if attendance_details.detail_id == 2:
                statistics_mentee_present_count += 1

    # We use statistics_mentee_count as the denominator in all cases here.
    if statistics_mentee_count > 0:
        statistics_mentee_present_pct = (Decimal(statistics_mentee_present_count)/Decimal(statistics_mentee_count)) * 100
    else:
        statistics_mentee_present_pct = 0

    inner_list.append('{:.0f}'.format(statistics_mentee_present_pct))
    
    # No outer list is necessary here, since we expect only one row of results.
    return tuple(inner_list)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_attendance_details(partner_id, user_id, curriculum_id):
        
    result = DBSession.query(
        Attendance.id.label('attendance_id'),
        AttendanceDetail.id.label('detail_id'),
        AttendanceDetail.description.label('description')).\
        options(FromCache(DOGPILE_CACHE_REGION)).\
        join(AttendanceDetail, Attendance.detail_id == AttendanceDetail.id).\
        filter(Attendance.partner_id == partner_id).\
        filter(Attendance.user_id == user_id).\
        filter(Attendance.curriculum_id == curriculum_id).\
        first()

    return result


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def update_mentee_attendance(local_db_session, partner_id, user_id, persona_id,
    curriculum_id, detail_id):

    existing_data = local_db_session.query(Attendance).\
        filter(Attendance.partner_id == partner_id).\
        filter(Attendance.user_id == user_id).\
        filter(Attendance.curriculum_id == curriculum_id).\
        first()
        
    if existing_data:
        local_db_session.query(Attendance).\
            filter(Attendance.partner_id == partner_id).\
            filter(Attendance.user_id == user_id).\
            filter(Attendance.curriculum_id == curriculum_id).\
            update({'detail_id': detail_id, 'admin_completed_datetime': datetime.datetime.utcnow()})
    else:
        new_data = Attendance(
            partner_id = partner_id,
            user_id = user_id,
            persona_id = persona_id,
            curriculum_id = curriculum_id,
            detail_id = detail_id,
            admin_completed_datetime = datetime.datetime.utcnow())
    
        local_db_session.add(new_data)
    
    local_db_session.commit()
    local_db_session.begin()

    # We send an email confirmation to the mentor only for absences.
    if detail_id == 3:
        other = get_latest_mentor_user_for_mentee(user_id)
    
        # Unmatched mentee, no one to receive this email
        if not other:
            return
        
        user_details = DBSession.query(
            IuserUser.first_name.label('user_first_name'),
            MemberMember.name.label('member_name'),
            MemberMember.url_name.label('member_url')).\
            join(MemberMember, IuserUser.member_id == MemberMember.id).\
            filter(IuserUser.id == user_id).\
            first()
    
        # We're adjusting case here, but plan to do so in the database soon.
        mentee_name = user_details[0].capitalize()
        mentor_name = other.first_name.capitalize()
    
        mailermsg = MailerMessage(
            to_address = other.email,
            when_added = datetime.datetime.now(),
            from_address = FROM_EMAIL,
            subject = "%s wasn't in class today..." % mentee_name,
            message_body = "Hi, %s. Even though %s was absent, there's still lots you can contribute. Please sign into the %s Platform at https://%s.imentor.org and complete your portion of Canvas so your mentee can respond the next time they sign in. Thanks!" % (mentor_name, mentee_name, user_details[1], user_details[2]),
            priority = 2,
            content_subtype = ''
            )
    
        local_db_session.add(mailermsg)
        local_db_session.commit()
        local_db_session.begin()

    return

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
if __name__=="__main__":
    #get_class_roster(1817)
    get_lesson(1817, 'current', 151826)
    #get_attendance(1817, 96)
    #get_attendance_statistics(1817, 96)
