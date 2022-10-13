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
from attendance import attendance # app name
from attendance.models import Attendance
from attendance.attendance_utils import (get_class_roster, get_lesson,
    get_attendance, get_attendance_statistics, update_mentee_attendance)
from new_platform.utils.roles import Role
from legacy_models.iuser import IuserUser

BASE_URL = "/attendance"

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class Attendance(Resource):

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
class ClassRoster(Resource):
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

        results = get_class_roster(post_args['partner_id'])
        outbound = []
        if results is not None:
            for r in results:
                outbound.append({
                    'first_name':r[0],
                    'last_name':r[1],
                    'user_id':r[2],
                    'persona_id':r[3],
                    'profile_link':r[4],
                    'email':r[5],
                    })

        return outbound

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class Lesson(Resource):
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

        result = get_lesson(post_args['partner_id'], post_args['period'], current_user.id)
        outbound = {}
        if result is not None:
            # We don't need strftime() here, since the value of these dates always is a string.
            outbound = \
                {
                'curriculum_id':result[0],
                'lesson_description':result[1],
                'lesson_start':result[2],
                'lesson_end':result[3],
                }

        return outbound

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class AttendanceData(Resource):
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

        results = get_attendance(post_args['partner_id'], post_args['curriculum_id'])
        outbound = []
        if results is not None:
            for r in results:
                outbound.append({
                    'description':r[0],
                    })

        return outbound

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class AttendanceStatistics(Resource):
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

        result = get_attendance_statistics(post_args['partner_id'], post_args['curriculum_id'])
        outbound = {}
        if result is not None:
            outbound = \
                {
                'present_percentage':result[0],
                }

        return outbound

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class MenteeData(Resource):
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

        update_mentee_attendance(local_db_session, post_args['partner_id'], post_args['user_id'],
            post_args['persona_id'], post_args['curriculum_id'], post_args['detail_id'])
  
        local_db_session.commit()
        return {'success':True}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@app.route(BASE_URL + "/")
def attendance_home():
    from flask_login import current_user

    if LOGIN_DISABLED:
        current_user = IuserUser.query.filter(
            IuserUser.id==DEFAULT_TEST_USER_ID).one()

    if hasattr(current_user,'id'):
        role = Role(current_user.id)
        if role.is_some_admin:
            return render_template("attendance/index.html",CDN_URL=CDN_PREFIX)

    return redirect("/")

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Use response endpoint
api.add_resource(ClassRoster, '{0}/class_roster/'.format(BASE_URL),
    endpoint='attendance_class_roster')
api.add_resource(Lesson, '{0}/lesson/'.format(BASE_URL),
    endpoint='attendance_lesson')
api.add_resource(AttendanceData, '{0}/attendance_data/'.format(BASE_URL),
    endpoint='attendance_attendance_data')
api.add_resource(AttendanceStatistics, '{0}/attendance_statistics/'.format(BASE_URL),
    endpoint='attendance_attendance_statistics')
api.add_resource(MenteeData, '{0}/mentee_data/'.format(BASE_URL),
    endpoint='attendance_mentee_data')
