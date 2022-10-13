# -*- coding: iso8859-15 -*-
import os,sys
import re
import pdb
import pprint
import traceback
from dateutil import tz
from datetime import datetime,timedelta
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import Base,metadata,DBSession,get_scoped_session

#Import 'app' object from auth as well
from auth import api, app

from flask import  current_app, request, redirect, render_template

from sqlalchemy import (BigInteger, Boolean, Column, Date, DateTime, desc,
    Float, ForeignKey, Index, Integer, Numeric, SmallInteger,
    String, Table, Text, Time, text, DATE, func, UniqueConstraint)
from sqlalchemy.dialects.postgresql.base import INET, TSVECTOR
from sqlalchemy.sql.expression import func, or_, not_, and_
from sqlalchemy.orm import relationship
from legacy_models.member import MemberMember
from legacy_models.partners import PartnersPartner,PartnersSession
from legacy_models.iuser import (IuserUser,IuserUsertype,IuserPersona,
    IuserPersonaPartner,IuserAssignedusertype,USERTYPE_MAP,ACTIVE_PERSONA_STATUS)
from new_platform.utils.user_details import (get_persona_obj_for_user,
    get_latest_mentee_user_for_mentor, get_latest_mentor_user_for_mentee,
    get_partners_for_user,get_users_for_partners,get_admin_obj_for_user,
    get_partner_admins_for_partners)
from new_platform.utils.roles import Role
from google_services.gdrive import create_gdoc_copy
from canvas.models import *
from canvas.legacy_updates import update_legacy_dependencies_with_new_canvas_set

class DupRoleException(Exception):
    pass

class NoPartnerException(Exception):
    pass

class MissingDateException(Exception):
    pass

class PersonaException(Exception):
    pass

class BadRangeException(Exception):
    pass


'''
Partner session adjustments
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
'''
def find_rightpsession(psc,psession,parent_curriculum,new_start_datetime):
    # First two parameters are dictionaries, detached from the db session.

    right_psession = DBSession.query(PartnersSessionCurriculum,PartnersSession,Curriculum).\
        filter(PartnersSessionCurriculum.curr_id==Curriculum.id).\
        filter(PartnersSessionCurriculum.p_session_id==PartnersSession.id).\
        filter(Curriculum.id!=parent_curriculum.id).\
        filter(Curriculum.active==True).\
        filter(PartnersSession.start >= new_start_datetime).\
        filter(PartnersSession.partner_id==psession['partner_id']).order_by(
        PartnersSession.start).first()

    if right_psession: 
        right_psession = right_psession[1]
        if right_psession.start.replace(tzinfo=None) == new_start_datetime:
            return False # Don't proceed, exact overlap exists.
        # Return recommended new end time, contiguous with rightcopy start datetime.
        return right_psession.start.replace(tzinfo=None) - timedelta(seconds=1)

def adjust_leftpsession_enddate(psc,psession,parent_curriculum,new_start_datetime,
    local_db_session):
    # Grab closest leftmost psession.
    # New left psession end should be contiguous with our new start.
    new_leftsession_end = new_start_datetime - timedelta(seconds=1)

    left_psession = DBSession.query(PartnersSessionCurriculum,PartnersSession,Curriculum).\
        filter(PartnersSessionCurriculum.curr_id==Curriculum.id).\
        filter(PartnersSessionCurriculum.p_session_id==PartnersSession.id).\
        filter(Curriculum.id!=parent_curriculum.id).\
        filter(Curriculum.active==True).\
        filter(PartnersSession.partner_id==psession['partner_id']).\
        filter(PartnersSession.start <= new_leftsession_end).order_by(
        desc(PartnersSession.start)).first()

    if left_psession: 
        left_psession = left_psession[1]
        if left_psession.start.replace(tzinfo=None) >= new_leftsession_end:
            return False # Don't proceed, exact overlap exists.

        local_db_session.query(PartnersSession).filter(PartnersSession.id==left_psession.id).update(
            {'end_date': new_leftsession_end})

        local_db_session.commit()
        local_db_session.begin()
        return True # OK to proceed

    return True # OK to proceed, no left session exists.
    

