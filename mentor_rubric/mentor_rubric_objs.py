# -*- coding: iso8859-15 -*-
import os,sys
import datetime

appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import (get_scoped_session,
    db,Base,metadata,DBSession)
from config.settings import (ENV_TYPE,LOGIN_DISABLED,
    DEFAULT_TEST_USER_ID,CDN_PREFIX)
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
from mentor_rubric import mentor_rubric # app name
from mentor_rubric.models import ProgramYear, MentorRubric
from mentor_rubric.mentor_rubric_utils import (get_program_years, get_rubric_data,
    update_mentor_data)
from new_platform.utils.roles import Role
from legacy_models.iuser import IuserUser

BASE_URL = "/mentor_rubric"

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class MentorRubric(Resource):

    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    @login_required
    def get(self,hlimit=25):
        from flask_login import current_user
        if LOGIN_DISABLED:
            current_user = IuserUser.query.filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class ProgramYears(Resource):
    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    @login_required
    def post(self):
        from flask_login import current_user
    
        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        #print "POST args: %s" % pprint.pformat(request.json)
        post_args = request.get_json(force=True)

        results = get_program_years()
        outbound = []
        if results is not None:
            for r in results:
                outbound.append({
                    'program_year_id':r[0],
                    'program_year_description':r[1],
                    'current_program_year':r[2],
                    })

        return outbound

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class RubricData(Resource):
    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    @login_required
    def post(self):
        from flask_login import current_user
    
        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        #print "POST args: %s" % pprint.pformat(request.json)
        post_args = request.get_json(force=True)

        results = get_rubric_data(post_args['partner_ids'], post_args['program_year_id'])
        outbound = []
        if results is not None:
            for r in results:
                outbound.append({
                    'mentor_first_name':r[0],
                    'mentor_last_name':r[1],
                    'mentor_user_id':r[2],
                    'mentor_persona_id':r[3],
                    'mentor_profile_link':r[4],
                    'mentor_email':r[5],
                    'mentee_first_name':r[6],
                    'mentee_last_name':r[7],
                    'mentee_user_id':r[8],
                    'mentee_persona_id':r[9],
                    'mentee_profile_link':r[10],
                    'mentee_email':r[11],
                    'rubric_strengths_based':r[12],
                    'rubric_resources':r[13],
                    'rubric_response_time':r[14],
                    'rubric_curriculum':r[15],
                    'rubric_admin_updated':r[16],
                    })

        return outbound

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class MentorData(Resource):
    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    @login_required
    def post(self):
        from flask_login import current_user
        local_db_session = get_scoped_session()

        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        #print "POST args: %s" % pprint.pformat(request.json)
        post_args = request.get_json(force=True)

        update_mentor_data(local_db_session, post_args['user_id'], post_args['persona_id'],
            post_args['program_year_id'], post_args['rubric_strengths_based'], post_args['rubric_resources'],
            post_args['rubric_response_time'], post_args['rubric_curriculum'])
  
        local_db_session.commit()
        return {'success':True}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@app.route(BASE_URL + "/debug/")
def mentor_rubric_home_debug():
    from flask_login import current_user

    if LOGIN_DISABLED:
        current_user = IuserUser.query.filter(
            IuserUser.id==DEFAULT_TEST_USER_ID).one()

    if hasattr(current_user,'id'):
        role = Role(current_user.id)
        if role.is_some_admin:
            return render_template("mentor_rubric/index_debug.html",CDN_URL=CDN_PREFIX)

    return redirect("/")

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@app.route(BASE_URL + "/")
def mentor_rubric_home():
    from flask_login import current_user

    if LOGIN_DISABLED:
        current_user = IuserUser.query.filter(
            IuserUser.id==DEFAULT_TEST_USER_ID).one()

    if hasattr(current_user,'id'):
        role = Role(current_user.id)
        if role.is_some_admin:
            return render_template("mentor_rubric/index.html",CDN_URL=CDN_PREFIX)

    return redirect("/")

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Use response endpoint
api.add_resource(ProgramYears, '{0}/program_years/'.format(BASE_URL),
    endpoint='mentor_rubric_program_years')
api.add_resource(RubricData, '{0}/rubric_data/'.format(BASE_URL),
    endpoint='mentor_rubric_rubric_data')
api.add_resource(MentorData, '{0}/mentor_data/'.format(BASE_URL),
    endpoint='mentor_rubric_mentor_data')
