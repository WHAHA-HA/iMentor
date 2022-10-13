# -*- coding: iso8859-15 -*-
import pdb
import pprint
import copy
import os,sys
from dateutil import tz
from datetime import datetime
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import get_scoped_session,Base,metadata,DBSession
from config.settings import (ENV_TYPE,LOGIN_DISABLED,
    DEFAULT_TEST_USER_ID,SUPERUSER_ANNOUNCER_ID)

from flask import Response, json, jsonify, make_response, url_for, abort
from flask import  current_app, request, redirect, render_template
from flask.views import View, MethodView
from flask_sqlalchemy import SQLAlchemy
import sqlalchemy
from sqlalchemy import desc
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

from new_platform.utils.roles import Role
from new_platform.utils import user_details
from mobile_notifications.mnutils import reset_badge_numbers,add_device_token
from legacy_models.iuser import IuserUser


# Notice that this is dynamic, based on project directory name!!!
if 'mobile' in projdir:
    BASE_URL = "/mpushnots"
else:
    BASE_URL = "/pushnots"

class Badges(Resource):

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

        # We don't care about post args here.
        #post_args = request.get_json(force=True)

        reset_badge_numbers(current_user.id)


class Devices(Resource):

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

        add_device_token(current_user.id,post_args['token'],
            post_args['device_type'],post_args['notes'])


# Endpoints ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
api.add_resource(Badges, '{0}/reset_badges/'.format(BASE_URL),
    endpoint='reset_badges')
api.add_resource(Devices, '{0}/register_device/'.format(BASE_URL),
    endpoint='register_device')
