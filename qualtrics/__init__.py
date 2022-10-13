# -*- coding: utf-8 -*-
import os, sys
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir, '..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import db

from flask import Blueprint, render_template, request

#qualtrics.config.from_pyfile('settings/settings.py')
# Requires a symlink from templates/404.html to local templates/app/404.html
APP_NAME='qualtrics'
qualtrics = Blueprint(APP_NAME, __name__, url_prefix='/'.format(APP_NAME),
                      template_folder='templates')

@qualtrics.app_errorhandler(403)
def handle_403(err):
    return render_template('{0}/403.html'.format(APP_NAME)), 403

@qualtrics.app_errorhandler(404)
def handle_404(err):
    return render_template('{0}/404.html'.format(APP_NAME)), 404

@qualtrics.app_errorhandler(500)
def handle_500(err):
    return render_template('{0}/500.html'.format(APP_NAME)), 500
