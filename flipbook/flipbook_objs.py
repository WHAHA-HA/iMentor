# -*- coding: iso8859-15 -*-
import pdb
import pprint
import copy
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
from flipbook import flipbook # app name
from legacy_models.iuser import IuserUser,USERTYPE_MAP
from new_platform.utils.roles import Role
from new_platform.utils.user_details import get_persona_for_user, get_persona_obj_for_user
from new_platform.utils.strip_html import strip_tags
from flipbook_utils import get_class_roster, get_new_content
from legacy_models.iuser import (BASIC_USER,
    MEMBER_ADMIN,REGIONAL_ADMIN,PARTNER_ADMIN,MENTOR,
    MENTEE,SUPER_ADMIN)
from utils.authz import check_authz
from flipbook.models import FlagCanvas, FlagConversation, FlagReflection

BASE_URL = "/flipbook"
CONTENT_DATETIME_FORMAT = '%-m/%-d/%-y %-I:%M %p'

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class Flipbook(Resource):

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
class NewContent(Resource):
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
            app.logger.exception("Not crashing. Rejecting new content access for this user: {0}, role is not admin: {1}".format(
            current_user.id,role.role))
            abort(403)

        #print "POST args: %s" % pprint.pformat(request.json)
        post_args = request.get_json(force=True)

        # We show only a subset of the available new content data for the sake of simplicity at this time.
        # We convert only the content_updated key to a string here, so that date sorting in the
        # get_new_content() function works correctly.
        results = get_new_content(post_args['partner_ids'], post_args['filter'])
        outbound = []
        if results is not None:
            for r in results:
                outbound.append({
                    'first_name':r[0],
                    'last_name':r[1],
                    'user_type':r[2],
                    'profile_link':r[3],
                    'content_link':r[4],
                    'content_type':r[7],
                    'content_updated':r[5].strftime(CONTENT_DATETIME_FORMAT),
                    'flag_id':r[8],
                    'flag_type_id':r[9],
                    'flag_description':r[10],
                    'content_id':r[11],
                    })

        return outbound
        
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class Flag(Resource):

    flag_struct  = {
        'flag_id':  fields.Integer,
        'flag_type_id':  fields.Integer,
        'content_id':  fields.Integer,
        'content_type': fields.String,
        }

    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    @login_required
    @marshal_with(flag_struct)
    def post(self):
        from flask_login import current_user
        local_db_session = get_scoped_session()

        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        # Check role before loading.
        role = Role(current_user.id)
        if not role.is_some_admin:
            app.logger.exception("Not crashing. Rejecting flag access for this user: {0}, role is not admin: {1}".format(
            current_user.id,role.role))
            abort(403)

        post_args = request.get_json(force=True)
       
        outbound = {"flag_id": post_args['flag_id']}
        
        # We use current_user.id for admin_removed_id as a placeholder for new flags.
        # We updated Canvas flags here.
        if post_args['content_type'][:2] == 'Ca':
            if post_args['flag_id'] == 'NA':
                flag_detail = FlagCanvas(
                    flag_type_id = post_args['flag_type_id'],
                    canvas_id = post_args['content_id'],
                    admin_added_id = current_user.id,
                    admin_added_datetime = datetime.datetime.utcnow(),
                    admin_removed_id = current_user.id,
                    admin_removed_datetime = None,
                    notes = None)
                    
                local_db_session.add(flag_detail)
                local_db_session.commit()
                outbound['flag_id'] = flag_detail.id
            else:
                local_db_session.query(FlagCanvas).\
                    filter(FlagCanvas.id == post_args['flag_id']).\
                    update({'admin_removed_id': current_user.id, 'admin_removed_datetime': datetime.datetime.utcnow()})

                local_db_session.commit()
        # We updated Conversations flags here.
        elif post_args['content_type'][:2] == 'Co':
            if post_args['flag_id'] == 'NA':
                flag_detail = FlagConversation(
                    flag_type_id = post_args['flag_type_id'],
                    conversation_id = post_args['content_id'],
                    admin_added_id = current_user.id,
                    admin_added_datetime = datetime.datetime.utcnow(),
                    admin_removed_id = current_user.id,
                    admin_removed_datetime = None,
                    notes = None)
                    
                local_db_session.add(flag_detail)
                local_db_session.commit()
                outbound['flag_id'] = flag_detail.id
            else:
                local_db_session.query(FlagConversation).\
                    filter(FlagConversation.id == post_args['flag_id']).\
                    update({'admin_removed_id': current_user.id, 'admin_removed_datetime': datetime.datetime.utcnow()})

                local_db_session.commit()
        # We updated Reflections flags here.
        elif post_args['content_type'][:2] == 'Re':
            if post_args['flag_id'] == 'NA':
                flag_detail = FlagReflection(
                    flag_type_id = post_args['flag_type_id'],
                    reflection_id = post_args['content_id'],
                    admin_added_id = current_user.id,
                    admin_added_datetime = datetime.datetime.utcnow(),
                    admin_removed_id = current_user.id,
                    admin_removed_datetime = None,
                    notes = None)
                    
                local_db_session.add(flag_detail)
                local_db_session.commit()
                outbound['flag_id'] = flag_detail.id
            else:
                local_db_session.query(FlagReflection).\
                    filter(FlagReflection.id == post_args['flag_id']).\
                    update({'admin_removed_id': current_user.id, 'admin_removed_datetime': datetime.datetime.utcnow()})

                local_db_session.commit()
        return outbound

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@app.route(BASE_URL + "/debug/")
def flipbook_home_debug():
    from flask_login import current_user

    if LOGIN_DISABLED:
        current_user = IuserUser.query.filter(
            IuserUser.id==DEFAULT_TEST_USER_ID).one()

    if hasattr(current_user,'id'):

        # Check role before loading.
        role = Role(current_user.id)
        if not role.is_some_admin:
            app.logger.exception("Not crashing. Rejecting flipbook load for this user: {0}, role is not admin: {1}".format(
            current_user.id,role.role))
            abort(403)

        return render_template("flipbook/index_debug.html",CDN_URL=CDN_PREFIX)

    return redirect("/")

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@app.route(BASE_URL + "/")
def flipbook_home():
    from flask_login import current_user

    if LOGIN_DISABLED:
        current_user = IuserUser.query.filter(
            IuserUser.id==DEFAULT_TEST_USER_ID).one()

    if hasattr(current_user,'id'):

        # Check role before loading.
        role = Role(current_user.id)
        if not role.is_some_admin:
            app.logger.exception("Not crashing. Rejecting flipbook load for this user: {0}, role is not admin: {1}".format(
            current_user.id,role.role))
            abort(403)

        return render_template("flipbook/index.html",CDN_URL=CDN_PREFIX)

    return redirect("/")

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Use response endpoint
api.add_resource(NewContent, '{0}/new_content/'.format(BASE_URL),
    endpoint='flipbook_new_content')
api.add_resource(Flag, '{0}/flag/'.format(BASE_URL),
    endpoint='flipbook_flag')
