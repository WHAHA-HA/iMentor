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

from legacy_models.iuser import IuserUser

BASE_URL = "/menu"

@app.route(BASE_URL + "/")
def menu_home():
    from flask_login import current_user

    if LOGIN_DISABLED:
        current_user = DBSession.query(IuserUser).filter(
            IuserUser.id==DEFAULT_TEST_USER_ID).one()

    if hasattr(current_user,'id'):
        return render_template("menu/menu.html",CDN_URL=CDN_PREFIX)

    return redirect("/")



@app.route(BASE_URL + "/debug/")
def menu_home_debug():
    from flask_login import current_user

    if LOGIN_DISABLED:
        current_user = DBSession.query(IuserUser).filter(
            IuserUser.id==DEFAULT_TEST_USER_ID).one()

    if hasattr(current_user,'id'):
        return render_template("menu/menu.debug.html",CDN_URL=CDN_PREFIX)

    return redirect("/")


# Endpoints
'''
api.add_resource(MenuSomething, '{0}/something/'.format(BASE_URL),
    endpoint='menu_something')
'''
