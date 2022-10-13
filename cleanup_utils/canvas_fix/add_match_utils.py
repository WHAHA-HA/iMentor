# -*- coding: iso8859-15 -*-
import time
from multiprocessing import Process
import subprocess
import os,sys
import pprint
import logging
import datetime
import re
import csv
from pytz import timezone
from sqlalchemy import and_,or_,desc
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'../..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import get_scoped_session,Base,metadata,DBSession,DOGPILE_CACHE_REGION
from config.settings import SUPERUSER_ANNOUNCER_ID
from utils.roles import Role

from utils.user_details import get_partners_for_user
from legacy_models.iuser import (IuserPersonaPartner,IuserPersona,IuserUsertype,
    IuserAssignedusertype,IuserUser,ACTIVE_PERSONA_STATUS)
from legacy_models.member import MemberMember
from legacy_models.iuser import IuserMatchhistory
from canvas.models import (CurriculumCopy,CanvasSetCopy,
    CanvasAppCopy,WidgetCopy,WidgetContentCopy,WidgetContentResponseMarkerCopy,
    WidgetContentMarkerReferenceCopy,WidgetContentUserResponse,WidgetContentUserResponseHistory,
    FlaggedLesson,Curriculum)

def adjust_times():
    start_date = datetime.datetime(year=datetime.datetime.utcnow().year-1,month=8,day=1)
    end_date = datetime.datetime(year=datetime.datetime.utcnow().year,month=7,day=31,hour=23,minute=59,second=59)

    local_db_session = get_scoped_session()
    #local_db_session.query(Curriculum).filter(
    #Curriculum.id >= 189).update({
    local_db_session.query(Curriculum).update({
    'start_datetime':start_date,
    'end_datetime':end_date})
    local_db_session.commit()
    
def add_match_user_id_from_lesson(local_db_session,user_id,persona_id,other_user_id,other_persona_id,lesson):
    lesson.matched_user_id = other_user_id
    lesson.matched_persona_id = other_persona_id
    lesson.curriculum_user_copy.matched_user_id = other_user_id
    lesson.curriculum_user_copy.matched_persona_id = other_persona_id
    if lesson.admin_last_viewed and lesson.admin_last_viewed < lesson.start_datetime:
        lesson.admin_last_viewed = None
    if lesson.last_viewed and lesson.last_viewed < lesson.start_datetime:
        lesson.last_viewed = None
    if lesson.user_completed and lesson.user_completed < lesson.start_datetime:
        lesson.user_completed = None
    if lesson.user_first_completed and lesson.user_first_completed < lesson.start_datetime:
        if lesson.last_viewed:
            lesson.user_first_completed = lesson.last_viewed
            if not lesson.user_completed:
                lesson.user_completed = lesson.last_viewed
        else:
            lesson.user_first_completed = None
            lesson.user_completed = None
    if lesson.user_started and lesson.user_started < lesson.start_datetime:
        lesson.user_started = None

    cacs = local_db_session.query(CanvasAppCopy).filter(
        CanvasAppCopy.id==lesson.id).all()
    for cac in cacs:
        cac.matched_user_id = other_user_id
        cac.matched_persona_id = other_persona_id

        wcs = local_db_session.query(WidgetCopy).filter(
            WidgetCopy.canvas_app_id==cac.id).all()
        for wc in wcs:
            wc.matched_user_id = other_user_id
            wc.matched_persona_id = other_persona_id

            wccs = local_db_session.query(WidgetContentCopy).filter(
                WidgetContentCopy.widget_id==wc.id).all()
            for wcc in wccs:
                wcc.matched_user_id = other_user_id
                wcc.matched_persona_id = other_persona_id

                local_db_session.query(WidgetContentMarkerReferenceCopy).filter(
                    WidgetContentMarkerReferenceCopy.matched_user_id==None).filter(
                    WidgetContentMarkerReferenceCopy.user_id == user_id).filter(
                    WidgetContentMarkerReferenceCopy.widget_content_id==wcc.id).update({
                        'matched_user_id':other_user_id,
                        'matched_persona_id':other_persona_id},synchronize_session=False)
                
                local_db_session.query(WidgetContentMarkerReferenceCopy).filter(
                    WidgetContentMarkerReferenceCopy.matched_user_id==None).filter(
                    WidgetContentMarkerReferenceCopy.user_id == other_user_id).filter(
                    WidgetContentMarkerReferenceCopy.widget_content_id==wcc.id).update({
                        'matched_user_id':user_id,
                        'matched_persona_id':persona_id},synchronize_session=False)
                
                markers = local_db_session.query(WidgetContentResponseMarkerCopy).filter(
                    WidgetContentResponseMarkerCopy.matched_user_id == None).filter(
                    WidgetContentResponseMarkerCopy.widget_content_id == wcc.id).all()

                for marker in markers:

                    local_db_session.query(WidgetContentUserResponse).filter(
                        WidgetContentUserResponse.matched_user_id == None).filter(
                        WidgetContentUserResponse.user_id == other_user_id).filter(
                        WidgetContentUserResponse.marker_id == marker.id).update({
                            'matched_user_id':user_id,
                            'matched_persona_id':persona_id},synchronize_session=False)
                
                    local_db_session.query(WidgetContentUserResponse).filter(
                        WidgetContentUserResponse.matched_user_id == None).filter(
                        WidgetContentUserResponse.user_id == user_id).filter(
                        WidgetContentUserResponse.marker_id == marker.id).update({
                            'matched_user_id':other_user_id,
                            'matched_persona_id':other_persona_id},synchronize_session=False)
                
                    local_db_session.query(WidgetContentResponseMarkerCopy).filter(
                        WidgetContentResponseMarkerCopy.user_id==other_user_id).filter(
                        WidgetContentResponseMarkerCopy.id==marker.id).filter(
                        WidgetContentResponseMarkerCopy.matched_user_id==None).update({
                            'matched_user_id':user_id,
                            'matched_persona_id':persona_id},synchronize_session=False)
                
                    local_db_session.query(WidgetContentResponseMarkerCopy).filter(
                        WidgetContentResponseMarkerCopy.user_id==user_id).filter(
                        WidgetContentResponseMarkerCopy.id==marker.id).filter(
                        WidgetContentResponseMarkerCopy.matched_user_id==None).update({
                            'matched_user_id':other_user_id,
                            'matched_persona_id':other_persona_id},synchronize_session=False)
                

