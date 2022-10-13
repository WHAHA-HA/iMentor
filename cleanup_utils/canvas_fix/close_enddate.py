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
from legacy_models.partners import PartnersSession
from canvas.models import (CurriculumCopy,CanvasSetCopy,CanvasSet,
    CanvasAppCopy,WidgetCopy,WidgetContentCopy,WidgetContentResponseMarkerCopy,
    WidgetContentMarkerReferenceCopy,WidgetContentUserResponse,WidgetContentUserResponseHistory,
    FlaggedLesson,Curriculum,PartnersSessionCurriculum)

    
def close_old_lessons():
    local_db_session = get_scoped_session()

    # Close user copies.
    for result in local_db_session.query(CanvasSetCopy,CanvasSet).join(
        CanvasSet,CanvasSetCopy.parent_id==CanvasSet.id).filter(
        CanvasSet.active==False).filter(
        CanvasSetCopy.end_datetime < CanvasSetCopy.start_datetime).all():

        result[0].end_datetime = result[0].start_datetime + datetime.timedelta(days=15)
        print result[0].id
        local_db_session.commit()
        local_db_session.begin()
          
    local_db_session.commit()

if __name__ == "__main__":
    close_old_lessons()