def adjust_psessions(psc,psession,parent_curriculum,new_start_datetime,
    new_end_datetime):
    local_db_session = get_scoped_session()

    # 1: Find right adjacent psession and adjust our new end date.
    # 2: Find left adjacent psession and adjust it's end date.
    # 3: Adjust matching psession.

    # 1
    new_end = find_rightpsession(psc,psession,parent_curriculum,new_start_datetime)
    if new_end == False:
        return False,None # Can't adjust this one.

    if new_end == None:
        new_end = new_end_datetime

    # 2
    if not adjust_leftpsession_enddate(psc,psession,parent_curriculum,
        new_start_datetime,local_db_session):
        local_db_session.commit()
        return False,None # Can't adjust this one.

    # 3
    local_db_session.query(PartnersSession).filter(PartnersSession.id==psession['id']).update(
        {'start':new_start_datetime,'end_date':new_end})
    local_db_session.commit()

    return True,new_end


def close_psession_gap(psc,psession,curriculum):
    # In the case of a psession adjustment that does not overlap with the 
    # original, we need to:
    # 1: Close the gap created by moving the orig

    local_db_session = get_scoped_session()
    # 1
    left_end = find_rightpsession(psc,psession,curriculum,
        psession['start'].replace(tzinfo=None))
    if left_end == False:
        local_db_session.commit()
        return False,None # Can't adjust this one.

    if left_end==None:
        local_db_session.commit()
        return True,None # No adjustment necessary, no new end date

    if not adjust_leftpsession_enddate(psc,psession,curriculum,left_end,
        local_db_session):
        local_db_session.commit()
        return False,None # Can't adjust this one.

'''
User copy adjustments
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
'''
def find_rightcopy(cscopy,new_start_datetime):
    local_db_session = get_scoped_session()

    rightcopy = local_db_session.query(CanvasSetCopy).filter(
        CanvasSetCopy.user_id==cscopy['user_id']).filter(
        CanvasSetCopy.id!=cscopy['id']).filter(
        CanvasSetCopy.start_datetime >= new_start_datetime).order_by(
        CanvasSetCopy.start_datetime).first()

    if rightcopy: 
        if new_start_datetime >= rightcopy.start_datetime - timedelta(seconds=1):
            app.logger.info("find_rightcopy: Not adjusting! user {0}, start {1}, new start conflicts: {2}".format(
                rightcopy.user_id, rightcopy.start_datetime, new_start_datetime))
            local_db_session.commit()
            return False # Don't proceed, new start >= new end

        # Return recommended new end time, contiguous with rightcopy start datetime.
        local_db_session.commit()
        return rightcopy.start_datetime - timedelta(seconds=1)

    local_db_session.commit()


def adjust_leftcopy_enddate(cscopy,new_start):
    # Grab closest leftmost non-overlapping lesson copy for this user. 
    # New leftcopy end should be contiguous with our new start.
    local_db_session = get_scoped_session()
    new_leftcopy_end = new_start - timedelta(seconds=1)

    ok_to_proceed = False

    matched_user = Role(cscopy['user_id']).get_matching_mentor_mentee()
    matched_user_id = None if not matched_user else matched_user.id

    leftcopy = local_db_session.query(CanvasSetCopy).filter(
        CanvasSetCopy.user_id==cscopy['user_id']).filter(
        CanvasSetCopy.matched_user_id==matched_user_id).filter(
        CanvasSetCopy.id!=cscopy['id']).filter(
        CanvasSetCopy.start_datetime <= new_leftcopy_end).order_by(
        desc(CanvasSetCopy.start_datetime)).first()

    if leftcopy: 
        if leftcopy.start_datetime >= new_leftcopy_end:
            app.logger.info("adjust_leftcopy_enddate: Not adjusting! user {0}, start {1}, new end conflicts: {2}".format(
                leftcopy.user_id, leftcopy.start_datetime, new_leftcopy_end))
            #return False # Don't proceed, exact overlap exists.

        local_db_session.query(CanvasSetCopy).filter(CanvasSetCopy.id==leftcopy.id).update(
            {'end_datetime': new_leftcopy_end})
        local_db_session.query(CurriculumCopy).filter(CurriculumCopy.id==leftcopy.curriculum_id).update(
            {'end_datetime': new_leftcopy_end})
        local_db_session.commit()
        local_db_session.begin()

    ok_to_proceed = True # OK to proceed, no left copy exists.

    # Double-check the curriculum copy, just to be sure all is in sync.
    leftcopy = local_db_session.query(CurriculumCopy).filter(
        CurriculumCopy.user_id==cscopy['user_id']).filter(
        CurriculumCopy.id!=cscopy['curriculum_id']).filter(
        CurriculumCopy.start_datetime <= new_leftcopy_end).order_by(
        desc(CurriculumCopy.start_datetime)).first()

    if leftcopy: 
        # Force update
        app.logger.info("Adjusting left curr copy for user id {0}".format(leftcopy.user_id))
        local_db_session.query(CurriculumCopy).filter(CurriculumCopy.id==leftcopy.id).update(
            {'end_datetime': new_leftcopy_end})

    local_db_session.commit()

    return ok_to_proceed
    

