# -*- coding: iso8859-15 -*-
import pdb
import json
import pprint
import copy
import os,sys
import datetime
import pymongo
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import (db,Base,metadata,
    DBSession,get_scoped_session)
from config.settings import (ENV_TYPE,LOGIN_DISABLED,
    DEFAULT_TEST_USER_ID,MONGO_HOST,MONGO_PORT,
    MONGO_DBNAME_DEBUG, MONGO_FORMS_DEBUG_COLLNAME)

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

from generic import generic # app name

from legacy_models.iuser import (IuserUser,MemberMember,USERTYPE_MAP,MENTOR,MENTEE,
    GENDER_CHOICES,MATCH_CHOICES,USER_STATUS_MAP)
from enrollment.models import SCHOOL_ATTENDANCE_VALUES,PROGRAM_READINESS_VALUES
from qualtrics.models import QUALTRICS_STATUS_MAP,QualtricsSurvey
from file_upload.models import FileUploadAllowList
from new_platform.utils.roles import Role
from new_platform.utils import user_details
from generic_utils import generic_user_info
from utils.authz import check_authz,can_user_access_messaging
from models import NoLoadError
from new_platform.utils.user_details import get_persona_obj_for_user

mongo_connection = pymongo.mongo_client.MongoClient(MONGO_HOST,MONGO_PORT)
database = pymongo.database.Database(mongo_connection,MONGO_DBNAME_DEBUG)
forms_debug_coll = database[MONGO_FORMS_DEBUG_COLLNAME]

# Notice that this is dynamic, based on project directory name!!!
if 'mobile' in projdir:
    BASE_URL = "/mgeneric"
else:
    BASE_URL = "/generic"


class GenericUser(Resource):
    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    @login_required
    def get(self,user_id=None):
        from flask_login import current_user
        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        if user_id:
            current_user = check_authz(current_user,user_id,replace_user=True)
            if not current_user:
                abort(403)

        return generic_user_info(current_user)


class GenericPartner(Resource):

    partner_school_struct = {
        'id':    fields.Integer,
        'school': fields.String,
        'graduating_class': fields.Integer
        }

    partner_struct = {
        'id':    fields.Integer,
        'name':  fields.String,
        'photo':  fields.String,
        'program_name':  fields.String,
        'state':  fields.String,
        'graduating_class':fields.Nested(partner_school_struct)
        }

    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    @login_required
    @marshal_with(partner_struct)
    def get(self,user_id=None):
        '''
        Get a list of partners based on the user's role.
        '''
        from flask_login import current_user
        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        if user_id:
            current_user = check_authz(current_user,user_id,replace_user=True)
            if not current_user:
                abort(403)

        # Only get user info for yourself or your mentee,
        # unless you're of a higher role.
        role_obj = Role(current_user.id)

        return user_details.get_partners_for_user(current_user,role_obj)


class GenericSurvey(Resource):

    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    @login_required
    def get(self,user_id=None):
        '''
        Get active surveys for this person's member id
        '''
        from flask_login import current_user
        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        if user_id:
            current_user = check_authz(current_user,user_id,replace_user=True)
            if not current_user:
                abort(403)

        outbound = []
        # Only show surveys for the user's member site.
        for r in QualtricsSurvey.query.filter(
            or_(QualtricsSurvey.member_id == current_user.member_id,
            QualtricsSurvey.member_id == None)).filter(
            QualtricsSurvey.survey_is_active == True).all():

            r_dict = r.__dict__
            del r_dict['_sa_instance_state']
            r_dict['start_date'] = str(r_dict['start_date'])
            r_dict['end_date'] = str(r_dict['end_date'])
            outbound.append(r_dict)

        return outbound
            

class GenericGender(Resource):
    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    @login_required
    def get(self):
        from flask_login import current_user
        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        return dict([(k,v) for v,k in GENDER_CHOICES.items()])
        

class GenericMatch(Resource):
    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    @login_required
    def get(self):
        from flask_login import current_user
        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        return MATCH_CHOICES
        

class GenericMember(Resource):
    member_info = {
        'id':    fields.Integer,
        'name':  fields.String
        }

    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    @login_required
    @marshal_with(member_info)
    def get(self):
        from flask_login import current_user
        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        return MemberMember.query.all()
        

class GenericAttendance(Resource):
    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    @login_required
    def get(self):
        from flask_login import current_user
        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        return SCHOOL_ATTENDANCE_VALUES
        
class GenericReadiness(Resource):
    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    @login_required
    def get(self):
        from flask_login import current_user
        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        return PROGRAM_READINESS_VALUES
        
