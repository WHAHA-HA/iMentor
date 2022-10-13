# -*- coding: iso8859-15 -*-
import os,sys
import pprint
import pymongo
import logging
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'../..'))
projdir2 = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)
    sys.path.append(projdir2)
from config.project_globals import (Base,metadata,
    DOGPILE_CACHE_REGION,DBSession,get_scoped_session)
from config.caching_query import CachingQuery,FromCache
from config.settings import (MONGO_HOST,MONGO_PORT,
    MONGO_DBNAME_MATCHING,MONGO_MSGQUEUE_COLLNAME)
#Import 'app' object from auth as well
from auth import api, app

from sqlalchemy import (BigInteger, Boolean, Column, Date, DateTime, 
    Float, ForeignKey, Index, Integer, Numeric, SmallInteger, 
    String, Table, Text, Time, text, func, or_)
from sqlalchemy.sql.expression import func, or_, not_, and_
from sqlalchemy.orm import sessionmaker, aliased
from sqlalchemy.orm.exc import NoResultFound, MultipleResultsFound
from legacy_models.partners import PartnersPartner
from legacy_models.curriculum import CurriculumPrompt
from legacy_models.calendars import CalendarsEventtype
from legacy_models.member import MemberMember,MemberSchool
from legacy_models.iuser import (IuserAssignedusertype,
    IuserUser,IuserUsertype,IuserPersona,IuserPersonaPartner,MentorSiteList,
    IuserMatchhistory,
    ACTIVE_PERSONA_STATUS,MENTOR,MENTEE,
    P_MATCH_STATUS_MATCHED,P_MATCH_STATUS_NA,P_MATCH_STATUS_READY,
    P_MATCH_STATUS_RESCREENING,
    USER_STATUS_INTACTIVE_WITHDRAWN,USER_STATUS_APPLICATION_INCOMPLETE,
    USER_STATUS_SCREENING_INCOMPLETE,USER_STATUS_ACTIVE)
from new_platform.enrollment.models import (check_mentee_readiness_school,
    MenteeReadinessSchool,SCHOOL_ATTENDANCE_NO_LEFT,SCHOOL_ATTENDANCE_YES,
    PROGRAM_READINESS_YES)
from new_platform.utils.user_details import (get_persona_obj_for_user,
    get_persona_for_user)
from new_platform.utils.roles import Role

mongo_connection = pymongo.mongo_client.MongoClient(MONGO_HOST,MONGO_PORT)
database = pymongo.database.Database(mongo_connection,MONGO_DBNAME_MATCHING)
msg_queue_coll = database[MONGO_MSGQUEUE_COLLNAME]

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class MissingPersonaException(Exception):
    pass

class AccessDeniedException(Exception):
    pass