def adjust_user_copies(parent_curriculum,partner_id,orig_start,orig_end,start_datetime,
    end_datetime):
    # For an overlap:
    # Change the dates of all copied canvas sets, unless they have been moved for an individual.
    # Unlikely but possible. Ignore the outliers.
    local_db_session = get_scoped_session()
    partner = local_db_session.query(PartnersPartner).filter(PartnersPartner.id==partner_id).one()
    try:
        admin = local_db_session.query(IuserPersona).filter(IuserPersona.id==partner.member_contact_id).one().user
    except:
        admin = []
    try:
        partner_admins = get_partner_admins_for_partners([partner_id])
    except:
        partner_admins = []

    user_ids = [x.id for x in get_users_for_partners([partner_id])] + [admin.id] if admin else [] + [x.id for x in partner_admins] if partner_admins else []

    user_ids = list(set(user_ids)) # For uniqueness

    processed_user_ids=[]

    for curr_copy in local_db_session.query(CurriculumCopy).filter(
        CurriculumCopy.parent_id==parent_curriculum.id).filter(
        CurriculumCopy.user_id.in_(user_ids)).order_by(CurriculumCopy.id).all():
        app.logger.info("Doing curr copy {0}".format(curr_copy.id))

        # Only adjust current matches. If old match data overlaps, leave it. 
        matched_user = Role(curr_copy.user_id).get_matching_mentor_mentee()
        matched_user_id = None if not matched_user else matched_user.id
        if curr_copy.matched_user_id != matched_user_id:
            continue

        curr_copy = dict([(x,y) for x,y in curr_copy.__dict__.iteritems() if x != '_sa_instance_state'])

        #app.logger.info("Doing curr copy {0}".format(curr_copy['id']))
        cscopy = local_db_session.query(CanvasSetCopy).filter(
            CanvasSetCopy.curriculum_id==curr_copy['id']
            ).order_by(CanvasSetCopy.id).first()

        # Don't be overly concerned if a cscopy doesn't exist for a curriculum.
        if not cscopy:
            continue

        cscopy = dict([(x,y) for x,y in cscopy.__dict__.iteritems() if x != '_sa_instance_state'])
        app.logger.info("Doing user id {0}".format(cscopy['user_id']))

        processed_user_ids.append(cscopy['user_id'])

        # 1: Find right adjacent copy and adjust our new end date.
        # 2: Find left adjacent copy and adjust it's end date.
        # 3: Adjust matching copies.

        # 1
        new_end = find_rightcopy(cscopy,start_datetime)

        if new_end == False:
            continue # Can't adjust this one.
        if new_end == None:
            new_end = end_datetime

        # 2
        if not adjust_leftcopy_enddate(cscopy,start_datetime):

            # Correct rogue curr copy records only for current match, not old matches.
            local_db_session.query(CurriculumCopy).filter(
                CurriculumCopy.matched_user_id==matched_user_id).filter(
                CurriculumCopy.id==cscopy['curriculum_id']).update(
                {'start_datetime':cscopy['start_datetime'],'end_datetime':cscopy['end_datetime']})

            local_db_session.commit()
            local_db_session.begin()
            continue # Can't adjust this one.

        # 3
        local_db_session.query(CanvasSetCopy).filter(CanvasSetCopy.id==cscopy['id']).update(
            {'start_datetime':start_datetime,'end_datetime':new_end})

        local_db_session.query(CurriculumCopy).filter(CurriculumCopy.id==cscopy['curriculum_id']).update(
            {'start_datetime':start_datetime,'end_datetime':new_end})

        local_db_session.commit()
        local_db_session.begin()

    local_db_session.commit()

    # Return user list for users which have no matching lesson.
    return list(set(user_ids).difference(set(processed_user_ids)))


