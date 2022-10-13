# -*- coding: iso8859-15 -*-
import os,sys
import requests
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import db,Base,metadata,DBSession
from config.settings import (ENV_TYPE,LOGIN_DISABLED,DEFAULT_TEST_USER_ID,
    TABLEAU_SERVER,TABLEAU_EMBED_URL,TABLEAU_STANDARD_URL,TABLEAU_TICKET_REQUEST_URL,
    TABLEAU_USERNAME)

from legacy_models.iuser import IuserUser

from flask import Response, json, jsonify, make_response, url_for, abort
from flask import  current_app, request, redirect, make_response, render_template
from flask.views import MethodView
from flask_restful import Resource, Api
from auth import app,api,login_required

BASE_URL='/dw_reports'

class InvalidAuthToken(Exception):
    pass

class TableauAccess(MethodView):

    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp


    # Get a sample report.
    @login_required
    def get(self,workbook,view,embedded=None):

        from flask_login import current_user
        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        # This accesses an internal URL, so don't verify the SSL cert.
        result = requests.post(TABLEAU_TICKET_REQUEST_URL,
            verify=False, data = {'username':TABLEAU_USERNAME})

        result.raise_for_status() # in case request failed for some reason

        ticket = result.text
        if ticket in ("-1",-1,"",None):
            if ENV_TYPE == "Production":
                raise InvalidAuthToken("Tableau failed to grant you a valid auth token (ticket). Maybe you're running this server code on a server Tableau does not recognize?")
            else:
                # Don't crash on dev, let this slide.
                app.logger.exception("Not crashing: Tableau failed to grant you a valid auth token (ticket) in a dev environment. Maybe you're running this server code on a server Tableau does not recognize?")

        data = {'standard_url':TABLEAU_STANDARD_URL.format(ticket,workbook,view),
                'ticket':ticket,
                'workbook':workbook,
                'view':view,
                'embed_url':TABLEAU_EMBED_URL,
               }
        
        return jsonify(data)

        '''
        This is a good test. Keep it around.

        workbook = '2014-15EngagementDashboard'
        view = 'AggregateEmailEngagement14-15?:iid=1'
        
        if embedded:
            return render_template("tableau_reports/tableau_test_embedded.html",**data)
        return render_template("tableau_reports/tableau_test_standard.html",**data)
        '''


app.add_url_rule('{0}/<string:workbook>/<string:view>/'.format(BASE_URL), view_func=TableauAccess.as_view('tableau_access_std'))
app.add_url_rule('{0}/<string:workbook>/<string:view>/<string:embedded>/'.format(BASE_URL), view_func=TableauAccess.as_view('tableau_access_embedded'))
