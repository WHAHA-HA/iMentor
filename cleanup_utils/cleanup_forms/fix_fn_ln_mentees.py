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

def preprocess_form():
    '''
    Find blank first/last name in iuser_user and fill it in from form.
    '''
    count = 0
    for form in FormCopy.query.all():
        print "Doing form %s" % form.id
        fn_resp = False

        user_obj = IuserUser.query.filter(
            IuserUser.id == form.user_id)

        user = user_obj.one()

        if user.first_name in ('',None):

            section = SectionCopy.query.filter(
                SectionCopy.user_id==user.id).filter(
                SectionCopy.description.ilike('Contact Information%')).filter(
                SectionCopy.form_id==form.id).one()

            # It's ok if not found: only mentees have this question
            # phrased this way.
            try:
                question = QuestionCopy.query.filter(
                    QuestionCopy.user_id==user.id).filter(
                    QuestionCopy.question_text.ilike('First Name%')).filter(
                    QuestionCopy.section_id==section.id).one()
            except:
                continue
    
            try:
                resp = UserResponse.query.filter(
                    UserResponse.user_id==user.id).filter(
                    UserResponse.question_id==question.id).one()
            except:
                # User didn't yet answer?
                continue
    
            if resp.user_response:
                print "Updating user's first name %s to %s" % (user.email,resp.user_response.title())
                user_obj.update({'first_name':resp.user_response.title()})
                count += 1
                fn_resp = True


        if user.last_name in ('',None):

            section = SectionCopy.query.filter(
                SectionCopy.user_id==user.id).filter(
                SectionCopy.description.ilike('Contact Information%')).filter(
                SectionCopy.form_id==form.id).one()

            # It's ok if not found: only mentees have this question
            # phrased this way.
            try:
                question = QuestionCopy.query.filter(
                    QuestionCopy.user_id==user.id).filter(
                    QuestionCopy.question_text.ilike('Last Name%')).filter(
                    QuestionCopy.section_id==section.id).one()
            except:
                continue
    
            try:
                resp = UserResponse.query.filter(
                    UserResponse.user_id==user.id).filter(
                    UserResponse.question_id==question.id).one()
            except:
                # User didn't yet answer?
                continue
    
            if resp.user_response:
                print "Updating user's last name %s to %s" % (user.email,resp.user_response.title())
                user_obj.update({'last_name':resp.user_response.title()})
                if not fn_resp:
                    count += 1

        db.session.commit()

    print "Fixed %d user's fn/ln" % count

if __name__ == "__main__":
    preprocess_form()
