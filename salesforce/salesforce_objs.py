# -*- coding: iso8859-15 -*-
# Authenticate Information was given out to roger.mitchell@arkusinc.com for data pushing
import pdb
import pprint
import copy
import os,sys
import json
from dateutil import tz
from datetime import datetime,timedelta
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import (Base,metadata,
    DBSession,get_scoped_session)
from config.settings import (ENV_TYPE,LOGIN_DISABLED,
    DEFAULT_TEST_USER_ID)

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

from salesforce import salesforce # app name

from legacy_models.iuser import (IuserUser, IuserPersona,
    IuserUsertype,IuserAssignedusertype,IuserUser,USERTYPE_MAP,ACTIVE_PERSONA_STATUS)
from legacy_models.partners import PartnersPartner

BASE_URL = "/sfclient"

class EndpointTest(Resource):

    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp


    @login_required
    def get(self):
        from flask_login import current_user

        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        return {'result':'hi!'}

class Match_Status_Endpoint(Resource):
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
 
        if 'return_bulk_personas' in post_args:
            query = DBSession.query(IuserPersona.match_status,IuserPersona.id).join(IuserUser,IuserPersona.user_id==IuserUser.id).filter(IuserPersona.match_status.in_(('M', 'C', 'ID'))).filter(IuserUser.member_id.in_([1, 244, 248]))
            result = []
            for item in query:
                dic = {
                'Match_Status__c': item.match_status,
                'iMi_Persona_ID__c': item.id
                }
                result.append(dic)

            return result

        query = DBSession.query(IuserPersona).filter(
            IuserPersona.user_id==outbound['user_id']).filter(
            IuserPersona.match_status==outbound['match_status']).first()

        if not query:
            return {"match_status":None,"user_id": None}
        return {"match_status":query.match_status,"user_id": query.user_id}


api.add_resource(EndpointTest, '{0}/'.format(BASE_URL),
    endpoint='endpoint_get')

api.add_resource(Match_Status_Endpoint, '{0}/match_status/'.format(BASE_URL),
    endpoint='endpoint_get2')
    
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
if __name__=="__main__":
    query = DBSession.query(IuserPersona.match_status,IuserPersona.id).join(IuserUser,IuserPersona.user_id==IuserUser.id).filter(IuserPersona.match_status.in_(('M', 'C', 'ID'))).filter(IuserUser.member_id.in_([1, 244, 248])).filter(IuserUser.id==175263)
    result = []
    for item in query:
        dic = {
        'Match_Status__c': item.match_status,
        'iMi_Persona_ID__c': item.id
        }
        result.append(dic)

    print result