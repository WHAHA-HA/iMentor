# -*- coding: iso8859-15 -*-
import pdb
import pprint
import copy
import os,sys
from dateutil import tz
from datetime import datetime,timedelta
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import (Base,metadata,
    DBSession,get_scoped_session)
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

from canvas import canvas # app name

from legacy_models.iuser import (IuserUser,
    IuserUsertype,IuserAssignedusertype,IuserUser,USERTYPE_MAP,ACTIVE_PERSONA_STATUS)
from legacy_models.partners import PartnersPartner
from models import *
from canvas_utils import copy_lessons_by_partner,flag_lesson
from new_platform.utils.roles import Role
from new_platform.utils import user_details
from lesson_management.lesson_mgmt_utils import get_recent_lessons, delete_lessons
from utils.authz import check_authz

BASE_URL = "/canvas"

# We prefer this display format for dates and times, since it is succinct yet still descriptive.
DATETIME_DISPLAY_FORMAT = '%-m/%-d %-I:%M %p'

class UnrecognizedMessageType(Exception):
    pass


class DupRoleException(Exception):
    pass

class ListLessons(Resource):
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

        results = get_recent_lessons(post_args['partner_id'])
        outbound = []
        for r in results:
            to_tz = tz.gettz(r[2])
            startdatetime = r[3].replace(tzinfo=tz.gettz('UTC')).astimezone(to_tz).replace(tzinfo=None)
            enddatetime = r[4].replace(tzinfo=tz.gettz('UTC')).astimezone(to_tz).replace(tzinfo=None)
            outbound.append({
                'partner_id':r[0],
                'partner_name':r[1],
                'lesson_start_string':startdatetime.strftime(DATETIME_DISPLAY_FORMAT),
                'lesson_end_string':enddatetime.strftime(DATETIME_DISPLAY_FORMAT),
                'lesson_description':r[5],
                'grade_number':r[6],
                'unit_number':r[7],
                'lesson_number':r[8],
                'session_id':r[9],
                'curriculum_id':r[10],
                })

        # adjust UTC times to partner time zone.
        return outbound


class CopyLessons(Resource):
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

        role = Role(current_user.id)
        if not role.is_some_admin:
            abort(403)

        #print "POST args: %s" % pprint.pformat(request.json)
        post_args = request.get_json(force=True)

        results = copy_lessons_by_partner(current_user,post_args)
        return results
        

class CanvasCurricula(Resource):
    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    grade_struct = {
        'id':                      fields.Integer,
        'grade_number':            fields.Integer,
        'description':             fields.String,
    }

    unit_struct = {
        'id':                      fields.Integer,
        'unit_number':             fields.Integer,
        'description':             fields.String,
    }

    curr_struct = {
        'id':                      fields.Integer,
        'canvas_type':             fields.Integer,
        'start_datetime':          fields.DateTime,
        'end_datetime':            fields.DateTime,
        'grade':                   fields.Nested(grade_struct),
        'unit':                    fields.Nested(unit_struct),
        'curriculum_number':       fields.Integer,
        'member_id':               fields.Integer,
        'description':             fields.String,
        }

    @login_required
    @marshal_with(curr_struct)
    def get(self):
        from flask_login import current_user
    
        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        return DBSession.query(Curriculum).filter(Curriculum.grade != None).filter(
            Curriculum.unit != None).filter(
            Curriculum.active == True).filter(
                or_(Curriculum.member_id==current_user.member_id,
                    Curriculum.member_id==None)).filter(
            Curriculum.unit != None).order_by(Curriculum.curriculum_number).all()


class CanvasLessons(Resource):

    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    curr_struct = {
        'id':                      fields.Integer,
        'canvas_type':             fields.Integer,
        'start_datetime':          fields.DateTime,
        'end_datetime':            fields.DateTime,
        'grade':                   fields.Integer,
        'unit':                    fields.Integer,
        'member_id':               fields.Integer,
        'description':             fields.String,
        'curriculum_number':       fields.Integer,
        }

    cset_struct = {
        'id':                      fields.Integer,
        'role':                    fields.Integer,
        'description':             fields.String,
        'start_datetime':          fields.DateTime,
        'end_datetime':            fields.DateTime,
        'curriculum':              fields.Nested(curr_struct),
        }

    @login_required
    @marshal_with(cset_struct)
    def get(self,canvas_set_type=None,role_id=None,user_id=None,
        ymd=None,end_ymd=None,canvas_set_id=None):
        from flask_login import current_user
    
        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        all_lesson_ids = [x.id for x in DBSession.query(Curriculum).filter(
            Curriculum.active==True).all()]

        return DBSession.query(CanvasSet).filter(
            CanvasSet.curriculum_id.in_(all_lesson_ids)).all()

