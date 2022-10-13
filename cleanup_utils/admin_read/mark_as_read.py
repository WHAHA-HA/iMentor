# -*- coding: iso8859-15 -*-
import os,sys
import pprint
import logging
import datetime
import re
import csv
from pytz import timezone
from sqlalchemy import and_,or_
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'../..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import get_scoped_session,Base,metadata,DBSession,DOGPILE_CACHE_REGION

from utils.user_details import get_partners_for_user
from legacy_models.iuser import (IuserPersonaPartner,IuserPersona,IuserUsertype,
    IuserAssignedusertype,IuserUser,ACTIVE_PERSONA_STATUS)
from canvas.models import CanvasSetCopy
from conversations.models import Conversation
from portfolio.models import ReflectionUserDetails

def mark_as_read():
    local_db_session = get_scoped_session()

    all_ids = [x.id for x in DBSession.query(CanvasSetCopy).filter(
        CanvasSetCopy.start_datetime <= datetime.datetime(2016,8,1,0,0,0)).filter(
        or_((CanvasSetCopy.admin_last_viewed == None),
        (CanvasSetCopy.admin_last_viewed <= CanvasSetCopy.last_viewed)
        )).all()]

    print all_ids
    if all_ids:
        local_db_session.query(CanvasSetCopy).filter(
            CanvasSetCopy.id.in_(all_ids)).update(
            {'admin_last_viewed':datetime.datetime(2016,8,1,0,0,0)},
            synchronize_session=False)


    all_ids = [x.id for x in DBSession.query(Conversation).filter(
        Conversation.received_by_server <= datetime.datetime(2016,8,1,0,0,0)).filter(
        or_((Conversation.admin_last_viewed == None),
        (Conversation.admin_last_viewed <= Conversation.received_by_server)
        )).all()]

    print all_ids
    if all_ids:
        local_db_session.query(Conversation).filter(
            Conversation.id.in_(all_ids)).update(
            {'admin_last_viewed':datetime.datetime(2016,8,1,0,0,0)},
            synchronize_session=False)


    all_ids = [x.id for x in DBSession.query(ReflectionUserDetails).filter(
        ReflectionUserDetails.started <= datetime.datetime(2016,8,1,0,0,0)).filter(
        or_((ReflectionUserDetails.admin_last_viewed == None),
        (ReflectionUserDetails.admin_last_viewed <= ReflectionUserDetails.last_viewed)
        )).all()]

    print all_ids
    if all_ids:
        local_db_session.query(ReflectionUserDetails).filter(
            ReflectionUserDetails.id.in_(all_ids)).update(
            {'admin_last_viewed':datetime.datetime(2016,8,1,0,0,0)},
            synchronize_session=False)

    local_db_session.commit()
            
if  __name__ == '__main__':
    mark_as_read()
