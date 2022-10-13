# -*- coding: iso8859-15 -*-
import os,sys
import pprint
import logging
import datetime
from dateutil import tz
import jinja2
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'../..'))
projdir2 = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)
    sys.path.append(projdir2)
from auth import app
from config.project_globals import (db,Base,metadata,
    DBSession,DOGPILE_CACHE_REGION,get_scoped_session)
from config.caching_query import CachingQuery,FromCache
from sqlalchemy import (BigInteger, Boolean, Column, Date, DateTime, 
    Float, ForeignKey, Index, Integer, Numeric, SmallInteger, 
    String, Table, Text, Time, text, func, or_)
from sqlalchemy.sql.expression import func, or_, not_, and_
from sqlalchemy.orm import sessionmaker, aliased
from sqlalchemy.orm.exc import NoResultFound, MultipleResultsFound
from legacy_models.partners import PartnersPartner, PartnersSession
from legacy_models.member import MemberMember
from legacy_models.utils import UtilsTimezone
from legacy_models.iuser import (IuserPersonaPartner, IuserPersona, 
    IuserUser,IuserAssignedusertype,IuserUsertype,USER_STATUS_ACTIVE)
from canvas.canvas_scheduling import direct_schedule_fix
from canvas.canvas_utils import justadd
from utils.user_details import (get_latest_persona,
        latest_mentee_for_mentor_subq,latest_mentor_for_mentee_subq)
from utils.roles import Role

