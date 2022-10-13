# -*- coding: iso8859-15 -*-
import os,sys
import pprint
import logging
import traceback
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

from config.project_globals import db,Base,metadata,DBSession,DOGPILE_CACHE_REGION
from legacy_models.iuser import (IuserUser,MentorSiteList,P_MATCH_STATUS_READY,
    P_MATCH_STATUS_MATCHED, P_MATCH_STATUS_CLOSED, P_MATCH_STATUS_NA)

from legacy_models.partners import PartnersPartner
from legacy_models.member import MemberSchool,MemberMember
from utils.roles import Role
from utils.user_details import get_persona_obj_for_user
from enrollment.models import *


def add_defaults():
    for m in MenteeReadinessSchool.query.filter(MenteeReadinessSchool.persona_id==None).all():
        persona = get_persona_obj_for_user(m.user_id,ignore_match_status=True)
        print "Doing {0}".format(m.user_id)
        if persona:
            MenteeReadinessSchool.query.filter(MenteeReadinessSchool.id==m.id).update(
                {'persona_id':persona.id})
        else:
            MenteeReadinessSchool.query.filter(MenteeReadinessSchool.id==m.id).update(
                {'persona_id':None})

        db.session.commit()
            

if __name__=='__main__':
    add_defaults()