class GenericUserStatus(Resource):
    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    @login_required
    def get(self):
        from flask_login import current_user
        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        return USER_STATUS_MAP
        
class GenericSurveyStatus(Resource):
    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    @login_required
    def get(self):
        from flask_login import current_user
        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        return QUALTRICS_STATUS_MAP
        
class GenericUserTypes(Resource):
    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    @login_required
    def get(self):
        from flask_login import current_user
        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        return USERTYPE_MAP
        
class GenericFileExtensions(Resource):
    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    @login_required
    def get(self):
        from flask_login import current_user
        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        return [x.file_extension for x in DBSession.query(FileUploadAllowList).all()]
        
class GenericJsonLogger(Resource):
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

        post_args = request.get_json(force=True)
        #print "Post Args: {0}".format(post_args)
        app.logger.warning(post_args)
        forms_debug_coll.insert(json.loads(post_args))
        return {}

class GenericNoLoad(Resource):
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

        # We log the details of the no-load error here for analysis and product improvement.
        persona = get_persona_obj_for_user(user_id = current_user.id, ignore_match_status = True)
        
        error_details = NoLoadError(
            user_id = current_user.id,
            persona_id = persona.id,
            product_type_id = post_args['product_type_id'],
            product_record_id = post_args['product_record_id'],
            content_type_id = post_args['content_type_id'],
            content_url = post_args['content_url'],
            error_datetime = datetime.datetime.utcnow())

        local_db_session.add(error_details)
        local_db_session.commit()

        return {'success':True}

class PersonaPermissionsMessaging(Resource):
    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    @login_required
    def get(self):
        from flask_login import current_user
        local_db_session = get_scoped_session()

        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        result = can_user_access_messaging(user_id=current_user.id)

        if result:
            return {'messaging':True,'member_id':current_user.member_id}

        return {'messaging':False,'member_id':None}


# Endpoints ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 'info' returns user-specific data, which 'choices' returns all options.
api.add_resource(GenericMember, '{0}/member_choices/'.format(BASE_URL),
    endpoint='generic_member_choices')

api.add_resource(GenericUser, '{0}/user_info/'.format(BASE_URL),
    endpoint='generic_user_info')

api.add_resource(GenericPartner, '{0}/partner_info/'.format(BASE_URL),
    endpoint='generic_partner_info')

api.add_resource(GenericSurvey, '{0}/survey_info/'.format(BASE_URL),
    endpoint='generic_survey_info')

api.add_resource(GenericUser, '{0}/user_info/<int:user_id>/'.format(BASE_URL),
    endpoint='generic_user_info_obo')

api.add_resource(GenericPartner, '{0}/partner_info/<int:user_id>/'.format(BASE_URL),
    endpoint='generic_partner_info_obo')

api.add_resource(GenericSurvey, '{0}/survey_info/<int:user_id>/'.format(BASE_URL),
    endpoint='generic_survey_info_obo')

api.add_resource(GenericGender, '{0}/gender_choices/'.format(BASE_URL),
    endpoint='generic_gender_choices')

api.add_resource(GenericMatch, '{0}/match_choices/'.format(BASE_URL),
    endpoint='generic_match_choices')

api.add_resource(GenericAttendance, '{0}/attendance_choices/'.format(BASE_URL),
    endpoint='generic_attendance_choices')

api.add_resource(GenericReadiness, '{0}/readiness_choices/'.format(BASE_URL),
    endpoint='generic_readiness_choices')

api.add_resource(GenericUserStatus, '{0}/user_status_choices/'.format(BASE_URL),
    endpoint='generic_user_status_choices')

api.add_resource(GenericSurveyStatus, '{0}/survey_status_choices/'.format(BASE_URL),
    endpoint='generic_survey_status_choices')

api.add_resource(GenericUserTypes, '{0}/user_type_choices/'.format(BASE_URL),
    endpoint='generic_user_type_choices')

api.add_resource(GenericFileExtensions, '{0}/file_extensions/'.format(BASE_URL),
    endpoint='generic_allowed_file_extensions')

api.add_resource(GenericJsonLogger, '{0}/json_logger/'.format(BASE_URL),
    endpoint='generic_json_logger')

api.add_resource(GenericNoLoad, '{0}/noload/'.format(BASE_URL),
    endpoint='generic_noload')

api.add_resource(PersonaPermissionsMessaging, '{0}/can_access_messaging/'.format(BASE_URL),
    endpoint='can_access_messaging')
