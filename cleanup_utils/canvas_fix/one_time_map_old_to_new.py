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
    WidgetContentMarkerReference,
    CurriculumCopy,CanvasSetCopy,
    CanvasAppCopy,WidgetCopy,WidgetContentCopy,WidgetContentResponseMarkerCopy,
    WidgetContentMarkerReferenceCopy)

'''
'''
old_to_new_mapping  = {}

def map_old_to_new():
    local_db_session = get_scoped_session()

    for curriculum in local_db_session.query(Curriculum).filter(
        Curriculum.active == True).all():

        for old_curr in local_db_session.query(Curriculum).filter(
            Curriculum.active == False).filter(
            Curriculum.description == curriculum.description).all():

            print "Found curriculum match: new {0} old {1}".format(curriculum.id,old_curr.id)

            local_db_session.query(CurriculumCopy).filter(
                CurriculumCopy.parent_id == old_curr.id).update(
                {'parent_id' : curriculum.id},synchronize_session=False)

            local_db_session.commit()
            local_db_session.begin()


            for canvas_set in local_db_session.query(CanvasSet).filter(
                CanvasSet.curriculum_id == curriculum.id).filter(
                CanvasSet.active == True).all():

                for old_cs in local_db_session.query(CanvasSet).filter(
                    CanvasSet.active == False).filter(
                    CanvasSet.curriculum_id == old_curr.id).all():

                    print "Found canvas set match: new {0} old {1}".format(canvas_set.id,old_cs.id)

                    local_db_session.query(CanvasSetCopy).filter(
                        CanvasSetCopy.parent_id == old_cs.id).update(
                        {'parent_id' : canvas_set.id},synchronize_session=False)

                    local_db_session.commit()
                    local_db_session.begin()


                    for canvas_app in local_db_session.query(CanvasApp).filter(
                        CanvasApp.canvas_set_id == canvas_set.id).filter(
                        CanvasApp.active == True).all():

                        for old_capp in local_db_session.query(CanvasApp).filter(
                            CanvasApp.canvas_set_id == old_cs.id).filter(
                            CanvasApp.active == False).all():

                            print "Found canvas app match: new {0} old {1}".format(canvas_app.id,old_capp.id)

                            local_db_session.query(CanvasAppCopy).filter(
                                CanvasAppCopy.parent_id == old_capp.id).update(
                                {'parent_id' : canvas_app.id},synchronize_session=False)

                            local_db_session.commit()
                            local_db_session.begin()


                            for widget in local_db_session.query(Widget).filter(
                                Widget.canvas_app_id == canvas_app.id).filter(
                                Widget.active == True).all():

                                for old_widget in local_db_session.query(Widget).filter(
                                    Widget.canvas_app_id == old_capp.id).filter(
                                    Widget.active == False).all():

                                    print "Found widget match: new {0} old {1}".format(widget.id,old_widget.id)

                                    local_db_session.query(WidgetCopy).filter(
                                        WidgetCopy.parent_id == old_widget.id).update(
                                        {'parent_id' : widget.id},synchronize_session=False)

                                    local_db_session.commit()
                                    local_db_session.begin()


                                    for widget_content in local_db_session.query(WidgetContent).filter(
                                        WidgetContent.active == True).filter(
                                        WidgetContent.widget_id == widget.id).all():
 
                                        for old_widget_content in local_db_session.query(WidgetContent).filter(
                                            WidgetContent.active == False).filter(
                                            WidgetContent.widget_id == old_widget.id).all():
     
                                            print "Found widget content match: new {0} old {1}".format(widget_content.id,old_widget_content.id)

                                            local_db_session.query(WidgetContentCopy).filter(
                                                WidgetContentCopy.parent_id == old_widget_content.id).update(
                                                {'parent_id' : widget_content.id},synchronize_session=False)

                                            local_db_session.commit()
                                            local_db_session.begin()
                                                     
 
                                            for widget_marker in local_db_session.query(WidgetContentResponseMarker).filter(
                                                WidgetContentResponseMarker.active == True).filter(
                                                WidgetContentResponseMarker.widget_content_id == widget_content.id).all():
 
                                                for old_widget_marker in local_db_session.query(WidgetContentResponseMarker).filter(
                                                    WidgetContentResponseMarker.active == False).filter(
                                                    WidgetContentResponseMarker.widget_content_id == old_widget_content.id).all():
     
                                                    print "Found widget content marker match: new {0} old {1}".format(widget_marker.id,old_widget_marker.id)

                                                    local_db_session.query(WidgetContentResponseMarkerCopy).filter(
                                                        WidgetContentResponseMarkerCopy.parent_id == old_widget_marker.id).update(
                                                        {'parent_id' : widget_marker.id},synchronize_session=False)

                                                    local_db_session.commit()
                                                    local_db_session.begin()
                                                     
 
                                            for widget_marker_ref in local_db_session.query(WidgetContentMarkerReference).filter(
                                                WidgetContentMarkerReference.active == True).filter(
                                                WidgetContentMarkerReference.widget_content_id == widget_content.id).all():
 
                                                for old_widget_marker_ref in local_db_session.query(WidgetContentMarkerReference).filter(
                                                    WidgetContentMarkerReference.active == False).filter(
                                                    WidgetContentMarkerReference.widget_content_id == old_widget_content.id).all():
 
                                                    print "Found widget content marker reference match: new {0} old {1}".format(widget_marker_ref.id,old_widget_marker_ref.id)

                                                    local_db_session.query(WidgetContentMarkerReferenceCopy).filter(
                                                        WidgetContentMarkerReferenceCopy.parent_id == old_widget_marker_ref.id).update(
                                                        {'parent_id' : widget_marker_ref.id},synchronize_session=False)
                                                     

                                                    local_db_session.commit()
                                                    local_db_session.begin()


    local_db_session.commit()
    local_db_session.begin()

if __name__ == "__main__":
    map_old_to_new()
