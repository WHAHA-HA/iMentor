# -*- coding: iso8859-15 -*-
import pdb
import pprint
import copy
import os,sys
import pymongo
import time
import re
from dateutil import tz
from datetime import datetime,timedelta
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'../..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import get_scoped_session,Base,metadata,DBSession
from config.settings import (ENV_TYPE,LOGIN_DISABLED,
    DEFAULT_TEST_USER_ID,SUPERUSER_ANNOUNCER_ID,MONGO_HOST,MONGO_PORT,
    MONGO_DBNAME_ES_CONVERSATION,MONGO_ES_CONVERSATION_ADDINDEX_COLLNAME,
    ESEARCH_INDEXED_APPS)

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
from conversations.models import (Conversation,ConversationAutoSave,
    ConversationLatestPoll)
from legacy_models.iuser import IuserUser
from utils.authz import check_authz
from utils.strip_html import strip_tags
from utils.user_details import user_timezone,get_persona_obj_for_user
from mobile_notifications.mnutils import send_push_notification

QUEUE_FIELD = ESEARCH_INDEXED_APPS['conversation']['queue_field']

mongo_connection = pymongo.mongo_client.MongoClient(MONGO_HOST,MONGO_PORT)
database = pymongo.database.Database(mongo_connection,MONGO_DBNAME_ES_CONVERSATION)
conversation_coll = database[MONGO_ES_CONVERSATION_ADDINDEX_COLLNAME]

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
superuser_announcer = DBSession.query(IuserUser).filter(
        IuserUser.id==SUPERUSER_ANNOUNCER_ID).one()


def add_wmsg():
        local_db_session = get_scoped_session()
        user_ids = [x.id for x in DBSession.query(IuserUser).all()]
        for current_user_id in user_ids:
            convcount = local_db_session.query(Conversation).filter(Conversation.user_id==current_user_id).count()
            if convcount > 0:
                continue
            try:
                recipient_persona_id = get_persona_obj_for_user(current_user_id,ignore_match_status=True).id
            except:
                 continue
            wmsg = Conversation(
                user_id = SUPERUSER_ANNOUNCER_ID,
                persona_id = get_persona_obj_for_user(SUPERUSER_ANNOUNCER_ID,ignore_match_status=True).id,
                recipient_user_id = current_user_id,
                recipient_persona_id = recipient_persona_id,
                received_by_server = datetime.utcnow().date(),
                sent_to_recipient = None,
                admin_last_viewed = datetime.utcnow().date(),
                data = """
            Welcome to Conversations! This is your tool to exchange messages as a pair. New message notifications will appear on the Conversations icon at the top right of your screen. Click the chat icon to open Conversations, click the paperclip icon to attach files and click the paper airplane icon to send your message. If you want to learn more, click the “Need help” link near the search icon above.
                   """,
                word_count = 69,
                sequence = 1)

            print "Added for user {0}".format(current_user_id)
            local_db_session.add(wmsg)
            local_db_session.commit()
            local_db_session.begin()
            
        local_db_session.commit()

if __name__ == '__main__':
    add_wmsg()
