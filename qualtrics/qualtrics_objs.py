# -*- coding: iso8859-15 -*-
import copy
from datetime import datetime
import httplib
import pdb
import pprint
import os,sys
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import Base,metadata,DBSession
from config.settings import (ENV_TYPE,LOGIN_DISABLED,
    DEFAULT_TEST_USER_ID,QUALTRICS_URI,CDN_PREFIX)

from flask import Response, json, jsonify, make_response, url_for, abort
from flask import  current_app, request, redirect, render_template, stream_with_context
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

from qualtrics import qualtrics # app name

from models import (QUALTRICS_STATUS_MAP,QUALTRICS_NOT_INVITED,
    QUALTRICS_INVITED,QUALTRICS_INCOMPLETE,QUALTRICS_COMPLETE)

from utils.user_details import get_partners_for_user,get_persona_obj_for_user
from utils.roles import Role
from utils.unicode_csv import UnicodeWriter
from legacy_models.iuser import (IuserUser,IuserPersona,
    USERTYPE_MAP,USER_STATUS_MAP,MATCH_CHOICES,USER_STATUS_APPLICATION_INCOMPLETE)
from qualtrics_utils import (get_earliest_survey_link,add_user_to_qualtrics,
    get_survey_user_list,invite_users,delete_invitations,lookup_emails,
    check_survey_status)

BASE_URL = '/new_surveys'

class QualtricsUserPanelID(Resource):
    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    @login_required
    def get(self,user_id):
        from flask_login import current_user
        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        if user_id:
            current_user = DBSession.query(IuserUser).filter(IuserUser.id==user_id).one()

        # This checks for existence before adding.
        result,user_panel_id = add_user_to_qualtrics(current_user)
        if result:
            return {'success':True,'qualtrics_panel_member_id':user_panel_id}

        return {'success':False,'result':pprint.pformat(user_panel_id)}
            

class QualtricsSurveyLinks(Resource):
    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    @login_required
    def get(self,user_id=None):
        from flask_login import current_user
        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        if user_id:
            current_user = DBSession.query(IuserUser).filter(IuserUser.id==user_id).one()

        persona = get_persona_obj_for_user(current_user.id,ignore_match_status=True)
        if not persona:
            # Super admins have no persona.
            return {'success':False,'link':None}

        # if user has no outstanding surveys to take, link is null.
        survey_desc,link = get_earliest_survey_link(current_user,persona,get_name=True)

        if link:
            return {'success':True,'link':link,'description':survey_desc}

        return {'success':False,'link':None}


@app.route('{0}/csv_user_data/'.format(BASE_URL),methods=['OPTIONS','POST'])
@login_required
def qualtrics_streamed_csv():
    from flask_login import current_user
    if LOGIN_DISABLED:
        current_user = DBSession.query(IuserUser).filter(
            IuserUser.id==DEFAULT_TEST_USER_ID).one()

    if request.method == 'OPTIONS':
        if ENV_TYPE != "Production":
            resp = Response('', status=200, mimetype='application/json')
            return resp

    elif request.method == 'POST':
        print "POST args: %s" % pprint.pformat(request.json)
        post_args = request.get_json(force=True)

        # rough validation
        for p in post_args['partner_ids']:
            int(p)

        post_args['csv_download'] = True

        result = get_survey_user_list(post_args,1,1) # page info ignored for csv,

        def generate():
            yield '"sep=|"\nUser Id|First Name|Last Name|Email|User Type|Grade|Graduating Class|School|User Status|Match Status|Partner ID|Application Status|Survey User ID|Survey ID|Survey Description|Survey Status\n'
            for r in result:
                yield '{0}|{1}|{2}|{3}|{4}|{5}|{6}|{7}|{8}|{9}|{10}|{11}|{12}|{13}|{14}|{15}\n'.format(
                    r[4].id,r[4].first_name.encode('ascii', 'ignore'),
                    r[4].last_name.encode('ascii', 'ignore'),
                    r[4].email,USERTYPE_MAP[r[3].usertype_id],
                    r[5].grade if r[5] else None,r[5].graduating_class if r[5] else None,
                    r[5].school if r[5] else None,USER_STATUS_MAP[r[4].status],
                    MATCH_CHOICES[r[1].match_status],r[7].id,
                    True if r[4].status != USER_STATUS_APPLICATION_INCOMPLETE else False,
                    r[1].qualtrics_panel_member_id,
                    r[6].id if r[6] else None,
                    r[6].survey.description if r[6] else None,
                    QUALTRICS_STATUS_MAP[r[6].survey_status] if r[6] else QUALTRICS_STATUS_MAP[QUALTRICS_NOT_INVITED]
                    )

        #resp = Response(stream_with_context(generate()))
        # File name is overridden in Angular. This one is ignored.
        resp = Response(generate())
        resp.mimetype='text/csv'
        resp.headers['Content-Disposition'] = 'attachment;filename=SurveyResults.csv'
        resp.headers['Cache-Control'] = 'must-revalidate, post-check=0, pre-check=0'
        '''
        resp.content_type='application/csv'
        resp.headers['Content-Description'] = 'File Transfer'
        resp.headers['Cache-Control'] = 'must-revalidate, post-check=0, pre-check=0'
        resp.headers['Content-Disposition'] = 'attachment;filename=SurveyResults.csv'
        '''
        return resp


