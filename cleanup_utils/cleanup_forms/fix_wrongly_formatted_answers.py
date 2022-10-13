# -*- coding: iso8859-15 -*-
import pdb
import pprint
import copy
import os,sys
import pymongo
from datetime import datetime,timedelta
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'../..'))
nprojdir = os.path.abspath(os.path.join(appdir,'../../..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)
    sys.path.append(nprojdir)

from config.project_globals import db,Base,metadata
from new_platform.audit import (audit_trail,DATA_REMOVE,DATA_ADD,
    DATA_NOCHG,DATA_ERROR,APPLICATION_DATA,FORM_DATA)

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

from apiforms import forms # app name
from apiforms.models import *
from apiforms.user_response_utils import ResponseServices

from legacy_models.iuser import (IuserUser,IuserEmployer,
    IuserUserRacialgroup,IuserPersonaUserProgram,
    IuserEmployerMember,
    USER_STATUS_SCREENING_INCOMPLETE,GENDER_CHOICES,
    USER_STATUS_APPLICATION_INCOMPLETE,
    MARITAL_STATUS_CHOICES)

from new_platform.utils import user_details
from legacy_models.utils import UtilsState,UtilsCountry
from legacy_models.partners import PartnersAttributes
from legacy_models.member import MemberMember
from college_checklist.models import UtilsCollege
from sqlalchemy.sql import select

# Wrong: this is a multi select. How did this even happen?
# select * from forms_section_user_response where id=1603;  
# id  | user_id | question_id | answer_id | selected_id | user_response 
#------+---------+-------------+-----------+-------------+---------------
# 1603 |  170420 |        2506 |      8231 |             | 
#(1 row)

def fix_user_resp():
    ur_obj = UserResponse.query.filter(UserResponse.id==1753)
    ur = ur_obj.one()
    ur_obj.update({
        'user_response': json.dumps( {'answer_ids':[10628,]} ),
        'answer_id': None
        })
    db.session.commit()
    
if __name__ == "__main__":
    fix_user_resp()
