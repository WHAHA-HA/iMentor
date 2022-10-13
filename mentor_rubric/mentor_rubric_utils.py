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
from mentor_rubric.models import ProgramYear, MentorRubric
from dateutil import tz
from legacy_models.member import MemberMember
from legacy_models.utils import UtilsTimezone
from utils.user_details import get_latest_mentee_for_mentor, user_timezone
from legacy_models.iuser import (IuserUser, IuserPersona, IuserPersonaPartner, ACTIVE_PERSONA_STATUS,
    IuserAssignedusertype, IuserUsertype)
from legacy_models.partners import PartnersPartner

DISPLAY_DATE_FORMAT = '%d%m%Y'

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_program_years():

    # We obtain all program years and default to the current one.
    program_years = DBSession.query(
        ProgramYear.id.label('id'),
        ProgramYear.description.label('description'),
        ProgramYear.start_datetime.label('start'),
        ProgramYear.end_datetime.label('end')).\
        options(FromCache(DOGPILE_CACHE_REGION)).\
        order_by(ProgramYear.start_datetime.desc()).\
        all()

    outer_list = []
    for year in program_years:
        inner_list = []
        
        inner_list.append(year.id)
        inner_list.append('Program Year ' + year.description)
        
        if year.start <= datetime.datetime.utcnow() and year.end >= datetime.datetime.utcnow():
            inner_list.append('True')
        else:
            inner_list.append('False')

        outer_list.append(tuple(inner_list))

    return outer_list

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_rubric_data(partner_ids, program_year_id):

    # We obtain rubric data from the perspective of all mentors receiving iMentor services.
    class_mentors = DBSession.query(
        IuserUser.id.label('mentor_user_id'),
        IuserPersona.id.label('mentor_persona_id'),
        IuserUser.first_name.label('mentor_first_name'),
        IuserUser.last_name.label('mentor_last_name'),
        IuserUser.email.label('mentor_email'),
        PartnersPartner.name.label('class'),
        MentorRubric.strengths_based.label('strengths_based'),
        MentorRubric.resources.label('resources'),
        MentorRubric.response_time.label('response_time'),
        MentorRubric.curriculum.label('curriculum'),
        MentorRubric.admin_completed_datetime.label('admin_completed'),
        UtilsTimezone.name.label('time_zone')).\
        options(FromCache(DOGPILE_CACHE_REGION)).\
        join(IuserPersona, IuserUser.id == IuserPersona.user_id).\
        join(IuserPersonaPartner, IuserPersona.id == IuserPersonaPartner.persona_id).\
        join(IuserAssignedusertype, IuserPersona.assigned_usertype_id == IuserAssignedusertype.id).\
        join(IuserUsertype, IuserAssignedusertype.usertype_id == IuserUsertype.id).\
        join(PartnersPartner, IuserPersonaPartner.partner_id == PartnersPartner.id).\
        join(MemberMember, IuserUser.member_id == MemberMember.id).\
        join(UtilsTimezone, MemberMember.time_zone_id == UtilsTimezone.id).\
        outerjoin(MentorRubric, and_(IuserUser.id == MentorRubric.user_id, IuserPersona.id == MentorRubric.persona_id, program_year_id == MentorRubric.program_year_id)).\
        filter(IuserUsertype.id == 4).\
        filter(IuserPersona.status == ACTIVE_PERSONA_STATUS).\
        filter(IuserPersona.match_status == 'M').\
        filter(IuserUser.status == 'A').\
        filter(IuserPersonaPartner.partner_id.in_(partner_ids)).\
        order_by(PartnersPartner.name.asc()).\
        order_by(IuserUser.first_name.asc()).\
        order_by(IuserUser.last_name.asc()).\
        all()

    outer_list = []
    for mentor in class_mentors:
        to_tz = tz.gettz(mentor.time_zone)
        inner_list = []
        
        inner_list.append(mentor.mentor_first_name)
        inner_list.append(mentor.mentor_last_name)
        inner_list.append(mentor.mentor_user_id)
        inner_list.append(mentor.mentor_persona_id)
        
        mentor_profile_link = '/iuser/backend_profile/' + str(mentor.mentor_persona_id) + '/'
        inner_list.append(mentor_profile_link)
        
        inner_list.append(mentor.mentor_email)

        latest_counterparty = get_latest_mentee_for_mentor(mentor.mentor_user_id)
        if latest_counterparty:
            mentee_details = DBSession.query(
                IuserUser.first_name.label('mentee_first_name'),
                IuserUser.last_name.label('mentee_last_name'),
                IuserUser.email.label('mentee_email')).\
                options(FromCache(DOGPILE_CACHE_REGION)).\
                filter(IuserUser.id == latest_counterparty.mentee_user_id).\
                first()
        
            inner_list.append(mentee_details.mentee_first_name)
            inner_list.append(mentee_details.mentee_last_name)
            inner_list.append(latest_counterparty.mentee_user_id)
            inner_list.append(latest_counterparty.mentee_persona_id)

            mentee_profile_link = '/iuser/backend_profile/' + str(latest_counterparty.mentee_persona_id) + '/'
            inner_list.append(mentee_profile_link)
            
            inner_list.append(mentee_details.mentee_email)
        else:
            inner_list.append('NA')
            inner_list.append('NA')
            inner_list.append('NA')
            inner_list.append('NA')
            inner_list.append('NA')
            inner_list.append('NA')

        if mentor.strengths_based:
            inner_list.append(mentor.strengths_based)
        else:
            inner_list.append(2)

        if mentor.resources:
            inner_list.append(mentor.resources)
        else:
            inner_list.append(2)

        if mentor.response_time:
            inner_list.append(mentor.response_time)
        else:
            inner_list.append(2)
            
        if mentor.curriculum:
            inner_list.append(mentor.curriculum)
        else:
            inner_list.append(2)

        if mentor.admin_completed:
            admin_completed_display = mentor.admin_completed.replace(tzinfo=tz.gettz('UTC')).astimezone(to_tz).replace(tzinfo=None)
            inner_list.append(admin_completed_display.strftime(DISPLAY_DATE_FORMAT))
        else:
            inner_list.append('NA')

        outer_list.append(tuple(inner_list))

    return outer_list

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def update_mentor_data(local_db_session, user_id, persona_id, program_year_id, rubric_strengths_based,
    rubric_resources, rubric_response_time, rubric_curriculum):

    existing_data = local_db_session.query(MentorRubric).\
        filter(MentorRubric.user_id == user_id).\
        filter(MentorRubric.persona_id == persona_id).\
        filter(MentorRubric.program_year_id == program_year_id).\
        first()
        
    if existing_data:
        local_db_session.query(MentorRubric).\
            filter(MentorRubric.user_id == user_id).\
            filter(MentorRubric.persona_id == persona_id).\
            filter(MentorRubric.program_year_id == program_year_id).\
            update({'strengths_based': rubric_strengths_based, 'resources': rubric_resources,
                'response_time': rubric_response_time, 'curriculum': rubric_curriculum,
                'admin_completed_datetime': datetime.datetime.utcnow()})
    else:
        new_data = MentorRubric(
            user_id = user_id,
            persona_id = persona_id,
            program_year_id = program_year_id,
            strengths_based = rubric_strengths_based,
            resources = rubric_resources,
            response_time = rubric_response_time,
            curriculum = rubric_curriculum,
            admin_completed_datetime = datetime.datetime.utcnow())
    
        local_db_session.add(new_data)
    
    local_db_session.commit()
    local_db_session.begin()

    return

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
if __name__=="__main__":
    #get_program_years()
    get_rubric_data([1817,1816], 1)