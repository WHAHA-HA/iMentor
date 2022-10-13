# -*- coding: iso8859-15 -*-
import os,sys
import pprint
import logging
import datetime
import re
import csv
from pytz import timezone
from sqlalchemy import and_
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'../..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import get_scoped_session,Base,metadata,DBSession,DOGPILE_CACHE_REGION
from utils.roles import Role

from utils.user_details import get_partners_for_user
from legacy_models.iuser import (IuserPersonaPartner,IuserPersona,IuserUsertype,
    IuserAssignedusertype,IuserUser,ACTIVE_PERSONA_STATUS)
from legacy_models.member import MemberMember


def new_ema_for_all():
    all_member_ids = [x.id for x in DBSession.query(MemberMember).all()]

    local_db_session = get_scoped_session()
    for a in all_member_ids:
        print a
        iut = IuserAssignedusertype(
            member_id=a,
            order=7,
            usertype_id=7,
            name='Enhanced Member Admin',
            abbr='ema',
            fixed=True)
        local_db_session.add(iut)
    local_db_session.commit()
            
if  __name__ == '__main__':
    new_ema_for_all()
