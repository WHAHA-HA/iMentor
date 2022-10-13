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

from config.project_globals import db,Base,metadata,DBSession,DOGPILE_CACHE_REGION
from legacy_models.iuser import (IuserPersonaPartner,IuserPersona,IuserUsertype,
    IuserAssignedusertype,IuserUser,ACTIVE_PERSONA_STATUS)
from legacy_models.partners import PartnersPartner
from legacy_models.member import MemberSchool
from utils.roles import Role
from utils.user_details import get_partners_for_user
from apiforms.models import *


def check_partners():

        result = DBSession.query(IuserPersonaPartner,IuserPersona,IuserUsertype,IuserAssignedusertype,IuserUser,PartnersPartner).\
            join(IuserPersona,IuserPersonaPartner.persona_id==IuserPersona.id).\
            join(PartnersPartner,IuserPersonaPartner.partner_id==PartnersPartner.id).\
            join(IuserAssignedusertype,IuserAssignedusertype.id==IuserPersona.assigned_usertype_id).\
            join(IuserUser,IuserUser.id==IuserPersona.user_id).\
            filter(IuserPersona.status == ACTIVE_PERSONA_STATUS).\
            filter(PartnersPartner.is_alumni == False).all()

        did_users = {}

        for r in result:
            if r[4].id in did_users and r[5].id in did_users[r[4].id]:
                continue

            if r[4].id not in did_users:
                did_users[r[4].id] = [r[5].id]
            else:
                did_users[r[4].id].append(r[5].id)

            role = Role(r[4].id)
            #print "Doing user {0}".format(r[4].id)
            partners = get_partners_for_user(r[4],role)
            partner_ids = [s.id for s in partners]

            if not partners:
                print "User {0} {1} role {2} has no partner sites? how could this be?".format(
                    r[4].id,r[4].email,role.role)

            if r[5].id not in partner_ids:
                print "User {0} {1} role {2} has a conflict in partner sites. Partner in Query: {3}:{4}, partners in get by user: {5}".format(
                    r[4].id,r[4].email,role.role,r[5].id,r[5].name,pprint.pformat([(s.id,s.name) for s in partners]))


if  __name__ == '__main__':
    check_partners()
