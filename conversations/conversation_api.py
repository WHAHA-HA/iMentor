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
from conversations.models import Conversation,ConversationAutoSave
from legacy_models.iuser import IuserUser
from utils.authz import check_authz
from utils.strip_html import strip_tags
from utils.strip_html import strip_tags
from utils.user_details import user_timezone
from legacy_updates import update_legacy_dependencies_upon_finish
from conversation_utils import (get_chunk_of_messages,
    post_messages,superuser_announcer,
    is_match_online,update_ts)

# Notice that this is dynamic, based on project directory name!!!
if 'mobile' in projdir:
    BASE_URL = "/mconv"
else:
    BASE_URL = "/conv"

'''
There's a big assumption here that there's only one "thread" of conversation between
groups of users. The means a mentor, the matching mentee and the responsible admin(s)
always see all messages to any single person from this group.
'''

class ConvChat(Resource):

    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    @login_required
    def get(self,from_id=None,to_id=None,from_datetime=None,msg_limit=20,dmy_start=None,dmy_end=None,search_string=None,
        user_id=None):

        from flask_login import current_user

        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        if not user_id:
            update_ts(current_user,poll=True,live=False)

        result,unseen_count,highest_seq = get_chunk_of_messages(BASE_URL,current_user,from_id,to_id,
            from_datetime,msg_limit,dmy_start,dmy_end,search_string,user_id,live=False)

        return jsonify({'messages':result,'unseen_count':unseen_count,
            'seen_count':len(result)-unseen_count,'other_online':is_match_online(current_user,user_id),
            'highest_seq':highest_seq})


class ConvChatLive(Resource):
    '''
    This is used in the cases where we need to distinguish a live "get" from
    a report/search, so we can mark things as seen.
    '''

    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    @login_required
    def get(self,from_id=None,to_id=None,from_datetime=None,msg_limit=20,dmy_start=None,dmy_end=None,search_string=None,
        user_id=None):
        from flask_login import current_user

        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        if not user_id:
            update_ts(current_user,poll=True,live=True)

        result,unseen_count,highest_seq = get_chunk_of_messages(BASE_URL,current_user,from_id,to_id,
            from_datetime,msg_limit,dmy_start,dmy_end,search_string,user_id,live=True)
        return jsonify({'messages':result,'unseen_count':unseen_count,
            'seen_count':len(result)-unseen_count,'other_online':is_match_online(current_user,user_id),
            'highest_seq':highest_seq})


    @login_required
    def post(self,from_id=None,to_id=None,from_datetime=None,msg_limit=1,dmy_start=None,dmy_end=None,search_string=None,
        user_id=None):
        from flask_login import current_user

        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        post_args = request.get_json(force=True)

        passed = post_messages(current_user,post_args,user_id)

        if not passed:
            app.logger.exception("User {0} tried to chat to user {1}, but isn't their admin, and isn't their mentor/mentee, rejected.".format(
                current_user.id,post_args['recipient_user_id']))
            abort(403)

        if not user_id:
            update_ts(current_user,poll=True,live=True)

        result,unseen_count,highest_seq = get_chunk_of_messages(BASE_URL,current_user,from_id=None,
            to_id=None,from_datetime=None,msg_limit=msg_limit,dmy_start=None,dmy_end=None,
            search_string=None,user_id=user_id,live=True)

        return jsonify({'messages':result,'unseen_count':unseen_count,
            'seen_count':len(result)-unseen_count,'other_online':is_match_online(current_user,user_id),
            'highest_seq':highest_seq})



# Endpoints ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
api.add_resource(ConvChatLive, '{0}/chat/live/'.format(BASE_URL),
    endpoint='conv_chat_live')
api.add_resource(ConvChatLive, '{0}/chat/live/<int:user_id>/'.format(BASE_URL),
    endpoint='conv_chat_live_obo')
api.add_resource(ConvChatLive, '{0}/chat/live/limit/<int:msg_limit>/'.format(BASE_URL),
    endpoint='conv_chat_live_limit')
api.add_resource(ConvChatLive, '{0}/chat/live/limit/<int:msg_limit>/<int:user_id>/'.format(BASE_URL),
    endpoint='conv_chat_live_limit_obo')
api.add_resource(ConvChatLive, '{0}/chat/live/from_datetime/<string:from_datetime>/limit/<int:msg_limit>/'.format(BASE_URL),
    endpoint='conv_chat_live_get_limit_from_datetime')
api.add_resource(ConvChat, '{0}/chat/'.format(BASE_URL),
    endpoint='conv_chat')
api.add_resource(ConvChat, '{0}/chat/limit/<int:msg_limit>/'.format(BASE_URL),
    endpoint='conv_chat_limit')
api.add_resource(ConvChat, '{0}/chat/<int:user_id>/'.format(BASE_URL),
    endpoint='conv_chat_obo')
api.add_resource(ConvChat, '{0}/chat/from_id/<int:from_id>/'.format(BASE_URL),
    endpoint='conv_chat_fromid')
api.add_resource(ConvChat, '{0}/chat/to_id/<int:to_id>/'.format(BASE_URL),
    endpoint='conv_chat_toid')
api.add_resource(ConvChat, '{0}/chat/from_datetime/<string:from_datetime>/'.format(BASE_URL),
    endpoint='conv_chat_datetime')
api.add_resource(ConvChat, '{0}/chat/from_id/<int:from_id>/limit/<int:msg_limit>/'.format(BASE_URL),
    endpoint='conv_chat_get_limit')
api.add_resource(ConvChat, '{0}/chat/to_id/<int:to_id>/limit/<int:msg_limit>/'.format(BASE_URL),
    endpoint='conv_chat_toid_limit')
api.add_resource(ConvChat, '{0}/chat/from_datetime/<string:from_datetime>/limit/<int:msg_limit>/'.format(BASE_URL),
    endpoint='conv_chat_get_limit_from_datetime')
api.add_resource(ConvChat, '{0}/chat/from_id/<int:from_id>/limit/<int:msg_limit>/<int:user_id>/'.format(BASE_URL),
    endpoint='conv_chat_get_limit_obo')
api.add_resource(ConvChat, '{0}/chat/to_id/<int:to_id>/limit/<int:msg_limit>/<int:user_id>/'.format(BASE_URL),
    endpoint='conv_chat_toid_limit_obo')
api.add_resource(ConvChat, '{0}/chat/date_range/<string:dmy_start>/<string:dmy_end>/'.format(BASE_URL),
    endpoint='conv_chat_get_date_range')
api.add_resource(ConvChat, '{0}/chat/date_range/<string:dmy_start>/<string:dmy_end>/<int:user_id>/'.format(BASE_URL),
    endpoint='conv_chat_get_date_range_obo')
api.add_resource(ConvChat, '{0}/chat/search/<string:search_string>/'.format(BASE_URL),
    endpoint='conv_chat_get_search_string')
api.add_resource(ConvChat, '{0}/chat/search/<string:search_string>/<int:user_id>/'.format(BASE_URL),
    endpoint='conv_chat_get_search_string_obo')

