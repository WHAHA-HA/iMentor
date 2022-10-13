# -*- coding: iso8859-15 -*-
import pdb
import pprint
import copy
import os,sys
import pymongo
from datetime import datetime
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import (Base,metadata,
    DBSession,get_scoped_session)
from config.settings import (ENV_TYPE,LOGIN_DISABLED,
    DEFAULT_TEST_USER_ID,MONGO_HOST,MONGO_PORT,
    MONGO_DBNAME_DEBUG, MONGO_FORMS_DEBUG_COLLNAME,CDN_PREFIX)

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

from apiforms import forms # app name
from apiforms.models import *

from legacy_models.iuser import (IuserUser,IuserEmployer,
    IuserPersona,USER_STATUS_SCREENING_INCOMPLETE)
from legacy_models.utils import UtilsState,UtilsCountry
from legacy_models.member import MemberMember
from college_checklist.models import UtilsCollege
from sqlalchemy.sql import select

from user_response_utils import (toggle_user_question_visbility,
    UserRetrievalServices,eval_user_response,check_form_authz,
    check_all_required_fields)
from utils.authz import check_authz

from form_proc_and_notify import FormDataProcessing
from new_platform.utils.roles import Role
from new_platform.generic.generic_utils import generic_user_info

mongo_connection = pymongo.mongo_client.MongoClient(MONGO_HOST,MONGO_PORT)
database = pymongo.database.Database(mongo_connection,MONGO_DBNAME_DEBUG)
forms_debug_coll = database[MONGO_FORMS_DEBUG_COLLNAME]

BASE_URL = "/forms"
COMPLETE_URL = "/forms_complete"

user_data = UserRetrievalServices()

form_data_proc = FormDataProcessing()

         

class UserFormServices(Resource):
    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    @login_required
    def get(self, form_id, section_id=None, question_id=None, answer_id=None, recurse='true', user_id=None):

        from flask_login import current_user
        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        current_user,form_copy = check_form_authz(current_user,user_id,form_id)

        if not form_copy:
            return abort(404)

        recurse = json.loads(recurse)
        nested_dict = {}

        nested_dict['form'] = user_data._get_form(form_id, current_user.id)
        if not nested_dict['form']:
            app.logger.warning("User {0} tried to get to form {1} which isn't their form. We sent them to /messages/list/.".format(
               current_user.email,form_id
               ))
            return abort(404)

        if recurse == True:
            if (section_id is None):
                #print "inside of section_id if statement"
                nested_dict = user_data._assemble_nested_dict(
                    current_user.id, nested_dict, form_id, 
                    section_id=None, question_id=None, answer_id=None)
                return nested_dict

            elif (question_id is None): # One section ID provided
                #print "inside of question_id if statement"
                nested_dict = user_data._assemble_nested_dict(
                    current_user.id, nested_dict, form_id, 
                    section_id=section_id, question_id=None, answer_id=None)
                return nested_dict

            elif (answer_id is None): # One section, one question
                #print "inside of answer_id if statement"
                nested_dict = user_data._assemble_nested_dict(
                    current_user.id, nested_dict, form_id, 
                    section_id=section_id, question_id=question_id, 
                    answer_id=None)
                if nested_dict and (not nested_dict['form']['sections'][0]['questions']):
                    abort(404)
                    
                return nested_dict

            else:
                # when specific endpoints for each category is hit
                nested_dict = user_data._assemble_nested_dict(
                    current_user.id, nested_dict, form_id, 
                    section_id=section_id, \
                    question_id=question_id, answer_id=answer_id)
                if nested_dict and ((not nested_dict['form']['sections'][0]['questions']) \
                    or (not nested_dict['form']['sections'][0]['questions'][0]['answers'])):
                        abort(404)
                    
                return nested_dict

        else:
            #print "non-recursive mode"
            if section_id:
                nested_dict['form']['sections'] = user_data._get_all_sections_for_form(
                    form_id=form_id, section_id=section_id)  # get section
                if (not nested_dict['form']['sections']): 
                    abort(404)
                    

            if question_id:
                for section in nested_dict['form']['sections']:  # get question
                    section['questions'] = user_data._get_all_questions_for_section(
                        section_id=section_id, question_id=question_id)
                if (not nested_dict['form']['sections'][0]['questions']):
                    abort(404)
                    
            return nested_dict