class QualtricsSurveyStatus(Resource):
    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    @login_required
    def post(self,page_size=200,page=1):
        from flask_login import current_user
        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        print "POST args: %s" % pprint.pformat(request.json)
        post_args = request.get_json(force=True)

        # This is the internal DB ID of the survey, not the survey string.
        return check_survey_status(post_args['survey_id'],post_args['user_ids'],current_user)


class QualtricsUserData(Resource):
    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    '''
    Test only.
    @login_required
    def get(self,page_size=200,page=1):
        from flask_login import current_user
        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        test_ids = [310,360,166,167,121,457,314,458,263,506,732,410,257,361,262,362,459,752,365,230,251,363,127,460,364,1078,1079,1110,1111,1142,1143,46,92,153,618,461,143,576,462,507,463,508,198,464,733,509,742,465,1015,1047,1174]

        return get_survey_user_list(post_args={'partner_ids':test_ids},page_size=page_size,page=page)
    '''


    @login_required
    def post(self,page_size=200,page=1):
        from flask_login import current_user
        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        role = Role(current_user.id)
        if not role.is_some_admin:
            abort(403)

        page_size = 1000 if page_size > 1000 else page_size

        print "POST args: %s" % pprint.pformat(request.json)
        post_args = request.get_json(force=True)

        if 'partner_ids' not in post_args or not post_args['partner_ids']:
            if 'external_email' in post_args:
                return lookup_emails(post_args,current_user)
            else:
                return []

        if 'invite' in post_args:
            invite_users(post_args,current_user)
        elif 'uninvite' in post_args:
            delete_invitations(post_args,current_user)

        # rough validation
        for p in post_args['partner_ids']:
            int(p)

        result = get_survey_user_list(post_args,page_size,page)

        if not result:
            return []

        return result


# Use response endpoint
api.add_resource(QualtricsUserData, '{0}/user_data/size/<int:page_size>/page/<int:page>/'.format(BASE_URL),
    endpoint='qualtrics_user_data')

api.add_resource(QualtricsSurveyStatus, '{0}/survey_status/'.format(BASE_URL),
    endpoint='qualtrics_user_survey_statuses')

api.add_resource(QualtricsSurveyLinks, '{0}/survey_link/'.format(BASE_URL),
    endpoint='qualtrics_user_survey_link')


@app.route(BASE_URL + "/")
def qualtrics_home():

    from flask_login import current_user
    if LOGIN_DISABLED:
        current_user = DBSession.query(IuserUser).filter(
            IuserUser.id==DEFAULT_TEST_USER_ID).one()

    # Only admins are allowed in.
    if hasattr(current_user,'id'):
        role = Role(current_user.id)
        if not role.is_some_admin:
            abort(403)

        return render_template("qualtrics/index.html",CDN_URL=CDN_PREFIX)

    return redirect("/")

