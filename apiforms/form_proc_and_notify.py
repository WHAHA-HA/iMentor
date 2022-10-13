# -*- coding: iso8859-15 -*-
import pdb
import pprint
import copy
import traceback
import os,sys
import pymongo
from datetime import datetime,timedelta
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import (Base,metadata,
    get_scoped_session,DBSession)

from config.settings import (ENV_TYPE,LOGIN_DISABLED,
    DEFAULT_TEST_USER_ID,MONGO_HOST,MONGO_PORT,
    MONGO_DBNAME_FORMS,MONGO_POP_FROM_FORM_COLLNAME,
    MONGO_FORM_NOTIFY_COLLNAME)

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

from apiforms import forms # app name
from apiforms.models import *
from apiforms.user_response_utils import ResponseServices

from legacy_models.iuser import (IuserUser,IuserEmployer,
    IuserUserRacialgroup,IuserPersonaUserProgram,
    IuserEmployerMember,
    USER_STATUS_SCREENING_INCOMPLETE,GENDER_CHOICES,
    USER_STATUS_APPLICATION_INCOMPLETE,
    MARITAL_STATUS_CHOICES)

from new_platform.utils import user_details
from legacy_models.utils import UtilsState,UtilsCountry
from legacy_models.member import MemberMember
from college_checklist.models import UtilsCollege
from sqlalchemy.sql import select

mongo_connection = pymongo.mongo_client.MongoClient(MONGO_HOST,MONGO_PORT)
database = pymongo.database.Database(mongo_connection,MONGO_DBNAME_FORMS)
forms_coll = database[MONGO_POP_FROM_FORM_COLLNAME]
notify_coll = database[MONGO_FORM_NOTIFY_COLLNAME]

uresp = ResponseServices()

class UnknownFormDataType(Exception):
    pass

class WrongUserException(Exception):
    pass

class FormNotifications(object):
    '''
    There's no "pop" here, it's done in django survey signals.
    '''
    def pushQ(self,persona_id,form_copy_id):
        data = {
            'persona_id':persona_id,
            'status':NOTIFY_APPLICATION_COMPLETE,
            'queue_date':datetime.now(),
            }

        # Returns Mongo object id
        return notify_coll.insert_one(data)