class DeleteLessons(Resource):
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

        delete_lessons(post_args['partner_id'], post_args['curriculum_id'],
            post_args['session_id'])

        return {'success':True}

class FlagLesson(Resource):
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

        current_user = check_authz(current_user,post_args['user_id'],
            replace_user=False)

        if not current_user:
            abort(403)

        '''
        flags is a dictionary: {'is_visible':False,'some_other_flag':something}
        We only have one flag right now.
        '''
        flag_lesson(current_user,post_args['curriculum_id'],
            post_args['user_id'],post_args['partner_id'],
            post_args['widget_content_id'],post_args['flags'])

        return {'success':True}


@app.route(BASE_URL + "/")
def canvas_home():
    from flask_login import current_user

    if LOGIN_DISABLED:
        current_user = DBSession.query(IuserUser).filter(
            IuserUser.id==DEFAULT_TEST_USER_ID).one()

    if hasattr(current_user,'id'):
        return render_template("canvas/canvas.html",CDN_URL=CDN_PREFIX)

    return redirect("/")

@app.route(BASE_URL + "/debug/")
def canvas_debug():
    from flask_login import current_user

    if LOGIN_DISABLED:
        current_user = DBSession.query(IuserUser).filter(
            IuserUser.id==DEFAULT_TEST_USER_ID).one()

    if hasattr(current_user,'id'):
        return render_template("canvas/canvas.debug.html",CDN_URL=CDN_PREFIX)

    return redirect("/")

@app.route(BASE_URL + "/lesson/<lesson_id>/")
def canvas_lesson(lesson_id):
    from flask_login import current_user

    if LOGIN_DISABLED:
        current_user = DBSession.query(IuserUser).filter(
            IuserUser.id==DEFAULT_TEST_USER_ID).one()

    if hasattr(current_user,'id'):
        return render_template("canvas/canvas.html",
            lesson_id_from_flask=lesson_id,CDN_URL=CDN_PREFIX)

    return redirect("/")

@app.route(BASE_URL + "/debug/lesson/<lesson_id>/")
def canvas_lesson_debug(lesson_id):
    from flask_login import current_user

    if LOGIN_DISABLED:
        current_user = DBSession.query(IuserUser).filter(
            IuserUser.id==DEFAULT_TEST_USER_ID).one()

    if hasattr(current_user,'id'):
        return render_template("canvas/canvas.debug.html",
            lesson_id_from_flask=lesson_id,CDN_URL=CDN_PREFIX)

    return redirect("/")

@app.route(BASE_URL + "/lessoncopy/<cscopy_id>/")
def canvas_cscopy(cscopy_id):
    from flask_login import current_user

    if LOGIN_DISABLED:
        current_user = DBSession.query(IuserUser).filter(
            IuserUser.id==DEFAULT_TEST_USER_ID).one()

    if hasattr(current_user,'id'):
        return render_template("canvas/canvas_cscopy.html",
            cscopy_id_from_flask=cscopy_id,CDN_URL=CDN_PREFIX)

    return redirect("/")

@app.route(BASE_URL + "/debug/lessoncopy/<cscopy_id>/")
def canvas_cscopy_debug(cscopy_id):
    from flask_login import current_user

    if LOGIN_DISABLED:
        current_user = DBSession.query(IuserUser).filter(
            IuserUser.id==DEFAULT_TEST_USER_ID).one()

    if hasattr(current_user,'id'):
        return render_template("canvas/canvas_cscopy.debug.html",
            cscopy_id_from_flask=cscopy_id,CDN_URL=CDN_PREFIX)

    return redirect("/")


