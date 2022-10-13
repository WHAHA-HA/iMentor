#!/usr/bin/env python
# -*- coding: iso8859-15 -*-

import socket
from threading import Thread
from flask_ocketio import disconnect, SocketIO, emit, join_room, leave_room
from flask import render_template

import functools
import pdb
import pprint
import copy
import os,sys
import json
from dateutil import tz
from datetime import datetime
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import get_scoped_session,Base,metadata,DBSession
from config.settings import (FLASK_HOST,FLASK_CHAT_WEBSOCKET_PORT,
    ENV_TYPE,LOGIN_DISABLED, DEFAULT_TEST_USER_ID,SUPERUSER_ANNOUNCER_ID)

from flask_sqlalchemy import SQLAlchemy
import sqlalchemy
from sqlalchemy import desc
from sqlalchemy.sql.expression import func, or_, not_, and_
from sqlalchemy.orm import sessionmaker
from sqlalchemy.orm.exc import NoResultFound, MultipleResultsFound

#Import 'app' object from auth as well
from auth import api, app, verify_session_id

from new_platform.utils.roles import Role
from new_platform.utils import user_details
from conversations.models import Conversation,ConversationAutoSave
from legacy_models.iuser import IuserUser
from utils.authz import check_authz
from utils.strip_html import strip_tags
from utils.strip_html import strip_tags
from utils.user_details import user_timezone
from conversations.conversation_utils import (superuser_announcer,
    get_chunk_of_messages,post_messages)

from chat_socketio import chat_socketio
from chat_socketio.chat_websocket import socketio
app.register_blueprint(chat_socketio)
socketio.run(app,host=FLASK_HOST,port=FLASK_CHAT_WEBSOCKET_PORT)
