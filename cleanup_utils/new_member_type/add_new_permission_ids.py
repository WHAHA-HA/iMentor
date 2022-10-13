# -*- coding: iso8859-15 -*-
import os,sys
import pprint
import logging
import datetime
import re
import csv
from pytz import timezone
from sqlalchemy import and_,exc
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
from legacy_models.permissions import PermissionsAssignedpermission


def new_perms_for_all_emas():
    local_db_session = get_scoped_session()
    for a in DBSession.query(PermissionsAssignedpermission).all():
        if a.assignedusertype.usertype_id == 1: # member admin
            # Add an equivalent record for enahnced member admins.
            # First file EMA user for same member site.
            ema = DBSession.query(IuserAssignedusertype).filter(
               IuserAssignedusertype.member_id==a.assignedusertype.member_id).filter(
               IuserAssignedusertype.usertype_id==7).one()
            print ema.id, a.permission_id
            ipe = PermissionsAssignedpermission(
                assignedusertype_id=ema.id,
                permission_id = a.permission_id)

            try:
                local_db_session.add(ipe)
                local_db_session.commit()
                print ipe.id
                local_db_session.begin()
            except exc.IntegrityError:
                print "dup"
                local_db_session.rollback()
                local_db_session.begin()

    local_db_session.commit()
            
if  __name__ == '__main__':
    new_perms_for_all_emas()
