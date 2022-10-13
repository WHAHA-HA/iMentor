# -*- coding: iso8859-15 -*-
import os,sys
import re
import pdb
import pprint
import traceback
import psycopg2
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

import sqlalchemy
from sqlalchemy import (BigInteger, Boolean, Column, Date, DateTime, desc,
    Float, ForeignKey, Index, Integer, Numeric, SmallInteger,
    String, Table, Text, Time, text, DATE, func, UniqueConstraint)
from sqlalchemy.dialects.postgresql.base import INET, TSVECTOR
from sqlalchemy.sql.expression import func, or_, not_, and_
from sqlalchemy.orm import relationship
from legacy_models.member import MemberMember
from legacy_models.utils import UtilsTimezone
from legacy_models.partners import PartnersPartner,PartnersSession
from legacy_models.iuser import (IuserUser,IuserUsertype,IuserPersona,
    IuserPersonaPartner,IuserAssignedusertype,USERTYPE_MAP,ACTIVE_PERSONA_STATUS,
    E_MEMBER_ADMIN,MEMBER_ADMIN,PARTNER_ADMIN)
from new_platform.utils.user_details import (get_persona_obj_for_user,
    get_latest_mentee_user_for_mentor, get_latest_mentor_user_for_mentee,
    get_partners_for_user,get_users_for_partners,get_admin_obj_for_user)
from new_platform.utils.roles import Role
from new_platform.utils.user_details import user_timezone
from google_services.gdrive import create_gdoc_copy
from canvas.models import *
from canvas.canvas_scheduling import schedule_fix_lessons
from attendance.models import Attendance

# We prefer this display formats for dates and times, since they are succinct yet still descriptive.
DATETIME_DISPLAY_FORMAT = '%-m/%-d/%y %-I:%M %p'

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Data model copy/retrieval functions.
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Find out which canvas set the user should receive.
#
# Note that start and end dates are used to override copies, not to
# search for current active ones.
def render_with_context(template, url='/', **kw):
    with app.test_request_context(url):
        return render_template(template, **kw)

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

def make_curriculum_copy(dontuse,parent_curriculum_id,user,persona,matched_user,member_id=None,
    optional_start_date=None,optional_end_date=None):

    local_db_session = get_scoped_session()

    corig = local_db_session.query(Curriculum).filter(Curriculum.id==parent_curriculum_id).filter(Curriculum.active==True).one()
    corig_dict = corig.__dict__
    corig_id = corig_dict['id']
    #local_db_session.expunge(corig)
    if '_sa_instance_state' in corig_dict:
        del corig_dict['_sa_instance_state']

    del corig_dict['id']
    # Doesn't exist in copy.
    #corig_dict['member_id'] = member_id if member_id else None
    del corig_dict['member_id']
    del corig_dict['featured_image']
    del corig_dict['secondary_description']
    corig_dict['user_id'] = user.id
    corig_dict['matched_user_id'] = matched_user.id if matched_user else None
    corig_dict['matched_persona_id'] = get_persona_obj_for_user(matched_user.id,ignore_match_status=True,ignore_active_status=False).id if matched_user else None
    corig_dict['persona_id'] = persona.id
    corig_dict['parent_id'] = corig_id
    corig_dict['start_datetime'] = optional_start_date if optional_start_date else corig_dict['start_datetime']
    corig_dict['end_datetime'] = optional_end_date if optional_end_date else corig_dict['end_datetime']
    del corig_dict['active']
    ccopy_new = CurriculumCopy(**corig_dict)
    local_db_session.add(ccopy_new)
    try:
        local_db_session.commit()
        ccopy_new = DBSession.query(CurriculumCopy).filter(CurriculumCopy.id == ccopy_new.id).one()
        return ccopy_new
            
    except sqlalchemy.exc.IntegrityError as e:
        if 'duplicate' in str(e.orig):
            from auth import app # KLUDGE: some other crash happens before this.
            app.logger.warning("make_curriculum_copy unique violation, skipping: {0}".format(traceback.format_exc()))
            local_db_session.rollback()
            local_db_session.begin()

            # Return already existing cset.
            DBSession.commit()
            muid = matched_user.id if matched_user else None
            ccopy_new = DBSession.query(CurriculumCopy).filter(
                CurriculumCopy.user_id==user.id).filter(
                CurriculumCopy.matched_user_id==muid).filter(
                CurriculumCopy.parent_id==corig_id).one()
            return ccopy_new
        else:
            from auth import app # KLUDGE: some other crash happens before this.
            app.logger.exception("make_curriculum_copy failed:{0}".format(traceback.format_exc()))
            raise

    except psycopg2.IntegrityError as err:
        if err.pgcode == '23505': # Unique violation
            from auth import app # KLUDGE: some other crash happens before this.
            app.logger.warning("flush: {0}".format(traceback.format_exc()))
            local_db_session.rollback()
            local_db_session.begin()

            # Return already existing cset.
            DBSession.commit()
            muid = matched_user.id if matched_user else None
            ccopy_new = DBSession.query(CurriculumCopy).filter(
                CurriculumCopy.user_id==user.id).filter(
                CurriculumCopy.matched_user_id==muid).filter(
                CurriculumCopy.parent_id==corig_id).one()
            return ccopy_new
        else:
            from auth import app # KLUDGE: some other crash happens before this.
            app.logger.exception("make_curriculum_copy failed, pg error code is {0}: {1}".format(err.pgcode,traceback.format_exc()))
            raise

    except:
        the_error = traceback.format_exc()
        if 'duplicate' in the_error:
            from auth import app # KLUDGE: some other crash happens before this.
            app.logger.warning("make_curriculum_copy unique violation, skipping: {0}".format(the_error))
            local_db_session.rollback()
            local_db_session.begin()

            # Return already existing cset.
            DBSession.commit()
            muid = matched_user.id if matched_user else None
            ccopy_new = DBSession.query(CurriculumCopy).filter(
                CurriculumCopy.user_id==user.id).filter(
                CurriculumCopy.matched_user_id==muid).filter(
                CurriculumCopy.parent_id==corig_id).one()
            return ccopy_new
        else:
            from auth import app # KLUDGE: some other crash happens before this.
            app.logger.exception("make_curriculum_copy failed:{0}".format(the_error))
            raise



