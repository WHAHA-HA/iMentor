# -*- coding: iso8859-15 -*-
import os,sys
import json
import traceback
import pprint
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)
import time, datetime
from flask_sqlalchemy import SQLAlchemy
from flask import Flask, redirect, g, got_request_exception, request
from flask_restful import Api
from flask import Response, jsonify, make_response
from flask_cache import Cache as URLCache

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, scoped_session
from sqlalchemy.ext.declarative import declarative_base
from config.project_globals import DBSession

from auth import api, app

from legacy_models.iuser import IuserUser

from config.settings import (DEBUG,DEFAULT_TEST_USER_ID,LOGIN_DISABLED,
    ENV_TYPE,HOSTNAME)

def add_details(sender, exception):
    from flask_login import current_user
    if LOGIN_DISABLED:
        current_user = DBSession.query(IuserUser).filter(
            IuserUser.id==DEFAULT_TEST_USER_ID).one()

    exc = traceback.format_exc()
    cid = None
    if hasattr(current_user,'id'):
        if getattr(current_user,'id'):
            cid = current_user.id

    msg = """
{0}:{1}: 
Exception: {2}
User {3}

Request: {4}
    """.format(ENV_TYPE,HOSTNAME,exc,cid,pprint.pformat(request.__dict__))

    sys.stderr.write(msg)
    if 'abort(404)' in exc:
        app.logger.warning(msg)
    else:
        app.logger.exception(msg)

def add_signals(app):
    got_request_exception.connect(add_details, app)

