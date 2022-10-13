# -*- coding: iso8859-15 -*-
import pprint
import copy
import os,sys
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import db,Base,metadata,DBSession,get_scoped_session
from config.settings import ENV_TYPE,LOGIN_DISABLED,DEFAULT_TEST_USER_ID

from college_checklist import cchklist
from college_checklist.models import (UtilsCollege, 
    CollegeChecklist, CollegeCategory, YES, NO)
from legacy_models.iuser import IuserUser


from flask import Response, jsonify, make_response
from flask import  current_app, request, redirect, render_template
from flask.views import View, MethodView
from flask_sqlalchemy import SQLAlchemy
from  sqlalchemy.sql.expression import func, or_, not_, and_
from flask_login import (current_user,
                             login_user, logout_user, UserMixin,
                             confirm_login, fresh_login_required)
from flask_restful import Resource, Api, fields, marshal_with, reqparse

from auth import app,api,login_required
from checklist_utils import get_mentee_for_mentor,get_current_selections

CCHOICES = '/cchklist/picks'

class UserMismatchException(Exception):
    pass

class CrashTestDummy(Resource):
    def get(self):
        app.logger.error("Woo! I'm an exception!")
        raise Exception("Woo! I'm an exception!")

class ChoiceCategoryView(Resource):

    categories = {
        'id':  fields.Integer,
        'ordinal':fields.Integer,
        'name':fields.String
        }


    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp


    @login_required
    @marshal_with(categories)
    def get(self):
        from flask_login import current_user
        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        return DBSession.query(CollegeCategory).all()