class UserResponseHandler(Resource):

    '''
    Don't pass ID. User repsonses are removed and then added.
    '''
    user_response_struct = {
        # Checklist fields
        #'id':                      fields.Integer,
        #'user_id':                 fields.Integer, user is logged-in user.
        'question_id':             fields.Integer,
        'answer_id':               fields.Integer,
        'user_response':           fields.String
        }

    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp


    @login_required
    @marshal_with(user_response_struct)
    def get(self,form_id,section_id,question_id,user_id=None):

        from flask_login import current_user
        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        current_user,form_copy = check_form_authz(current_user,user_id,form_id)

        if not form_copy:
            return abort(404)

        question = DBSession.query(QuestionCopy).filter(and_(
          QuestionCopy.id == question_id, 
          QuestionCopy.user_id == current_user.id
          )
        ).first()

        if not question:
            abort(404)

        return user_data._get_user_response_for_question(
            question_id,current_user.id
            )

    @login_required
    def delete(self,form_id,section_id,question_id,user_id=None):
        # This deletes the user response related to the question,
        # not the question!

        from flask_login import current_user
        local_db_session = get_scoped_session()

        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        current_user,form_copy = check_form_authz(current_user,user_id,form_id)

        if not form_copy:
            return abort(404)

        current_response = DBSession.query(UserResponse).filter(
            and_(
                UserResponse.question_id == question_id,
                UserResponse.user_id == current_user.id
                )
            ).first()
        if current_response:
            local_db_session.query(UserResponse).filter(
                UserResponse.id==current_response.id).delete()
            local_db_session.commit()
            return {'success':True}

        return {'success':True,'error':'Record not found, but this is not treated like an error.'}


    @login_required
    def post(self,form_id,section_id,question_id,user_id=None):

        from flask_login import current_user
        local_db_session = get_scoped_session()

        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        current_user,form_copy = check_form_authz(current_user,user_id,form_id)

        if not form_copy:
            return abort(404)

        question = DBSession.query(QuestionCopy).filter(and_(
            QuestionCopy.id == question_id, 
            QuestionCopy.user_id == current_user.id)).first()

        if not question:
            abort(404)

        post_args = request.get_json(force=True)
        print "Post Args: {0}".format(post_args)

        user_response = post_args['user_response']['user_response'] \
            if 'user_response' in post_args['user_response'] else None

        post_q_id = post_args['user_response']['question_id']
        if post_q_id != question_id:
            app.logger.exception("Inbound question id for Form POST: {0} doesn't match posted question id: {1}, returning JSON error. Request: {2}".format(
                question_id,post_q_id ,pprint.pformat(request)))
            return {'success':False,'error':"Inbound question id for Form POST: {0} doesn't match posted question id: {1}".format(question_id,post_q_id)}

        answer_id = post_args['user_response']['answer_id'] \
          if 'answer_id' in post_args['user_response'] else None

        if answer_id == 0:
            answer_id = None

        current_response = DBSession.query(UserResponse).filter(
            and_(
                UserResponse.question_id == question_id,
                UserResponse.user_id == current_user.id
                )
            ).first()

        error,user_response,answer_id,external_table_id = \
            eval_user_response(
            current_user.id,form_id,user_response,
            question_id,answer_id
            )

        if error:
            try:
                local_db_session.expunge(current_response)
            except:
                pass
            return error

        new_user_response = UserResponse(
            user_id = current_user.id,
            question_id = question_id,
            answer_id = answer_id,
            selected_id = external_table_id,
            user_response = user_response
            )

        #print "User response: {0}".format(user_response)

        '''
        Delete old response after new one is submitted.
        Much easier than trying to merge responses.
        '''
        if current_response:
            local_db_session.query(UserResponse).filter(
                UserResponse.id==current_response.id).delete()

        local_db_session.add(new_user_response)

        local_db_session.commit()
        local_db_session.begin()

        # If on behalf of user, immediately update.
        if user_id:
            question = DBSession.query(QuestionCopy).filter(QuestionCopy.id==question_id).one()
            section = DBSession.query(SectionCopy).filter(SectionCopy.id==question.section_id).one()
            form_copy = DBSession.query(FormCopy).filter(FormCopy.id==section.form_id).one()
            persona = DBSession.query(IuserPersona).filter(
               IuserPersona.id==form_copy.persona_id).one()

            form_data_proc.push_app_form_value(local_db_session,
                form_copy,current_user,persona,question)


        question_hide_list = toggle_user_question_visbility(
            local_db_session,
            form_id=form_id,
            question=question,
            user_response=new_user_response)

        local_db_session.commit()

        # Debug data
        post_args['user_id'] = current_user.id
        post_args['obo_user_id'] = user_id
        post_args['outbound_question_hide_list'] = question_hide_list
        # forms_debug_coll.insert(post_args)

        return {'success': True, 'hide':question_hide_list}


