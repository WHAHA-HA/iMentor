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
from sqlalchemy import and_,or_
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
from tasks.models import RecurringInfoUpdateLocal

'''
tasks_recurring_info_update_localization

 id | recurring_info_update_id | member_id | partner_id | role_id 
----+--------------------------+-----------+------------+---------
  1 |                        1 |       197 |            |       4
  2 |                        2 |       197 |            |       5
  3 |                        3 |         1 |            |       4
  4 |                        3 |       244 |            |       4
  5 |                        4 |         1 |            |       5
  6 |                        4 |       244 |            |       5
'''

def add_addr_prompt():
    local_db_session = get_scoped_session()

    for member in local_db_session.query(MemberMember).filter(
        MemberMember.status_id==1).all():

        # No dups.
        if member.id in (1,197,244):
            continue

        print "Doing member id {0}".format(member.id)

        r = RecurringInfoUpdateLocal(
            recurring_info_update_id=3,
            role_id=4,
            member_id=member.id)
        local_db_session.add(r)

        r = RecurringInfoUpdateLocal(
            recurring_info_update_id=4,
            role_id=5,
            member_id=member.id)
        local_db_session.add(r)

    local_db_session.commit()

if __name__ == "__main__":
    add_addr_prompt()
