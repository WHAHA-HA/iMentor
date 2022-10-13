# -*- coding: iso8859-15 -*-
import pprint
import copy
import os,sys
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from flask import Blueprint,render_template,request
from flask_restful import Resource, Api
from config.project_globals import app,api
from auth.login_from_django import LocalLoginManager,verify_session_id
from config.settings import ENV_TYPE, DEFAULT_TEST_USER_ID

login_manager = LocalLoginManager() # Used by @login_required
login_manager.init_app(app)
login_manager.login_view  = '/login'

from flask_login import login_required

from legacy_models.calendars import  CalendarsEventtype,CalendarsEventmeta
from legacy_models.curriculum import CurriculumPrompt
from legacy_models.partners import PartnersPartner
from legacy_models.iuser import IuserUser

# Requires a symlink from templates/404.html to local templates/app/404.html
APP_NAME='auth'
lauth = Blueprint(APP_NAME, __name__, url_prefix='/{0}'.format(APP_NAME),
    template_folder='templates')

@lauth.app_errorhandler(403)
def handle_403(err):
    return render_template('{0}/403.html'.format(APP_NAME)), 403

@lauth.app_errorhandler(404)
def handle_404(err):
    return render_template('{0}/404.html'.format(APP_NAME)), 404

@lauth.app_errorhandler(500)
def handle_500(err):
    return render_template('{0}/500.html'.format(APP_NAME)), 500

@login_manager.user_loader
def load_user(userid):
    """  
    user_loader stores the returned User object in current_user during every 
    flask request. 
    """
    if userid is None:
        return redirect('/')

    user_obj = IuserUser.query.filter(IuserUser.id==int(userid)).first()
    return user_obj

# Serves landing page
@app.route("/")
def main_landing2():
    return render_template("auth/landing.html")