class UserFormComplete(Resource):
    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    @login_required
    def post(self, form_id,user_id=None):
        from flask_login import current_user
        local_db_session = get_scoped_session()

        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        current_user,form_copy = check_form_authz(current_user,user_id,form_id)

        if not form_copy:
            return abort(404)

        local_db_session.query(FormCopy).filter(
            FormCopy.user_id == current_user.id).filter(
            FormCopy.id == form_id).update({
                'form_was_completed':True,
                'form_was_completed_datetime':datetime.now()
                })

        local_db_session.commit()
        local_db_session.begin()

        # if application, and user is done, update user table.
        # Don't overwrite existing values with blank.
        if form_copy.form_data_type == APPLICATION:
            local_db_session.query(IuserUser).filter(
                IuserUser.id==current_user.id).update({
                'status':USER_STATUS_SCREENING_INCOMPLETE})

        # Don't do this in OBO mode.
        if not user_id:
            check_all_required_fields(form_copy,current_user)

        local_db_session.commit()

        form_data_proc.pushQ(current_user.id,form_copy.id) 
        
        return {'success':True}

# ==================================
class UserHiddenQuestions(Resource): # for testing purposes only
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

        current_user,form_copy = check_form_authz(current_user,user_id,form_id)

        if not form_copy:
            return abort(404)

        questions = DBSession.query(QuestionCopy).filter(or_(
            QuestionCopy.is_active == False,
            QuestionCopy.is_visible == False,
            )).all()

        question_list = []
        for question in questions:
            question = question.__dict__
            del question['_sa_instance_state']
            question_list.append(question)
            question['answers'] = []
            for answer in DBSession.query(AnswerCopy).filter(AnswerCopy.question_id==question['id']).all():
                answer = answer.__dict__
                del answer['_sa_instance_state']
                question['answers'].append(answer)
        return question_list


# ======== For User Interface: Recurse
api.add_resource(UserFormComplete, '{0}/form/<int:form_id>/'.format(COMPLETE_URL),
    endpoint='user_interface_form_complete')

api.add_resource(UserFormComplete, '{0}/form/<int:form_id>/<int:user_id>/'.format(COMPLETE_URL),
    endpoint='user_interface_form_complete_obo_user')

api.add_resource(UserFormServices, '{0}/form_gen/<int:form_id>/'.format(BASE_URL),
    endpoint='user_interface_form_recurse_true')

api.add_resource(UserFormServices, '{0}/form_gen/<int:form_id>/<int:user_id>/'.format(BASE_URL),
    endpoint='user_interface_form_recurse_true_obo_user')


api.add_resource(UserFormServices, '{0}/form_gen/<int:form_id>/section/<int:section_id>/'.format(BASE_URL),
    endpoint='user_interface_section_recurse_true')

api.add_resource(UserFormServices, '{0}/form_gen/<int:form_id>/section/<int:section_id>/<int:user_id>/'.format(BASE_URL),
    endpoint='user_interface_section_recurse_true_obo_user')


api.add_resource(UserFormServices,
    '{0}/form_gen/<int:form_id>/section/<int:section_id>/question/<int:question_id>/'.format(BASE_URL),
    endpoint='user_interface_question_recurse_true')

api.add_resource(UserFormServices,
    '{0}/form_gen/<int:form_id>/section/<int:section_id>/question/<int:question_id>/<int:user_id>/'.format(BASE_URL),
    endpoint='user_interface_question_recurse_true_obo_user')

#======= Saving this part for Admin functionality on the Copy
api.add_resource(UserFormServices,
    '{0}/form_gen/<int:form_id>/section/<int:section_id>/question/<int:question_id>/answer/<int:answer_id>/'.format(BASE_URL),
    endpoint='user_interface_answer_recurse_true')

api.add_resource(UserFormServices,
    '{0}/form_gen/<int:form_id>/section/<int:section_id>/question/<int:question_id>/answer/<int:answer_id>/<int:user_id>/'.format(BASE_URL),
    endpoint='user_interface_answer_recurse_true_obo_user')

# ======== For User Interface: Non-Recurse
api.add_resource(UserFormServices, '{0}/form_gen/<int:form_id>/recurse/<string:recurse>/'.format(BASE_URL),
    endpoint='user_interface_form_recurse_false')

api.add_resource(UserFormServices, '{0}/form_gen/<int:form_id>/recurse/<string:recurse>/<int:user_id>/'.format(BASE_URL),
    endpoint='user_interface_form_recurse_false_obo_user')


api.add_resource(UserFormServices, '{0}/form_gen/<int:form_id>/section/<int:section_id>/recurse/<string:recurse>/'.format(BASE_URL),
    endpoint='user_interface_section_recurse_false')