def close_user_copy_gap(parent_curriculum,partner_id):
    # for non-overlaps. Run this before adding the new curriculum records.
    local_db_session = get_scoped_session()
    partner = local_db_session.query(PartnersPartner).filter(PartnersPartner.id==partner_id).one()
    try:
        admin = local_db_session.query(IuserPersona).filter(IuserPersona.id==partner.member_contact_id).one().user
    except:
        admin = None
    try:
        partner_admins = get_partner_admins_for_partners([partner_id])
    except:
        partner_admins = []

    user_ids = [x.id for x in get_users_for_partners([partner_id])] + [admin.id] if admin else [] + [x.id for x in partner_admins] if partner_admins else []

    user_ids = list(set(user_ids)) # For uniqueness

    for curr_copy in local_db_session.query(CurriculumCopy).filter(CurriculumCopy.parent_id==parent_curriculum.id).all():
        curr_copy = dict([(x,y) for x,y in curr_copy.__dict__.iteritems() if x != '_sa_instance_state'])

        for cscopy in local_db_session.query(CanvasSetCopy).filter(
            CanvasSetCopy.user_id.in_(user_ids)).filter(
            CanvasSetCopy.curriculum_id==curr_copy['id']).all():
            cscopy = dict([(x,y) for x,y in cscopy.__dict__.iteritems() if x != '_sa_instance_state'])

            # 1: Find right adjacent copy. Use it to determine end date.
            # 2: Find left adjacent copy and adjust it's end date.

            # 1
            new_end = find_rightcopy(cscopy,cscopy['start_datetime'])
            if new_end in (False,None):
                new_end = cscopy['end_datetime']

            # 2
            if not adjust_leftcopy_enddate(cscopy,new_end):

                matched_user = Role(cscopy['user_id']).get_matching_mentor_mentee()
                matched_user_id = None if not matched_user else matched_user.id

                # Correct any rogue records.
                local_db_session.query(CurriculumCopy).filter(
                    CurriculumCopy.matched_user_id==matched_user_id).filter(
                    CurriculumCopy.id==cscopy['curriculum_id']).update(
                    {'start_datetime':cscopy['start_datetime'],'end_datetime':cscopy['end_datetime']})

                local_db_session.commit()
                local_db_session.begin()

    local_db_session.commit()

'''
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
'''

def schedule_fix_lessons(post_args,utc_start = False):
    partner_id = post_args['partner_ids'][0]
    curriculum_id = post_args['curriculum_id']
    
    partner = DBSession.query(PartnersPartner).filter(PartnersPartner.id==partner_id).one()
    to_tz = tz.gettz(partner.member.time_zone.name)

    if utc_start == False: 
        start_datetime = datetime.strptime(
            '{0}-{1}-{2} {3}:{4}:{5}'.format(
            post_args['start_year'], post_args['start_month'], post_args['start_day'],
            post_args['start_hour'], post_args['start_min'],0), "%y-%m-%d %H:%M:%S"
            ).replace(tzinfo=to_tz)    
        start_datetime = start_datetime.astimezone(tz.gettz('UTC'))
        start_datetime = start_datetime.replace(tzinfo=None)
        app.logger.info("Start date was not UTC. Now it is: {0}".format(start_datetime))
    else:
        start_datetime = datetime.strptime(post_args['start_datetime'], '%y-%m-%d %H:%M:%S')
        app.logger.info("Start date was UTC. {0}".format(start_datetime))

    return direct_schedule_fix(partner_id,curriculum_id,start_datetime)

