# -*- coding: iso8859-15 -*-
import pdb
import pprint
import copy
import os,sys
import math
from datetime import datetime
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

from enrollment import enrollment # app name
from new_platform.utils.user_status_type import adjust_user_status

from legacy_models.partners import PartnersPartner
from legacy_models.iuser import (USERTYPE_MAP,ACTIVE_PERSONA_STATUS,
    GENDER_CHOICES,MATCH_CHOICES,USER_STATUS_MAP,IuserPersonaPartner,
    USER_STATUS_APPLICATION_INCOMPLETE,
    IuserPersona,IuserUsertype,IuserAssignedusertype,IuserUser)
from qualtrics.models import (QualtricsInvite,QUALTRICS_STATUS_MAP,
    QUALTRICS_COMPLETE)

from new_platform.utils.roles import Role
from new_platform.utils import user_details
from enrollment.models import (MenteeReadinessSchool,SCHOOL_ATTENDANCE_VALUES,
    PROGRAM_READINESS_VALUES)
from enrollment_utils import _get_mentees_for_partners

BASE_URL = "/enrollment"


class EnrollmentMentees(Resource):

    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    '''
    #Test only
    @login_required
    def get(self,page_size=200,page=1):
        from flask_login import current_user
        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        test_ids = [2203,2204]

        return _get_mentees_for_partners(post_args={'partner_ids':test_ids},page_size=page_size,page=page)
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

        # rough validation
        for p in post_args['partner_ids']:
            int(p)

        result = []
        if post_args['partner_ids']:
            result = _get_mentees_for_partners(post_args,page_size,page)

        return result
 


class EnrollmentChanges(Resource):

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

        role = Role(current_user.id)
        if not role.is_some_admin:
            abort(403)

        print "POST args: %s" % pprint.pformat(request.json)
        post_args = request.get_json(force=True)

        if 'attendance' in post_args and post_args['attendance']:
            mr = MenteeReadinessSchool.query.filter(
                MenteeReadinessSchool.user_id==post_args['user_id']).first()
            if mr:
                MenteeReadinessSchool.query.filter(
                    MenteeReadinessSchool.user_id==post_args['user_id']).update(
                    {'school_attendance':post_args['attendance']})
            else:
                mr = MenteeReadinesssSchool(
                    user_id=post_args['user_id'],
                    school_attendance=post_args['attendance'])
                db.session.add(mr) 

        if 'readiness' in post_args and post_args['readiness']:
            mr = MenteeReadinessSchool.query.filter(
                MenteeReadinessSchool.user_id==post_args['user_id']).first()
            if mr:
                MenteeReadinessSchool.query.filter(
                    MenteeReadinessSchool.user_id==post_args['user_id']).update(
                    {'program_readiness':post_args['readiness']})
            else:
                mr = MenteeReadinesssSchool(
                    user_id=post_args['user_id'],
                    program_readiness=post_args['readiness'])
                db.session.add(mr) 

        db.session.commit()
        return adjust_user_status(post_args['user_id'])


@app.route('{0}/csv_user_data/'.format(BASE_URL),methods=['OPTIONS','POST'])
@login_required
def enrollment_streamed_csv():
    from flask_login import current_user
    if LOGIN_DISABLED:
        current_user = DBSession.query(IuserUser).filter(
            IuserUser.id==DEFAULT_TEST_USER_ID).one()

    role = Role(current_user.id)
    if not role.is_some_admin:
        abort(403)

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

        # Pages ignored for CSV download.
        result = _get_mentees_for_partners(post_args,1,1)

        def generate_csv():
            yield '"sep=|"\nUser Id|First Name|Last Name|Email|Gender|Application Status|Attendance|Program Readiness|Parental Consent|User Status|Match Status|Partner Name\n'
            for r in result:
                yield "{0}|{1}|{2}|{3}|{4}|{5}|{6}|{7}|{8}|{9}|{10}|{11}\n".format(
                    r[4].id,
                    r[4].first_name.encode('utf-8','ignore'),
                    r[4].last_name.encode('utf-8','ignore'),
                    r[4].email,
                    r[4].gender,
                    True if r[4].status != USER_STATUS_APPLICATION_INCOMPLETE else False,
                    SCHOOL_ATTENDANCE_VALUES[r[5].school_attendance] if r[5] else None,
                    PROGRAM_READINESS_VALUES[r[5].program_readiness] if r[5] else None,
                    r[4].mentee_consent_form,
                    USER_STATUS_MAP[r[4].status],
                    MATCH_CHOICES[r[1].match_status],
                    r[6].name.encode('ascii', 'ignore'))

        resp = Response(generate_csv())
        resp.mimetype='text/csv'
        resp.headers['Content-Disposition'] = 'attachment;filename=EnrollmentResults.csv'
        resp.headers['Cache-Control'] = 'must-revalidate, post-check=0, pre-check=0'
        return resp


# Use response endpoint
api.add_resource(EnrollmentMentees, '{0}/partner_mentees/size/<int:page_size>/page/<int:page>/'.format(BASE_URL),
    endpoint='partner_mentees')

api.add_resource(EnrollmentChanges, '{0}/update/'.format(BASE_URL),
    endpoint='update_data')



@app.route(BASE_URL + "/")
def enrollment_home():
    from flask_login import current_user
    if LOGIN_DISABLED:
        current_user = DBSession.query(IuserUser).filter(
            IuserUser.id==DEFAULT_TEST_USER_ID).one()

    if hasattr(current_user,'id'):
        role = Role(current_user.id)
        if not role.is_some_admin:
            abort(403)

        return render_template("enrollment/index.html",CDN_URL=CDN_PREFIX)

    return redirect("/")

