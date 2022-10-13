# -*- coding: iso8859-15 -*-
import copy
from datetime import datetime,timedelta,date
import httplib
import json
import math
import re
import pdb
import pprint
import random
import requests
import string
import traceback
import os,sys
from sqlalchemy.sql.expression import func, or_, not_, and_

appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'../..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import (Base,metadata,
    DBSession,get_scoped_session)
from config.settings import (ENV_TYPE,LOGIN_DISABLED,
    DEFAULT_TEST_USER_ID,EMAIL_HOST_USER,QUALTRICS_URI,
    QUALTRICS_USER,QUALTRICS_TOKEN,QUALTRICS_API_SELECT,
    QUALTRICS_API_FORMAT,QUALTRICS_API_VERSION)


#Import 'app' object from auth as well
from auth import api, app

from qualtrics import qualtrics # app name
from legacy_models.mailer import MailerMessage
from legacy_models.iuser import (IuserUser,IuserPersona,IuserPersonaPartner,
    IuserUsertype,IuserAssignedusertype,ACTIVE_PERSONA_STATUS,USERTYPE_MAP,
    USER_STATUS_MAP,MATCH_CHOICES,USER_STATUS_INACTIVE_REJECTED,
    USER_STATUS_INTACTIVE_WITHDRAWN,USER_STATUS_INTACTIVE_DELETED,
    USER_STATUS_ACTIVE, USER_STATUS_APPLICATION_INCOMPLETE,
    USER_STATUS_SCREENING_INCOMPLETE,
    MENTEE,MENTOR)
from legacy_models.partners import PartnersPartner
from legacy_models.member import MemberSchool
from college_checklist.models import CollegeChecklist
from new_platform.utils.roles import Role
from new_platform.utils.user_details import (get_persona_obj_for_user,
    get_partners_for_user,get_latest_mentor_user_for_mentee,
    get_latest_mentee_user_for_mentor,get_admin_for_user,
    get_latest_mentee_for_mentor,get_latest_mentor_for_mentee)
from qualtrics.models import (QualtricsSurvey,QualtricsInvite,QualtricsLibPanel,
    QUALTRICS_STATUS_MAP,QUALTRICS_NOT_INVITED,
    QUALTRICS_INVITED,QUALTRICS_INCOMPLETE,QUALTRICS_COMPLETE,
    QUALTRICS_INCOMPLETE_CLOSED,QUALTRICS_INVITED_CLOSED)
import csv
from dateutil import parser

# id | persona_id | user_id | invited_by_user_id | survey_id | survey_status | date_invited | last_modified | survey_link     

def reinsert_missing():
    local_db_session = get_scoped_session()
    for csvf in ('./26.sql',):
        with open(csvf, 'rb') as csvfile:
          reader = csv.DictReader(csvfile, delimiter='|', quotechar=',')
          count = 0
          for row in reader:
              count += 1
              print "Row count: %s" % count
              row['user_id'] = int(row['user_id'])
              row['persona_id'] = int(row['persona_id'])
              row['invited_by_user_id'] = int(row['invited_by_user_id'])
              row['survey_id'] = int(row['survey_id'])
              row['survey_status'] = int(row['survey_status'])
    
              result = DBSession.query(QualtricsInvite).filter(
                  QualtricsInvite.persona_id==row['persona_id']).filter(
                  QualtricsInvite.survey_id==26).first()

              if not result:
                  dt = parser.parse(row['date_invited'])
                  date_invited = date(year=dt.year,month=dt.month,day=dt.day)
                  record = QualtricsInvite(
                      persona_id=row['persona_id'],
                      user_id=row['user_id'],
                      invited_by_user_id=row['invited_by_user_id'],
                      survey_id=row['survey_id'],
                      survey_status=row['survey_status'],
                      date_invited=date_invited,
                      last_modified=None,
                      survey_link=row['survey_link'],
                      )

                  local_db_session.add(record)
                  local_db_session.flush()
                  print "Inserted {0}".format(record.id)

    local_db_session.commit()

if __name__ == "__main__":
    reinsert_missing()
