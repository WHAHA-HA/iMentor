# -*- coding: iso8859-15 -*-
import pdb
import pprint
import copy
import os,sys
from datetime import datetime
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import db,Base,metadata,DBSession
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
from snapshot import snapshot # app name
from legacy_models.iuser import IuserUser,USERTYPE_MAP
from new_platform.utils.roles import Role
from snapshot_utils import (get_class_roster,
    get_lesson, get_lesson_engagement, get_lesson_engagement_statistics)
from sms_notifications.sms_outbound import send_sms_lesson_reminder_message

BASE_URL = "/snapshot"

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

        # Check role before loading.
        role = Role(current_user.id)
        if not role.is_some_admin:
            app.logger.exception("Not crashing. Rejecting class roster access for this user: {0}, role is not admin: {1}".format(
            current_user.id,role.role))
            abort(403)

        #print "POST args: %s" % pprint.pformat(request.json)
        post_args = request.get_json(force=True)

        results = get_class_roster(post_args['partner_id'])
        outbound = []
        if results is not None:
            for r in results:
                outbound.append({
                    'mentee_first_name':r[0],
                    'mentee_last_name':r[1],
                    'mentee_user_id':r[2],
                    'mentee_persona_id':r[3],
                    'mentee_profile_link':r[4],
                    'mentee_email':r[5],
                    'mentee_current_lesson_id':r[6],
                    'mentor_first_name':r[7],
                    'mentor_last_name':r[8],
                    'mentor_user_id':r[9],
                    'mentor_persona_id':r[10],
                    'mentor_profile_link':r[11],
                    'mentor_email':r[12],
                    'mentor_current_lesson_id':r[13],
                    'staff_email':r[14],
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

        # Check role before loading.
        role = Role(current_user.id)
        if not role.is_some_admin:
            app.logger.exception("Not crashing. Rejecting lesson access for this user: {0}, role is not admin: {1}".format(
            current_user.id,role.role))
            abort(403)

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
class LessonEngagement(Resource):
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

        # Check role before loading.
        role = Role(current_user.id)
        if not role.is_some_admin:
            app.logger.exception("Not crashing. Rejecting lesson access for this user: {0}, role is not admin: {1}".format(
            current_user.id,role.role))
            abort(403)

        #print "POST args: %s" % pprint.pformat(request.json)
        post_args = request.get_json(force=True)

        results = get_lesson_engagement(post_args['partner_id'], post_args['curriculum_id'],current_user)
        outbound = []
        if results is not None:
            for r in results:
                # We don't reveal all data in the JSON keys yet, since much of it is intended for future enhancements.
                # We don't need strftime() here, since the value of these dates always is a string.
                outbound.append({
                    'party_canvas_icon':r[0],
                    'party_canvas_link':r[1],
                    'party_conversations_icon':r[2],
                    'party_conversations_link':r[3],
                    'counterparty_canvas_icon':r[4],
                    'counterparty_canvas_link':r[5],
                    'counterparty_conversations_icon':r[6],
                    'counterparty_conversations_link':r[7],
                    'cscopy_id':r[8],
                    'cscopy2_id':r[9] if len(r) > 9 else None,
                    })

        return outbound

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class LessonEngagementStatistics(Resource):
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

        # Check role before loading.
        role = Role(current_user.id)
        if not role.is_some_admin:
            app.logger.exception("Not crashing. Rejecting lesson access for this user: {0}, role is not admin: {1}".format(
            current_user.id,role.role))
            abort(403)

        #print "POST args: %s" % pprint.pformat(request.json)
        post_args = request.get_json(force=True)

        result = get_lesson_engagement_statistics(post_args['partner_id'], post_args['curriculum_id'])
        outbound = {}
        if result is not None:
            outbound = \
                {
                'overall_mentee_participation':result[0],
                'overall_mentor_participation':result[1],
                'overall_pair_participation':result[2],
                'canvas_mentee_participation':result[3],
                'canvas_mentor_participation':result[4],
                'canvas_pair_participation':result[5],
                'conversations_mentee_participation':result[6],
                'conversations_mentor_participation':result[7],
                'conversations_pair_participation':result[8],
                }

        return outbound

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class Texts(Resource):
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

        # Check role before loading.
        role = Role(current_user.id)
        if not role.is_some_admin:
            app.logger.exception("Not crashing. Rejecting text access for this user: {0}, role is not admin: {1}".format(
            current_user.id,role.role))
            abort(403)

        #print "POST args: %s" % pprint.pformat(request.json)
        post_args = request.get_json(force=True)

        send_sms_lesson_reminder_message(post_args['user_lesson_tuples'])

        return {'success':True}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@app.route(BASE_URL + "/debug/")
def snapshot_home_debug():
    from flask_login import current_user

    if LOGIN_DISABLED:
        current_user = IuserUser.query.filter(
            IuserUser.id==DEFAULT_TEST_USER_ID).one()

    if hasattr(current_user,'id'):

        # Check role before loading.
        role = Role(current_user.id)
        if not role.is_some_admin:
            app.logger.exception("Not crashing. Rejecting snapshot load for this user: {0}, role is not admin: {1}. Sent them to /".format(
            current_user.id,role.role))
            return redirect("/")

        return render_template("snapshot/index_debug.html",CDN_URL=CDN_PREFIX)

    return redirect("/")

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@app.route(BASE_URL + "/")
def snapshot_home():
    from flask_login import current_user

    if LOGIN_DISABLED:
        current_user = IuserUser.query.filter(
            IuserUser.id==DEFAULT_TEST_USER_ID).one()

    if hasattr(current_user,'id'):

        # Check role before loading.
        role = Role(current_user.id)
        if not role.is_some_admin:
            app.logger.exception("Not crashing. Rejecting snapshot load for this user: {0}, role is not admin: {1}. Sent them to /".format(
            current_user.id,role.role))
            return redirect("/")

        return render_template("snapshot/index.html",CDN_URL=CDN_PREFIX)

    return redirect("/")

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Use response endpoint
api.add_resource(ClassRoster, '{0}/class_roster/'.format(BASE_URL),
    endpoint='snapshot_class_roster')
api.add_resource(Lesson, '{0}/lesson/'.format(BASE_URL),
    endpoint='snapshot_lesson')
api.add_resource(LessonEngagement, '{0}/lesson_engagement/'.format(BASE_URL),
    endpoint='snapshot_lesson_engagement')
api.add_resource(LessonEngagementStatistics, '{0}/lesson_engagement_statistics/'.format(BASE_URL),
    endpoint='snapshot_lesson_engagement_statistics')
api.add_resource(Texts, '{0}/texts/'.format(BASE_URL),
    endpoint='snapshot_texts')