api.add_resource(UserFormServices, '{0}/form_gen/<int:form_id>/section/<int:section_id>/recurse/<string:recurse>/<int:user_id>/'.format(BASE_URL),
    endpoint='user_interface_section_recurse_false_obo_user')


api.add_resource(UserFormServices,
    '{0}/form_gen/<int:form_id>/section/<int:section_id>/question/<int:question_id>/recurse/<string:recurse>/'.format(BASE_URL), 
    endpoint='user_interface_question_recurse_false')

api.add_resource(UserFormServices,
    '{0}/form_gen/<int:form_id>/section/<int:section_id>/question/<int:question_id>/recurse/<string:recurse>/<int:user_id>/'.format(BASE_URL), 
    endpoint='user_interface_question_recurse_false_obo_user')

# For hidden questions
#api.add_resource(UserHiddenQuestions, '{0}/questions/hidden/'.format(BASE_URL),
#   endpoint='copy_question_hidden')

# Use response endpoint
api.add_resource(UserResponseHandler, '{0}/form/<int:form_id>/section/<int:section_id>/question/<int:question_id>/user_response/'.format(BASE_URL),
    endpoint='user_response')

api.add_resource(UserResponseHandler, '{0}/form/<int:form_id>/section/<int:section_id>/question/<int:question_id>/user_response/<int:user_id>/'.format(BASE_URL),
    endpoint='user_response_obo_user')


# forms landing page
@app.route(BASE_URL + '/debug/')
def forms_home_debug():
    from flask_login import current_user

    if LOGIN_DISABLED:
        current_user = DBSession.query(IuserUser).filter(
            IuserUser.id==DEFAULT_TEST_USER_ID).one()

    if hasattr(current_user,'id'):
        return render_template("apiforms/form_home_debug.html",CDN_URL=CDN_PREFIX)

    return redirect("/")

# forms optimized landing page
@app.route(BASE_URL + '/')
def forms_home():
    from flask_login import current_user

    if LOGIN_DISABLED:
        current_user = DBSession.query(IuserUser).filter(
            IuserUser.id==DEFAULT_TEST_USER_ID).one()

    if hasattr(current_user,'id'):
        return render_template("apiforms/form_home.html",CDN_URL=CDN_PREFIX)

    return redirect("/")

@app.route(BASE_URL + '/two/')
def forms_home2():
    return forms_home()

# This is called by legacy code, in imentor/iuser/views.py
@app.route(BASE_URL + '/obo_forms/<user_id>/')
def forms_on_behalf_of(user_id):
    from flask_login import current_user

    if LOGIN_DISABLED:
        current_user = DBSession.query(IuserUser).filter(
            IuserUser.id==DEFAULT_TEST_USER_ID).one()

    if hasattr(current_user,'id'):
        if check_authz(current_user,user_id,replace_user=False):
            return render_template("apiforms/admin_form_home.html",
                user_id_from_flask=user_id,CDN_URL=CDN_PREFIX)

    return redirect("/")


# This is called by legacy code, in imentor/iuser/views.py
@app.route(BASE_URL + '/obo_forms/<user_id>/app_form/')
def app_forms_on_behalf_of(user_id):
    from flask_login import current_user

    if LOGIN_DISABLED:
        current_user = DBSession.query(IuserUser).filter(
            IuserUser.id==DEFAULT_TEST_USER_ID).one()

    if hasattr(current_user,'id'):
        if check_authz(current_user,user_id,replace_user=False):
            return render_template("apiforms/admin_form_home.html",
                user_id_from_flask=user_id,app_form='app_form',CDN_URL=CDN_PREFIX)

    return redirect("/")


# This is called by legacy code, in imentor/iuser/views.py
@app.route(BASE_URL + '/obo_forms/<user_id>/no_app_form/')
def missing_app_forms_on_behalf_of(user_id):
    from flask_login import current_user

    if LOGIN_DISABLED:
        current_user = DBSession.query(IuserUser).filter(
            IuserUser.id==DEFAULT_TEST_USER_ID).one()

    if hasattr(current_user,'id'):
        if check_authz(current_user,user_id,replace_user=False):
            return render_template("apiforms/admin_nonexistent_form_home.html",
                user_id_from_flask=user_id,app_form='no_app_form',CDN_URL=CDN_PREFIX)

    return redirect("/")

# This is called after form is complete.
@app.route('{0}/done/'.format(COMPLETE_URL))
def user_submitted_form():
    from flask_login import current_user
    if LOGIN_DISABLED:
        current_user = DBSession.query(IuserUser).filter(
            IuserUser.id==DEFAULT_TEST_USER_ID).one()

    if hasattr(current_user,'id'):
        return render_template("apiforms/app_submitted.html",CDN_URL=CDN_PREFIX)

    return redirect("/")
