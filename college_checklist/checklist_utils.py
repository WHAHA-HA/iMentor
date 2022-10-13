# -*- coding: iso8859-15 -*-
import pprint
import copy
import os,sys
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import db,Base,metadata,DBSession
from config.settings import ENV_TYPE,LOGIN_DISABLED,DEFAULT_TEST_USER_ID

from college_checklist import cchklist
from college_checklist.models import (UtilsCollege,
    CollegeChecklist, CollegeCategory, YES, NO)
from legacy_models.iuser import IuserUser


from flask import Response, jsonify, make_response, abort
from flask import  current_app, request, redirect, render_template
from flask.views import View, MethodView
from flask_sqlalchemy import SQLAlchemy
from  sqlalchemy.sql.expression import func, or_, not_, and_
from flask_login import (current_user,
                             login_user, logout_user, UserMixin,
                             confirm_login, fresh_login_required)
from flask_restful import Resource, Api, fields, marshal_with, reqparse

from auth import app,api,login_required
from new_platform.utils import user_details
from new_platform.utils.roles import Role

def get_mentee_for_mentor(current_user):
    '''
    If user is a mentor, they're editing records for a mentee.
    Otherwise they're editing teir own records.
    '''
    if Role(user_id = current_user.id).is_mentor:
        act_on_user = user_details.get_latest_mentee_user_for_mentor(user_id=current_user.id)

        if not act_on_user:
            app.logger.warning("Mentor {0} has no Mentee, kicking them out of college checklist.".format(current_user.email))
            abort(404)

    else:
         act_on_user = current_user

    return act_on_user

def get_current_selections(act_on_user):
    return DBSession.query(CollegeChecklist).\
        join(UtilsCollege,CollegeChecklist.college_id==UtilsCollege.id).\
        join(CollegeCategory,CollegeChecklist.category_id==CollegeCategory.id).\
        filter(CollegeChecklist.user_id==act_on_user.id).\
        order_by(CollegeCategory.ordinal.asc()).\
        order_by(UtilsCollege.name.asc()).\
        all()