def get_specific_canvas_set_for_user(local_db_session,
    user,matched_user,parent_curriculum_id,parent_canvas_set_id,
    skip_other=False,curr_start_date=None,curr_end_date=None,cset_start_date=None,
    cset_end_date=None,use_this_cscopy_id=None):
    #print "User: {0}".format(user.id)

    grade=None
    role = Role(user.id)
    # Try matching first, fall back to no match.
    persona = get_persona_obj_for_user(user.id,ignore_match_status=False)
    if not persona:
        persona = get_persona_obj_for_user(user.id,ignore_match_status=True)
    if not persona:
        raise PersonaException("User {0} has no persona. We ignored match status".format(user.id))
    '''
    try:
        partner = get_partners_for_user(user,role)[0]
    except:
        raise NoPartnerException("User {0} has no assigned partner, skipping.".format(
            user.email))
    '''

    muid = matched_user.id if matched_user else None

    if use_this_cscopy_id:
        ccopy = None
        # If retrieving hsitory, use old match in the copy we're retrieving.
        cscopy = DBSession.query(CanvasSetCopy).filter(
            CanvasSetCopy.user_id==user.id).filter(
            CanvasSetCopy.id==use_this_cscopy_id).one()
        if cscopy:
            matched_user = None if not cscopy.matched_user_id else \
                DBSession.query(IuserUser).filter(IuserUser.id==cscopy.matched_user_id).one()
            muid = matched_user.id if cscopy.matched_user_id else None
            ccopy = cscopy.curriculum_user_copy
            parent_canvas_set_id=cscopy.parent_id
    else:
        ccopy = DBSession.query(CurriculumCopy).filter(
            CurriculumCopy.user_id==user.id).filter(
            CurriculumCopy.matched_user_id==muid).filter(
            CurriculumCopy.parent_id==parent_curriculum_id).first()

    '''
    Allow access always, irrespective of date.
    if ccopy:
        if ccopy.end_datetime <= datetime.utcnow():
            msg = "get_specific_canvas_set_for_user(): User {0} has a copy {1} of parent {2}, but date expired.".format(user.id,ccopy.id,ccopy.parent_id)
            #print msg
            return {'success':False,'error':msg}
             
    else:
    '''
    if not ccopy:
        if not curr_start_date or not curr_end_date or not cset_start_date or not cset_end_date:
            msg = "When creating a copy of a specific lesson for a user, all of the curriculum and canvas set date parameters are necessary. We're missing at least one, rejecting for user {0} curriculum master {1}".format(user.id,parent_curriculum_id)
            from auth import app # KLUDGE: some other crash happens before this.
            app.logger.warning(msg)
            return {'success':False,'error':msg}

        #print "Can't find copy for master curriculum {0} for user {1}, creating it.".format(
        #    parent_curriculum_id,user.id)

        ccopy = make_curriculum_copy(local_db_session,parent_curriculum_id,user,persona,matched_user,member_id=None,
            optional_start_date=curr_start_date,optional_end_date=curr_end_date)

    return get_user_content(local_db_session,ccopy,user,role,persona,matched_user,grade,None,
        curr_start_date=curr_start_date,curr_end_date=curr_end_date,
        cset_start_date=cset_start_date,cset_end_date=cset_end_date,
        skip_other=skip_other,parent_canvas_set_id=parent_canvas_set_id)


def get_most_recent_canvas_set_for_user(local_db_session,user,matched_user,canvas_type=None,
    curr_start_date=None,curr_end_date=None,cset_start_date=None,cset_end_date=None,
    skip_other=False,use_grade=False):

    role = Role(user.id)
    # Try matching first, fall back to no match.
    persona = get_persona_obj_for_user(user.id,ignore_match_status=False)
    if not persona:
        persona = get_persona_obj_for_user(user.id,ignore_match_status=True)
    if not persona:
        raise PersonaException("User {0} has no persona. We ignored match status".format(user.id))

    grade = None
    grade_ref = None
    if use_grade:
        partners = get_partners_for_user(user,role)
        if len(partners) != 1:
            raise NoPartnerException("User {0} has no assigned partner, skipping.".format(
                user.email))
        partner = partners[0]

        grade = partner.graduating_class.grade
        grade_ref = DBSession.query(GradeInfo).filter(GradeInfo.grade_number==grade).one()

    '''
    If user's curriculum does not exist, create it here.
    '''
    muid = matched_user.id if matched_user else None
    ccopy = DBSession.query(CurriculumCopy).filter(CurriculumCopy.user_id==user.id
        ).filter(CurriculumCopy.matched_user_id==muid
        ).filter(and_(CurriculumCopy.start_datetime <= datetime.utcnow(),
             CurriculumCopy.end_datetime >= datetime.utcnow())).order_by(CurriculumCopy.start_datetime.desc())

    if grade: 
        ccopy = ccopy.filter(CurriculumCopy.grade_id==grade_ref.id)

    ccopy = ccopy.first()

    if ccopy:
        return get_user_content(local_db_session,ccopy,user,role,persona,matched_user,grade,None,
            curr_start_date=curr_start_date,curr_end_date=curr_end_date,
            cset_start_date=cset_start_date,cset_end_date=cset_end_date,
            skip_other=skip_other,parent_canvas_set_id=None)


    corig = DBSession.query(Curriculum).filter(
        and_(Curriculum.start_datetime <= datetime.utcnow(),Curriculum.end_datetime >= datetime.utcnow())).order_by(Curriculum.start_datetime.desc())

    if grade:
        corig = corig.filter(Curriculum.grade_id==grade_ref.id).first()
    else:
        corig = corig.first()

    if not corig:
        if grade:
            msg = 'No active Canvases found in the current date range for grade {0}'.format(grade)
        else:
            msg = 'No active Canvases found in the current date range '
        #print msg

        return {'success':False,'error':msg}

    # Check for expired copy.
    muid = matched_user.id if matched_user else None
    ccopy = DBSession.query(CurriculumCopy).filter(
        CurriculumCopy.matched_user_id==muid).filter(
        CurriculumCopy.user_id==user.id).filter(
        CurriculumCopy.parent_id==corig.id).first()

    if ccopy:
        if ccopy.end_datetime <= datetime.utcnow():
            msg = "get_most_recent_canvas_set_for_user(): User {0} has a copy {1} of parent {2}, but date expired.".format(user.id,ccopy.id,ccopy.parent_id)
            #print msg
            return {'success':False,'error':msg}
             
    ccopy = make_curriculum_copy(local_db_session,corig.id,user,persona,matched_user,member_id=None)

    return get_user_content(local_db_session,ccopy,user,role,persona,matched_user,grade,None,
        curr_start_date=curr_start_date,curr_end_date=curr_end_date,
        cset_start_date=cset_start_date,cset_end_date=cset_end_date,
        skip_other=skip_other,parent_canvas_set_id=None)


