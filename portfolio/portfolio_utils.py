# -*- coding: iso8859-15 -*-
import os,sys
import pprint
import logging
import datetime
import time
import re
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
from canvas.models import (Curriculum, CurriculumCopy, 
    GradeInfo, UnitInfo, CanvasSet, 
    WidgetContentUserResponse, WidgetContentResponseMarkerCopy, WidgetContentCopy, 
    WidgetCopy, CanvasAppCopy, CanvasSetCopy, CurriculumCopy, 
    WidgetContentMarkerReferenceCopy, WidgetContentUserResponse,
    DocTitleMapping)
from legacy_models.iuser import IuserUser
from portfolio.models import ReflectionUserResponse, ReflectionCard, ReflectionUserDetails
from utils.user_details import get_details_for_user, get_latest_mentor_for_mentee, get_latest_mentee_for_mentor
from new_platform.utils.roles import Role

# Resource map links: moved to the top to make constants obvious.
RESOURCE_MAP_LINK = {
   '/drawings/d/':       'https://docs.google.com/drawings/d/',
   '/spreadsheets/d/' :  'https://docs.google.com/spreadsheets/d/',
   '/document/d/':       'https://docs.google.com/document/d/',
   '/presentation/d/':       'https://docs.google.com/presentation/d/',
    }
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_scheduled_grades(user_id):

    results = DBSession.query(
        Curriculum.id.label('curriculum_id'),
        GradeInfo.description.label('grade_description'),
        GradeInfo.grade_number.label('grade_number'),
        GradeInfo.id.label('grade_id')).\
        options(FromCache(DOGPILE_CACHE_REGION)).\
        distinct(GradeInfo.grade_number).\
        join(GradeInfo, Curriculum.grade_id == GradeInfo.id).\
        join(CurriculumCopy, Curriculum.id == CurriculumCopy.parent_id).\
        join(CanvasSetCopy, CurriculumCopy.id == CanvasSetCopy.curriculum_id).\
        filter(CanvasSetCopy.user_id == user_id).\
        order_by(GradeInfo.grade_number.desc()).\
        all()

    return results

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_scheduled_units(user_id, grade_id):
    
    results = DBSession.query(
        Curriculum.id.label('curriculum_id'),
        UnitInfo.description.label('unit_description'),
        GradeInfo.grade_number.label('grade_number'),
        GradeInfo.id.label('grade_id'),
        UnitInfo.unit_number.label('unit_number'),
        UnitInfo.id.label('unit_id'),
        UnitInfo.featured_image.label('featured_image'),
        UnitInfo.secondary_description.label('secondary_unit_description'),
        CanvasSetCopy.matched_user_id.label('matched_user_id'),
        CanvasSetCopy.id.label('cscopy_id'),
        CanvasSetCopy.start_datetime.label('unit_start')).\
        options(FromCache(DOGPILE_CACHE_REGION)).\
        distinct(UnitInfo.unit_number).\
        join(GradeInfo, Curriculum.grade_id == GradeInfo.id).\
        join(UnitInfo, Curriculum.unit_id == UnitInfo.id).\
        join(CurriculumCopy, Curriculum.id == CurriculumCopy.parent_id).\
        join(CanvasSetCopy, CurriculumCopy.id == CanvasSetCopy.curriculum_id).\
        filter(CanvasSetCopy.user_id == user_id).\
        filter(GradeInfo.id == grade_id).\
        order_by(UnitInfo.unit_number.asc()).\
        order_by(CanvasSetCopy.start_datetime.asc()).\
        all()

    outer_list = []
    for row in results:
        inner_list = []
        current_flag = 'False'
        mentee_finished_flag = 'True'
        mentor_finished_flag = 'True'
        both_finished_flag = 'True'
        new_content_flag = 'False'
        
        # The curriculum ID is not necessary for unit display on the Portfolio and isn't always accurate anyway,
        # since multiple curricula typically appears within a single unit.
        inner_list.append(row.unit_description)
        inner_list.append(row.grade_number)
        inner_list.append(row.grade_id)
        inner_list.append(row.unit_number)
        inner_list.append(row.unit_id)
        inner_list.append(row.featured_image)
        inner_list.append(row.secondary_unit_description)

        mentor_user_id=None
        mentee_user_id=None
        mentee_first_name=None
        mentor_first_name=None

        reflection_details = get_reflection_response(user_id, grade_id, row.unit_id)
        scheduled_lesson_details, latest_counterparty = get_scheduled_lesson_details(user_id, grade_id, row.unit_id)
        for lesson in scheduled_lesson_details:

            # Skip lessons that were not started and were assigned last school year.
            if not lesson.canvas_start and lesson.curriculum_end <= datetime.datetime.utcnow():
                continue
             
            # We update the flags below only for scheduled lessons.
            lcid = latest_counterparty.id if latest_counterparty else None
            if lesson.canvas_start:
                # This is the current lesson flag.
                if datetime.datetime.utcnow() >= lesson.canvas_start and \
                    datetime.datetime.utcnow() < lesson.canvas_end and \
                    lesson.matched_user_id == lcid:
                    current_flag = 'True'
    
                # These are the mentee finished and mentor finished flags, respectively.
                # We apply the finished flags to matched and unmatched mentors and mentees.
                if lesson.party_canvas_role == 5:
                    mentee_first_name = DBSession.query(IuserUser).filter(IuserUser.id==lesson.party_user_id).one().first_name
                    mentee_user_id = lesson.party_user_id
                    mentor_first_name = None
                    mentor_user_id = None
                    if lesson.party_canvas_completed is None:
                        mentee_finished_flag = 'False'
                        if lesson.matched_user_id:
                            both_finished_flag = 'False'
                        else:
                            both_finished_flag = 'NA'
                    if lesson.matched_user_id:
                        if hasattr(lesson,'counterparty_canvas_completed'):
                            mentor_first_name = DBSession.query(IuserUser).filter(IuserUser.id==lesson.counterparty_user_id).one().first_name
                            mentor_user_id = lesson.counterparty_user_id
                            if lesson.counterparty_canvas_completed is not None:
                                mentor_finished_flag = 'True'
                                both_finished_flag = 'True'
                            else:
                                mentor_finished_flag = 'False'
                                both_finished_flag = 'False'
                    else:
                        mentor_finished_flag = 'NA'
                        both_finished_flag = 'NA'
    
                # These are the mentee finished and mentor finished flags, respectively.
                # We apply the finished flags to matched and unmatched mentors and mentees.
                if lesson.party_canvas_role == 4:
                    mentor_first_name = DBSession.query(IuserUser).filter(IuserUser.id==lesson.party_user_id).one().first_name
                    mentor_user_id = lesson.party_user_id
                    mentee_first_name = None
                    mentee_user_id = None
                    if lesson.matched_user_id:
                        if hasattr(lesson,'counterparty_canvas_completed'):
                            mentee_first_name = DBSession.query(IuserUser).filter(IuserUser.id==lesson.counterparty_user_id).one().first_name
                            mentee_user_id = lesson.counterparty_user_id
                            if lesson.counterparty_canvas_completed is not None:
                                mentee_finished_flag = 'True'
                                both_finished_flag = 'True'
                            else:
                                mentee_finished_flag = 'False'
                                both_finished_flag = 'False'
                    else:
                        mentee_finished_flag = 'NA'
                        both_finished_flag = 'NA'
                    if lesson.party_canvas_completed is None:
                        mentor_finished_flag = 'False'
                        if lesson.matched_user_id:
                            both_finished_flag = 'False'
                        else:
                            both_finished_flag = 'NA'
        
                # This is the new content flag, which applies only to matched mentors and mentees.
                if lesson.party_canvas_role in [5, 4]:
                    if lesson.matched_user_id:
                        # We set the new content flag, based on lessons here.
                        if hasattr(lesson,'counterparty_updated') and \
                            lesson.counterparty_updated is not None and lesson.party_viewed is not None:
                            if lesson.counterparty_updated > lesson.party_viewed:
                                new_content_flag = 'True'
                        elif hasattr(lesson,'counterparty_updated') and \
                            lesson.counterparty_updated is not None and lesson.party_viewed is None:
                            new_content_flag = 'True'
                        # We set the new content flag, based on reflections here.
                        if hasattr(reflection_details,'counterparty_updated') and \
                            reflection_details.counterparty_updated is not None and reflection_details.party_viewed is not None:
                            if reflection_details.counterparty_updated > reflection_details.party_viewed:
                                new_content_flag = 'True'
                        elif hasattr(reflection_details,'counterparty_updated') and \
                            reflection_details.counterparty_updated is not None and reflection_details.party_viewed is None:
                            new_content_flag = 'True'
                    else:
                        new_content_flag = 'NA'
    
                # Staff do not require most of the above flags.
                if lesson.party_canvas_role == 1:
                    mentee_finished_flag = 'NA'
                    mentor_finished_flag = 'NA'
                    both_finished_flag = 'NA'
                    new_content_flag = 'NA'

        inner_list.append(current_flag)
        inner_list.append(mentee_finished_flag)
        inner_list.append(mentor_finished_flag)
        inner_list.append(both_finished_flag)
        inner_list.append(new_content_flag)
        inner_list.append(row.unit_start)
        inner_list.append(row.cscopy_id)
        inner_list.append(mentor_first_name)
        inner_list.append(mentee_first_name)
        inner_list.append(mentor_user_id)
        inner_list.append(mentee_user_id)

        outer_list.append(tuple(inner_list))

    # We sort the units in ascending order by the start date of their earliest lessons.
    def getKey(item):
        return item[12]

    sorted_list = sorted(outer_list, key = getKey, reverse = False)

    return sorted_list

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_scheduled_lessons(user_id, grade_id, unit_id):

    results, latest_counterparty = get_scheduled_lesson_details(user_id, grade_id, unit_id)

    mentor_user_id=None
    mentee_user_id=None
    mentee_first_name=None
    mentor_first_name=None

    outer_list = []
    for row in results:
        inner_list = []
        inner_list.append(row.curriculum_id)
        inner_list.append(row.canvas_set_id)
        inner_list.append(row.lesson_description)
        inner_list.append(row.grade_number)
        inner_list.append(row.grade_id)
        inner_list.append(row.unit_number)
        inner_list.append(row.unit_id)
        inner_list.append(row.lesson_number)
        inner_list.append(row.featured_image)
        inner_list.append(row.secondary_lesson_description)

        # Skip lessons that were not started and were assigned last school year.
        if not row.canvas_start and row.curriculum_end <= datetime.datetime.utcnow():
            continue
             
        # We update the flags below only for scheduled lessons.
        if row.canvas_start:
            # This is the current lesson flag.
            if datetime.datetime.utcnow() >= row.canvas_start and datetime.datetime.utcnow() < row.canvas_end:
                inner_list.append('True')
            else:
                inner_list.append('False')
    
            # These are the mentee finished and mentor finished flags, respectively.
            # We display the finished flag for matched and unmatched mentees.
            if row.party_canvas_role == 5:
                mentee_first_name = DBSession.query(IuserUser).filter(IuserUser.id==row.party_user_id).one().first_name
                mentee_user_id = row.party_user_id
                mentor_first_name = None
                mentor_user_id = None

                if row.party_canvas_completed:
                    inner_list.append('True')
                else:
                    inner_list.append('False')

                if row.matched_user_id:
                    if hasattr(row,'counterparty_canvas_completed'):
                        mentor_first_name = DBSession.query(IuserUser).filter(IuserUser.id==row.counterparty_user_id).one().first_name
                        mentor_user_id = row.counterparty_user_id
                        if row.counterparty_canvas_completed:
                            inner_list.append('True')
                        else:
                            inner_list.append('False')
                    else:
                        inner_list.append('NA')
                else:
                    inner_list.append('NA')
    
            # These are the mentee finished and mentor finished flags, respectively.
            # We display the finished flag for matched and unmatched mentors.
            elif row.party_canvas_role == 4:
                mentor_first_name = DBSession.query(IuserUser).filter(IuserUser.id==row.party_user_id).one().first_name
                mentor_user_id = row.party_user_id
                mentee_first_name = None
                mentee_user_id = None
                if row.matched_user_id:
                    if hasattr(row,'counterparty_canvas_completed'):
                        mentee_first_name = DBSession.query(IuserUser).filter(IuserUser.id==row.counterparty_user_id).one().first_name
                        mentee_user_id = row.counterparty_user_id
                        if row.counterparty_canvas_completed:
                            inner_list.append('True')
                        else:
                            inner_list.append('False')
                    else:
                        inner_list.append('NA')
                else:
                    inner_list.append('NA')

                if row.party_canvas_completed:
                    inner_list.append('True')
                else:
                    inner_list.append('False')

            else:
                inner_list.append('NA')
                inner_list.append('NA')
    
            # This is the both finished flag and the new content flag, respectively.
            if row.party_canvas_role in [5, 4]:
                if row.matched_user_id:
                    if hasattr(row,'party_canvas_completed') and \
                        hasattr(row,'counterparty_canvas_completed') and \
                        row.party_canvas_completed and row.counterparty_canvas_completed:
                        inner_list.append('True')
                    else:
                        inner_list.append('False')

                    if hasattr(row,'counterparty_updated') and \
                        row.counterparty_updated and row.party_viewed:
                        if row.counterparty_updated > row.party_viewed:
                            inner_list.append('True')
                        else:
                            inner_list.append('False')

                    elif hasattr(row,'counterparty_updated') and \
                        row.counterparty_updated and not row.party_viewed:
                        inner_list.append('True')
                    else:
                        inner_list.append('False')
                else:
                    inner_list.append('NA')
                    inner_list.append('NA')
            else:
                inner_list.append('NA')
                inner_list.append('NA')


            # Scheduled flag
            inner_list.append('True')
        else:
            inner_list.append('NA')
            inner_list.append('NA')
            inner_list.append('NA')
            inner_list.append('NA')
            inner_list.append('NA')
            inner_list.append('False')

        inner_list.append(row.lesson_type)
        inner_list.append(row.unit_description)
        inner_list.append(row.cscopy_id)
        inner_list.append(mentor_first_name)
        inner_list.append(mentee_first_name)
        inner_list.append(mentor_user_id)
        inner_list.append(mentee_user_id)

        outer_list.append(tuple(inner_list))
    
    return outer_list

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_reflection_response(user_id, grade_id, unit_id):

    user_role = Role(user_id)
    latest_counterparty = user_role.get_matching_mentor_mentee()

    if latest_counterparty:
        counterparty_user_id = latest_counterparty.id
        ReflectionUserDetails2 = aliased(ReflectionUserDetails)
        ReflectionUserResponse2 = aliased(ReflectionUserResponse)

        result = DBSession.query(
            ReflectionCard.id.label('reflection_card_id'),
            ReflectionUserResponse.id.label('reflection_response_id'),
            ReflectionUserResponse.reflection_html.label('party_reflection_html'),
            ReflectionUserResponse2.reflection_html.label('counterparty_reflection_html'),
            ReflectionUserDetails.last_viewed.label('party_viewed'),
            ReflectionUserDetails2.completed.label('counterparty_updated')).\
            options(FromCache(DOGPILE_CACHE_REGION)).\
            outerjoin(ReflectionUserDetails, and_(ReflectionCard.id == ReflectionUserDetails.reflection_card_id, user_id == ReflectionUserDetails.user_id)).\
            outerjoin(ReflectionUserResponse, ReflectionUserDetails.id == ReflectionUserResponse.reflection_user_details_id).\
            outerjoin(ReflectionUserDetails2, and_(ReflectionCard.id == ReflectionUserDetails2.reflection_card_id, counterparty_user_id == ReflectionUserDetails2.user_id)).\
            outerjoin(ReflectionUserResponse2, ReflectionUserDetails2.id == ReflectionUserResponse2.reflection_user_details_id).\
            filter(ReflectionCard.grade_id == grade_id).\
            filter(ReflectionCard.unit_id == unit_id).\
            first()
    else:
        result = DBSession.query(
            ReflectionCard.id.label('reflection_card_id'),
            ReflectionUserResponse.id.label('reflection_response_id'),
            ReflectionUserResponse.reflection_html.label('party_reflection_html')).\
            options(FromCache(DOGPILE_CACHE_REGION)).\
            outerjoin(ReflectionUserDetails, and_(ReflectionCard.id == ReflectionUserDetails.reflection_card_id, user_id == ReflectionUserDetails.user_id)).\
            outerjoin(ReflectionUserResponse, ReflectionUserDetails.id == ReflectionUserResponse.reflection_user_details_id).\
            filter(ReflectionCard.grade_id == grade_id).\
            filter(ReflectionCard.unit_id == unit_id).\
            first()

    return result

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_reflection_card(grade_id, unit_id):

    result = DBSession.query(
        ReflectionCard.id.label('reflection_card_id'),
        ReflectionCard.mentor_card_html.label('mentor_card_html'),
        ReflectionCard.mentee_card_html.label('mentee_card_html'),
        GradeInfo.grade_number.label('grade_number'),
        GradeInfo.id.label('grade_id'),
        UnitInfo.unit_number.label('unit_number'),
        UnitInfo.id.label('unit_id')).\
        options(FromCache(DOGPILE_CACHE_REGION)).\
        join(Curriculum, ReflectionCard.unit_id == Curriculum.unit_id).\
        join(GradeInfo, Curriculum.grade_id == GradeInfo.id).\
        join(UnitInfo, Curriculum.unit_id == UnitInfo.id).\
        filter(GradeInfo.id == grade_id).\
        filter(UnitInfo.id == unit_id).\
        first()

    return result

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_scheduled_lesson_details(user_id, grade_id, unit_id):

    user_role = Role(user_id)
    latest_counterparty = user_role.get_matching_mentor_mentee()

    # The many ordering clauses in the queries below ensure the relevant data
    # appears in the first row of results, since we only retrieve the first row.
    if latest_counterparty:
        counterparty_user_id = latest_counterparty.id
        
    CanvasSet2 = aliased(CanvasSet)
    CanvasSetCopy2 = aliased(CanvasSetCopy)
    CanvasSetCopy3 = aliased(CanvasSetCopy)
    CanvasAppCopy3 = aliased(CanvasAppCopy)
    WidgetCopy3 = aliased(WidgetCopy)
    WidgetContentCopy3 = aliased(WidgetContentCopy)
    WidgetContentResponseMarkerCopy3 = aliased(WidgetContentResponseMarkerCopy)
        
    results = DBSession.query(
            Curriculum.id.label('curriculum_id'),
            Curriculum.start_datetime.label('curriculum_start'),
            Curriculum.end_datetime.label('curriculum_end'),
            CanvasSet.id.label('canvas_set_id'),
            CanvasSet.description.label('lesson_description'),
            GradeInfo.grade_number.label('grade_number'),
            GradeInfo.id.label('grade_id'),
            UnitInfo.unit_number.label('unit_number'),
            UnitInfo.id.label('unit_id'),
            UnitInfo.description.label('unit_description'),
            Curriculum.curriculum_number.label('lesson_number'),
            Curriculum.featured_image.label('featured_image'),
            Curriculum.secondary_description.label('secondary_lesson_description'),
            CanvasSetCopy.start_datetime.label('canvas_start'),
            CanvasSetCopy.user_id.label('party_user_id'),
            CanvasSetCopy.matched_user_id.label('matched_user_id'), # should match counterparty user id
            CanvasSetCopy.id.label('cscopy_id'),
            CanvasSetCopy.end_datetime.label('canvas_end'),
            CanvasSetCopy.role.label('party_canvas_role'),
            CanvasSetCopy.user_completed.label('party_canvas_completed'),
            CanvasSetCopy2.role.label('counterparty_canvas_role'),
            CanvasSetCopy2.user_id.label('counterparty_user_id'),
            CanvasSetCopy2.matched_user_id.label('counterparty_matched_user_id'),
            CanvasSetCopy2.id.label('counterparty_cscopy_id'),
            CanvasSetCopy2.user_completed.label('counterparty_canvas_completed'),
            CanvasSetCopy.last_viewed.label('party_viewed'),
            CanvasSetCopy3.user_completed.label('counterparty_updated'),
            Curriculum.canvas_type.label('lesson_type')).\
            options(FromCache(DOGPILE_CACHE_REGION)).\
            distinct(GradeInfo.grade_number).\
            distinct(UnitInfo.unit_number).\
            distinct(Curriculum.curriculum_number).\
            distinct(Curriculum.id).\
            join(GradeInfo, Curriculum.grade_id == GradeInfo.id).\
            join(UnitInfo, Curriculum.unit_id == UnitInfo.id).\
            join(CanvasSet, Curriculum.id == CanvasSet.curriculum_id).\
            outerjoin(CanvasSetCopy, and_(CanvasSet.id == CanvasSetCopy.parent_id, user_id == CanvasSetCopy.user_id)).\
            outerjoin(CanvasAppCopy, CanvasSetCopy.id == CanvasAppCopy.canvas_set_id).\
            outerjoin(WidgetCopy, CanvasAppCopy.id == WidgetCopy.canvas_app_id).\
            outerjoin(WidgetContentCopy, WidgetCopy.id == WidgetContentCopy.widget_id).\
            outerjoin(WidgetContentMarkerReferenceCopy, WidgetContentCopy.id == WidgetContentMarkerReferenceCopy.widget_content_id).\
            outerjoin(WidgetContentResponseMarkerCopy3, WidgetContentMarkerReferenceCopy.other_marker_id == WidgetContentResponseMarkerCopy3.id).\
            outerjoin(WidgetContentCopy3, WidgetContentResponseMarkerCopy3.widget_content_id == WidgetContentCopy3.id).\
            outerjoin(WidgetCopy3, WidgetContentCopy3.widget_id == WidgetCopy3.id).\
            outerjoin(CanvasAppCopy3, WidgetCopy3.canvas_app_id == CanvasAppCopy3.id).\
            outerjoin(CanvasSetCopy3, CanvasAppCopy3.canvas_set_id == CanvasSetCopy3.id).\
            join(CanvasSet2, Curriculum.id == CanvasSet2.curriculum_id).\
            join(CanvasSetCopy2, and_(CanvasSet2.id == CanvasSetCopy2.parent_id, CanvasSetCopy.user_id == CanvasSetCopy2.matched_user_id)).\
            filter(GradeInfo.id == grade_id).\
            filter(UnitInfo.id == unit_id).\
            order_by(GradeInfo.grade_number.asc()).\
            order_by(UnitInfo.unit_number.asc()).\
            order_by(Curriculum.curriculum_number.asc()).\
            order_by(Curriculum.id.desc()).\
            order_by(CanvasSetCopy3.user_completed.asc()).\
            order_by(CanvasSetCopy2.user_id.asc()).\
            order_by(CanvasSetCopy.user_id.asc()).\
            all()

    results_cscopy_ids = [x.cscopy_id for x in results]

    # Get unmatched lessons as well. Avoid dups from above results.
    results2 = DBSession.query(
            Curriculum.id.label('curriculum_id'),
            Curriculum.start_datetime.label('curriculum_start'),
            Curriculum.end_datetime.label('curriculum_end'),
            CanvasSet.id.label('canvas_set_id'),
            CanvasSet.description.label('lesson_description'),
            GradeInfo.grade_number.label('grade_number'),
            GradeInfo.id.label('grade_id'),
            UnitInfo.unit_number.label('unit_number'),
            UnitInfo.id.label('unit_id'),
            UnitInfo.description.label('unit_description'),
            Curriculum.curriculum_number.label('lesson_number'),
            Curriculum.featured_image.label('featured_image'),
            Curriculum.secondary_description.label('secondary_lesson_description'),
            CanvasSetCopy.matched_user_id.label('matched_user_id'),
            CanvasSetCopy.start_datetime.label('canvas_start'),
            CanvasSetCopy.end_datetime.label('canvas_end'),
            CanvasSetCopy.user_id.label('party_user_id'),
            CanvasSetCopy.role.label('party_canvas_role'),
            CanvasSetCopy.id.label('cscopy_id'),
            CanvasSetCopy.user_completed.label('party_canvas_completed'),
            Curriculum.canvas_type.label('lesson_type')).\
            options(FromCache(DOGPILE_CACHE_REGION)).\
            distinct(GradeInfo.grade_number).\
            distinct(UnitInfo.unit_number).\
            distinct(Curriculum.curriculum_number).\
            distinct(Curriculum.id).\
            join(GradeInfo, Curriculum.grade_id == GradeInfo.id).\
            join(UnitInfo, Curriculum.unit_id == UnitInfo.id).\
            join(CanvasSet, Curriculum.id == CanvasSet.curriculum_id).\
            outerjoin(CanvasSetCopy, and_(CanvasSet.id == CanvasSetCopy.parent_id, user_id == CanvasSetCopy.user_id)).\
            filter(GradeInfo.id == grade_id).\
            filter(UnitInfo.id == unit_id).\
            filter(CanvasSetCopy.id.notin_(results_cscopy_ids)).\
            order_by(GradeInfo.grade_number.asc()).\
            order_by(UnitInfo.unit_number.asc()).\
            order_by(Curriculum.curriculum_number.asc()).\
            order_by(Curriculum.id.desc()).\
            order_by(CanvasSetCopy.user_id.asc()).\
            all()

    sort_outbound = {}

    for x in results:
        if x.canvas_start not in sort_outbound:
            sort_outbound[x.canvas_start] = [x]
        else:
            sort_outbound[x.canvas_start].append(x)

    for x in results2:
        if x.canvas_start not in sort_outbound:
            sort_outbound[x.canvas_start] = [x]
        else:
            sort_outbound[x.canvas_start].append(x)

    outbound = []
    for k in sorted(sort_outbound.keys()):
        outbound.extend(sort_outbound[k])

    return [outbound, latest_counterparty]

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_supplemental_resources(user_id):

    google_resources = DBSession.query(
        WidgetContentCopy.new_doc_id.label('personal_google_link'),
        WidgetContentCopy.html.label('card_html'),
        WidgetContentCopy.url.label('card_url'),
        WidgetContentCopy.orig_doc_id.label('original_google_link')).\
        options(FromCache(DOGPILE_CACHE_REGION)).\
        distinct(WidgetContentCopy.new_doc_id).\
        filter(WidgetContentCopy.user_id == user_id).\
        filter(WidgetContentCopy.new_doc_id != None).\
        all()
        
    uploaded_resources = DBSession.query(
        WidgetContentUserResponse.response_url.label('uploaded_file_link')).\
        options(FromCache(DOGPILE_CACHE_REGION)).\
        distinct(WidgetContentUserResponse.response_url).\
        filter(WidgetContentUserResponse.user_id == user_id).\
        filter(WidgetContentUserResponse.response_url != None).\
        filter(WidgetContentUserResponse.response_url != '').\
        all()

    google_outer_list = []
    sorted_google_outer_list = []
    for resource in google_resources:
        inner_list = []

        # We determine the type of Google resource, based on instructions displayed
        # to the user or the original Google link.
        if resource.card_html:
            for k,v in RESOURCE_MAP_LINK.items():
                if k in resource.card_html:
                    google_link = v + resource.personal_google_link
                    break
            else:
                # This condition occurs if the loop break never occurred.
                google_link = 'NA'

        elif resource.card_url:
            for k,v in RESOURCE_MAP_LINK.items():
                if k in resource.card_url:
                    google_link = v + resource.personal_google_link
                    break
            else:
                # This condition occurs if the loop break never occurred.
                google_link = 'NA'


        inner_list.append(google_link)
        
        # We create a mapping of original Google links to their titles.
        doctitle_map = DBSession.query(DocTitleMapping).filter(
            DocTitleMapping.orig_doc_id == resource.original_google_link
            ).first()

        if not doctitle_map:
            doctitle_map = DBSession.query(DocTitleMapping).filter(
                DocTitleMapping.orig_doc_id == None
                ).one()
        
        inner_list.append(doctitle_map.doc_title)
        
        inner_list.append('Google')
        
        google_outer_list.append(tuple(inner_list))
        sorted_google_outer_list = sorted(google_outer_list, key=lambda resource: resource[1], reverse = False)

    uploaded_outer_list = []
    sorted_uploaded_outer_list = []
    for resource in uploaded_resources:
        inner_list = []
        
        inner_list.append(resource.uploaded_file_link)
        
        # We parse only the file name for display.
        uploaded_file_description = re.sub('/user_content/[0-9]*/', '', resource.uploaded_file_link)
        inner_list.append(uploaded_file_description)

        inner_list.append('Uploaded File')
        
        uploaded_outer_list.append(tuple(inner_list))
        sorted_uploaded_outer_list = sorted(uploaded_outer_list, key=lambda resource: resource[1], reverse = False)

    user_role = Role(user_id)
    latest_counterparty = user_role.get_matching_mentor_mentee()

    # We want to display any files uploaded by the counterparty as well.
    if latest_counterparty:
        counterparty_user_id = latest_counterparty.id
        counterparty_uploaded_resources = DBSession.query(
            WidgetContentUserResponse.response_url.label('uploaded_file_link')).\
            options(FromCache(DOGPILE_CACHE_REGION)).\
            distinct(WidgetContentUserResponse.response_url).\
            filter(WidgetContentUserResponse.user_id == counterparty_user_id).\
            filter(WidgetContentUserResponse.response_url != None).\
            filter(WidgetContentUserResponse.response_url != '').\
            all()

        for resource in counterparty_uploaded_resources:
            inner_list = []
            
            inner_list.append(resource.uploaded_file_link)
            
            # We parse only the file name for display.
            uploaded_file_description = re.sub('/user_content/[0-9]*/', '', resource.uploaded_file_link)
            inner_list.append(uploaded_file_description)
    
            inner_list.append('Uploaded File')
            
            uploaded_outer_list.append(tuple(inner_list))
            sorted_uploaded_outer_list = sorted(uploaded_outer_list, key=lambda resource: resource[1], reverse = False)

    final_outer_list = []
    # We sort each group of resources separately, then combine then to preserve the sorted groups.
    final_outer_list = sorted_google_outer_list + sorted_uploaded_outer_list

    return final_outer_list

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
if __name__=="__main__":
    #get_scheduled_grades(151937)
    #get_scheduled_units(151964, 1)
    #get_scheduled_lessons(151865, 3, 3)
    #get_reflection_response(151937, 2, 10)
    #get_reflection_card(1, 2)
    get_supplemental_resources(151865)