class CollegeChecklistView(Resource):
    '''
    These are the student's college selections from the college list,
    with all other parameters.
    '''

    '''
[
    {
        "category_id": 2,  #target/safety/reach? foreign key
        "app_completion": 1, 
        "app_deadline": "2015-03-01", 
        "app_review": 1, 
        "app_submission": "2015-01-31", 
        "essay_submission": 1, 
        "fafsa_submission": 3, 
        "fee_payment": 2, 
        "recommendation_submission": 2, 
        "test_submission": 2, 
        "transcript_submission": 3
        "choice": 1, # going?
        "college": {
            "id": 101, 
            "name": "Middlebury College"
        }, 
        "id": 2,      # Checklist ID
        "result": 3,  #accepted?
        "user_id": 1201
    }
]   
    '''
    college_fields = {
        'id':  fields.Integer,
        'name':fields.String
        }

    checklist_fields = {
        # Checklist fields
        'id':                      fields.Integer,
        'app_deadline':            fields.String,
        'app_completion':          fields.Integer,
        'app_review':              fields.Integer,
        'app_submission':          fields.String,
        'fee_payment':             fields.Integer,
        'transcript_submission':   fields.Integer,
        'test_submission':         fields.Integer,
        'essay_submission':        fields.Integer,
        'recommendation_submission':fields.Integer,
        'fafsa_submission':        fields.Integer,
        'college':                 fields.Nested(college_fields),
        'category_id':             fields.Integer,
        'result':                  fields.Integer,
        'choice':                  fields.Integer
        }


    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp


    @login_required
    @marshal_with(checklist_fields)
    def get(self):

        from flask_login import current_user
        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        #print("request: {0}".format(pprint.pformat(request.__dict__)))
        
        '''
        This will throw a 404 if there is no mentee for the
        logged in mentor.
        '''
        act_on_user = get_mentee_for_mentor(current_user)

        #print "Current user: {0}, acting on user: {1}".format(current_user.id,act_on_user.id)

        return get_current_selections(act_on_user)


    @login_required
    def post(self):
        from flask_login import current_user
        local_db_session = get_scoped_session()

        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        #print("request: {0}".format(pprint.pformat(request.__dict__)))

        '''
        This will throw a 404 if there is no mentee for the
        logged in mentor.
        '''
        act_on_user = get_mentee_for_mentor(current_user)

        #print "Current user: {0}, acting on user: {1}".format(current_user.id,act_on_user.id)

        #print "POST args: %s" % pprint.pformat(request.json)
        post_args = request.json
        outbound = {}

        # Remove front end debugging field(s).
        if 'error' in post_args:
            del post_args['error']

        if 'id' in post_args:

            # This isn't updated, and causes a sqlalchemy unconsumed error.
            college = post_args['college']
            del post_args['college']

            do_check = DBSession.query(CollegeChecklist).filter(
                CollegeChecklist.id==post_args['id']).first()
            if do_check.user_id != act_on_user.id:
                raise UserMismatchException(
                    "Existing record belongs to a different user. Bye bye.")

            local_db_session.query(CollegeChecklist).filter(
                CollegeChecklist.id==post_args['id']).update(post_args)

            local_db_session.commit()

            return {"success":True}

        else:
            existing_selection = DBSession.query(CollegeChecklist).filter(
                CollegeChecklist.college_id==post_args['college']['id'],
                CollegeChecklist.user_id==act_on_user.id
                ).first()

            if existing_selection:

                college = post_args['college']
                del post_args['college']

                local_db_session.query(CollegeChecklist).filter(
                    CollegeChecklist.college_id==college['id'],
                    CollegeChecklist.user_id==act_on_user.id
                    ).update(post_args)

            else:
                if 'app_completion' not in post_args or not post_args['app_completion']:
                    post_args['app_completion'] =  0
        
                if 'app_review' not in post_args or not post_args['app_review']:
                    post_args['app_review'] =  0
        
                if 'fee_payment' not in post_args or not post_args['fee_payment']:
                    post_args['fee_payment'] =  0
        
                if 'transcript_submission' not in post_args or not post_args['transcript_submission']:
                    post_args['transcript_submission'] =  0

                if 'recommendation_submission' not in post_args or not post_args['recommendation_submission']:
                    post_args['recommendation_submission'] =  0

                if 'test_submission' not in post_args or not post_args['test_submission']:
                    post_args['test_submission'] =  0

                if 'essay_submission' not in post_args or not post_args['essay_submission']:
                    post_args['essay_submission'] =  0

                if 'fafsa_submission' not in post_args or not post_args['fafsa_submission']:
                    post_args['fafsa_submission'] =  0

                if 'result' not in post_args or not post_args['result']:
                    post_args['result'] = 0 # unknown

                if 'choice' not in post_args or not post_args['choice']:
                    post_args['choice'] = 0 # unknown

                if 'category_id' not in post_args or not post_args['category_id']:
                    post_args['category_id'] = None

                college_id = post_args['college']['id']

                del post_args['college']
                checklist = CollegeChecklist(**post_args)
                checklist.college_id = college_id
                checklist.user_id = act_on_user.id
                local_db_session.add(checklist)

                local_db_session.flush()

                outbound['id'] = checklist.id

            local_db_session.commit()

            outbound['success'] = True
            return outbound


    @login_required
    def delete(self,pick_id):
        from flask_login import current_user

        local_db_session = get_scoped_session()
        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        '''
        This will throw a 404 if there is no mentee for the
        logged in mentor.
        '''
        act_on_user = get_mentee_for_mentor(current_user)

        curr_pick = None
        local_db_session.query(CollegeChecklist).filter(
            CollegeChecklist.id==pick_id).filter(
            CollegeChecklist.user_id==act_on_user.id).delete()

        local_db_session.commit()

        return {'success':True}


# This is ignoring the Blueprint app prefix.
api.add_resource(CollegeChecklistView, 
    '{0}/'.format(CCHOICES),
    endpoint='checklist')

api.add_resource(ChoiceCategoryView, 
    '{0}/choices/'.format(CCHOICES),
    endpoint='choices')

api.add_resource(CollegeChecklistView, 
    '{0}/pick/<int:pick_id>/'.format(CCHOICES),
    endpoint='delete_checklist')

api.add_resource(CrashTestDummy, 
    '{0}/crash20109498123978553/'.format(CCHOICES),
    endpoint='crash_cchklist')

