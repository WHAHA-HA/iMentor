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

from config.project_globals import db,Base,metadata,DBSession
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
from legacy_models.member import MemberMember
from college_checklist.models import UtilsCollege


def fix_employer_missing_id():
    results = QuestionCopy.query.filter(
        QuestionCopy.question_type==QUESTION_DROPDOWN_EMPLOYERS).all()

    for r in results:
        #print "results: {0}".format(r.id)
        response = UserResponse.query.filter(UserResponse.selected_id==None
            ).filter(or_(UserResponse.user_response!=None,UserResponse.user_response!='')
            ).filter(UserResponse.question_id==r.id
            ).first()

        if response and response.user_response != 'Not Listed':
            #print "response: {0}".format(response.id)

            user = IuserUser.query.filter(IuserUser.id==r.user_id
                ).filter(or_(IuserUser.employer_id==None,IuserUser.employer_id==0)).first()

            if user:
                employer = IuserEmployer.query.filter(IuserEmployer.name==response.user_response.strip()).first()

                if not employer:

                    print "Not added to employer table yet, adding now: {0}".format(response.user_response)
                    new_employer = IuserEmployer(name=response.user_response.strip())
                    db.session.add(new_employer)
                    db.session.flush()
                    db.session.refresh(new_employer)

                    new_employer_member = IuserEmployerMember(
                        employer_id=new_employer.id,
                        member_id=user.member_id)
    
                    db.session.add(new_employer_member)
                    db.session.flush()
                    db.session.refresh(new_employer_member)

                    user.employer_id = new_employer.id
    
                    db.session.commit()

                else:
                    print "User employer: {0}, response: {1}".format(
                        user.employer_id,response.user_response) 

                    IuserUser.query.filter(IuserUser.id==user.id).update({
                        'employer_id':employer.id})

                    db.session.commit()
    
if __name__ == "__main__":
    fix_employer_missing_id()