class FormDataProcessing(object):

    form_nots = FormNotifications()

    def pushQ(self,user_id,form_copy_id):
        data = {
            'user_id':user_id,
            'form_copy_id':form_copy_id,
            'error':False,
            'last_try':datetime.now(),
            }

        # Returns Mongo object id
        return forms_coll.insert_one(data)

    def push_app_form_value(self,local_db_session,form_copy,user,persona,q):
        # returns error, if one exists.
        q_error = None

        user_id = user.id
        text_array,resp,returned_structs = uresp.answer_lookup(user_id,q.id,return_struct=True)

        # This is terrible code. This mapping should be in a table.
        # But for applications, there are too many weird conditions.

        # All field validation and space stripping has happened by now.
        # No need to repeat it here.
        if resp:
            if q.question_type in (
                QUESTION_FREEFORM_TEXT,QUESTION_FREEFORM_CHAR) and \
                resp.user_response in ('',None) and \
                q.is_required and q.is_active:

                msg = \
                    "Missing required answer for question {0}, question text: {1}, user:{2}, form copy {3}".format(
                    q.id,q.question_text,user.email,form_copy.id)
                app.logger.info(msg)

                q_error = msg

            if q.question_type in (
                QUESTION_SINGLE_SELECT_TOGGLE,
                QUESTION_SINGLE_SELECT_RADIO,
                QUESTION_DROPDOWN) and \
                not text_array and \
                q.is_required and q.is_active:

                msg = \
                    "Missing required answer for question {0}, question text: {1}, user:{2}, form copy {3}".format(
                    q.id,q.question_text,user.email,form_copy.id)
                app.logger.info(msg)

                q_error = msg

            elif q.question_type == QUESTION_RACIAL_GROUP:
                existing_obj = DBSession.query(IuserUserRacialgroup).filter(
                    IuserUserRacialgroup.user_id==q.user_id).filter(
                    IuserUserRacialgroup.racialgroup_id.notin_(
                    resp.user_response['rgroups']))

                if existing_obj.count() > 0:
                    for existing in existing_obj.all():
                        local_db_session.query(IuserUserRacialgroup).filter(
                            IuserUserRacialgroup.id==existing.id).delete()

                        existing_d = existing.__dict__
                        if '_sa_instance_state' in existing_d:
                            del existing_d['_sa_instance_state']

                    local_db_session.commit()
                    local_db_session.begin()
                   
                matching_ids = [x.racialgroup_id for x in DBSession.query(IuserUserRacialgroup).filter(
                    IuserUserRacialgroup.user_id==q.user_id).filter(
                    IuserUserRacialgroup.racialgroup_id.in_(
                    resp.user_response['rgroups']))]

                for i in resp.user_response['rgroups']:
                    if i not in matching_ids:
                        irg = IuserUserRacialgroup(
                            user_id=q.user_id,
                            racialgroup_id=i)

                        local_db_session.add(irg)
                        local_db_session.commit()
                        irg_d = copy.deepcopy(irg.__dict__)
                        if '_sa_instance_state' in irg_d:
                            del irg_d['_sa_instance_state']
                        local_db_session.begin()

            elif q.question_type == QUESTION_PARTNER_PROGRAM:

                existing_obj = DBSession.query(IuserPersonaUserProgram).filter(
                    IuserPersonaUserProgram.persona_id==persona.id).filter(
                    IuserPersonaUserProgram.userprogram_id.notin_(
                    resp.user_response['mprograms']))

                if existing_obj.count() > 0:
                    for existing in existing_obj.all():
                        local_db_session.query(IuserPersonaUserProgram).filter(
                            IuserPersonaUserProgram.id == existing.id).delete()

                        existing_d = existing.__dict__
                        if '_sa_instance_state' in existing_d:
                            del existing_d['_sa_instance_state']

                    local_db_session.commit()
                    local_db_session.begin()
                   
                matching_ids = [x.userprogram_id for x in DBSession.query(IuserPersonaUserProgram).filter(
                    IuserPersonaUserProgram.persona_id==persona.id).filter(
                    IuserPersonaUserProgram.persona_id.in_(
                    resp.user_response['mprograms']))]

                for i in resp.user_response['mprograms']:
                    if i not in matching_ids:
                        ipr = IuserPersonaUserProgram(
                            persona_id=persona.id,
                            userprogram_id=i)

                        local_db_session.add(ipr)
                        local_db_session.commit()
                        ipr_d = copy.deepcopy(ipr.__dict__)
                        if '_sa_instance_state' in ipr_d:
                            del ipr_d['_sa_instance_state']
                        local_db_session.begin()

            elif q.question_type in (QUESTION_DROPDOWN_EMPLOYERS,
                QUESTION_DROPDOWN_EMPLOYERS_TYPE2):

                local_db_session.query(IuserUser).filter(IuserUser.id==user_id).update({
                    'employer_id':resp.selected_id})
                local_db_session.commit()
                local_db_session.begin()

            elif q.question_type == QUESTION_CAREER_OCCUPATION:

                local_db_session.query(IuserUser).filter(IuserUser.id==user_id).update({
                    'occupation_id':resp.user_response['occupations'][0],
                    'career_id':resp.user_response['career_id']})
                local_db_session.commit()
                local_db_session.begin()


            elif q.question_type == QUESTION_DATETIME and \
                q.parent_id in [x.id for x in DBSession.query(Question).filter(and_(
                Question.question_type.notin_(
                    [QUESTION_HEADING,QUESTION_INSTRUCTIONS]),
                Question.question_text.ilike('What is your birthday%')
                )).all()]:
                    bday = datetime(month=resp.user_response['month'],
                        day=resp.user_response['day'],
                        year=resp.user_response['year'],
                        hour=0,minute=0,second=0)
                    local_db_session.query(IuserUser).filter(IuserUser.id==user_id).update(
                        {'date_of_birth':bday})
                    local_db_session.commit()
                    local_db_session.begin()


            elif q.question_type == QUESTION_PHONE:

                if q.parent_id in [x.id for x in DBSession.query(Question).filter(and_(
                    Question.question_type.notin_(
                        [QUESTION_HEADING,QUESTION_INSTRUCTIONS]
                        ),
                    not_(Question.question_text.ilike('%Parent%')),
                    Question.question_text.ilike('%primary%'),
                    Question.question_text.ilike('%phone%')
                    )).all()]:

                    if resp.user_response in (None,''):
                        msg = 'Home phone added by user was blank/None, ignored. This user has no home phone info. User response id: {0}, response: {1}'.format(
                            resp.id,resp.user_response)

                        q_error = msg
                        app.logger.info(msg)

                    else:
                        local_db_session.query(IuserUser).filter(IuserUser.id==user_id).update(
                            {'home_phone':resp.user_response})
                        local_db_session.commit()
                        local_db_session.begin()

                elif q.parent_id in [x.id for x in DBSession.query(Question).filter(and_(
                    Question.question_type.notin_(
                        [QUESTION_HEADING,QUESTION_INSTRUCTIONS]
                        ),
                    not_(Question.question_text.ilike('%Parent%')),
                    Question.question_text.ilike('%secondary%'),
                    Question.question_text.ilike('%phone%')
                    )).all()]:

                    if resp.user_response in (None,''):
                        msg = 'Work phone added by user was blank/None, ignored. This user has no work phone info. User response id: {0}, response: {1}'.format(
                            resp.id,resp.user_response)

                        q_error = msg
                        app.logger.info(msg)

                    else:
                        local_db_session.query(IuserUser).filter(IuserUser.id==user_id).update(
                            {'work_phone':resp.user_response})
                        local_db_session.commit()
                        local_db_session.begin()

                elif q.parent_id in [x.id for x in DBSession.query(Question).filter(and_(
                    Question.question_type.notin_(
                        [QUESTION_HEADING,QUESTION_INSTRUCTIONS]),
                    Question.question_text.ilike('%parent%'),
                    Question.question_text.ilike('%phone%')
                    )).all()]:

                    if resp.user_response in (None,''):
                        msg = 'Parent phone added by user was blank/None, ignored. This user has no parent phone info. User response id: {0}, response: {1}'.format(
                            resp.id,resp.user_response)

                        q_error = msg
                        app.logger.info(msg)

                    else:
                        local_db_session.query(IuserUser).filter(IuserUser.id==user_id).update(
                            {'parent_home_phone':resp.user_response})
                        local_db_session.commit()
                        local_db_session.begin()

                else:
                    msg = \
                        "Can't identify type of phone number: Can't find parent matching expected text patterns for question {0}, question text: {1}, user:{2}, form copy {3}, user response: id: {4}, response: {5}".format(
                        q.id,q.question_text,user.email,form_copy.id,resp.id,resp.user_response)
                    q_error = msg
                    app.logger.info(msg)

            elif q.parent_id in [x.id for x in DBSession.query(Question).filter(and_(
                Question.question_type.notin_(
                    [QUESTION_HEADING,QUESTION_INSTRUCTIONS]),
                Question.question_text.ilike('Is this a cell phone%')
                )).all()]:
                # Figure out which phone number this is for.
                localq = DBSession.query(QuestionCopy).filter(and_(
                    QuestionCopy.user_id==user_id,
                    QuestionCopy.ordinal==q.ordinal,
                    QuestionCopy.sub_ordinal==100,
                    QuestionCopy.section_id==q.section_id,
                    )).first()

                if localq:
                    localfield = None
                    localqtext = localq.question_text.lower()
                    if 'primary' in localqtext:
                        localfield = 'home_phone_is_cell'
                    elif 'secondary' in localqtext:
                        localfield = 'work_phone_is_cell'
                    elif 'parent' in localqtext:
                        localfield = 'parent_home_phone_is_cell'
                    else:
                        msg = \
                            "Can't identify type of 'is cell' response: Can't find phone question matching expected ordinal for this question {0}, question text: {1}, user:{2}, form copy {3}, user response: id: {4}, response: {5}".format(
                            q.id,q.question_text,user.email,form_copy.id,resp.id,resp.user_response)
                        q_error = msg
                        app.logger.info(msg)

                    if localfield:
                        if 'yes' in ','.join([x.lower() for x in text_array]):
                            local_db_session.query(IuserUser).filter(IuserUser.id==user_id).update(
                                {localfield:True})
                            local_db_session.commit()
                            local_db_session.begin()

                        elif 'no' in ','.join([x.lower() for x in text_array]):
                            local_db_session.query(IuserUser).filter(IuserUser.id==user_id).update(
                                {localfield:False})
                            local_db_session.commit()
                            local_db_session.begin()

                        else:
                            msg = \
                                "Can't find matching yes/no answer for this 'is cell' question in phone questions. The question: {0}, question text: {1}, user: {2}, form copy {3}, user response: id: {4}, response: {5}".format(
                                q.id,q.question_text,user.email,form_copy.id,resp.id,resp.user_response)
                            q_error = msg
                            app.logger.info(msg)
                else:
                    msg = \
                        "Can't identify type of 'is cell' response: Can't find phone question matching expected ordinal for this question {0}, question text: {1}, user:{2}, form copy {3}, user response: id: {4}, response: {5}".format(
                        q.id,q.question_text,user.email,form_copy.id,resp.id,resp.user_response)
                    q_error = msg
                    app.logger.info(msg)


            elif q.parent_id in [x.id for x in DBSession.query(Question).filter(and_(
                Question.question_type.notin_(
                    [QUESTION_HEADING,QUESTION_INSTRUCTIONS]),
                Question.question_text.ilike('how did you hear%')
                )).all()]:

                if not text_array:
                    msg = 'How Hear added by user was blank/None, ignored. This user has no how hear info. User response id: {0}, response: {1}'.format(
                        resp.id,','.join(text_array))

                    q_error = msg
                    app.logger.info(msg)


                else:
                    # One question is freeform text, the rest are RADIO.
                    # answer_lookup() unifies this for us,
                    local_db_session.query(IuserUser).filter(IuserUser.id==user_id).update(
                        {'imentor_hear':','.join(text_array)})
                    local_db_session.commit()
                    local_db_session.begin()

            elif q.question_type == QUESTION_ADDRESS:
                if q.parent_id in [x.id for x in DBSession.query(Question).filter(and_(

                    Question.question_type.notin_(
                        [QUESTION_HEADING,QUESTION_INSTRUCTIONS]),
                    Question.question_text.ilike('home%'),
                    Question.question_text.ilike('%address%')
                    )).all()]:

                    local_db_session.query(IuserUser).filter(IuserUser.id==user_id).update({
                        'address1':resp.user_response['address'],
                        'city':resp.user_response['city'],
                        'state_id':resp.user_response['state_id'],
                        'zip_code':resp.user_response['zipcode']
                        })
                    local_db_session.commit()
                    local_db_session.begin()

                elif q.parent_id in [x.id for x in DBSession.query(Question).filter(and_(
                    Question.question_type.notin_(
                        [QUESTION_HEADING,QUESTION_INSTRUCTIONS]),
                    Question.question_text.ilike('parent%'),
                    Question.question_text.ilike('%address%')
                    )).all()]:

                    local_db_session.query(IuserUser).filter(IuserUser.id==user_id).update({
                        'parent_address':resp.user_response['address'],
                        'parent_city':resp.user_response['city'],
                        'parent_state_id':resp.user_response['state_id'],
                        'parent_zip_code':resp.user_response['zipcode']
                        })
                    local_db_session.commit()
                    local_db_session.begin()

                elif q.parent_id in [x.id for x in DBSession.query(Question).filter(and_(
                    Question.question_type.notin_(
                        [QUESTION_HEADING,QUESTION_INSTRUCTIONS]),
                        Question.question_text.ilike('work address%')
                    )).all()]:

                    local_db_session.query(IuserUser).filter(IuserUser.id==user_id).update({
                        'work_address':resp.user_response['address'],
                        'work_city':resp.user_response['city'],
                        'work_state_id':resp.user_response['state_id'],
                        'work_zip_code':resp.user_response['zipcode']
                        })
                    local_db_session.commit()
                    local_db_session.begin()

            elif q.parent_id in [x.id for x in DBSession.query(Question).filter(and_(
                Question.question_type.notin_(
                    [QUESTION_HEADING,QUESTION_INSTRUCTIONS]),
                Question.question_text.ilike('preferred%'),
                Question.question_text.ilike('%first name%')
                )).all()]:

                if resp.user_response in (None,''):
                    msg = 'First name added by user was blank/None, ignored. This user has no first name info. User response id: {0}, response: {1}'.format(
                        resp.id,resp.user_response)

                    q_error = msg
                    app.logger.info(msg)

                else:
                    local_db_session.query(IuserUser).filter(IuserUser.id==user_id).update(
                        {'first_name':resp.user_response})
                    local_db_session.commit()
                    local_db_session.begin()
                
            elif q.parent_id in [x.id for x in DBSession.query(Question).filter(and_(
                Question.question_type.notin_(
                    [QUESTION_HEADING,QUESTION_INSTRUCTIONS]),
                Question.question_text.ilike('preferred%'),
                Question.question_text.ilike('%last name%')
                )).all()]:

                if resp.user_response in (None,''):
                    msg = 'Last name added by user was blank/None, ignored. This user has no last name info. User response id: {0}, response: {1}'.format(
                        resp.id,resp.user_response)

                    q_error = msg
                    app.logger.info(msg)

                else:
                    local_db_session.query(IuserUser).filter(IuserUser.id==user_id).update(
                        {'last_name':resp.user_response})
                    local_db_session.commit()
                    local_db_session.begin()

            elif q.parent_id in [x.id for x in DBSession.query(Question).filter(and_(
                Question.question_type.notin_(
                    [QUESTION_HEADING,QUESTION_INSTRUCTIONS]),
                Question.question_text.ilike('first name%')
                )).all()]:

                if resp.user_response in (None,''):
                    msg = 'First name added by user was blank/None, ignored. This user has no first name info. User response id: {0}, response: {1}'.format(
                        resp.id,resp.user_response)

                    q_error = msg
                    app.logger.info(msg)

                else:
                    local_db_session.query(IuserUser).filter(IuserUser.id==user_id).update(
                        {'first_name':resp.user_response})
                    local_db_session.commit()
                    local_db_session.begin()
                
            elif q.parent_id in [x.id for x in DBSession.query(Question).filter(and_(
                Question.question_type.notin_(
                    [QUESTION_HEADING,QUESTION_INSTRUCTIONS]),
                Question.question_text.ilike('last name%')
                )).all()]:

                if resp.user_response in (None,''):
                    msg = 'Last name added by user was blank/None, ignored. This user has no last name info. User response id: {0}, response: {1}'.format(
                        resp.id,resp.user_response)

                    q_error = msg
                    app.logger.info(msg)

                else:
                    local_db_session.query(IuserUser).filter(IuserUser.id==user_id).update(
                        {'last_name':resp.user_response})
                    local_db_session.commit()
                    local_db_session.begin()

            elif q.parent_id in [x.id for x in DBSession.query(Question).filter(and_(
                Question.question_type.notin_(
                    [QUESTION_HEADING,QUESTION_INSTRUCTIONS]),
                Question.question_text.ilike('legal first name%'))).all()]:

                if resp.user_response in (None,''):
                    msg = 'Legal first name added by user was blank/None, ignored. This user has no Legal first name info. User response id: {0}, response: {1}'.format(
                        resp.id,resp.user_response)

                    q_error = msg
                    app.logger.info(msg)

                else:
                    local_db_session.query(IuserUser).filter(IuserUser.id==user_id).update(
                        {'legal_first_name':resp.user_response})
                    local_db_session.commit()
                    local_db_session.begin()

            elif q.parent_id in [x.id for x in DBSession.query(Question).filter(and_(
                Question.question_type.notin_(
                    [QUESTION_HEADING,QUESTION_INSTRUCTIONS]),
                Question.question_text.ilike('legal last name%'))).all()]:

                if resp.user_response in (None,''):
                    msg = 'Legal last name added by user was blank/None, ignored. This user has no legal last name info. User response id: {0}, response: {1}'.format(
                        resp.id,resp.user_response)

                    q_error = msg
                    app.logger.info(msg)

                else:
                    local_db_session.query(IuserUser).filter(IuserUser.id==user_id).update(
                        {'legal_last_name':resp.user_response})
                    local_db_session.commit()
                    local_db_session.begin()

            elif q.parent_id in [x.id for x in DBSession.query(Question).filter(and_(
                Question.question_type.notin_(
                    [QUESTION_HEADING,QUESTION_INSTRUCTIONS]),
                Question.question_text.ilike('%parent%'),
                Question.question_text.ilike('%first name%')
                )).all()]:

                if resp.user_response in (None,''):
                    msg = 'Parent name added by user was blank/None, ignored. This user has no parent name info. User response id: {0}, response: {1}'.format(
                        resp.id,resp.user_response)

                    q_error = msg
                    app.logger.info(msg)

                else:
                    # Append to existing. This is imperfect. Assumes only one last name.
                    full_name = resp.user_response
                    if user.parent_name:
                        full_name = resp.user_response + ' ' + ' '.join(user.parent_name.split()[-1])

                    local_db_session.query(IuserUser).filter(IuserUser.id==user_id).update(
                        {'parent_name':full_name})
                    local_db_session.commit()
                    local_db_session.begin()

            elif q.parent_id in [x.id for x in DBSession.query(Question).filter(and_(
                Question.question_type.notin_(
                    [QUESTION_HEADING,QUESTION_INSTRUCTIONS]),
                Question.question_text.ilike('%parent%'),
                Question.question_text.ilike('%last name%')
                )).all()]:

                if resp.user_response in (None,''):
                    msg = 'Parent name added by user was blank/None, ignored. This user has no parent name info. User response id: {0}, response: {1}'.format(
                        resp.id,resp.user_response)

                    q_error = msg
                    app.logger.info(msg)

                else:
                    # Append to existing. This is imperfect. Assumes extra
                    # words are part of the last name.
                    full_name = resp.user_response
                    if user.parent_name:
                        full_name = user.parent_name.split()[0] + ' ' + resp.user_response

                    local_db_session.query(IuserUser).filter(IuserUser.id==user_id).update(
                        {'parent_name':full_name})
                    local_db_session.commit()
                    local_db_session.begin()

            elif q.parent_id in [x.id for x in DBSession.query(Question).filter(
                Question.question_type.notin_(
                    [QUESTION_HEADING,QUESTION_INSTRUCTIONS])
                ).filter(or_(
                    Question.question_text.ilike('%employer was not listed%'),
                    Question.question_text.ilike('employer%')
                )).all()]:

                # In the future, check this for profanity.
                if resp.user_response not in (None,''):
                    if len(resp.user_response) > 100:
                        resp.user_response = resp.user_response[:100]

                    emp_exists = DBSession.query(IuserEmployer).filter(
                        IuserEmployer.name==resp.user_response).first()

                    if emp_exists:

                        local_db_session.query(IuserUser).filter(IuserUser.id==user_id).update({
                            'employer_id':emp_exists.id})

                        # Update form choice as well.
                        resp.selected_id = emp_exists.id

                        local_db_session.commit()
                        local_db_session.begin()

                    else:
                        newstring = resp.user_response if len(resp.user_response) < 100 \
                            else resp.user_response[:100]

                        new_employer = IuserEmployer(name=newstring)
                        local_db_session.add(new_employer)
                        local_db_session.commit()
                        local_db_session.begin()

                        new_employer_member = IuserEmployerMember(
                            employer_id=new_employer.id,
                            member_id=user.member_id)

                        local_db_session.add(new_employer_member)
                        local_db_session.commit()
                        local_db_session.begin()

                        # Update form choice as well.
                        resp.selected_id = new_employer.id

                        local_db_session.query(IuserUser).filter(IuserUser.id==user_id).update(
                            {'employer_other':newstring,'employer_id':new_employer.id})

                        local_db_session.commit()
                        local_db_session.begin()

                        local_db_session.expunge(new_employer)
                        nemp_d = new_employer.__dict__

                        local_db_session.expunge(new_employer_member)
                        nempm_d = new_employer_member.__dict__

                else: # User submitted a blank field
                    msg = 'New Employer added by user was blank/None, ignored. This user has no employer info. User response id: {0}, response: {1}'.format(
                        resp.id,resp.user_response)

                    q_error = msg
                    app.logger.info(msg)

            elif q.parent_id in [x.id for x in DBSession.query(Question).filter(and_(
                Question.question_type.notin_(
                    [QUESTION_HEADING,QUESTION_INSTRUCTIONS]),
                Question.question_text.ilike('%gender%'))).all()]:

                local_db_session.query(IuserUser).filter(IuserUser.id==user_id).update(
                    {'gender':GENDER_CHOICES[returned_structs[0].answer_text]})
                local_db_session.commit()
                local_db_session.begin()

            elif q.parent_id in [x.id for x in DBSession.query(Question).filter(and_(
                Question.question_type.notin_(
                    [QUESTION_HEADING,QUESTION_INSTRUCTIONS]),
                Question.question_text.ilike('who referred%'))).all()]:

                if resp.user_response in (None,''):
                    msg = 'Who Referred added by user was blank/None, ignored. This user has no Who Referred info. User response id: {0}, response: {1}'.format(
                        resp.id,resp.user_response)

                    q_error = msg
                    app.logger.info(msg)

                else:
                    local_db_session.query(IuserUser).filter(IuserUser.id==user_id).update(
                        {'imentor_other':resp.user_response})
                    local_db_session.commit()
                    local_db_session.begin()

            elif q.parent_id in [x.id for x in DBSession.query(Question).filter(and_(
                Question.question_type.notin_(
                    [QUESTION_HEADING,QUESTION_INSTRUCTIONS]),
                Question.question_text.ilike('job title%'))).all()]:

                if resp.user_response in ('',None):
                    msg = "Job title {0} is blank/null for user, question id {1}, skipping.".format(
                            resp.user_response,q.id)

                    app.logger.info(msg)
                    q_error = msg

                else:
                    local_db_session.query(IuserUser).filter(IuserUser.id==user_id).update(
                        {'job_title':resp.user_response})
                    local_db_session.commit()
                    local_db_session.begin()

            elif q.parent_id in [x.id for x in DBSession.query(Question).filter(and_(
                Question.question_type.notin_(
                    [QUESTION_HEADING,QUESTION_INSTRUCTIONS]),
                Question.question_text.ilike('marital%'))).all()]:

                local_db_session.query(IuserUser).filter(IuserUser.id==user_id).update(
                    {'marital_status':MARITAL_STATUS_CHOICES[returned_structs[0].answer_text]})
                local_db_session.commit()
                local_db_session.begin()

        else: # no resp
            if q.is_required and q.is_active:
                msg = \
                    "Missing required answer for question {0}, question text: {1}, user:{2}, form copy {3}".format(
                    q.id,q.question_text,user.email,form_copy.id)
                q_error = msg
                app.logger.info(msg)
            else:
                app.logger.info("No answer found for form copy {0}, question {1}, answer not required".format(
                    form_copy.id,q.id))

        return q_error


    def preprocess_form(self,local_db_session):
        '''
        Preload certain fields before the form is complete.
        Only process forms touched recently.
        Currently this is only done for the application form.
        '''

        for unfinished_form in DBSession.query(FormCopy).filter(
            FormCopy.form_was_completed == False,
            FormCopy.form_data_type == APPLICATION
            #FormCopy.last_touched_datetime >= (datetime.now() - timedelta(days=1))
            ).order_by(desc(FormCopy.last_touched_datetime)).all():

            user = DBSession.query(IuserUser).filter(
                IuserUser.id == unfinished_form.user_id).one()

            if user.status != USER_STATUS_APPLICATION_INCOMPLETE:
                app.logger.warning("User {0} status was changed to {1}, skipping form.".format(
                    user.id,user.status))
                continue

            app.logger.info("Doing unfinished form {0} user id {1}, date:{2}".format(
                unfinished_form.id,unfinished_form.user_id,
                unfinished_form.form_was_completed_datetime))

            local_db_session.query(IuserPersona).filter(
                IuserPersona.id==unfinished_form.persona_id).update(
                {'intake_last_updated':unfinished_form.last_touched_datetime})
            local_db_session.commit()
            local_db_session.begin()

            self.preprocess_fields(local_db_session,unfinished_form)



    def popQ(self):
        local_db_session = get_scoped_session()

        ready_form = forms_coll.find_one_and_delete({'error':{'$ne':True}})
        while ready_form:
            msg = "POP: Processing {0}".format(
                pprint.pformat(ready_form))
            app.logger.info(msg)

            try:
                form_errors,form_type = self.process_form(local_db_session,
                    ready_form['user_id'],
                    ready_form['form_copy_id'])

                if not form_errors:
                    if form_type == APPLICATION:
                        persona_id = user_details.get_persona_for_user(
                            user_id=ready_form['user_id'],
                            ignore_match_status=True,
                            ignore_active_status=True)[1].id
    
                        # Make django send notifications, only after we 
                        # migrate data from forms to other tables.
                        self.form_nots.pushQ(persona_id,NOTIFY_APPLICATION_COMPLETE)
    
                    else:
                        pass # We have no other form types right now.

                else:
                    # Form does not have to be processed again.
                    # Humans will correct data through another interface.
                    ready_form['last_try'] = datetime.now()
                    ready_form['error'] = True
                    ready_form['msgs'] = '|'.join(form_errors)
                    # Returns Mongo object id
                    #forms_coll.insert_one(ready_form)
    
                    if form_type == APPLICATION:
                        persona_id = user_details.get_persona_for_user(
                            user_id=ready_form['user_id'],
                            ignore_match_status=True,
                            ignore_active_status=True)[1].id

                        # migrate data from forms to other tables.
                        self.form_nots.pushQ(persona_id,NOTIFY_APPLICATION_COMPLETE)
    
                ready_form = forms_coll.find_one_and_delete({'error':{'$ne':True}})

            except:
                forms_coll.insert_one(ready_form)
                local_db_session.commit()
                raise

        local_db_session.commit()


    def process_form(self,local_db_session, user_id,form_copy_id):
        form_errors = [] # list of form error strings

        form_copy = DBSession.query(FormCopy).filter(FormCopy.user_id==user_id).filter(
            FormCopy.id==form_copy_id).first()
        if not form_copy:
            msg = 'Form no longer exists, skipping form id {0}'.format(
                form_copy_id)
            app.logger.info(msg)

            return [msg],None


        user = DBSession.query(IuserUser).filter(IuserUser.id == user_id).first()
        if not user:
            msg = 'User no longer exists, skipping form id {0}'.format(
                form_copy_id)
            app.logger.info(msg)

            return [msg],form_copy.form_data_type

        if user.id != form_copy.user_id:
            raise WrongUserException("User id passed in: {0} does not match user id {1} for form id {2}".format(
                user_id,form_copy.id, form_copy.user_id)) 

        local_db_session.query(IuserPersona).filter(
            IuserPersona.id==form_copy.persona_id).update(
            {'intake_last_updated':form_copy.last_touched_datetime})
        local_db_session.commit()
        local_db_session.begin()
        
        persona = DBSession.query(IuserPersona).filter(
            IuserPersona.id == form_copy.persona_id).one()

        section_copy_ids = [x.id for x in DBSession.query(SectionCopy).filter(
            SectionCopy.user_id==user_id).filter(
            SectionCopy.form_id==form_copy_id).all()]

        question_copies = DBSession.query(QuestionCopy).filter(
            QuestionCopy.user_id==user_id).filter(
            QuestionCopy.section_id.in_(section_copy_ids)).all()

        question_copy_ids = [x.id for x in question_copies]

        if form_copy.form_data_type == APPLICATION:
            for q in question_copies:
                if q.question_type in (QUESTION_HEADING,QUESTION_INSTRUCTIONS):
                    continue
    
                q_error = self.push_app_form_value(local_db_session,
                    form_copy,user,persona,q)

                if q_error:
                    form_errors.append(q_error)

        else:
            raise UnknownFormDataType("Unknown form data type {0}".format(
                form_copy.form_data_type))

        # Do this all the time.
        #if not form_errors:
        local_db_session.query(IuserUser).filter(IuserUser.id==user_id).update(
            {'application_submit_date':datetime.now()})
        local_db_session.commit()
        local_db_session.begin()

        return form_errors,form_copy.form_data_type


    def preprocess_fields(self,local_db_session,form_copy):
        user_id = form_copy.user_id
        # This is only executed for 'Application Incomplete' status users.

        form_errors = [] # list of form error strings

        if not form_copy:
            msg = 'Form no longer exists, skipping form id {0}'.format(
                form_copy.id)
            app.logger.info(msg)

            return [msg],None

        if form_copy.form_data_type != APPLICATION:
            msg = 'Right now we only preprocess Application forms, skipping form id {0}'.format(
                form_copy.id)
            app.logger.info(msg)

            return [msg],None


        user = DBSession.query(IuserUser).filter(IuserUser.id == user_id).first()
        if not user:
            msg = 'User no longer exists, skipping form id {0}'.format(
                form_copy.id)
            app.logger.info(msg)

            return [msg],form_copy.form_data_type

        if user.id != form_copy.user_id:
            raise WrongUserException("User id passed in: {0} does not match user id {1} for form id {2}".format(
                user_id,form_copy.id, form_copy.user_id)) 
        
        persona = DBSession.query(IuserPersona).filter(
            IuserPersona.id == form_copy.persona_id).one()

        section_copy_ids = [x.id for x in DBSession.query(SectionCopy).filter(
            SectionCopy.user_id==user_id).filter(
            SectionCopy.form_id==form_copy.id).all()]

        question_copies = DBSession.query(QuestionCopy).filter(
            QuestionCopy.user_id==user_id).filter(
            QuestionCopy.section_id.in_(section_copy_ids)).all()

        question_copy_ids = [x.id for x in question_copies]

        for q in question_copies:
            if q.question_type in (QUESTION_HEADING,QUESTION_INSTRUCTIONS):
                continue

            try:
                text_array,resp,returned_structs = uresp.answer_lookup(user_id,q.id,return_struct=True)
            except:
                app.logger.exception("form_preprocessing: skipping answer, question {0}:{1} userid {2}, error during parse: {3}".format(
                    q.id,q.question_text,user.id,traceback.format_exc()))
                continue

            # This is terrible code. This mapping should be in a table.
            # But for applications, there are too many weird conditions.

            # All field validation and space stripping has happened by now.
            # No need to repeat it here.
            if resp:

                if q.question_type == QUESTION_PHONE:

                    if q.parent_id in [x.id for x in DBSession.query(Question).filter(and_(
                        Question.question_type.notin_(
                            [QUESTION_HEADING,QUESTION_INSTRUCTIONS]
                            ),
                        not_(Question.question_text.ilike('%Parent%')),
                        Question.question_text.ilike('%primary%'),
                        Question.question_text.ilike('%phone%')
                        )).all()]:

                        if resp.user_response in (None,''):
                            msg = 'Home phone added by user was blank/None, ignored. This user has no home phone info. User response id: {0}, response: {1}'.format(
                                resp.id,resp.user_response)

                            form_errors.append(msg)
                            app.logger.info(msg)

                        else:
                            local_db_session.query(IuserUser).filter(IuserUser.id==user_id).update(
                                {'home_phone':resp.user_response})
                            local_db_session.commit()
                            local_db_session.begin()

                    elif q.parent_id in [x.id for x in DBSession.query(Question).filter(and_(
                        Question.question_type.notin_(
                            [QUESTION_HEADING,QUESTION_INSTRUCTIONS]
                            ),
                        not_(Question.question_text.ilike('%Parent%')),
                        Question.question_text.ilike('%secondary%'),
                        Question.question_text.ilike('%phone%')
                        )).all()]:

                        if resp.user_response in (None,''):
                            msg = 'Work phone added by user was blank/None, ignored. This user has no work phone info. User response id: {0}, response: {1}'.format(
                                resp.id,resp.user_response)

                            form_errors.append(msg)
                            app.logger.info(msg)

                        else:
                            local_db_session.query(IuserUser).filter(IuserUser.id==user_id).update(
                                {'work_phone':resp.user_response})
                            local_db_session.commit()
                            local_db_session.begin()

                    elif q.parent_id in [x.id for x in DBSession.query(Question).filter(and_(
                        Question.question_type.notin_(
                            [QUESTION_HEADING,QUESTION_INSTRUCTIONS]),
                        Question.question_text.ilike('%parent%'),
                        Question.question_text.ilike('%phone%')
                        )).all()]:

                        if resp.user_response in (None,''):
                            msg = 'Parent phone added by user was blank/None, ignored. This user has no parent phone info. User response id: {0}, response: {1}'.format(
                                resp.id,resp.user_response)

                            form_errors.append(msg)
                            app.logger.info(msg)

                        else:
                            local_db_session.query(IuserUser).filter(IuserUser.id==user_id).update(
                                {'parent_home_phone':resp.user_response})
                            local_db_session.commit()
                            local_db_session.begin()

                    else:
                        msg = \
                            "Can't identify type of phone number: Can't find parent matching expected text patterns for question {0}, question text: {1}, user:{2}, form copy {3}, user response: id: {4}, response: {5}".format(
                            q.id,q.question_text,user.email,form_copy.id,resp.id,resp.user_response)
                        form_errors.append(msg)
                        app.logger.info(msg)


                elif q.parent_id in [x.id for x in DBSession.query(Question).filter(and_(
                    Question.question_type.notin_(
                        [QUESTION_HEADING,QUESTION_INSTRUCTIONS]),
                    Question.question_text.ilike('Is this a cell phone%')
                    )).all()]:
                    # Figure out which phone number this is for.
                    localq = DBSession.query(QuestionCopy).filter(and_(
                        QuestionCopy.user_id==user_id,
                        QuestionCopy.ordinal==q.ordinal,
                        QuestionCopy.sub_ordinal==100,
                        QuestionCopy.section_id==q.section_id,
                        )).first()

                    if localq:
                        localfield = None
                        localqtext = localq.question_text.lower()
                        if 'primary' in localqtext:
                            localfield = 'home_phone_is_cell'
                        elif 'secondary' in localqtext:
                            localfield = 'work_phone_is_cell'
                        elif 'parent' in localqtext:
                            localfield = 'parent_home_phone_is_cell'
                        else:
                            msg = \
                                "Can't identify type of 'is cell' response: Can't find phone question matching expected ordinal for this question {0}, question text: {1}, user:{2}, form copy {3}, user response: id: {4}, response: {5}".format(
                                q.id,q.question_text,user.email,form_copy.id,resp.id,resp.user_response)
                            form_errors.append(msg)
                            app.logger.info(msg)

                        if localfield:
                            if 'yes' in ','.join([x.lower() for x in text_array]):
                                local_db_session.query(IuserUser).filter(IuserUser.id==user_id).update(
                                    {localfield:True})
                                local_db_session.commit()
                                local_db_session.begin()
    
                            elif 'no' in ','.join([x.lower() for x in text_array]):
                                local_db_session.query(IuserUser).filter(IuserUser.id==user_id).update(
                                    {localfield:False})
                                local_db_session.commit()
                                local_db_session.begin()
    
                            else:
                                msg = \
                                    "Can't find matching yes/no answer for this 'is cell' question in phone questions. The question: {0}, question text: {1}, user: {2}, form copy {3}, user response: id: {4}, response: {5}".format(
                                    q.id,q.question_text,user.email,form_copy.id,resp.id,resp.user_response)
                                form_errors.append(msg)
                                app.logger.info(msg)
                    else:
                        msg = \
                            "Can't identify type of 'is cell' response: Can't find phone question matching expected ordinal for this question {0}, question text: {1}, user:{2}, form copy {3}, user response: id: {4}, response: {5}".format(
                            q.id,q.question_text,user.email,form_copy.id,resp.id,resp.user_response)
                        form_errors.append(msg)
                        app.logger.info(msg)

                elif q.parent_id in [x.id for x in DBSession.query(Question).filter(and_(
                    Question.question_type.notin_(
                        [QUESTION_HEADING,QUESTION_INSTRUCTIONS]),
                    Question.question_text.ilike('%gender%'))).all()]:
    
                    local_db_session.query(IuserUser).filter(IuserUser.id==user_id).update(
                        {'gender':GENDER_CHOICES[returned_structs[0].answer_text]})
                    local_db_session.commit()
                    local_db_session.begin()

                elif q.parent_id in [x.id for x in DBSession.query(Question).filter(and_(
                    Question.question_type.notin_(
                        [QUESTION_HEADING,QUESTION_INSTRUCTIONS]),
                    Question.question_text.ilike('preferred%'),
                    Question.question_text.ilike('%first name%')
                    )).all()]:

                    if resp.user_response in (None,''):
                        msg = 'First name added by user was blank/None, ignored. This user has no first name info. User response id: {0}, response: {1}'.format(
                            resp.id,resp.user_response)

                        form_errors.append(msg)
                        app.logger.info(msg)

                    else:
                        local_db_session.query(IuserUser).filter(IuserUser.id==user_id).update(
                            {'first_name':resp.user_response})
                        local_db_session.commit()
                        local_db_session.begin()
                    
                elif q.parent_id in [x.id for x in DBSession.query(Question).filter(and_(
                    Question.question_type.notin_(
                        [QUESTION_HEADING,QUESTION_INSTRUCTIONS]),
                    Question.question_text.ilike('preferred%'),
                    Question.question_text.ilike('%last name%')
                    )).all()]:

                    if resp.user_response in (None,''):
                        msg = 'Last name added by user was blank/None, ignored. This user has no last name info. User response id: {0}, response: {1}'.format(
                            resp.id,resp.user_response)

                        form_errors.append(msg)
                        app.logger.info(msg)

                    else:
                        local_db_session.query(IuserUser).filter(IuserUser.id==user_id).update(
                            {'last_name':resp.user_response})
                        local_db_session.commit()
                        local_db_session.begin()

                elif q.parent_id in [x.id for x in DBSession.query(Question).filter(and_(
                    Question.question_type.notin_(
                        [QUESTION_HEADING,QUESTION_INSTRUCTIONS]),
                    Question.question_text.ilike('first name%')
                    )).all()]:

                    if resp.user_response in (None,''):
                        msg = 'First name added by user was blank/None, ignored. This user has no first name info. User response id: {0}, response: {1}'.format(
                            resp.id,resp.user_response)

                        form_errors.append(msg)
                        app.logger.info(msg)

                    else:
                        local_db_session.query(IuserUser).filter(IuserUser.id==user_id).update(
                            {'first_name':resp.user_response})
                        local_db_session.commit()
                        local_db_session.begin()
                    
                elif q.parent_id in [x.id for x in DBSession.query(Question).filter(and_(
                    Question.question_type.notin_(
                        [QUESTION_HEADING,QUESTION_INSTRUCTIONS]),
                    Question.question_text.ilike('last name%')
                    )).all()]:

                    if resp.user_response in (None,''):
                        msg = 'Last name added by user was blank/None, ignored. This user has no last name info. User response id: {0}, response: {1}'.format(
                            resp.id,resp.user_response)

                        form_errors.append(msg)
                        app.logger.info(msg)

                    else:
                        local_db_session.query(IuserUser).filter(IuserUser.id==user_id).update(
                            {'last_name':resp.user_response})
                        local_db_session.commit()
                        local_db_session.begin()

                elif q.parent_id in [x.id for x in DBSession.query(Question).filter(and_(
                    Question.question_type.notin_(
                        [QUESTION_HEADING,QUESTION_INSTRUCTIONS]),
                    Question.question_text.ilike('legal first name%'))).all()]:

                    if resp.user_response in (None,''):
                        msg = 'Legal first name added by user was blank/None, ignored. This user has no Legal first name info. User response id: {0}, response: {1}'.format(
                            resp.id,resp.user_response)

                        form_errors.append(msg)
                        app.logger.info(msg)

                    else:
                        local_db_session.query(IuserUser).filter(IuserUser.id==user_id).update(
                            {'legal_first_name':resp.user_response})
                        local_db_session.commit()
                        local_db_session.begin()

                elif q.parent_id in [x.id for x in DBSession.query(Question).filter(and_(
                    Question.question_type.notin_(
                        [QUESTION_HEADING,QUESTION_INSTRUCTIONS]),
                    Question.question_text.ilike('legal last name%'))).all()]:

                    if resp.user_response in (None,''):
                        msg = 'Legal last name added by user was blank/None, ignored. This user has no legal last name info. User response id: {0}, response: {1}'.format(
                            resp.id,resp.user_response)

                        form_errors.append(msg)
                        app.logger.info(msg)

                    else:
                        local_db_session.query(IuserUser).filter(IuserUser.id==user_id).update(
                            {'legal_last_name':resp.user_response})
                        local_db_session.commit()
                        local_db_session.begin()

                elif q.parent_id in [x.id for x in DBSession.query(Question).filter(and_(
                    Question.question_type.notin_(
                        [QUESTION_HEADING,QUESTION_INSTRUCTIONS]),
                    Question.question_text.ilike('%parent%'),
                    Question.question_text.ilike('%first name%')
                    )).all()]:

                    if resp.user_response in (None,''):
                        msg = 'Parent name added by user was blank/None, ignored. This user has no parent name info. User response id: {0}, response: {1}'.format(
                            resp.id,resp.user_response)

                        form_errors.append(msg)
                        app.logger.info(msg)

                    else:
                        # Append to existing. This is imperfect. Assumes only one last name.
                        full_name = resp.user_response
                        if user.parent_name:
                            full_name = resp.user_response + ' ' + ' '.join(user.parent_name.split()[-1])

                        local_db_session.query(IuserUser).filter(IuserUser.id==user_id).update(
                            {'parent_name':full_name})
                        local_db_session.commit()
                        local_db_session.begin()

                elif q.parent_id in [x.id for x in DBSession.query(Question).filter(and_(
                    Question.question_type.notin_(
                        [QUESTION_HEADING,QUESTION_INSTRUCTIONS]),
                    Question.question_text.ilike('%parent%'),
                    Question.question_text.ilike('%last name%')
                    )).all()]:

                    if resp.user_response in (None,''):
                        msg = 'Parent name added by user was blank/None, ignored. This user has no parent name info. User response id: {0}, response: {1}'.format(
                            resp.id,resp.user_response)

                        form_errors.append(msg)
                        app.logger.info(msg)

                    else:
                        # Append to existing. This is imperfect. Assumes extra
                        # words are part of the last name.
                        full_name = resp.user_response
                        if user.parent_name:
                            full_name = user.parent_name.split()[0] + ' ' + resp.user_response

                        local_db_session.query(IuserUser).filter(IuserUser.id==user_id).update(
                            {'parent_name':full_name})
                        local_db_session.commit()
                        local_db_session.begin()

                elif q.question_type in (QUESTION_DROPDOWN_EMPLOYERS,
                    QUESTION_DROPDOWN_EMPLOYERS_TYPE2):
    
                    local_db_session.query(IuserUser).filter(IuserUser.id==user_id).update({
                        'employer_id':resp.selected_id})
                    local_db_session.commit()
                    local_db_session.begin()

                elif q.parent_id in [x.id for x in DBSession.query(Question).filter(
                    Question.question_type.notin_(
                        [QUESTION_HEADING,QUESTION_INSTRUCTIONS])
                    ).filter(or_(
                        Question.question_text.ilike('%employer was not listed%'),
                        Question.question_text.ilike('employer%')
                    )).all()]:

                    # In the future, check this for profanity.
                    if resp.user_response not in (None,''):
                        if len(resp.user_response) > 100:
                            resp.user_response = resp.user_response[:100]

                        emp_exists = DBSession.query(IuserEmployer).filter(
                            IuserEmployer.name==resp.user_response).first()

                        if emp_exists:

                            local_db_session.query(IuserUser).filter(IuserUser.id==user_id).update({
                                'employer_id':emp_exists.id})

                            # Update form choice as well.
                            resp.selected_id = emp_exists.id

                            local_db_session.commit()
                            local_db_session.begin()

                        else:
                            newstring = resp.user_response if len(resp.user_response) < 100 \
                                else resp.user_response[:100]

                            new_employer = IuserEmployer(name=newstring)
                            local_db_session.add(new_employer)
                            local_db_session.commit()
                            local_db_session.begin()
    
                            new_employer_member = IuserEmployerMember(
                                employer_id=new_employer.id,
                                member_id=user.member_id)

                            local_db_session.add(new_employer_member)
                            local_db_session.commit()
                            local_db_session.begin()


                            local_db_session.query(IuserUser).filter(IuserUser.id==user_id).update(
                                {'employer_other':newstring,'employer_id':new_employer.id})

                            # Update form choice as well.
                            resp.selected_id = new_employer.id

                            local_db_session.commit()
                            local_db_session.begin()

                            local_db_session.expunge(new_employer)
                            nemp_d = new_employer.__dict__

                            local_db_session.expunge(new_employer_member)
                            nempm_d = new_employer_member.__dict__


                    else: # User submitted a blank field
                        msg = 'New Employer added by user was blank/None, ignored. This user has no employer info. User response id: {0}, response: {1}'.format(
                            resp.id,resp.user_response)

                        form_errors.append(msg)
                        app.logger.info(msg)


        return form_errors,form_copy.form_data_type


if __name__ == "__main__":
    #forms_coll.insert_one({u'form_copy_id': 678, u'user_id': 171222, u'error': False})
    #FormDataProcessing().popQ()
    #FormDataProcessing().process_form(172634,1938)
    #form = DBSession.query(FormCopy).filter(FormCopy.id==1938).one()
    #FormDataProcessing().preprocess_fields(form)
    #FormDataProcessing().preprocess_form()
    pass