def direct_schedule_fix(partner_id,curriculum_id,start_datetime):
    partner = DBSession.query(PartnersPartner).filter(PartnersPartner.id==partner_id).one()
    curriculum = DBSession.query(Curriculum).filter(Curriculum.active==True).filter(
        Curriculum.id==curriculum_id).one()
    if not curriculum:
        return None,None,None,False
    to_tz = tz.gettz(partner.member.time_zone.name)
    partner_id = partner.id
    end_datetime = start_datetime + timedelta(days = 150)
    match = False
    overlap = False

    if (start_datetime >= end_datetime):
        #print "Bad date range: {0} to {1} ".format(start_datetime,end_datetime)
        return None, None, None, None

    # Same lesson: Matching on curriculum id and partner id, not dates.
    fpsc = DBSession.query(PartnersSessionCurriculum,PartnersSession,Curriculum).\
        filter(PartnersSessionCurriculum.curr_id==Curriculum.id).\
        filter(Curriculum.id==curriculum.id).\
        filter(Curriculum.active==True).\
        filter(PartnersSessionCurriculum.p_session_id==PartnersSession.id).\
        filter(PartnersSession.partner_id==partner_id).first()

    if fpsc:
        m_psc,m_psession,m_curr = fpsc[0],fpsc[1],fpsc[2]
        # Detatch these from the db session since we'll be changing them.
        m_psc = dict([(x,y) for x,y in m_psc.__dict__.iteritems() if x != '_sa_instance_state'])
        m_psession = dict([(x,y) for x,y in m_psession.__dict__.iteritems() if x != '_sa_instance_state'])

        match = True

        # Look for overlap both ways: new start between existing start and end, 
        # old start between new start and end.
        if (m_psession['start'].replace(tzinfo=None) <= start_datetime and \
            m_psession['end_date'].replace(tzinfo=None) >= start_datetime) or \
            (start_datetime <= m_psession['start'].replace(tzinfo=None) and \
            end_datetime >= m_psession['start'].replace(tzinfo=None)):
            overlap = True

            # If match and overlap, adjust dates to the new ones.
            adj_status,end_datetime = adjust_psessions(m_psc,m_psession,m_curr,
                start_datetime,end_datetime)

            addlist = adjust_user_copies(curriculum,partner_id,
                m_psession['start'].replace(tzinfo=None),
                m_psession['end_date'].replace(tzinfo=None),start_datetime,
                end_datetime)

            '''
            print "Found same overlapping lesson: curriculum id {0} partner {1}, dates: {2} to {3}, new range: {4} to {5}".format(
                curriculum.id,partner_id,m_psession.start,m_psession.end_date,
                start_datetime,end_datetime)
            '''

        else: # Match and no overlap: close gap, adjust dates to new ones.
            close_psession_gap(m_psc,m_psession,curriculum)
            close_user_copy_gap(curriculum,partner_id)

            adj_status,end_datetime = adjust_psessions(m_psc,m_psession,m_curr,
                start_datetime,end_datetime)

            addlist = adjust_user_copies(curriculum,partner_id,
                m_psession['start'].replace(tzinfo=None),
                m_psession['end_date'].replace(tzinfo=None),start_datetime,
                end_datetime)

            '''
            print "Found same non-overlapping lesson: curriculum id {0} partner {1}, dates: {2} to {3}, new range: {4} to {5}".format(
                curriculum.id,partner_id,m_psession.start,m_psession.end_date,
                start_datetime,end_datetime)
            '''

        return addlist,start_datetime,end_datetime,False

    else:
        # Look for non-match exact overlap. Reject if it happens.
        fpsc = DBSession.query(PartnersSessionCurriculum,PartnersSession,Curriculum).\
            filter(PartnersSessionCurriculum.curr_id==Curriculum.id).\
            filter(Curriculum.active==True).\
            filter(PartnersSession.start == start_datetime).\
            filter(PartnersSessionCurriculum.p_session_id==PartnersSession.id).\
            filter(PartnersSession.partner_id==partner_id).first()

        if fpsc:
            return None,None,None,False

        # If no match, overlap is handled by standard adjust functions.
        # So we don't care about overlap here.
        # If there was nothing to adjust, this is fine.
           
        # This returns psc and psession dictionaries.
        psc,psession,new_curr = update_legacy_dependencies_with_new_canvas_set(
            curriculum.id, partner_id,start_datetime,end_datetime)

        adj_status,end_datetime = adjust_psessions(psc,psession,curriculum,start_datetime,
            end_datetime)

        addlist = adjust_user_copies(curriculum,partner_id,
            psession['start'].replace(tzinfo=None),
            psession['end_date'].replace(tzinfo=None),start_datetime,
            end_datetime)

        '''
        print "Found new non-overlapping lesson: curriculum id {0} partner {1}, new range: {2} to {3}".format(
            curriculum.id,partner_id,start_datetime,end_datetime)
        '''

        # Add new cscopies first, then fix overlaps (True = call this function again). 
        return addlist,start_datetime,end_datetime,True


