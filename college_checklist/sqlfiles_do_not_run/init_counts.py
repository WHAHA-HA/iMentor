# -*- coding: iso8859-15 -*-
import pprint
import copy
import os,sys
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'../..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import db,Base,metadata,DBSession
from config.settings import ENV_TYPE,LOGIN_DISABLED,DEFAULT_TEST_USER_ID

from college_checklist import cchklist
from college_checklist.models import (UtilsCollege, 
    CollegeCount, CollegeChecklist, YES, NO)
from legacy_models.iuser import IuserUser


from flask import Response, jsonify, make_response
from flask import  current_app, request, redirect, render_template
from flask.views import View, MethodView
from flask_sqlalchemy import SQLAlchemy
from  sqlalchemy.sql.expression import func, or_, not_, and_
from flask_login import (current_user,
                             login_user, logout_user, UserMixin,
                             confirm_login, fresh_login_required)
from flask_restful import Resource, Api, fields, marshal_with, reqparse

from auth import app,api,login_required

def init_counts():
   for college in UtilsCollege.query.all():
       count = CollegeCount.query.filter(CollegeCount.college_id==college.id).first()
       if not count:
           newcount = CollegeCount(selected_by_mentees = 0,
               selected_by_mentors = 0,
               college_id = college.id)
           local_db_session.add(newcount)
           local_db_session.flush()
           local_db_session.refresh(newcount)
           print "Adding: {0}".format(newcount.__dict__)
       else:
           print "Count already exists: {0}".format(count.__dict__)
   local_db_session.commit()

init_counts()