def get_user_content(dontuse, 
    curriculum,user,role,persona,matched_user,grade,canvas_type=None,
    curr_start_date=None,curr_end_date=None,cset_start_date=None,cset_end_date=None,
    skip_other=False,parent_canvas_set_id=None):
    # This is the user's copy of curriculum, not the master copy.
    local_db_session = get_scoped_session()

    # Accomodate for enhanced member admin, which is a superset of member admin.
    # Also assume partner admin is an admin, for ease of maintenance of master lessons.
    check_role = role.role
    if role.role in (E_MEMBER_ADMIN,PARTNER_ADMIN):
        check_role = MEMBER_ADMIN

    if parent_canvas_set_id:
        muid = matched_user.id if matched_user else None
        canvas_set_user = DBSession.query(CanvasSetCopy).filter(
            CanvasSetCopy.matched_user_id==muid).filter(
            CanvasSetCopy.user_id==user.id).filter(
            CanvasSetCopy.parent_id==parent_canvas_set_id).first()

        '''
        Allow access all the time if they ask for a specific lesson.
        if canvas_set_user and canvas_set_user.end_datetime <= datetime.utcnow():
            msg = "get_user_content(): User {0} has a copy {1} of parent {2}, but date expired.".format(user.id,canvas_set_user.id,canvas_set_user.parent_id)
            #print msg
            return {'success':False,'error':msg}
        '''
             
    else:
        muid = matched_user.id if matched_user else None
        canvas_set_user = DBSession.query(CanvasSetCopy).filter(
            CanvasSetCopy.matched_user_id==muid).filter(
            CanvasSetCopy.user_id==user.id).filter(
            CanvasSetCopy.curriculum_id==curriculum.id).first()

        if canvas_set_user and canvas_set_user.end_datetime <= datetime.utcnow():
            msg = "get_user_content(): User {0} has a copy {1} of parent {2}, but date expired.".format(user.id,canvas_set_user.id,canvas_set_user.parent_id)
            #print msg
            return {'success':False,'error':msg}
             

    if not canvas_set_user:
        if parent_canvas_set_id:
            if not curr_start_date or not curr_end_date or not cset_start_date or not cset_end_date:
                msg = "When creating a copy of a specific lesson for a user, all of the curriculum and canvas set date parameters are necessary. We're missing at least one, rejecting for user {0} canvas set master {1}".format(user.id,parent_canvas_set_id)
                #app.logger.warning(msg)
                return {'success':False,'error':msg}

            #print "Can't find copy for master canvas set {0} for user {1}, creating it.".format(
            #    parent_canvas_set_id,user.id)

            cset_user = DBSession.query(CanvasSet).filter(
                CanvasSet.id==parent_canvas_set_id).filter(
                CanvasSet.active==True).filter(
                CanvasSet.role==check_role).first()
        else:
            cset_user = DBSession.query(CanvasSet).filter(CanvasSet.role==check_role
                ).filter(CanvasSet.active==True
                ).filter(and_(CanvasSet.start_datetime <= datetime.utcnow(),CanvasSet.end_datetime >= datetime.utcnow())
                ).filter(CanvasSet.curriculum_id==curriculum.parent_id).order_by(CanvasSet.start_datetime.desc()).first()

        if not cset_user:
            msg = 'No active Canvas Sets found in the current date range for curriculum {0} role {1}'.format(curriculum.parent_id,USERTYPE_MAP[check_role])
            #print msg

            return {'success':False,'error':msg}

        mentor = None
        mentee = None
        if role.is_mentor:
            mentee = matched_user
            '''
            if mentee:
               print "Mentor {0} matched mentee: {1}".format(user.id,mentee.id)
            else:
               print "Mentor {0} has no mentee match".format(user.id)
            '''
            mentor = None
    
        elif role.is_mentee:
            mentor = matched_user
            '''
            if mentor:
               print "Mentee {0} matched mentor: {1}".format(user.id,mentor.id)
            else:
               print "Mentee {0} has no mentor match".format(user.id)
            '''
            mentee = None
    
        # Generate records for both mentor and matching mentee at the same time
        # if a match exists.
        if (role.is_mentor and mentee) or (role.is_mentee and mentor):
    
            other_persona = get_persona_obj_for_user(matched_user.id,ignore_match_status=False)
            other_role = Role(matched_user.id)
    
            # other user, same match, same curriculum.
            canvas_set_other = DBSession.query(CanvasSetCopy).filter(CanvasSetCopy.user_id==matched_user.id
                ).filter(CanvasSetCopy.user_id==matched_user.id
                ).filter(CanvasSetCopy.matched_user_id==user.id
                ).filter(CanvasSetCopy.curriculum_id==curriculum.id).first()
            #).filter(CanvasSetCopy.user_completed==None

            # Generate records for the match, if a match exists but records do not.
            if not canvas_set_other and not skip_other:
                if parent_canvas_set_id:
                    get_specific_canvas_set_for_user(local_db_session, 
                        matched_user,user,curriculum.parent_id,
                        parent_canvas_set_id=parent_canvas_set_id,skip_other=True,
                        curr_start_date=curr_start_date,curr_end_date=curr_end_date,
                        cset_start_date=cset_start_date, cset_end_date=cset_end_date)
                else:
                    get_most_recent_canvas_set_for_user(local_db_session, 
                        matched_user,user,None,skip_other=True,
                        curr_start_date=curr_start_date,curr_end_date=curr_end_date,
                        cset_start_date=cset_start_date, cset_end_date=cset_end_date)

        # We have to retrieve it again.
        if parent_canvas_set_id:
            cset_user = DBSession.query(CanvasSet).filter(
                CanvasSet.id==parent_canvas_set_id).first()
        else:
            # Accomodate for enhanced member admin, which is a superset of member admin.
            # Also assume partner admin is an admin, for ease of maintenance of master lessons.
            check_role = role.role
            if role.role in (E_MEMBER_ADMIN,PARTNER_ADMIN):
                check_role = MEMBER_ADMIN

            cset_user = DBSession.query(CanvasSet).filter(CanvasSet.role==check_role
                ).filter(and_(CanvasSet.start_datetime <= datetime.utcnow(),CanvasSet.end_datetime >= datetime.utcnow())
                ).filter(CanvasSet.curriculum_id==curriculum.parent_id).order_by(CanvasSet.start_datetime.desc()).first()

        try:
            canvas_set_user = create_user_copy(
                local_db_session,cset_user,curriculum,user,role,persona,grade,mentor,mentee,
                curr_start_date=curr_start_date,curr_end_date=curr_end_date,
                cset_start_date=cset_start_date,cset_end_date=cset_end_date)

        except sqlalchemy.exc.IntegrityError as e:
            if 'duplicate' in str(e.orig):
                from auth import app # KLUDGE: some other crash happens before this.
                local_db_session.rollback()
                local_db_session.begin()

                # Get a copy since it already exists. Must have been created by
                # a race condition.
                if parent_canvas_set_id:
                    muid = matched_user.id if matched_user else None
                    canvas_set_user = DBSession.query(CanvasSetCopy).filter(
                        CanvasSetCopy.user_id==user.id).filter(
                        CanvasSetCopy.matched_user_id==muid).filter(
                        CanvasSetCopy.parent_id==parent_canvas_set_id).first()

                else:
                    muid = matched_user.id if matched_user else None
                    canvas_set_user = DBSession.query(CanvasSetCopy).filter(
                        CanvasSetCopy.user_id==user.id).filter(
                        CanvasSetCopy.matched_user_id==muid).filter(
                        CanvasSetCopy.curriculum_id==curriculum.id).first()

            else:
                from auth import app # KLUDGE: some other crash happens before this.
                app.logger.exception("create_user_copy failed: {0}".format(traceback.format_exc()))
                raise

        except psycopg2.IntegrityError as err:
            if err.pgcode == '23505': # Unique violation
                from auth import app # KLUDGE: some other crash happens before this.
                app.logger.warning("create_user_copy unique violation, skipping: {0}".format(traceback.format_exc()))
                local_db_session.rollback()
                local_db_session.begin()

                # Get a copy since it already exists. Must have been created by
                # a race condition.
                if parent_canvas_set_id:
                    muid = matched_user.id if matched_user else None
                    canvas_set_user = DBSession.query(CanvasSetCopy).filter(
                        CanvasSetCopy.user_id==user.id).filter(
                        CanvasSetCopy.matched_user_id==muid).filter(
                        CanvasSetCopy.parent_id==parent_canvas_set_id).first()

                else:
                    muid = matched_user.id if matched_user else None
                    canvas_set_user = DBSession.query(CanvasSetCopy).filter(
                        CanvasSetCopy.user_id==user.id).filter(
                        CanvasSetCopy.matched_user_id==muid).filter(
                        CanvasSetCopy.curriculum_id==curriculum.id).first()

            else:
                from auth import app # KLUDGE: some other crash happens before this.
                app.logger.exception("create_user_copy failed, pg error code is {0}: {1}".format(err.pgcode,traceback.format_exc()))
                raise

        except:
            the_error = traceback.format_exc()
            if 'duplicate' in the_error:
                from auth import app # KLUDGE: some other crash happens before this.
                local_db_session.rollback()
                local_db_session.begin()

                # Get a copy since it already exists. Must have been created by
                # a race condition.
                if parent_canvas_set_id:
                    muid = matched_user.id if matched_user else None
                    canvas_set_user = DBSession.query(CanvasSetCopy).filter(
                        CanvasSetCopy.user_id==user.id).filter(
                        CanvasSetCopy.matched_user_id==muid).filter(
                        CanvasSetCopy.parent_id==parent_canvas_set_id).first()

                else:
                    muid = matched_user.id if matched_user else None
                    canvas_set_user = DBSession.query(CanvasSetCopy).filter(
                        CanvasSetCopy.user_id==user.id).filter(
                        CanvasSetCopy.matched_user_id==muid).filter(
                        CanvasSetCopy.curriculum_id==curriculum.id).first()

            else:
                from auth import app # KLUDGE: some other crash happens before this.
                app.logger.exception("create_user_copy failed: {0}".format(the_error))
                raise


        '''
        print "Created canvas set {0} from parent {1} for user {2}.".format(
            canvas_set_user.id, canvas_set_user.parent_id, user.id)
        '''
    to_tz = user_timezone(user.id)

    start_display = canvas_set_user.start_datetime.replace(tzinfo=tz.gettz('UTC')).astimezone(to_tz).replace(tzinfo=None)
    end_display = canvas_set_user.end_datetime.replace(tzinfo=tz.gettz('UTC')).astimezone(to_tz).replace(tzinfo=None)

    if canvas_set_user.user_first_completed:
        first_finish_display = canvas_set_user.user_first_completed.replace(tzinfo=tz.gettz('UTC')).astimezone(to_tz).replace(tzinfo=None)

    if canvas_set_user.user_completed:
        finish_display = canvas_set_user.user_completed.replace(tzinfo=tz.gettz('UTC')).astimezone(to_tz).replace(tzinfo=None)

    # We change the "no-response" card for the mentor, if her mentee was absent for this particular lesson.
    if role.is_mentor:
        mentee = get_latest_mentee_user_for_mentor(user.id)
        
        if mentee:
            attendance_data = DBSession.query(Attendance).\
                filter(Attendance.user_id == mentee.id).\
                filter(Attendance.curriculum_id == curriculum.parent_id).\
                filter(Attendance.detail_id == 3).\
                first()
                
            if attendance_data:
                mentee_absent = 'True'
            else:
                mentee_absent = 'False'
        else:
            mentee_absent = 'NA'
    else:
        mentee_absent = 'NA'

    outbound = {'canvas_set':canvas_set_user.__dict__}
    if '_sa_instance_state' in outbound['canvas_set']:
        del outbound['canvas_set']['_sa_instance_state']
        if 'curriculum_user_copy' in outbound['canvas_set']:
            del outbound['canvas_set']['curriculum_user_copy']
    outbound['canvas_set']['curriculum_id'] = canvas_set_user.curriculum_id
    outbound['canvas_set']['canvas_type'] = curriculum.canvas_type
    outbound['canvas_set']['created_datetime'] = outbound['canvas_set']['created_datetime'].strftime(DATETIME_DISPLAY_FORMAT)
    outbound['canvas_set']['last_viewed'] = outbound['canvas_set']['last_viewed'].strftime(DATETIME_DISPLAY_FORMAT) \
        if outbound['canvas_set']['last_viewed'] else None
    outbound['canvas_set']['admin_last_viewed'] = outbound['canvas_set']['admin_last_viewed'].strftime(DATETIME_DISPLAY_FORMAT) \
        if outbound['canvas_set']['admin_last_viewed'] else None
    outbound['canvas_set']['start_datetime'] = outbound['canvas_set']['start_datetime'].strftime(DATETIME_DISPLAY_FORMAT) \
        if outbound['canvas_set']['start_datetime'] else None
    outbound['canvas_set']['end_datetime'] = outbound['canvas_set']['end_datetime'].strftime(DATETIME_DISPLAY_FORMAT) \
        if outbound['canvas_set']['end_datetime'] else None
    outbound['canvas_set']['user_started'] = outbound['canvas_set']['user_started'].strftime(DATETIME_DISPLAY_FORMAT) \
        if outbound['canvas_set']['user_started'] else None
    outbound['canvas_set']['user_completed'] = outbound['canvas_set']['user_completed'].strftime(DATETIME_DISPLAY_FORMAT) \
        if outbound['canvas_set']['user_completed'] else None
    outbound['canvas_set']['user_first_completed'] = outbound['canvas_set']['user_first_completed'].strftime(DATETIME_DISPLAY_FORMAT) \
        if outbound['canvas_set']['user_first_completed'] else None
    outbound['canvas_set']['grade_id'] = curriculum.grade_id
    outbound['canvas_set']['unit_id'] = curriculum.unit_id
    outbound['canvas_set']['start_datetime_display'] = start_display.strftime(DATETIME_DISPLAY_FORMAT)
    outbound['canvas_set']['end_datetime_display'] = end_display.strftime(DATETIME_DISPLAY_FORMAT)

    if canvas_set_user.user_first_completed:
        outbound['canvas_set']['first_finish_display'] = first_finish_display.strftime(DATETIME_DISPLAY_FORMAT)
    else:
        outbound['canvas_set']['first_finish_display'] = 'NA'

    if canvas_set_user.user_completed:
        outbound['canvas_set']['finish_display'] = finish_display.strftime(DATETIME_DISPLAY_FORMAT)
    else:
        outbound['canvas_set']['finish_display'] = 'NA'
        
    outbound['canvas_set']['mentee_absent'] = mentee_absent

    outbound['canvas_set']['apps'] = []

    for app_obj in DBSession.query(CanvasAppCopy).filter(CanvasAppCopy.canvas_set_id==canvas_set_user.id).all():
        app = app_obj.__dict__
        if '_sa_instance_state' in app:
            del app['_sa_instance_state']
        outbound['canvas_set']['apps'].append(app)
        app['widgets'] = []

        for widget_obj in DBSession.query(WidgetCopy).filter(WidgetCopy.canvas_app_id==app['id']
            ).order_by(WidgetCopy.ordinal).all() :
            widget = widget_obj.__dict__
            if '_sa_instance_state' in widget:
                del widget['_sa_instance_state']
            app['widgets'].append(widget)
            widget['content'] = []

            for content in DBSession.query(WidgetContentCopy).filter(
                WidgetContentCopy.widget_id==widget['id']).filter(
                WidgetContentCopy.is_visible==True).order_by(
                WidgetContentCopy.ordinal).all():
                content = content.__dict__
                if '_sa_instance_state' in content:
                    del content['_sa_instance_state']
                widget['content'].append(content)

                if WIDGET_CONTENT_MAP[content['content_type']]:
                    url = content['url']
                    if content['content_type'] == WIDGET_CONTENT_VIMEO:
                        url = re.sub('.*vimeo.com/','',content['url'])
                    elif content['content_type'] == WIDGET_CONTENT_YOUTUBE:
                        url = re.sub('.*watch\?v=','',content['url'])
                        url = re.sub('.*embed\/','',url)
                        url = re.sub('.*youtu.be\/','',url)
                        url = re.sub('\&.*$','',url)
                    elif content['content_type'] == WIDGET_CONTENT_PREZI:
                        url = re.sub('.*embed\/','',content['url'])
                        url = re.sub('.*prezi.com\/','',url)
                        url = re.sub('\/\?.*$','',url)
                    elif content['content_type'] == WIDGET_CONTENT_SOUNDCLOUD:
                        url = re.sub('.*soundcloud.com/tracks/','',content['url'])
                        url = re.sub('\&.*$','',url)
                    try:
                        content['html'] = render_template(
                            WIDGET_CONTENT_MAP[content['content_type']],url=url)
                    except AttributeError:
                        # This happens when called from a command line script.
                        content['html'] = render_with_context(
                            WIDGET_CONTENT_MAP[content['content_type']],url=url)

                content['response_markers'] = []
                for marker in DBSession.query(WidgetContentResponseMarkerCopy).filter(
                    WidgetContentResponseMarkerCopy.widget_content_id==content['id']).order_by(
                    WidgetContentResponseMarkerCopy.ordinal).all():
                    marker = marker.__dict__
                    if '_sa_instance_state' in marker:
                        del marker['_sa_instance_state']
                    content['response_markers'].append(marker)

                    marker['responses'] = []
                    for resp in DBSession.query(WidgetContentUserResponse).filter(
                        WidgetContentUserResponse.marker_id==marker['id']).order_by(
                        WidgetContentUserResponse.ordinal).all():
                        resp = resp.__dict__
                        if '_sa_instance_state' in resp:
                            del resp['_sa_instance_state']
                        resp['response_datetime'] = \
                            resp['response_datetime'].strftime(DATETIME_DISPLAY_FORMAT) if \
                            resp['response_datetime'] else None
                        marker['responses'].append(resp)

                content['response_marker_refs'] = []
                for marker_ref in DBSession.query(WidgetContentMarkerReferenceCopy).filter(
                    WidgetContentMarkerReferenceCopy.widget_content_id==content['id']).order_by(
                    WidgetContentMarkerReferenceCopy.ordinal).all():
                    marker_ref = marker_ref.__dict__
                    if '_sa_instance_state' in marker_ref:
                        del marker_ref['_sa_instance_state']
                    content['response_marker_refs'].append(marker_ref)

                    # We want all of other people's responses for the specified marker id.
                    marker_ref['responses'] = []
                    for resp in DBSession.query(WidgetContentUserResponse).filter(
                        WidgetContentUserResponse.marker_id==marker_ref['other_marker_id']).order_by(
                        WidgetContentUserResponse.ordinal).all():
                        resp = resp.__dict__
                        if '_sa_instance_state' in resp:
                            del resp['_sa_instance_state']
                        resp['response_datetime'] = \
                            resp['response_datetime'].strftime(DATETIME_DISPLAY_FORMAT) if \
                            resp['response_datetime'] else None
                        marker_ref['responses'].append(resp)


    return outbound