def adjust_user_status(user_id):
    '''
    For users who are currently User Status: SI, Match Status: NA
    WHEN Application Status = Complete + Attendance = Yes + Program Readiness = Yes + Parental Consent = Yes
    THEN Set User Status to Active and Match Status to RTBM
    
    For users who are currently User Status: Active, Match Status: RS
    WHEN Application Status = Complete + Attendance = Yes + Program Readiness = Yes + Parental Consent = Yes
    THEN User Status remains active and Match Status is set to RTBM

    IF Attendance = No - “Left School"
    THEN User Status = Inactive Withdrawn

    All other combinations will not change the User Status and User Status should remain as is.
    '''
    local_db_session = get_scoped_session()

    user = DBSession.query(IuserUser).filter(IuserUser.id==user_id).one()
    persona = get_persona_obj_for_user(user.id,ignore_match_status=True)
    if not persona:
        # Check if user has any persona. If they don't it's a bug.
        if not get_persona_for_user(user.id,email=None,get_all_active=True,
            ignore_match_status=True,ignore_active_status=True):
            raise MissingPersonaException("Whoa!! This user: {0}, {1} has no persona records of any kind. This is a bug.".format(
                user.id,user.email))

        raise AccessDeniedException("Not an error: This user: {0}, {1} has no active persona, tried to log in, and was denied access. This user has at least one persona record, but it is inactive.".format(
            user.id,user.email))

    role = Role(user.id)
    if role.role == MENTEE:
        mrs = local_db_session.query(MenteeReadinessSchool).filter(
            MenteeReadinessSchool.user_id==user.id).first()
        if not mrs:
            check_mentee_readiness_school(persona)
            #app.logger.exception("No MenteeReadinessSchool obj found for user {0}. Not crashing, just logging.".format(user.id))

            local_db_session.commit()

            # Django has trouble letting these fall out of scope. Close it to assist.
            local_db_session.close()

            return {'status':user.status,'match_status':persona.match_status}

        # Just make sure persona is set, since field was added later.
        elif mrs.persona_id == None:
            check_mentee_readiness_school(persona)

        if mrs.school_attendance == SCHOOL_ATTENDANCE_NO_LEFT:
            local_db_session.query(IuserUser).filter(IuserUser.id==user.id).update(
                {'status':USER_STATUS_INTACTIVE_WITHDRAWN})
            local_db_session.commit()

            # Django has trouble letting these fall out of scope. Close it to assist.
            local_db_session.close()

            return {'status':USER_STATUS_INTACTIVE_WITHDRAWN,'match_status':persona.match_status}

        elif persona.match_status == P_MATCH_STATUS_NA and user.status == USER_STATUS_SCREENING_INCOMPLETE:
            if user.status != USER_STATUS_APPLICATION_INCOMPLETE and mrs.school_attendance==SCHOOL_ATTENDANCE_YES and \
                mrs.program_readiness == PROGRAM_READINESS_YES and user.mentee_consent_form:

                local_db_session.query(IuserUser).filter(IuserUser.id==user.id).update(
                    {'status':USER_STATUS_ACTIVE})
                local_db_session.query(IuserPersona).filter(IuserPersona.id==persona.id).update(
                    {'match_status':P_MATCH_STATUS_READY})
                local_db_session.commit()
                msg_queue_coll.insert({'persona_id':persona.id})

                # Django has trouble letting these fall out of scope. Close it to assist.
                local_db_session.close()

                return {'status':USER_STATUS_ACTIVE,'match_status':P_MATCH_STATUS_READY}

        elif persona.match_status == P_MATCH_STATUS_RESCREENING and user.status == USER_STATUS_ACTIVE:
            if user.status != USER_STATUS_APPLICATION_INCOMPLETE and mrs.school_attendance==SCHOOL_ATTENDANCE_YES and \
                mrs.program_readiness == PROGRAM_READINESS_YES and user.mentee_consent_form:

                local_db_session.query(IuserPersona).filter(IuserPersona.id==persona.id).update(
                    {'match_status':P_MATCH_STATUS_READY})
                local_db_session.commit()

                # Django has trouble letting these fall out of scope. Close it to assist.
                local_db_session.close()

                return {'status':user.status,'match_status':P_MATCH_STATUS_READY}

        elif persona.match_status == P_MATCH_STATUS_READY:
            if user.status != USER_STATUS_ACTIVE or mrs.school_attendance != SCHOOL_ATTENDANCE_YES or \
                mrs.program_readiness != PROGRAM_READINESS_YES or not user.mentee_consent_form:

                local_db_session.query(IuserPersona).filter(IuserPersona.id==persona.id).update(
                    {'match_status':P_MATCH_STATUS_RESCREENING})
                local_db_session.commit()

                # Django has trouble letting these fall out of scope. Close it to assist.
                local_db_session.close()

                return {'status':user.status,'match_status':P_MATCH_STATUS_RESCREENING}


    local_db_session.commit()

    # Django has trouble letting these fall out of scope. Close it to assist.
    local_db_session.close()

    return {'status':user.status,'match_status':persona.match_status}
       

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
def assign_user_type(user_id,form_user_type):
    local_db_session = get_scoped_session()
    user = DBSession.query(IuserUser).filter(IuserUser.id==user_id).one()

    if form_user_type == 'Mentor':

        # Check if member school defaults exist for this member site.
        # If not, create it.
        # This really has nothing to do with the user.
        ms_default = DBSession.query(MemberSchool).filter(
            MemberSchool.member_id==user.member_id,
            MemberSchool.graduating_class==9999).first()

        if not ms_default:
            ms_default = MemberSchool(
                member_id=user.member_id,
                school="General",
                graduating_class=9999)

            local_db_session.add(ms_default)
            local_db_session.commit()
            local_db_session.begin()

        msl = MentorSiteList(
            user_id = user_id,
            member_school_id = ms_default.id
            )
        local_db_session.add(msl)
        local_db_session.commit()
        local_db_session.begin()

    usertype = DBSession.query(IuserUsertype).filter(
        IuserUsertype.type==form_user_type).one()

    assigned_usertype = DBSession.query(IuserAssignedusertype).filter(
        IuserAssignedusertype.member_id == user.member.id).filter(
        IuserAssignedusertype.usertype_id == usertype.id).one()


    # Potentially new user: Test if user has a persona. If not, create one.
    # We have the issue of users who may need to create another persona.
    # But we're not going to allow that here.
    # If their selection doesn't match their persona, we just save the selection
    # and change nothing else. Reconciliation with all form data happens elsewhere.
    iuser_persona = DBSession.query(IuserPersona).filter(
        IuserPersona.user_id == user.id,
        #IuserPersona.assigned_usertype_id == assigned_usertype.id # - no, it may not match.
        ).order_by(IuserPersona.id.desc()
        ).first()

    if not iuser_persona:
        iuser_persona = IuserPersona(
            user_id = user.id,
            assigned_usertype_id = assigned_usertype.id,
            status = ACTIVE_PERSONA_STATUS
            )
        local_db_session.add(iuser_persona)
        local_db_session.commit()
        local_db_session.begin()

        app.logger.warning("New User: Created persona {0} for user {1}".format(
            pprint.pformat(iuser_persona.__dict__),user.email))

    else:
        app.logger.info(
            "New User: Found existing persona {0} for user {1}, no changes made during mentor/mentee application".format(
            pprint.pformat(iuser_persona.__dict__),user.email))

    if form_user_type == 'Mentee':
        check_mentee_readiness_school(iuser_persona)
    if form_user_type == 'Mentor':
        ms = DBSession.query(MentorSiteList).filter(MentorSiteList.user_id==user.id).first()
        if not ms:
            # Now check if user (mentor) has a mmember school entry.
            mattr = DBSession.query(MemberSchool).filter(MemberSchool.school=='General').filter(
                MemberSchool.graduating_class==9999).filter(
                MemberSchool.member_id==user.member_id).first()
            if not mattr:
                mattr = MemberSchool(school='General',
                    graduating_class=9999,member_id=user.member_id)
                local_db_session.add(mattr)
                local_db_session.commit()
                local_db_session.begin()

            ms = MentorSiteList(
                user_id = iuser_persona.user.id,
                member_school_id = mattr.id
                )
            local_db_session.add(ms)
            local_db_session.commit()
            local_db_session.begin()

    iuser_persona = DBSession.query(IuserPersona).filter(
        IuserPersona.user_id == user.id,
        ).order_by(IuserPersona.id.desc()
        ).first()

    local_db_session.commit()

    # This doesn't fall out of scope when called by Django. Not sure why.
    local_db_session.close()
    return iuser_persona

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
# For new users:
def create_persona_partner(user_id,partner_id,form_map,form_user_type):
    local_db_session = get_scoped_session()

    user = DBSession.query(IuserUser).filter(IuserUser.id==user_id).one()

    usertype = DBSession.query(IuserUsertype).filter(
        IuserUsertype.type==form_map[form_user_type]).one()

    assigned_usertype = DBSession.query(IuserAssignedusertype).filter(
        IuserAssignedusertype.member_id == user.member.id).filter(
        IuserAssignedusertype.usertype_id == usertype.id).one()

    # Map persona to new partner. Remove old mapping if it exists.
    # Persona was created when form was requested.
    iuser_persona = DBSession.query(IuserPersona).filter(
        IuserPersona.user_id == user.id
        #IuserPersona.assigned_usertype_id == assigned_usertype.id # - no, it may not match.
        ).order_by(IuserPersona.id.desc()
        ).first()

    persona_partner_obj = local_db_session.query(IuserPersonaPartner).filter(
        IuserPersonaPartner.persona_id == iuser_persona.id
        )

    persona_partner = persona_partner_obj.first()

    if persona_partner:
        app.logger.warning(
            "New User: Found existing persona partner {0} for user {1}, removing and replacing it.".format(
            pprint.pformat(persona_partner.__dict__),user.email))

        persona_partner_obj.delete()

    persona_partner = IuserPersonaPartner(
        partner_id = partner_id,
        persona_id =  iuser_persona.id
        )

    local_db_session.add(persona_partner)
    local_db_session.commit()

    # This doesn't fall out of scope when called by Django. Not sure why.
    local_db_session.close()

    app.logger.warning(
        "New User: Added persona partner {0} for user {1}.".format(
       pprint.pformat(persona_partner.__dict__),user.email))

    return True