from canvas.models import (PartnersSessionCurriculum, Curriculum,
    GradeInfo, UnitInfo, CurriculumCopy, CanvasSetCopy)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_recent_lessons(partner_id):
    
    results = DBSession.query(
        PartnersPartner.id.label('partner_id'),
        PartnersPartner.name.label('partner_name'),
        UtilsTimezone.name.label('time_zone'),
        PartnersSession.start.label('lesson_start'),
        PartnersSession.end_date.label('lesson_end'),
        PartnersSession.description.label('lesson_description'),
        GradeInfo.grade_number.label('grade_number'),
        UnitInfo.unit_number.label('unit_number'),
        Curriculum.curriculum_number.label('lesson_number'),
        PartnersSession.id.label('session_id'),
        Curriculum.id.label('curriculum_id')).\
        options(FromCache(DOGPILE_CACHE_REGION)).\
        join(PartnersSession, PartnersPartner.id == PartnersSession.partner_id).\
        join(MemberMember, PartnersPartner.member_id == MemberMember.id).\
        join(UtilsTimezone, MemberMember.time_zone_id == UtilsTimezone.id).\
        join(PartnersSessionCurriculum, PartnersSession.id == PartnersSessionCurriculum.p_session_id).\
        join(Curriculum, PartnersSessionCurriculum.curr_id == Curriculum.id).\
        join(UnitInfo, Curriculum.unit_id == UnitInfo.id).\
        join(GradeInfo, Curriculum.grade_id == GradeInfo.id).\
        filter(PartnersPartner.id == partner_id).\
        order_by(PartnersSession.start.desc()).\
        all()

    return results

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def schedule_missing_lessons(partner_id=None,curriculum_id=None):

    # Needed for Google Docs templates, so lesson copying can make doc copies.
    # Blueprint load doesn't work here, strangely. 
    my_loader = jinja2.ChoiceLoader([
        app.jinja_loader,
        jinja2.FileSystemLoader([projdir2 + '/canvas/templates', \
                                 projdir2 + '/lesson_mgmt/templates']),
    ])
    app.jinja_loader = my_loader

    local_db_session = get_scoped_session()

    global_class_count = 0
    global_user_count = 0
    
    # We obtain the classes with a current lesson.
    class_details = local_db_session.query(
        PartnersPartner.id.label('partner_id'),
        PartnersPartner.name.label('partner_name'),
        PartnersSession.start.label('lesson_start'),
        PartnersSession.end_date.label('lesson_end'),
        Curriculum.id.label('lesson_id'),
        PartnersSession.description.label('lesson_description'),
        GradeInfo.grade_number.label('grade_number'),
        UnitInfo.unit_number.label('unit_number'),
        Curriculum.curriculum_number.label('lesson_number'),
        PartnersPartner.member_contact_id.label('staff_id')).\
        options(FromCache(DOGPILE_CACHE_REGION)).\
        join(PartnersSession, PartnersPartner.id == PartnersSession.partner_id).\
        join(PartnersSessionCurriculum, PartnersSession.id == PartnersSessionCurriculum.p_session_id).\
        join(Curriculum, PartnersSessionCurriculum.curr_id == Curriculum.id).\
        join(UnitInfo, Curriculum.unit_id == UnitInfo.id).\
        join(GradeInfo, Curriculum.grade_id == GradeInfo.id).\
        filter(PartnersPartner.status_id == 1).\
        filter(PartnersPartner.is_alumni == False).\
        filter(PartnersSession.start <= datetime.datetime.utcnow()).\
        filter(PartnersSession.end_date > datetime.datetime.utcnow()).\
        filter(Curriculum.active == True).\
        order_by(PartnersSession.id.asc()).\
        all()

        #filter(PartnersPartner.member_id.in_([1, 244, 197])).\

    # We then retrieve any mentors and mentees in those classes who do not have the current lesson.
    for class_detail in class_details:

        latest_persona_subq = get_latest_persona(filtered = False, user_id = None)

        # One of these subqueries will be null. We don't know which one we're matching.
        #mentee_match_subq = latest_mentee_for_mentor_subq(latest_persona_subq)
        #mentor_match_subq = latest_mentor_for_mentee_subq(latest_persona_subq)

        '''
            outerjoin(or_(
                mentor_match_subq, and_(IuserPersona.id == mentor_match_subq.c.mentor_persona_id, mentor_match_subq.c.mentee_user_id == CurriculumCopy.matched_user_id),
                mentee_match_subq, and_(IuserPersona.id == mentee_match_subq.c.mentee_persona_id, mentee_match_subq.c.mentor_user_id == CurriculumCopy.matched_user_id))).\

            outerjoin(mentor_match_subq, mentor_match_subq.c.mentee_user_id == CurriculumCopy.matched_user_id).\
            outerjoin(mentee_match_subq, mentee_match_subq.c.mentor_user_id == CurriculumCopy.matched_user_id).\
            mentor_match_subq.c.mentee_user_id.label('mentee_matched_to_this_mentor'),
            mentee_match_subq.c.mentor_user_id.label('mentor_matched_to_this_mentee')
        '''

        user_details = local_db_session.query(
            IuserUser.id.label('user_id'),
            IuserPersona.id.label('persona_id'),
            IuserAssignedusertype.usertype_id.label('role'),
            CurriculumCopy.parent_id.label('lesson_id'),
            CurriculumCopy.matched_user_id.label('lesson_matched_user_id'),
            ).\
            options(FromCache(DOGPILE_CACHE_REGION)).\
            join(latest_persona_subq, IuserUser.id == latest_persona_subq.c.user_id).\
            join(IuserPersona, latest_persona_subq.c.latest_persona_id == IuserPersona.id).\
            join(IuserPersonaPartner, IuserPersona.id == IuserPersonaPartner.persona_id).\
            join(IuserAssignedusertype,IuserPersona.assigned_usertype_id == IuserAssignedusertype.id).\
            join(IuserUsertype,IuserAssignedusertype.usertype_id == IuserUsertype.id).\
            outerjoin(CurriculumCopy, and_(IuserPersonaPartner.persona_id == CurriculumCopy.persona_id, class_detail.lesson_id == CurriculumCopy.parent_id)).\
            filter(IuserPersonaPartner.partner_id == class_detail.partner_id).\
            order_by(IuserPersonaPartner.persona_id.asc()).\
            all()

        # Finally, we schedule the missing lesson for mentors and mentees as necessary.
        add_user_ids = []
        for user_detail in user_details:
            matched_user = Role(user_detail.user_id).get_matching_mentor_mentee()
            matched_user_id = matched_user.id if matched_user else None
            if user_detail.lesson_id is None:
                add_user_ids.append(user_detail.user_id)
                global_user_count += 1
            elif user_detail.lesson_matched_user_id != matched_user_id:
                # Newly matched, or newly unmatched.
                add_user_ids.append(user_detail.user_id)
                global_user_count += 1

        if add_user_ids:
            global_class_count += 1

            app.logger.info( "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~************************~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" )
            app.logger.info( "Doing partner id {0} lesson id {1}".format(class_detail.partner_id,class_detail.lesson_id) )
            app.logger.info( "These users are missing lessons: {0}".format(pprint.pformat(add_user_ids)) )

            addlist,start,end,recheck = direct_schedule_fix(class_detail.partner_id,class_detail.lesson_id,class_detail.lesson_start)
            for u in add_user_ids:
                if u not in addlist:
                    app.logger.info( "NOTE: user {0} was not in the addlist, but is missing lessons. Adding.".format(u) )
                    addlist.append(u)
                    recheck=True
            if addlist:
                justadd(addlist,class_detail.lesson_id,start,end)
            if addlist or recheck:
                app.logger.info( "** Redoing partner id {0} lesson id {1}".format(class_detail.partner_id,class_detail.lesson_id) )
                addlist,start,end,x = direct_schedule_fix(class_detail.partner_id,class_detail.lesson_id,class_detail.lesson_start)
                justadd(addlist,class_detail.lesson_id,start,end)

    local_db_session.commit()
    return global_class_count, global_user_count

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def delete_lessons(partner_id, curriculum_id, session_id):

    local_db_session = get_scoped_session()

    # We retrieve any mentors, mentees, or staff in the given class who do not have the given lesson.
    latest_persona_subq = get_latest_persona(filtered = False, user_id = None)
    user_details = local_db_session.query(
        IuserUser.id.label('user_id'),
        CanvasSetCopy.id.label('canvas_set_copy_id'),
        CurriculumCopy.id.label('curriculum_copy_id')).\
        options(FromCache(DOGPILE_CACHE_REGION)).\
        join(latest_persona_subq, IuserUser.id == latest_persona_subq.c.user_id).\
        join(IuserPersona, latest_persona_subq.c.latest_persona_id == IuserPersona.id).\
        join(IuserPersonaPartner, IuserPersona.id == IuserPersonaPartner.persona_id).\
        outerjoin(CurriculumCopy, and_(IuserPersonaPartner.persona_id == CurriculumCopy.persona_id, curriculum_id == CurriculumCopy.parent_id)).\
        outerjoin(CanvasSetCopy, CurriculumCopy.id == CanvasSetCopy.curriculum_id).\
        filter(IuserPersonaPartner.partner_id == partner_id).\
        filter(CanvasSetCopy.user_first_completed == None).\
        order_by(IuserPersonaPartner.persona_id.asc()).\
        all()

    # We first delete lesson data from each user.
    # Sometimes we have orphaned CanvasSetCopy records or CurriculumCopy records,
    # so we check for IDs in each case and don't filter them from the query above.
    for detail in user_details:
        if detail.canvas_set_copy_id:
            db.session.execute(
                '''
                --Canvas Set Copy data
                
                delete from canvas_widget_content_marker_reference_copy *
                where id in (
                    select
                        cwcmrc.id
                    from canvas_set_copy as csc
                    join canvas_curriculum_copy as ccc on ccc.id = csc.curriculum_id
                    left outer join canvas_app_copy as cac on cac.canvas_set_id = csc.id
                    left outer join canvas_widget_copy as cwc on cwc.canvas_app_id = cac.id
                    left outer join canvas_widget_content_copy as cwcc on cwcc.widget_id = cwc.id
                    left outer join canvas_widget_content_response_marker_copy as cwcrmc on cwcrmc.widget_content_id = cwcc.id
                    left outer join canvas_widget_content_marker_reference_copy as cwcmrc on cwcmrc.widget_content_id = cwcc.id
                    left outer join canvas_content_user_response as ccur on ccur.marker_id = cwcrmc.id
                    where csc.id = %d
                );
                
                delete from canvas_content_user_response *
                where id in (
                    select
                        ccur.id
                    from canvas_set_copy as csc
                    join canvas_curriculum_copy as ccc on ccc.id = csc.curriculum_id
                    left outer join canvas_app_copy as cac on cac.canvas_set_id = csc.id
                    left outer join canvas_widget_copy as cwc on cwc.canvas_app_id = cac.id
                    left outer join canvas_widget_content_copy as cwcc on cwcc.widget_id = cwc.id
                    left outer join canvas_widget_content_response_marker_copy as cwcrmc on cwcrmc.widget_content_id = cwcc.id
                    left outer join canvas_widget_content_marker_reference_copy as cwcmrc on cwcmrc.widget_content_id = cwcc.id
                    left outer join canvas_content_user_response as ccur on ccur.marker_id = cwcrmc.id
                    where csc.id = %d
                );
                
                delete from canvas_widget_content_response_marker_copy *
                where id in (
                    select
                        cwcrmc.id
                    from canvas_set_copy as csc
                    join canvas_curriculum_copy as ccc on ccc.id = csc.curriculum_id
                    left outer join canvas_app_copy as cac on cac.canvas_set_id = csc.id
                    left outer join canvas_widget_copy as cwc on cwc.canvas_app_id = cac.id
                    left outer join canvas_widget_content_copy as cwcc on cwcc.widget_id = cwc.id
                    left outer join canvas_widget_content_response_marker_copy as cwcrmc on cwcrmc.widget_content_id = cwcc.id
                    left outer join canvas_widget_content_marker_reference_copy as cwcmrc on cwcmrc.widget_content_id = cwcc.id
                    left outer join canvas_content_user_response as ccur on ccur.marker_id = cwcrmc.id
                    where csc.id = %d
                );
                
                delete from canvas_widget_content_response_marker_copy *
                where id in (
                    select
                        cwcrmc.id
                    from canvas_set_copy as csc
                    join canvas_curriculum_copy as ccc on ccc.id = csc.curriculum_id
                    left outer join canvas_app_copy as cac on cac.canvas_set_id = csc.id
                    left outer join canvas_widget_copy as cwc on cwc.canvas_app_id = cac.id
                    left outer join canvas_widget_content_copy as cwcc on cwcc.widget_id = cwc.id
                    left outer join canvas_widget_content_response_marker_copy as cwcrmc on cwcrmc.widget_content_id = cwcc.id
                    left outer join canvas_widget_content_marker_reference_copy as cwcmrc on cwcmrc.widget_content_id = cwcc.id
                    left outer join canvas_content_user_response as ccur on ccur.marker_id = cwcrmc.id
                    where csc.id = %d
                );
                
                delete from canvas_widget_content_copy *
                where id in (
                    select
                        cwcc.id
                    from canvas_set_copy as csc
                    join canvas_curriculum_copy as ccc on ccc.id = csc.curriculum_id
                    left outer join canvas_app_copy as cac on cac.canvas_set_id = csc.id
                    left outer join canvas_widget_copy as cwc on cwc.canvas_app_id = cac.id
                    left outer join canvas_widget_content_copy as cwcc on cwcc.widget_id = cwc.id
                    left outer join canvas_widget_content_response_marker_copy as cwcrmc on cwcrmc.widget_content_id = cwcc.id
                    left outer join canvas_widget_content_marker_reference_copy as cwcmrc on cwcmrc.widget_content_id = cwcc.id
                    left outer join canvas_content_user_response as ccur on ccur.marker_id = cwcrmc.id
                    where csc.id = %d
                );
                
                delete from canvas_widget_copy *
                where id in (
                    select
                        cwc.id
                    from canvas_set_copy as csc
                    join canvas_curriculum_copy as ccc on ccc.id = csc.curriculum_id
                    left outer join canvas_app_copy as cac on cac.canvas_set_id = csc.id
                    left outer join canvas_widget_copy as cwc on cwc.canvas_app_id = cac.id
                    left outer join canvas_widget_content_copy as cwcc on cwcc.widget_id = cwc.id
                    left outer join canvas_widget_content_response_marker_copy as cwcrmc on cwcrmc.widget_content_id = cwcc.id
                    left outer join canvas_widget_content_marker_reference_copy as cwcmrc on cwcmrc.widget_content_id = cwcc.id
                    left outer join canvas_content_user_response as ccur on ccur.marker_id = cwcrmc.id
                    where csc.id = %d
                );
                
                delete from canvas_app_copy *
                where id in (
                    select
                        cac.id
                    from canvas_set_copy as csc
                    join canvas_curriculum_copy as ccc on ccc.id = csc.curriculum_id
                    left outer join canvas_app_copy as cac on cac.canvas_set_id = csc.id
                    left outer join canvas_widget_copy as cwc on cwc.canvas_app_id = cac.id
                    left outer join canvas_widget_content_copy as cwcc on cwcc.widget_id = cwc.id
                    left outer join canvas_widget_content_response_marker_copy as cwcrmc on cwcrmc.widget_content_id = cwcc.id
                    left outer join canvas_widget_content_marker_reference_copy as cwcmrc on cwcmrc.widget_content_id = cwcc.id
                    left outer join canvas_content_user_response as ccur on ccur.marker_id = cwcrmc.id
                    where csc.id = %d
                );
                
                delete from canvas_set_copy *
                where id in (
                    select
                        csc.id
                    from canvas_set_copy as csc
                    join canvas_curriculum_copy as ccc on ccc.id = csc.curriculum_id
                    left outer join canvas_app_copy as cac on cac.canvas_set_id = csc.id
                    left outer join canvas_widget_copy as cwc on cwc.canvas_app_id = cac.id
                    left outer join canvas_widget_content_copy as cwcc on cwcc.widget_id = cwc.id
                    left outer join canvas_widget_content_response_marker_copy as cwcrmc on cwcrmc.widget_content_id = cwcc.id
                    left outer join canvas_widget_content_marker_reference_copy as cwcmrc on cwcmrc.widget_content_id = cwcc.id
                    left outer join canvas_content_user_response as ccur on ccur.marker_id = cwcrmc.id
                    where csc.id = %d
                );
                ''' % (detail.canvas_set_copy_id, detail.canvas_set_copy_id, detail.canvas_set_copy_id,
                        detail.canvas_set_copy_id, detail.canvas_set_copy_id, detail.canvas_set_copy_id,
                        detail.canvas_set_copy_id, detail.canvas_set_copy_id)
                )
            db.session.commit()
            
        if detail.curriculum_copy_id:
            db.session.execute(
                '''                
                --Canvas Curriculum Copy data
                
                delete from canvas_curriculum_copy *
                where id = %d;
                ''' % detail.curriculum_copy_id
                )
            db.session.commit()

    # We finally delete any legacy participation data and the session data.
    db.session.execute(
        '''                
        --Participation data
        
        delete from reporting_matchcompletesession *
        where session_id = %d;
        
        delete from reporting_allmatchemail *
        where sess_id = %d;
        
        delete from reporting_allmatchsessions *
        where session_id = %d;
        
        --Session data
        
        delete from partners_session_curriculum *
        where curr_id = %d
            and p_session_id = %d;
        
        delete from partners_session * 
        where id = %d;
        ''' % (session_id, session_id, session_id, curriculum_id, session_id, session_id)
        )
    db.session.commit()

    return

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
if __name__=="__main__":
    #delete_lessons(1817, 8, 36355)
    '''
    #get_recent_lessons(1817)
    schedule_missing_lessons()
    #app.debug = True
    #import pdb;pdb.set_trace()
    lesson_start = datetime.datetime(2016,3,28,17,0,0).replace(tzinfo=tz.gettz('US/Eastern')).astimezone(tz.gettz('UTC')).replace(tzinfo=None)

    addlist,start,end,recheck = direct_schedule_fix(1817,161,lesson_start)
    if addlist:
        justadd(addlist,161,start,end)
    if addlist or recheck:
        addlist,start,end,recheck = direct_schedule_fix(1817,161,lesson_start)
    '''
    pass