# The function which calls this needs to find the correct canvas set 
# based on date, user role, etc.
def create_user_copy(dontuse,cset_obj,curriculum,user,role,persona,grade,mentor,mentee,
        curr_start_date=None,curr_end_date=None,cset_start_date=None,cset_end_date=None):

    local_db_session = get_scoped_session()

    # Accomodate for enhanced member admin, which is a superset of member admin.
    # Also assume partner admin is an admin, for ease of maintenance of master lessons.
    check_role = role.role
    if role.role in (E_MEMBER_ADMIN,PARTNER_ADMIN):
        check_role = MEMBER_ADMIN

    matched_user = None
    if (role.is_mentor and mentee) or (role.is_mentee and mentor):
        matched_user = mentor if role.is_mentee else mentee
        matched_user_role = Role(matched_user.id)

    cset = cset_obj.__dict__

    cset_id = cset['id']
    #local_db_session.expunge(cset_obj)
    if '_sa_instance_state' in cset:
        del cset['_sa_instance_state']
    del cset['id']
    cset['user_id'] = user.id
    cset['matched_user_id'] = matched_user.id if matched_user else None
    cset['matched_persona_id'] = get_persona_obj_for_user(matched_user.id,ignore_match_status=True,ignore_active_status=False).id if matched_user else None
    cset['persona_id'] = persona.id
    cset['role'] = role.role
    cset['parent_id'] = cset_id
    cset['curriculum_id'] = curriculum.id
    cset['start_datetime'] = cset_start_date if cset_start_date else cset['start_datetime']
    cset['end_datetime'] = cset_end_date if cset_end_date else cset['end_datetime']
    del cset['active']
    new_cset = CanvasSetCopy(**cset)
    local_db_session.add(new_cset)

    try:
        local_db_session.flush()

    except sqlalchemy.exc.IntegrityError as e:
        if 'duplicate' in str(e.orig):
            from auth import app # KLUDGE: some other crash happens before this.
            app.logger.warning("create_user_copy unique violation, skipping: {0}".format(traceback.format_exc()))
            local_db_session.rollback()
            local_db_session.begin()

            # Return already existing cset.
            muid = matched_user.id if matched_user else None
            new_cset = DBSession.query(CanvasSetCopy).filter(
                CanvasSetCopy.matched_user_id==muid).filter(
                CanvasSetCopy.user_id==user.id).filter(
                CanvasSetCopy.parent_id==cset_id).one()
            return new_cset
        else:
            from auth import app # KLUDGE: some other crash happens before this.
            app.logger.exception("create_user_copy failed:{0}".format(traceback.format_exc()))
            raise

    except psycopg2.IntegrityError as err:
        if err.pgcode == '23505': # Unique violation
            from auth import app # KLUDGE: some other crash happens before this.
            app.logger.warning("create_user_copy unique violation, skipping: {0}".format(traceback.format_exc()))
            local_db_session.rollback()
            local_db_session.begin()

            # Return already existing cset.
            muid = matched_user.id if matched_user else None
            new_cset = DBSession.query(CanvasSetCopy).filter(
                CanvasSetCopy.matched_user_id==muid).filter(
                CanvasSetCopy.user_id==user.id).filter(
                CanvasSetCopy.parent_id==cset_id).one()
            return new_cset
        else:
            from auth import app # KLUDGE: some other crash happens before this.
            app.logger.exception("create_user_copy failed, pg error code is {0}: {1}".format(err.pgcode,traceback.format_exc()))
            raise

    except:
        the_error = traceback.format_exc()
        if 'duplicate' in the_error:
            from auth import app # KLUDGE: some other crash happens before this.
            app.logger.warning("create_user_copy unique violation, skipping: {0}".format(the_error))
            local_db_session.rollback()
            local_db_session.begin()

            # Return already existing cset.
            muid = matched_user.id if matched_user else None
            new_cset = DBSession.query(CanvasSetCopy).filter(
                CanvasSetCopy.matched_user_id==muid).filter(
                CanvasSetCopy.user_id==user.id).filter(
                CanvasSetCopy.parent_id==cset_id).one()
            return new_cset
        else:
            from auth import app # KLUDGE: some other crash happens before this.
            app.logger.exception("create_user_copy failed:{0}".format(the_error))
            raise


    for app_obj in DBSession.query(CanvasApp).filter(CanvasApp.canvas_set_id==cset_id).all():
        app = app_obj.__dict__
        app_id = app['id']
        #local_db_session.expunge(app_obj)
        app['user_id'] = user.id
        app['matched_user_id'] = matched_user.id if matched_user else None
        app['matched_persona_id'] = get_persona_obj_for_user(matched_user.id,ignore_match_status=True,ignore_active_status=False).id if matched_user else None
        app['persona_id'] = persona.id
        app['canvas_set_id'] = new_cset.id
        app['parent_id'] = app_id
        if '_sa_instance_state' in app:
            del app['_sa_instance_state']
        del app['id']
        del app['active']
        new_app = CanvasAppCopy(**app)
        local_db_session.add(new_app)
        local_db_session.flush()

        for widget_obj in DBSession.query(Widget).filter(Widget.canvas_app_id==app_id
            ).all():
            widget = widget_obj.__dict__
            widget_id = widget['id']
            #local_db_session.expunge(widget_obj)
            widget['user_id'] = user.id
            widget['matched_user_id'] = matched_user.id if matched_user else None
            widget['matched_persona_id'] = get_persona_obj_for_user(matched_user.id,ignore_match_status=True,ignore_active_status=False).id if matched_user else None
            widget['persona_id'] = persona.id
            widget['canvas_app_id'] = new_app.id
            widget['parent_id'] = widget_id
            if '_sa_instance_state' in widget:
                del widget['_sa_instance_state']
            del widget['id']
            del widget['active']
            new_widget = WidgetCopy(**widget)
            local_db_session.add(new_widget)
            local_db_session.flush()
            del widget_obj

            for content_obj in DBSession.query(WidgetContent).filter(
                WidgetContent.widget_id==widget_id).all():
                content = content_obj.__dict__
                content_id = content['id']
                content['user_id'] = user.id
                content['matched_user_id'] = matched_user.id if matched_user else None
                content['matched_persona_id'] = get_persona_obj_for_user(matched_user.id,ignore_match_status=True,ignore_active_status=False).id if matched_user else None
                content['persona_id'] = persona.id
                content['widget_id'] = new_widget.id
                content['parent_id'] = content_id
                if '_sa_instance_state' in content:
                    del content['_sa_instance_state']
                del content['id']
                del content['active']
                del content_obj # garbage collection
                new_content = WidgetContentCopy(**content)

                '''
                For Google docs, grab the doc id and copy the document for the user.
                '''
                if content['content_type'] == WIDGET_CONTENT_GDOC or \
                    (content['content_type'] == WIDGET_CONTENT_LINK and \
                    'docs.google.com' in content['url']):

                    if '/edit?' in content['url']:
                        doc_id = re.search('\/([\w.-]*)\/edit',content['url']).group(1)

                        matched_user_content = None

                        new_content.orig_doc_id = doc_id

                        if matched_user:
                            # Other content parent record may be different, but orig doc id 
                            # is the same.
                            # For google doc edit URLs, we're restricting them to one doc id copy 
                            # per user from the same master. Copy can appear across lessons, and
                            # will be shared by mentor-mentee pairs.
                            result = local_db_session.query(WidgetContent,WidgetContentCopy).join(
                                WidgetContentCopy,WidgetContent.id==WidgetContentCopy.parent_id).filter(
                                WidgetContent.active==True).filter(
                                WidgetContentCopy.orig_doc_id==doc_id).filter(
                                WidgetContentCopy.user_id==matched_user.id).first()

                            matched_user_content = None
                            if result:
                                matched_user_content = result[1]
                                del result

                        result = local_db_session.query(WidgetContent,WidgetContentCopy).join(
                            WidgetContentCopy,WidgetContent.id==WidgetContentCopy.parent_id).filter(
                            WidgetContent.active==True).filter(
                            WidgetContentCopy.orig_doc_id==doc_id).filter(
                            WidgetContentCopy.user_id==user.id).first()

                        current_user_content = None
                        if result:
                            current_user_content = result[1]
                            del result

                        if not current_user_content:
                            # Did the match already generate a new copy? 
                            # If so we want to collaborate.
                            if matched_user_content:
                                new_content.new_doc_id = matched_user_content.new_doc_id
                                new_content.url = re.sub(doc_id,matched_user_content.new_doc_id,content['url'])
                                '''
                                try:
                                    print "Found URL copy for matching user {0}, replacing url for this user {1} from this: {2} to this {3}".format(matched_user.id,user.id,content['url'],new_content.url)
                                except:
                                    # Avoid unicode errors.
                                    print "Found URL copy for matching user {0}, replacing doc id for this user {1} from this: {2} to this {3}".format(matched_user.id,user.id,doc_id,matched_user_content.new_doc_id)
                                '''

                            else:
                                # Neither user or other have a copy yet. Make one.
                                # Created GDocs under the Mentee's user ID, if we have one.
                                gdoc_user_id = user.id if not mentee else mentee.id
                                new_doc = create_gdoc_copy(gdoc_user_id,doc_id)
                                new_content.url = re.sub(doc_id,new_doc['id'],content['url'])
                                new_content.new_doc_id = new_doc['id']
                                #print "Created new doc for user {0} original doc id {1} new doc id {2}".format(user.id,doc_id,new_doc['id'])

                        else:
                            # If the current user already has a copy, reuse it. 
                            new_content.new_doc_id = current_user_content.new_doc_id
                            new_content.url = re.sub(doc_id,current_user_content.new_doc_id,content['url'])
                            '''
                            try:
                                print "Found URL copy for current user, replacing url for same user {0} from this: {1} to this {2}".format(user.id,content['url'],new_content.url)
                            except:
                                # Avoid unicode errors.
                                print "Found URL copy for current user, replacing doc id for same user {0} from this: {1} to this {2}".format(user.id,doc_id,current_user_content.new_doc_id)
                            '''
                        #if result:
                        #    del result # garbage collection


                elif (content['content_type'] == WIDGET_CONTENT_HTML) and \
                    ('docs.google.com' in content['html']):

                    # Does a gdoc link appear already embedded in HTML?
                    if '/edit?' in content['html']:
                        doc_id = re.search('\/([\w.-]*)\/edit',content['html']).group(1)

                        matched_user_content = None

                        new_content.orig_doc_id = doc_id

                        if matched_user:
                            # Other content parent record may be different, but orig doc id 
                            # is the same.
                            # For google doc edit URLs, we're restricting them to one doc id copy 
                            # per user from the same master. Copy can appear across lessons, and
                            # will be shared by mentor-mentee pairs.
                            result = local_db_session.query(WidgetContent,WidgetContentCopy).join(
                                WidgetContentCopy,WidgetContent.id==WidgetContentCopy.parent_id).filter(
                                WidgetContent.active==True).filter(
                                WidgetContentCopy.orig_doc_id==doc_id).filter(
                                WidgetContentCopy.user_id==matched_user.id).first()

                            matched_user_content = None
                            if result:
                                matched_user_content = result[1]
                                del result

                        result = local_db_session.query(WidgetContent,WidgetContentCopy).join(
                            WidgetContentCopy,WidgetContent.id==WidgetContentCopy.parent_id).filter(
                            WidgetContent.active==True).filter(
                            WidgetContentCopy.orig_doc_id==doc_id).filter(
                            WidgetContentCopy.user_id==user.id).first()

                        current_user_content = None
                        if result:
                            current_user_content = result[1]
                            del result

                        if not current_user_content:
                            # Did the match already generate a new copy? 
                            # If so we want to collaborate.
                            if matched_user_content:
                                new_content.new_doc_id = matched_user_content.new_doc_id
                                new_content.html = re.sub(doc_id,matched_user_content.new_doc_id,content['html'])
                                '''
                                try:
                                    print "Found HTML copy for matching user {0}, replacing doc id for this user {1} from this: \n{2}\n to this \n{3}\n".format(matched_user.id,user.id,content['html'],new_content.html)
                                except:
                                    # Avoid unicode errors.
                                    print "Found HTML copy for matching user {0}, replacing doc id for this user {1} from this: \n{2}\n to this \n{3}\n".format(matched_user.id,user.id,doc_id,matched_user_contetn.new_doc_id)
                                '''

                            else:
                                # Neither user or other have a copy yet. Make one.
                                # Created GDocs under the Mentee's user ID, if we have one.
                                gdoc_user_id = user.id if not mentee else mentee.id
                                new_doc = create_gdoc_copy(gdoc_user_id,doc_id)
                                new_content.new_doc_id = new_doc['id']
                                new_content.html = re.sub(doc_id,new_doc['id'],content['html'])
                                #print "Created new doc for user {0} original doc id {1} new doc id {2}".format(user.id,doc_id,new_doc['id'])

                        else:
                            # If the current user already has a copy, reuse it. 
                            new_content.new_doc_id = current_user_content.new_doc_id
                            new_content.html = re.sub(doc_id,current_user_content.new_doc_id,content['html'])
                            '''
                            try:
                                print "Found HTML copy for current user, replacing html for same user {0} from this: {1} to this {2}".format(user.id,content['html'],new_content.url)
                            except:
                                # Avoid unicode errors.
                                pass
                            '''
                        #if result:
                        #    del result # garbage collection

                '''
                Set visibility flag on this new content.
                Note that even though a widget content copy is not visible, it's still generated.
                It may be togged to visible at some later point in time.
                '''
                partner_site = get_partners_for_user(user,role)
                if partner_site:
                    partner_site=partner_site[0]
                    flags = DBSession.query(FlaggedLesson).filter(
                        FlaggedLesson.parent_widget_content_id==content['parent_id']).filter(
                        FlaggedLesson.parent_curriculum_id==curriculum.parent_id).filter(
                        FlaggedLesson.partner_site_id==partner_site.id).filter(
                        or_(
                            and_(FlaggedLesson.user_id==None,FlaggedLesson.persona_id==None),
                            and_(FlaggedLesson.user_id==user.id,FlaggedLesson.persona_id==persona.id)
                        )).all()

                    for flag in flags:
                        # We only have one flag for the time being.
                        if flag.flag_name==IS_VISIBLE and flag.flag_bool_value==False:
                            new_content.is_visible = False

                local_db_session.add(new_content)
                local_db_session.flush()
                #print "Created content id {0}".format(new_content.id)

                for marker_obj in DBSession.query(WidgetContentResponseMarker).filter(
                    WidgetContentResponseMarker.widget_content_id==content_id).all():
                    marker = marker_obj.__dict__
                    marker_id = marker['id']
                    #local_db_session.expunge(marker_obj)
                    marker['user_id'] = user.id
                    marker['matched_user_id'] = matched_user.id if matched_user else None
                    marker['persona_id'] = persona.id
                    marker['matched_persona_id'] = get_persona_obj_for_user(matched_user.id,ignore_match_status=True,ignore_active_status=False).id if matched_user else None
                    marker['widget_content_id'] = new_content.id
                    marker['parent_id'] = marker_id
                    if '_sa_instance_state' in marker:
                        del marker['_sa_instance_state']
                    del marker['id']
                    del marker['active']
                    new_marker = WidgetContentResponseMarkerCopy(**marker)
                    local_db_session.add(new_marker)
                    local_db_session.flush()

                    '''
                    # Accomodate for enhanced member admin, which is a superset of member admin.
                    # Also assume partner admin is an admin, for ease of maintenance of master lessons.
                    check_role = role.role
                    if role.role in (E_MEMBER_ADMIN,PARTNER_ADMIN):
                        check_role = MEMBER_ADMIN

                    print "**** Found response marker {0}, created copy {1} for user id {2}, {3}:{4}".format(
                        marker_id,new_marker.id,user.id,USERTYPE_MAP[check_role],new_content.html.encode('utf-8'))
                    '''

                    # We're looking for someone else's marker refs to this response marker we've created.
                    for ref_obj in DBSession.query(WidgetContentMarkerReference).filter(
                        WidgetContentMarkerReference.other_marker_id==marker_id).all():
                        
                        '''
                        print "**** Found marker reference {0} to original marker {1}. Now looking for other user's copies.".format(
                            ref_obj.id,marker_id)
                        '''

                        # (1) Find the response marker refs (orig, not copies) 
                        # who's marker id is this old marker.
                        # (2) Find all reference copies who's parents are these marker refs, 
                        # where the copy belongs to the other (mentor/mentee) in the match (or to self).
                        # (3) Set their copy marker ids to the new marker copy we just created.
                        
                        if matched_user:
                            for marker_ref_copy in local_db_session.query(WidgetContentMarkerReferenceCopy).filter(
                                WidgetContentMarkerReferenceCopy.user_id.in_((matched_user.id,user.id))).filter(
                                WidgetContentMarkerReferenceCopy.matched_user_id.in_((matched_user.id,user.id))).filter(
                                WidgetContentMarkerReferenceCopy.parent_id==ref_obj.id).all():
                                marker_ref_copy.other_marker_id=new_marker.id
                                local_db_session.flush()

                                '''
                                # Accomodate for enhanced member admin, which is a superset of member admin.
                                # Also assume partner admin is an admin, for ease of maintenance of master lessons.
                                check_role = role.role
                                if role.role in (E_MEMBER_ADMIN,PARTNER_ADMIN):
                                    check_role = MEMBER_ADMIN

                                other_check_role = matched_user_role.role
                                if matched_user_role.role in (E_MEMBER_ADMIN,PARTNER_ADMIN):
                                    other_check_role = MEMBER_ADMIN

                                print "**** Found other person's (or our own) marker reference {4}, parent id {5} for user id {0}, {1} pointing to our own response marker {6}: user id {2}, {3}".format(
                                    matched_user_id,USERTYPE_MAP[other_check_role] if matched_user_role else None,
                                    marker_ref_copy.user_id,USERTYPE_MAP[check_role],
                                    marker_ref_copy.id,ref_obj.id,new_marker.id)
                                '''
                                    
                        else:
                            # Users can see their own responses in later lessons.
                            for marker_ref_copy in local_db_session.query(WidgetContentMarkerReferenceCopy).filter(
                                WidgetContentMarkerReferenceCopy.user_id==user.id).filter(
                                WidgetContentMarkerReferenceCopy.matched_user_id==None).filter(
                                WidgetContentMarkerReferenceCopy.parent_id==ref_obj.id).all():
                                marker_ref_copy.other_marker_id=new_marker.id
                                local_db_session.flush()


                                '''
                                # Accomodate for enhanced member admin, which is a superset of member admin.
                                # Also assume partner admin is an admin, for ease of maintenance of master lessons.
                                check_role = role.role
                                if role.role in (E_MEMBER_ADMIN,PARTNER_ADMIN):
                                    check_role = MEMBER_ADMIN

                                print "**** Found our own self-referencing marker reference {2}, parent id {3} for user id {0}, {1} pointing to our own response marker {4}: user id {2}, {3}".format(
                                    marker_ref_copy.user_id,USERTYPE_MAP[check_role],
                                    marker_ref_copy.id,ref_obj.id,new_marker.id)
                                '''
                                    
                       
                # These marker references are for this user and this widget, referencing 
                # other user's responses.
                # Look up these other user's response marker copies. If they don't exist
                # yet, set the copy marker_id to 0.
                # (1) Get all marker references belonging to the original widget content id (not copy).
                # (2) For each of these, find the original response marker.
                # (3) Find this response marker's copy (where parent = this response marker),
                # where user = other user (mentor/mentee) or self.
                # (4) Create our marker reference copy, set the marker_id to the other user's marker.
                # Only do this if matched.
                for ref_obj in DBSession.query(WidgetContentMarkerReference).filter(
                    WidgetContentMarkerReference.widget_content_id==content_id).all():
    
                    other_marker = DBSession.query(WidgetContentResponseMarker).filter(
                        WidgetContentResponseMarker.id==ref_obj.other_marker_id).one()
    
                    if matched_user:
                        marker_copy = DBSession.query(WidgetContentResponseMarkerCopy).filter(
                            WidgetContentResponseMarkerCopy.parent_id==other_marker.id).filter(
                            WidgetContentResponseMarkerCopy.matched_user_id.in_((matched_user.id,user.id))).filter(
                            WidgetContentResponseMarkerCopy.user_id.in_((matched_user.id,user.id))).first()
                    else:
                        # Users can see their own responses in later lessons.
                        marker_copy = DBSession.query(WidgetContentResponseMarkerCopy).filter(
                            WidgetContentResponseMarkerCopy.parent_id==other_marker.id).filter(
                            WidgetContentResponseMarkerCopy.matched_user_id==None).filter(
                            WidgetContentResponseMarkerCopy.user_id==user.id).first()
    
                    ref = ref_obj.__dict__
                    ref_id = ref['id']
                    #local_db_session.expunge(ref_obj)
                    ref['user_id'] = user.id
                    ref['matched_user_id'] = matched_user.id if matched_user else None
                    ref['persona_id'] = persona.id
                    ref['matched_persona_id'] = get_persona_obj_for_user(matched_user.id,ignore_match_status=True,ignore_active_status=False).id if matched_user else None
                    ref['widget_content_id'] = new_content.id
                    ref['other_marker_id'] = 0 if not marker_copy else marker_copy.id
                    ref['parent_id'] = ref_id
                    if '_sa_instance_state' in ref:
                        del ref['_sa_instance_state']
                    del ref['id']
                    del ref['active']
                    new_ref = WidgetContentMarkerReferenceCopy(**ref)
                    local_db_session.add(new_ref)
                    local_db_session.flush()

                    '''
                    # Accomodate for enhanced member admin, which is a superset of member admin.
                    # Also assume partner admin is an admin, for ease of maintenance of master lessons.
                    check_role = role.role
                    if role.role in (E_MEMBER_ADMIN,PARTNER_ADMIN):
                        check_role = MEMBER_ADMIN

                    if matched_user:
                        other_check_role = matched_user_role.role
                        if matched_user_role.role in (E_MEMBER_ADMIN,PARTNER_ADMIN):
                            other_check_role = MEMBER_ADMIN

                        print "**** Created other marker reference: {4}, parent id {5} for our user id {0}, {1} showing response marker {6} from user id {2}, {3}".format(
                            user.id,USERTYPE_MAP[check_role],matched_user.id,USERTYPE_MAP[other_check_role] if matched_user_role else None,
                            new_ref.id,ref_id,new_ref.other_marker_id)
                    else:
                        print "**** Created self reference: {4}, parent id {5} for our user id {0}, {1} showing response marker {6} from user id {2}, {3}".format(
                            user.id,USERTYPE_MAP[check_role],user.id,USERTYPE_MAP[check_role],
                            new_ref.id,ref_id,new_ref.other_marker_id)
                    '''


    local_db_session.commit()
    #local_db_session.begin()

    # Get the thing we just saved.
    muid = matched_user.id if matched_user else None
    new_cset = DBSession.query(CanvasSetCopy).filter(
        CanvasSetCopy.matched_user_id==muid).filter(
        CanvasSetCopy.user_id==user.id).filter(
        CanvasSetCopy.parent_id==cset_id).one()

    return new_cset