@app.route(BASE_URL + "/lesson/<lesson_id>/<user_id>/")
def canvas_lesson_obo(lesson_id,user_id):
    from flask_login import current_user

    if LOGIN_DISABLED:
        current_user = DBSession.query(IuserUser).filter(
            IuserUser.id==DEFAULT_TEST_USER_ID).one()

    #print "specific_lesson_canvas_obo called"

    if hasattr(current_user,'id'):
        # Get role before current_user is replaced.
        role = Role(current_user.id)

        current_user = check_authz(current_user,user_id,replace_user=True)
        if not current_user:
            abort(403)

        return render_template("canvas/canvas.html",
            lesson_id_from_flask=lesson_id,user_id_from_flask=current_user.id,CDN_URL=CDN_PREFIX)

    return redirect("/")

@app.route(BASE_URL + "/debug/lesson/<lesson_id>/<user_id>/")
def canvas_lesson_obo_debug(lesson_id,user_id):
    from flask_login import current_user

    if LOGIN_DISABLED:
        current_user = DBSession.query(IuserUser).filter(
            IuserUser.id==DEFAULT_TEST_USER_ID).one()

    #print "specific_lesson_canvas_obo called"

    if hasattr(current_user,'id'):
        # Get role before current_user is replaced.
        role = Role(current_user.id)

        current_user = check_authz(current_user,user_id,replace_user=True)
        if not current_user:
            abort(403)

        return render_template("canvas/canvas.debug.html",
            lesson_id_from_flask=lesson_id,user_id_from_flask=current_user.id,CDN_URL=CDN_PREFIX)

    return redirect("/")

@app.route(BASE_URL + "/lessoncopy/<cscopy_id>/<user_id>/")
def canvas_cscopy_obo(cscopy_id,user_id):
    from flask_login import current_user

    if LOGIN_DISABLED:
        current_user = DBSession.query(IuserUser).filter(
            IuserUser.id==DEFAULT_TEST_USER_ID).one()

    #print "specific_cscopy_canvas_obo called"

    if hasattr(current_user,'id'):
        # Get role before current_user is replaced.
        role = Role(current_user.id)

        current_user = check_authz(current_user,user_id,replace_user=True)
        if not current_user:
            abort(403)

        return render_template("canvas/canvas_cscopy.html",
            cscopy_id_from_flask=cscopy_id,user_id_from_flask=current_user.id,CDN_URL=CDN_PREFIX)

    return redirect("/")

@app.route(BASE_URL + "/debug/lessoncopy/<cscopy_id>/<user_id>/")
def canvas_cscopy_obo_debug(cscopy_id,user_id):
    from flask_login import current_user

    if LOGIN_DISABLED:
        current_user = DBSession.query(IuserUser).filter(
            IuserUser.id==DEFAULT_TEST_USER_ID).one()

    #print "specific_cscopy_canvas_obo called"

    if hasattr(current_user,'id'):
        # Get role before current_user is replaced.
        role = Role(current_user.id)

        current_user = check_authz(current_user,user_id,replace_user=True)
        if not current_user:
            abort(403)

        return render_template("canvas/canvas_cscopy.debug.html",
            cscopy_id_from_flask=cscopy_id,user_id_from_flask=current_user.id,CDN_URL=CDN_PREFIX)

    return redirect("/")


# Use response endpoint
api.add_resource(CanvasLessons, '{0}/lessons/'.format(BASE_URL),
    endpoint='canvas_get_all_lessons')
api.add_resource(CanvasCurricula, '{0}/curricula/'.format(BASE_URL),
    endpoint='canvas_get_all_curr')
api.add_resource(CopyLessons, '{0}/assign_lessons/'.format(BASE_URL),
    endpoint='canvas_assign_lessons')
api.add_resource(ListLessons, '{0}/get_assigned_lessons/'.format(BASE_URL),
    endpoint='canvas_get_assigned_lessons')
api.add_resource(DeleteLessons, '{0}/delete_lessons/'.format(BASE_URL),
    endpoint='canvas_delete_lessons')
api.add_resource(FlagLesson, '{0}/flag/'.format(BASE_URL),
    endpoint='canvas_flag_lessons')
