# -*- coding: iso8859-15 -*-
import pdb
import pprint
import copy
import os,sys
import pymongo
import datetime
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'../..'))
nprojdir = os.path.abspath(os.path.join(appdir,'../../..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)
    sys.path.append(nprojdir)

from config.project_globals import db,Base,metadata,DBSession
from new_platform.audit import (audit_trail,DATA_REMOVE,DATA_ADD,
    DATA_NOCHG,DATA_ERROR,APPLICATION_DATA,FORM_DATA)

from config.settings import (ENV_TYPE,LOGIN_DISABLED,
    DEFAULT_TEST_USER_ID,MONGO_HOST,MONGO_PORT,
    MONGO_DBNAME_FORMS,MONGO_POP_FROM_FORM_COLLNAME,
    MONGO_FORM_NOTIFY_COLLNAME)

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

from qualtrics.models import *
from old_models import OldQualtricsInvites,OldQualtricsIDS
from utils.roles import Role
from qualtrics.qualtrics_3rd_party import _get_imentor_survey_list


from legacy_models.iuser import (IuserUser,IuserEmployer,
    IuserUserRacialgroup,IuserPersonaUserProgram,
    IuserEmployerMember, IuserPersona,
    USER_STATUS_SCREENING_INCOMPLETE,GENDER_CHOICES,
    USER_STATUS_APPLICATION_INCOMPLETE,
    MARITAL_STATUS_CHOICES,MENTEE,MENTOR)

from new_platform.utils import user_details
from legacy_models.member import MemberMember

I_MAP = {
    'Not Invited':1,
    'Invited':2,
    'Incomplete':3,
    'Completed':4,
    }

def move_data():
    qinfo = {}

    for record in _get_imentor_survey_list():
        qinfo[record['SurveyID']] = {
            'name':record['SurveyName'],
            'active':record['SurveyStatus'] == 'Active',
            'start_date':datetime.datetime.strptime(record['SurveyStartDate'], "%Y-%m-%d %H:%M:%S").date() if record['SurveyStartDate'][0] != '0' else None,
            'end_date':datetime.datetime.strptime(record['SurveyExpirationDate'], "%Y-%m-%d %H:%M:%S").date() if record['SurveyExpirationDate'][0] != '0' else None
            }

    for record in OldQualtricsIDS.query.all():
        liveinfo = None
        if record.survey_id in qinfo:
            liveinfo = qinfo[record.survey_id]
        if not liveinfo:
            print "We have a survey missing form Qualtrics, skipping record {0}".format(
                pprint.pformat(record.__dict__))
            continue

        user_type = MENTOR if record.distribution_id_mentor else MENTEE

        existing_record = QualtricsSurvey.query.filter(
            QualtricsSurvey.survey_string==record.survey_id).filter(
            QualtricsSurvey.user_type==user_type
            ).first()

        if existing_record:
            continue

        # No longer kept my member id, it will be null most of the time.
        new_record = QualtricsSurvey(
            description = liveinfo['name'] if liveinfo else None,
            member_id = None,
            library_string = record.library_id,
            panel_string = record.panel_id,
            distribution_string = record.distribution_id_mentor if record.distribution_id_mentor else record.distribution_id_mentee,
            survey_string = record.survey_id,
            user_type = MENTOR if record.distribution_id_mentor else MENTEE,
            start_date = liveinfo['start_date'] if liveinfo and liveinfo['start_date'] and liveinfo['start_date'] >= record.start_date else record.start_date,
            end_date = liveinfo['end_date'] if liveinfo and liveinfo['end_date'] and liveinfo['end_date'] >= record.end_date else record.end_date,
            survey_is_active = liveinfo['active']
            )
        print "new record: {0}".format(pprint.pformat(new_record.__dict__))

        db.session.add(new_record)
        db.session.commit()
    
    for record in OldQualtricsInvites.query.all():
        user_id = IuserPersona.query.filter(IuserPersona.id==record.persona_id).one().user_id
        role = Role(user_id).role
        #member_id = IuserUser.query.filter(IuserUser.id==user_id).one().member_id

        survey = QualtricsSurvey.query.filter(
            QualtricsSurvey.survey_string==record.survey_id
            ).filter(QualtricsSurvey.survey_string==record.survey_id
            #).filter(QualtricsSurvey.member_id==member_id
            ).filter(QualtricsSurvey.user_type==role
            ).one()

        new_record = QualtricsInvite(
            persona_id = record.persona_id,
            user_id = user_id,
            invited_by_user_id = int(record.invited_by) if record.invited_by else 164122,
            survey_id = survey.id,
            survey_status = I_MAP[record.survey_invitation_status] if survey.survey_is_active or record.survey_invitation_status == QUALTRICS_COMPLETE else QUALTRICS_INCOMPLETE,
            date_invited = record.date_invited,
            survey_link = record.survey_link
            )
        print "new record: {0}".format(pprint.pformat(new_record.__dict__))

        db.session.add(new_record)
        db.session.commit()
    
if __name__ == "__main__":
    print _get_imentor_survey_list()
    move_data()