def justadd(addlist,parent_curriculum_id,start_datetime,end_datetime):

    local_db_session = get_scoped_session()

    lessons_by_role = {}
    # We expect one curriculum per week, and three Canvas Sets (lessons): one per role for mentor, mentee, admin
    canvas_sets = local_db_session.query(CanvasSet).filter(CanvasSet.curriculum_id==parent_curriculum_id).all()
    canvas_set_ids = [x.id for x in canvas_sets]

    for c in canvas_sets:

        if c.role in lessons_by_role:
            raise DupRoleException("Found more than one lesson in the same curriculum for the same role, crashing! Dups: 1:{0}, 2:{1}".format(
                pprint.pformat(c.__dict__),pprint.pformat(lessons_by_role[c.role])))

        lessons_by_role[c.role] = c.id

    # Just add lessons for those who don't have any. History and
    # Partner Session were already handled.
    for user_id in addlist:

        user = DBSession.query(IuserUser).filter(IuserUser.id==user_id).one()
        role = Role(user_id)

        # Accomodate for enhanced member admin, which is a superset of member admin.
        # Also assume partner admin is an admin, for ease of maintenance of master lessons.
        check_role = role.role
        if role.role in (E_MEMBER_ADMIN,PARTNER_ADMIN):
            check_role = MEMBER_ADMIN

        matched_user = role.get_matching_mentor_mentee()
    
        if check_role in lessons_by_role:
            try:
                cscopy = get_specific_canvas_set_for_user(local_db_session,
                    user,matched_user,parent_curriculum_id,
                    lessons_by_role[check_role],skip_other=False,curr_start_date=start_datetime,
                    curr_end_date=end_datetime,cset_start_date=start_datetime,
                    cset_end_date=end_datetime)
            except (PersonaException,BadRangeException):
                from auth import app # KLUDGE: some other crash happens before this.
                app.logger.warning("justadd: {0}".format(traceback.format_exc()))
            except psycopg2.IntegrityError as err:
                if err.pgcode == '23505': # Unique violation
                    from auth import app # KLUDGE: some other crash happens before this.
                    app.logger.warning("justadd unique violation, skipping: {0}".format(traceback.format_exc()))
                else:
                    from auth import app # KLUDGE: some other crash happens before this.
                    app.logger.exception("justadd failed, pg error code is {0}: {1}".format(err.pgcode,traceback.format_exc()))
                    raise
            except sqlalchemy.exc.IntegrityError as e:
                if 'duplicate' in str(e.orig):
                    from auth import app # KLUDGE: some other crash happens before this.
                    app.logger.warning("justadd unique violation, skipping: {0}".format(traceback.format_exc()))
                else:
                    from auth import app # KLUDGE: some other crash happens before this.
                    app.logger.exception("justadd failed:{0}".format(traceback.format_exc()))
                    raise
            except:
                the_error = traceback.format_exc()
                if 'duplicate' in the_error:
                    from auth import app # KLUDGE: some other crash happens before this.
                    app.logger.warning("justadd unique violation, skipping: {0}".format(the_error))
                else:
                    from auth import app # KLUDGE: some other crash happens before this.
                    app.logger.exception("justadd failed:{0}".format(the_error))
                    raise

    local_db_session.commit()


