# -*- coding: iso8859-15 -*-
import os,sys
import pprint
import logging
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
from canvas.models import (Curriculum, CurriculumCopy, GradeInfo, UnitInfo, CanvasSet, 
    WidgetContentUserResponse, WidgetContentResponseMarkerCopy, WidgetContentCopy, 
    WidgetCopy, CanvasAppCopy, CanvasSetCopy, CurriculumCopy, WidgetContentMarkerReferenceCopy,
    PartnersSessionCurriculum)
from portfolio.models import ReflectionUserResponse, ReflectionCard, ReflectionUserDetails
from conversations.models import Conversation
from utils.user_details import get_details_for_user, get_latest_mentor_for_mentee, get_latest_mentee_for_mentor
from legacy_models.partners import PartnersPartner, PartnersSession
from legacy_models.member import MemberMember
from legacy_models.utils import UtilsTimezone
from legacy_models.iuser import (IuserUser, IuserPersona, IuserPersonaPartner, ACTIVE_PERSONA_STATUS,
    IuserAssignedusertype, IuserUsertype)
from datetime import datetime
from dateutil import tz
from decimal import Decimal
from flipbook.models import (FlagType,FlagCanvas,FlagConversation,
    FlagReflection,REVIEW_FLAG,SAFETY_FLAG,STORY_FLAG)