def add_match_user_id_from_response(local_db_session,user_id,persona_id,other_user_id,other_persona_id,response,history):
    history.matched_user_id = other_user_id
    history.matched_persona_id = other_persona_id
    response.matched_user_id = other_user_id
    response.matched_persona_id = other_persona_id
    response.widget_content_marker_user_copy.matched_user_id = other_user_id
    response.widget_content_marker_user_copy.matched_persona_id = other_persona_id
    response.widget_content_marker_user_copy.widget_content_user_copy.matched_user_id = other_user_id
    response.widget_content_marker_user_copy.widget_content_user_copy.matched_persona_id = other_persona_id
    response.widget_content_marker_user_copy.widget_content_user_copy.widget_user_copy.matched_user_id = other_user_id
    response.widget_content_marker_user_copy.widget_content_user_copy.widget_user_copy.matched_persona_id = other_persona_id
    response.widget_content_marker_user_copy.widget_content_user_copy.widget_user_copy.canvas_app_user_copy.matched_user_id = other_user_id
    response.widget_content_marker_user_copy.widget_content_user_copy.widget_user_copy.canvas_app_user_copy.matched_persona_id = other_persona_id
    response.widget_content_marker_user_copy.widget_content_user_copy.widget_user_copy.canvas_app_user_copy.canvas_set_user_copy.matched_user_id = other_user_id
    response.widget_content_marker_user_copy.widget_content_user_copy.widget_user_copy.canvas_app_user_copy.canvas_set_user_copy.matched_persona_id = other_persona_id
    lesson = response.widget_content_marker_user_copy.widget_content_user_copy.widget_user_copy.canvas_app_user_copy.canvas_set_user_copy
    if lesson.admin_last_viewed and lesson.admin_last_viewed < lesson.start_datetime:
        lesson.admin_last_viewed = None
    if lesson.last_viewed and lesson.last_viewed < lesson.start_datetime:
        lesson.last_viewed = None
    if lesson.user_completed and lesson.user_completed < lesson.start_datetime:
        lesson.user_completed = None
    if lesson.user_first_completed and lesson.user_first_completed < lesson.start_datetime:
        if lesson.last_viewed:
            lesson.user_first_completed = lesson.last_viewed
            if not lesson.user_completed:
                lesson.user_completed = lesson.last_viewed
        else:
            lesson.user_first_completed = None
            lesson.user_completed = None
    if lesson.user_started and lesson.user_started < lesson.start_datetime:
        lesson.user_started = None
    response.widget_content_marker_user_copy.widget_content_user_copy.widget_user_copy.canvas_app_user_copy.canvas_set_user_copy.curriculum_user_copy.matched_user_id = other_user_id
    response.widget_content_marker_user_copy.widget_content_user_copy.widget_user_copy.canvas_app_user_copy.canvas_set_user_copy.curriculum_user_copy.matched_persona_id = other_persona_id

    # For response markers/references to their own, or their matche's responses.
    local_db_session.query(WidgetContentResponseMarkerCopy).filter(
        WidgetContentResponseMarkerCopy.id==response.widget_content_marker_user_copy.widget_content_id).filter(
        WidgetContentResponseMarkerCopy.persona_id==persona_id).update({
            'matched_user_id':other_user_id,
            'matched_persona_id':other_persona_id},synchronize_session=False)

    local_db_session.query(WidgetContentResponseMarkerCopy).filter(
        WidgetContentResponseMarkerCopy.id==response.widget_content_marker_user_copy.widget_content_id).filter(
        WidgetContentResponseMarkerCopy.persona_id==other_persona_id).update({
            'matched_user_id':user_id,
            'matched_persona_id':persona_id},synchronize_session=False)

    local_db_session.query(WidgetContentMarkerReferenceCopy).filter(
        WidgetContentMarkerReferenceCopy.widget_content_id==response.widget_content_marker_user_copy.widget_content_id).filter(
        WidgetContentMarkerReferenceCopy.persona_id==persona_id).update({
            'matched_user_id':other_user_id,
            'matched_persona_id':other_persona_id},synchronize_session=False)

    local_db_session.query(WidgetContentMarkerReferenceCopy).filter(
        WidgetContentMarkerReferenceCopy.widget_content_id==response.widget_content_marker_user_copy.widget_content_id).filter(
        WidgetContentMarkerReferenceCopy.persona_id==other_persona_id).update({
            'matched_user_id':user_id,
            'matched_persona_id':persona_id},synchronize_session=False)

if __name__ == '__main__':
     adjust_times()