def copy_lessons_by_partner(current_user,post_args,utc_start = False):

    addlist,start,end,recheck = schedule_fix_lessons(post_args,utc_start)
    if addlist:
        justadd(addlist,post_args['curriculum_id'],start,end)
    if addlist or recheck:
        addlist,start,end,x = schedule_fix_lessons(post_args,utc_start)
        justadd(addlist,post_args['curriculum_id'],start,end)


def adjust_lesson_for_flag(curriculum_id,user_id,partner_id,widget_content_id,flag_name,flag_value):
    local_db_session = get_scoped_session()
    if user_id == None:
        user_ids = [x.id for x in get_users_for_partners([partner_id])]
    else:
        user_ids = [user_id]

    # We only have one flag right now.
    if flag_name == IS_VISIBLE:
        local_db_session.query(WidgetContentCopy).filter(
            WidgetContentCopy.parent_id==widget_content_id).filter(
            WidgetContentCopy.parent.widget.canvas_app.canvas_set.curriculum.id==curriculum_id).filter(
            WidgetContentCopy.is_visible!=flag_value).filter(
            WidgetContentCopy.user_id.in_(user_ids)).update({'is_visible':flag_value})
        local_db_session.commit()
        local_db_session.begin()


def flag_lesson(current_user,curriculum_id,user_id,partner_id,widget_content_id,flags):
    local_db_session = get_scoped_session()

    matched_user = Role(user_id).get_matching_mentor_mentee()

    # flags is a dictionary: {'is_visible':False,'some_other_flag':something}
    for flag_name in flags:
        # We only have one flag right now.
        if flag_name == IS_VISIBLE:
            flagged = DBSession.query(FlaggedLesson).filter(
                FlaggedLesson.user_id==user_id,FlaggedLesson.parent_curriculum_id==curriculum_id,
                FlaggedLesson.partner_id==partner_id,
                FlaggedLesson.widget_content_id==widget_content_id,
                FlaggedLesson.flag_name==IS_VISIBLE).first()

            if flagged:
                if flagged.flag_bool_value != flags[IS_VISIBLE]:
                    if flags[IS_VISIBLE] == True:
                        # Lessons default to visible = True. Remove record.
                        local_db_sessionquery(FlaggedLesson).filter(
                            FlaggedLesson.id==flagged.id).delete()
                        local_db_session.commit()
                        local_db_session.begin()
                    else:
                        # Somehow a True got stored: change it.
                        local_db_session.query(FlaggedLesson).filter(
                            FlaggedLesson.id==flagged.id).update(
                            {'flag_bool_value':False})
                        local_db_session.commit()
                        local_db_session.begin()
            else:
                flesson = FlaggedLesson(
                    user_id=user_id,
                    matched_user_id=matched_user.id if matched_user else None,
                    matched_persona_id = get_persona_obj_for_user(matched_user.id,ignore_match_status=True,ignore_active_status=False).id if matched_user else None,
                    partner_site_id=partner_id,
                    persona_id = get_persona_obj_for_user(user_id,ignore_match_status=True).id,
                    parent_widget_content_id=widget_content_id,
                    parent_curriculum_id=curriculum_id,
                    flag_name=IS_VISIBLE,
                    flag_bool_value=False)

                local_db_session.add(flesson)
                local_db_session.commit()
                local_db_session.begin()

        # Adjust lessons.
        adjust_lesson_for_flag(curriculum_id,user_id,partner_id,widget_content_id,flag_name,flags[IS_VISIBLE])
