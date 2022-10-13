#!/usr/bin/env python
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
from canvas.models import (Curriculum,CanvasSet,
    CanvasApp,Widget,WidgetContent,WidgetContentResponseMarker,
    WidgetContentMarkerReference)

'''
This makes a master copy of Canvas masters for a new school year. This keeps partner sessions
accurate, and easily allows for duplicate lesson assignment across year, since the master 
ids will be different.
Note that duplicate assignment of the same master across different matches, for example, if a 
mentor is matched with a new mentee and repeats lessons with that new mentee) is also allowed
in the system, and has nothing to do with new vs. original masters. 
'''
old_to_new_markers  = {}
new_refs = []

def copy_lesson_master():
    local_db_session = get_scoped_session()

    # Give it a good date range for portfolio visibility filtering. 
    # This is assuming this script is run in the summer/fall of the school year that is just starting.
    start_date = datetime.datetime(year=datetime.datetime.utcnow().year,month=8,day=1)
    end_date = datetime.datetime(year=datetime.datetime.utcnow().year+1,month=7,day=31,hour=23,minute=59,second=59)

    for curriculum in local_db_session.query(Curriculum).filter(
        Curriculum.active == True).all():
        new_curr = dict([(x,y) for x,y in curriculum.__dict__.iteritems() if x not in ('_sa_instance_state','id')])
        curriculum.active=False
        new_curr_obj = Curriculum(**new_curr)
        new_curr_obj.start_datetime = start_date
        new_curr_obj.end_datetime = end_date
        local_db_session.add(new_curr_obj)
        local_db_session.flush()
        print "Added new curriculum {0}".format(new_curr_obj.id)

        for canvas_set in local_db_session.query(CanvasSet).filter(
            CanvasSet.active == True).filter(
            CanvasSet.curriculum_id == curriculum.id).all():
            new_cs = dict([(x,y) for x,y in canvas_set.__dict__.iteritems() if x not in ('_sa_instance_state','id','curriculum_id')])
            new_cs_obj = CanvasSet(**new_cs)
            new_cs_obj.curriculum_id = new_curr_obj.id
            canvas_set.active=False
            local_db_session.add(new_cs_obj)
            local_db_session.flush()

            for canvas_app in local_db_session.query(CanvasApp).filter(
                CanvasApp.active == True).filter(
                CanvasApp.canvas_set_id == canvas_set.id).all():
                new_ca = dict([(x,y) for x,y in canvas_app.__dict__.iteritems() if x not in ('_sa_instance_state','id','canvas_set_id')])
                new_ca_obj = CanvasApp(**new_ca)
                new_ca_obj.canvas_set_id = new_cs_obj.id
                canvas_app.active=False
                local_db_session.add(new_ca_obj)
                local_db_session.flush()

                for widget in local_db_session.query(Widget).filter(
                    Widget.active == True).filter(
                    Widget.canvas_app_id == canvas_app.id).all():
                    new_w = dict([(x,y) for x,y in widget.__dict__.iteritems() if x not in ('_sa_instance_state','id','canvas_app_id')])
                    new_w_obj = Widget(**new_w)
                    new_w_obj.canvas_app_id = new_ca_obj.id
                    widget.active=False
                    local_db_session.add(new_w_obj)
                    local_db_session.flush()

                    for widget_content in local_db_session.query(WidgetContent).filter(
                        WidgetContent.active == True).filter(
                        WidgetContent.widget_id == widget.id).all():
                        new_wc = dict([(x,y) for x,y in widget_content.__dict__.iteritems() if x not in ('_sa_instance_state','id','widget_id')])
                        new_wc_obj = WidgetContent(**new_wc)
                        new_wc_obj.widget_id = new_w_obj.id
                        widget_content.active=False
                        local_db_session.add(new_wc_obj)
                        local_db_session.flush()

                        for widget_marker in local_db_session.query(WidgetContentResponseMarker).filter(
                            WidgetContentResponseMarker.active == True).filter(
                            WidgetContentResponseMarker.widget_content_id == widget_content.id).all():
                            new_cm = dict([(x,y) for x,y in widget_marker.__dict__.iteritems() if x not in ('_sa_instance_state','id','widget_content_id')])
                            new_cm_obj = WidgetContentResponseMarker(**new_cm)
                            new_cm_obj.widget_content_id = new_wc_obj.id
                            widget_marker.active=False
                            local_db_session.add(new_cm_obj)
                            local_db_session.flush()
                            old_to_new_markers[widget_marker.id] = new_cm_obj.id

                        for widget_marker_ref in local_db_session.query(WidgetContentMarkerReference).filter(
                            WidgetContentMarkerReference.active == True).filter(
                            WidgetContentMarkerReference.widget_content_id == widget_content.id).all():
                            new_cmr = dict([(x,y) for x,y in widget_marker_ref.__dict__.iteritems() if x not in ('_sa_instance_state','id','widget_content_id')])
                            new_cmr_obj = WidgetContentMarkerReference(**new_cmr)
                            new_cmr_obj.widget_content_id = new_wc_obj.id
                            widget_marker_ref.active=False
                            local_db_session.add(new_cmr_obj)
                            local_db_session.flush()
                            new_refs.append(new_cmr_obj.id)

    local_db_session.commit()
    local_db_session.begin()

    # Now fix marker references, so new answers get seen properly in new lessons.
    for widget_marker_ref in local_db_session.query(WidgetContentMarkerReference).filter(
        WidgetContentMarkerReference.id.in_(new_refs)).all():
        print "Replacing marker ref {0} with {1} in {2}".format(widget_marker_ref.other_marker_id,
            old_to_new_markers[widget_marker_ref.other_marker_id], widget_marker_ref.id)
        widget_marker_ref.other_marker_id = old_to_new_markers[widget_marker_ref.other_marker_id]

    local_db_session.commit()

if __name__ == "__main__":
    copy_lesson_master()