CONTENT_DATETIME_FORMAT = '%-m/%-d/%-y %-I:%M %p'
CONV_DATE_FORMAT = '%d%m%Y'

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_class_roster(partner_ids):

    # We obtain data for all mentors and mentees receiving iMentor services.
    class_users = DBSession.query(
        IuserUser.id.label('user_id'),
        IuserPersona.id.label('persona_id'),
        IuserUser.first_name.label('first_name'),
        IuserUser.last_name.label('last_name'),
        IuserUsertype.type.label('user_type'),
        IuserPersonaPartner.partner_id.label('partner_id'),
        IuserPersona.match_status.label('match_status'),
        UtilsTimezone.name.label('time_zone')).\
        options(FromCache(DOGPILE_CACHE_REGION)).\
        join(IuserPersona, IuserUser.id == IuserPersona.user_id).\
        join(IuserPersonaPartner, IuserPersona.id == IuserPersonaPartner.persona_id).\
        join(IuserAssignedusertype, IuserPersona.assigned_usertype_id == IuserAssignedusertype.id).\
        join(IuserUsertype, IuserAssignedusertype.usertype_id == IuserUsertype.id).\
        join(MemberMember, IuserUser.member_id == MemberMember.id).\
        join(UtilsTimezone, MemberMember.time_zone_id == UtilsTimezone.id).\
        filter(IuserUsertype.id.in_([5, 4])).\
        filter(IuserPersona.status == ACTIVE_PERSONA_STATUS).\
        filter(IuserPersona.match_status != 'C').\
        filter(IuserUser.status.in_(['A', 'SI'])).\
        filter(IuserPersonaPartner.partner_id.in_(partner_ids)).\
        order_by(IuserUser.first_name.asc()).\
        order_by(IuserUser.last_name.asc()).\
        all()

    outer_list = []
    for user in class_users:
        inner_list = []
        
        inner_list.append(user.first_name)
        inner_list.append(user.last_name)
        inner_list.append(user.user_id)
        inner_list.append(user.persona_id)
        inner_list.append(user.user_type)
        
        user_profile_link = '/iuser/backend_profile/' + str(user.persona_id) + '/'
        inner_list.append(user_profile_link)
        
        inner_list.append(user.match_status)
        inner_list.append(user.time_zone)

        outer_list.append(tuple(inner_list))

    return outer_list

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_new_content(partner_ids, filter):

    class_roster = get_class_roster(partner_ids)
    outer_list = []
    for user in class_roster:
        canvas_details = get_new_canvas_details(user[2], filter)
        to_tz = tz.gettz(user[7])

        # Some users may have no new content.
        if canvas_details:
            for detail in canvas_details:
                canvas_inner_list = []
                canvas_inner_list.append(user[0])
                canvas_inner_list.append(user[1])
                canvas_inner_list.append(user[4])
                canvas_inner_list.append(user[5])

                lesson_link = '/canvas/lessoncopy/' + str(detail.cscopy_id) + '/' + str(user[2]) + '/'
                canvas_inner_list.append(lesson_link)

                # We always have a party viewed date.
                canvas_party_viewed_display = detail.party_viewed.replace(tzinfo=tz.gettz('UTC')).astimezone(to_tz).replace(tzinfo=None)
                canvas_inner_list.append(canvas_party_viewed_display)
                
                # However, we may not have a staff viewed date yet.
                if detail.party_staff_last_viewed:
                    canvas_party_staff_last_viewed_display = detail.party_staff_last_viewed.replace(tzinfo=tz.gettz('UTC')).astimezone(to_tz).replace(tzinfo=None)
                    canvas_inner_list.append(canvas_party_staff_last_viewed_display.strftime(CONTENT_DATETIME_FORMAT))
                else:
                    canvas_inner_list.append('NA')
                
                canvas_inner_list.append('Canvas: ' + detail.lesson_description)
                
                if detail.flag_id:
                    canvas_inner_list.append(detail.flag_id)
                    canvas_inner_list.append(detail.flag_type_id)
                    canvas_inner_list.append(detail.flag_description)
                else:
                    canvas_inner_list.append('NA')
                    canvas_inner_list.append('NA')
                    canvas_inner_list.append('NA')

                canvas_inner_list.append(detail.canvas_id)

                outer_list.append(tuple(canvas_inner_list))

        # Only matched users have access to Conversations.
        if user[6] == 'M':
            conversation_details = get_new_conversation_details(user[2], filter)
            
            if conversation_details:
                for detail in conversation_details:
                    conversation_inner_list = []
                    conversation_inner_list.append(user[0])
                    conversation_inner_list.append(user[1])
                    conversation_inner_list.append(user[4])
                    conversation_inner_list.append(user[5])
                    
                    conversation_link = str(user[2]) + "," + detail.conversation_start.strftime(CONV_DATE_FORMAT) + "," + datetime.utcnow().strftime(CONV_DATE_FORMAT)
                    conversation_inner_list.append(conversation_link)
                    
                    # We always have a party viewed date.
                    conversation_start_display = detail.conversation_start.replace(tzinfo=tz.gettz('UTC')).astimezone(to_tz).replace(tzinfo=None)
                    conversation_inner_list.append(conversation_start_display)

                    # However, we may not have a staff viewed date yet.
                    if detail.staff_last_viewed:
                        conversation_staff_last_viewed_display = detail.staff_last_viewed.replace(tzinfo=tz.gettz('UTC')).astimezone(to_tz).replace(tzinfo=None)
                        conversation_inner_list.append(conversation_staff_last_viewed_display.strftime(CONTENT_DATETIME_FORMAT))
                    else:
                        conversation_inner_list.append('NA')

                    conversation_inner_list.append('Conversation')
                    
                    if detail.flag_id:
                        conversation_inner_list.append(detail.flag_id)
                        conversation_inner_list.append(detail.flag_type_id)
                        conversation_inner_list.append(detail.flag_description)
                    else:
                        conversation_inner_list.append('NA')
                        conversation_inner_list.append('NA')
                        conversation_inner_list.append('NA')

                    conversation_inner_list.append(detail.conversation_id)

                    outer_list.append(tuple(conversation_inner_list))

        # We no longer use reflections.
        #reflection_details = get_new_reflection_details(user[2], filter)
        reflection_details = None
        
        # We include Reflections here for safety purposes, though Reflections likely will not count toward participation.
        if reflection_details:
            for detail in reflection_details:
                reflection_inner_list = []
                reflection_inner_list.append(user[0])
                reflection_inner_list.append(user[1])
                reflection_inner_list.append(user[4])
                reflection_inner_list.append(user[5])

                reflection_link = '/portfolio/' + str(user[2]) + '/#/grade/' + str(detail.grade_id) + '/unit/' + str(detail.unit_id) + '/'
                reflection_inner_list.append(reflection_link)

                # We always have a party viewed date.
                reflection_party_viewed_display = detail.party_viewed.replace(tzinfo=tz.gettz('UTC')).astimezone(to_tz).replace(tzinfo=None)
                reflection_inner_list.append(reflection_party_viewed_display)
                
                # However, we may not have a staff viewed date yet.
                if detail.staff_last_viewed:
                    reflection_staff_last_viewed_display = detail.staff_last_viewed.replace(tzinfo=tz.gettz('UTC')).astimezone(to_tz).replace(tzinfo=None)
                    reflection_inner_list.append(reflection_staff_last_viewed_display.strftime(CONTENT_DATETIME_FORMAT))
                else:
                    reflection_inner_list.append('NA')

                reflection_inner_list.append('Reflection: ' + detail.unit_description)
                
                if detail.flag_id:
                    reflection_inner_list.append(detail.flag_id)
                    reflection_inner_list.append(detail.flag_type_id)
                    reflection_inner_list.append(detail.flag_description)
                else:
                    reflection_inner_list.append('NA')
                    reflection_inner_list.append('NA')
                    reflection_inner_list.append('NA')

                reflection_inner_list.append(detail.reflection_id)

                outer_list.append(tuple(reflection_inner_list))              

    # We sort the new content from oldest to newest.
    # We don't convert the party viewed dates into strings here, so that the chronological sort works correctly.
    def getKey(item):
        return item[5]

    sorted_list = sorted(outer_list, key = getKey, reverse = False)

    return sorted_list

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_new_canvas_details(user_id, filter):

    results = DBSession.query(
        Curriculum.id.label('curriculum_id'),
        CanvasSet.id.label('canvas_set_id'),
        CanvasSet.description.label('lesson_description'),
        GradeInfo.grade_number.label('grade_number'),
        UnitInfo.unit_number.label('unit_number'),
        Curriculum.curriculum_number.label('lesson_number'),
        CanvasSetCopy.matched_user_id.label('matched_user_id'),
        CanvasSetCopy.id.label('cscopy_id'),
        CanvasSetCopy.start_datetime.label('canvas_start'),
        CanvasSetCopy.end_datetime.label('canvas_end'),
        CanvasSetCopy.role.label('party_canvas_role'),
        CanvasSetCopy.last_viewed.label('party_viewed'),
        CanvasSetCopy.user_completed.label('party_canvas_ever_completed'),
        CanvasSetCopy.user_first_completed.label('party_canvas_first_completed'),
        CanvasSetCopy.admin_last_viewed.label('party_staff_last_viewed'),
        CanvasSetCopy.parent_id.label('party_lesson_id'),
        CanvasSetCopy.user_id.label('party_user_id'),
        CanvasSetCopy.persona_id.label('party_persona_id'),
        FlagCanvas.id.label('flag_id'),
        FlagType.id.label('flag_type_id'),
        FlagType.description.label('flag_description'),
        CanvasSetCopy.id.label('canvas_id')).\
        options(FromCache(DOGPILE_CACHE_REGION)).\
        distinct(GradeInfo.grade_number).\
        distinct(UnitInfo.unit_number).\
        distinct(Curriculum.curriculum_number).\
        distinct(Curriculum.id).\
        join(GradeInfo, Curriculum.grade_id == GradeInfo.id).\
        join(UnitInfo, Curriculum.unit_id == UnitInfo.id).\
        join(CanvasSet, Curriculum.id == CanvasSet.curriculum_id).\
        join(CanvasSetCopy, and_(CanvasSet.id == CanvasSetCopy.parent_id, user_id == CanvasSetCopy.user_id)).\
        outerjoin(FlagCanvas, and_(CanvasSetCopy.id == FlagCanvas.canvas_id, None == FlagCanvas.admin_removed_datetime)).\
        outerjoin(FlagType, FlagCanvas.flag_type_id == FlagType.id)

    if filter == 'new':
        results = results.\
            filter(or_(CanvasSetCopy.admin_last_viewed < CanvasSetCopy.last_viewed, CanvasSetCopy.admin_last_viewed == None))
    elif filter == 'review':
        results = results.\
            filter(FlagType.id == 1)
    elif filter == 'safety':
        results = results.\
            filter(FlagType.id == 2)
    elif filter == 'story':
        results = results.\
            filter(FlagType.id == 3)

    results = results.\
        filter(CanvasSetCopy.last_viewed != None).\
        order_by(GradeInfo.grade_number.asc()).\
        order_by(UnitInfo.unit_number.asc()).\
        order_by(Curriculum.curriculum_number.asc()).\
        order_by(Curriculum.id.asc()).\
        order_by(CanvasSetCopy.last_viewed.desc()).\
        all()

    return results

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_new_conversation_details(user_id, filter):

    results = DBSession.query(
        Conversation.id.label('conversation_id'),
        Conversation.user_id.label('party_user_id'),
        Conversation.recipient_user_id.label('counterparty_user_id'),
        Conversation.received_by_server.label('conversation_start'),
        Conversation.admin_last_viewed.label('staff_last_viewed'),
        FlagConversation.id.label('flag_id'),
        FlagType.id.label('flag_type_id'),
        FlagType.description.label('flag_description')).\
        options(FromCache(DOGPILE_CACHE_REGION)).\
        outerjoin(FlagConversation, and_(Conversation.id == FlagConversation.conversation_id, None == FlagConversation.admin_removed_datetime)).\
        outerjoin(FlagType, FlagConversation.flag_type_id == FlagType.id).\
        filter(user_id == Conversation.user_id)
        
    if filter == 'new':
        results = results.\
            filter(or_(Conversation.admin_last_viewed < Conversation.received_by_server, Conversation.admin_last_viewed == None))
    elif filter == 'review':
        results = results.\
            filter(FlagType.id == 1)
    elif filter == 'safety':
        results = results.\
            filter(FlagType.id == 2)
    elif filter == 'story':
        results = results.\
            filter(FlagType.id == 3)

    results = results.\
        order_by(Conversation.received_by_server.desc()).\
        all()

    return results
    
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_new_reflection_details(user_id, filter):

    results = DBSession.query(
        ReflectionUserDetails.id.label('reflection_id'),
        ReflectionUserDetails.grade_id.label('grade_id'),
        ReflectionUserDetails.unit_id.label('unit_id'),
        ReflectionUserDetails.last_viewed.label('party_viewed'),
        ReflectionUserDetails.admin_last_viewed.label('staff_last_viewed'),
        UnitInfo.description.label('unit_description'),
        FlagReflection.id.label('flag_id'),
        FlagType.id.label('flag_type_id'),
        FlagType.description.label('flag_description')).\
        options(FromCache(DOGPILE_CACHE_REGION)).\
        join(UnitInfo, ReflectionUserDetails.unit_id == UnitInfo.id).\
        outerjoin(FlagReflection, and_(ReflectionUserDetails.id == FlagReflection.reflection_id, None == FlagReflection.admin_removed_datetime)).\
        outerjoin(FlagType, FlagReflection.flag_type_id == FlagType.id).\
        filter(ReflectionUserDetails.user_id == user_id)

    if filter == 'new':
        results = results.\
            filter(or_(ReflectionUserDetails.admin_last_viewed < ReflectionUserDetails.last_viewed, ReflectionUserDetails.admin_last_viewed == None))
    elif filter == 'review':
        results = results.\
            filter(FlagType.id == REVIEW_FLAG)
    elif filter == 'safety':
        results = results.\
            filter(FlagType.id == SAFETY_FLAG)
    elif filter == 'story':
        results = results.\
            filter(FlagType.id == STORY_FLAG)

    results = results.\
        order_by(ReflectionUserDetails.last_viewed.desc()).\
        all()

    return results

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
if __name__=="__main__":
    #get_class_roster(1817)
    get_new_content([1817], 'new')
    #get_new_canvas_details(151865, 'new')
    #get_new_conversation_details(151865, 'all')
    #get_new_reflection_details(151865, 'all')
