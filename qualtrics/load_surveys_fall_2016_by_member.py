#!/bin/env python
# -*- coding: iso8859-15 -*-
import pdb
import pprint
import copy
import os,sys
import pymongo
import datetime
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
nprojdir = os.path.abspath(os.path.join(appdir,'../..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)
    sys.path.append(nprojdir)

from config.project_globals import get_scoped_session,Base,metadata,DBSession

from config.settings import (ENV_TYPE,LOGIN_DISABLED,
    DEFAULT_TEST_USER_ID,MONGO_HOST,MONGO_PORT,
    MONGO_DBNAME_FORMS,MONGO_POP_FROM_FORM_COLLNAME,
    MONGO_FORM_NOTIFY_COLLNAME)

from flask import Response, json, jsonify, make_response, url_for, abort
from flask import  current_app, request, redirect, render_template
from flask.views import View, MethodView
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.sql.expression import func, or_, not_, and_
from sqlalchemy.orm import sessionmaker 
from sqlalchemy.orm.exc import NoResultFound, MultipleResultsFound

from flask_login import (current_user,
                             login_user, logout_user, UserMixin,
                             confirm_login, fresh_login_required)
from flask_restful import Resource, Api, fields, marshal_with
#from flask_wtf import Form, RadioField

#Import 'app' object from auth as well
from auth import api, app, login_required

from qualtrics.models import *
from qualtrics.qualtrics_3rd_party import manually_gen_survey_distribution_id
from legacy_models.iuser import MENTOR,MENTEE

import pdb;pdb.set_trace()

# Survey title and ID From Qualtrics, good for dev and prod.
survey = {
    'BBBS Mentee Pre Survey 2016-17':'SV_55a1qPwy6vdUjmR',
    'BBBS Mentor Pre Survey 2016-17':'SV_6msdcHUhmLnYl25',
    }

# POSSIBLY ONLY GOOD FOR DEV! Double-check these in prod.
# There's only one active panel, and it only belongs to one library.
lib_str='GR_72qpYD0dtt1P9uR'
panel_str='ML_3KPtzqmnMDqW5s9'

distribution = {}

# These are manually generated distribution ids. There's a manual function in qualtrics_3rd_party.py
# to accomplish this.
# REGENERATE THESE FOR PROD! Don't reuse these.
for s in survey:
    d = manually_gen_survey_distribution_id(survey[s],s)
    distribution[survey[s]] = d
    
pprint.pprint(distribution)

'''
-> manually_gen_survey_distribution_id('SV_6ioEJxfxA2dREqx','BBBS Mentee Fall 2016 Survey')
5hjbaOGJVlqj25f
-> manually_gen_survey_distribution_id('SV_2hjTHaHV2oJqBsp','BBBS Mentor Fall 2016 Survey')
3CbKSLD2TEcT7aB
-> manually_gen_survey_distribution_id('SV_5vUrLGK0nPEdyqF','iMentor Mentee Fall 2016 Survey')
26lOZ4mebprk8Qd
-> manually_gen_survey_distribution_id('SV_6EDK6XqLxPYdAWx','iMentor Mentor Fall 2016 Survey')
0CZhD9yOBJ1b1Wd
'''

# REGENERATE THESE FOR PROD! Don't reuse these.
'''
'SV_0Jo2RJV8539GSr3': u'6Vg6FMH1VtL50Q5',
 'SV_9uj22iLbVUd1Ndj': u'4NrQT8jeOuBQI5L',
 'SV_bPpriXo8YjxoFc9': u'a9H1sBaFsC9uHXL',
 'SV_cHMjouChjivB8Yl': u'1AJo9u1qCDDPc3z'}

distribution =  {
    'SV_6ioEJxfxA2dREqx':'5hjbaOGJVlqj25f',
    'SV_2hjTHaHV2oJqBsp':'3CbKSLD2TEcT7aB',
    'SV_5vUrLGK0nPEdyqF':'26lOZ4mebprk8Qd',
    'SV_6EDK6XqLxPYdAWx':'0CZhD9yOBJ1b1Wd',
    }
'''

member_survey = [
    ('BBBS Mentee Pre Survey 2016-17',191),
    ('BBBS Mentee Pre Survey 2016-17',231),
    ('BBBS Mentee Pre Survey 2016-17',252),
    ('BBBS Mentor Pre Survey 2016-17',191),
    ('BBBS Mentor Pre Survey 2016-17',231),
    ('BBBS Mentor Pre Survey 2016-17',252),
]

def insert_into_qualtrics_survey():

    local_db_session = get_scoped_session()

    for survey_name,member_id in member_survey:

        survey_id = survey[survey_name]
        dist_id = distribution[survey_id]

        s = QualtricsSurvey(
            description = survey_name,
            member_id = member_id,
            library_string = lib_str,
            panel_string = panel_str,
            distribution_string = dist_id,
            survey_string = survey_id,
            user_type = MENTEE if 'Mentee' in survey_name else MENTOR,
           )
        local_db_session.add(s)

    local_db_session.commit()

if __name__ == "__main__":
    insert_into_qualtrics_survey()
