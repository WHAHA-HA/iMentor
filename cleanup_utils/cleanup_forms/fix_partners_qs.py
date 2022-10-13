# -*- coding: iso8859-15 -*-
import pdb
import pprint
import copy
import os,sys
import json
from datetime import datetime,timedelta
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'../..'))
nprojdir = os.path.abspath(os.path.join(appdir,'../../..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)
    sys.path.append(nprojdir)

from config.project_globals import DBSession,Base,metadata,get_scoped_session

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
from legacy_models.member import MemberUserprogram
from college_checklist.models import UtilsCollege
from sqlalchemy.sql import select

from apiforms.models import Question,Answer,QuestionCopy,AnswerCopy,UserResponse

def fix_partner_qs():
    import pdb;pdb.set_trace()
    local_db_session = get_scoped_session()

    # bbbsc (247), bay area (248)
    mpdict = {}
    mprograms = DBSession.query(MemberUserprogram).filter(
        MemberUserprogram.member_id==248
        ).filter(MemberUserprogram.hidden==False).all()
    for m in mprograms:
        mpdict[m.name] = m.id
    pprint.pprint(mpdict)

    del_answers = []
    del_answer_parents = []
    for masterq in local_db_session.query(Question).filter(
        Question.question_text.ilike('%san jose%')).all():
        for userq in local_db_session.query(QuestionCopy).filter(
            QuestionCopy.parent_id==masterq.id).all():
            for usera in local_db_session.query(AnswerCopy).filter(
                AnswerCopy.question_id==userq.id).all():
                del_answers.append(usera.id)
                del_answer_parents.append(usera.parent_id)
                for resp in local_db_session.query(UserResponse).filter(
                    UserResponse.answer_id==usera.id).all():
                    # Replace answer id with selected id
                    print "Replacing {0}{1} with mprogram {1}".format(
                        resp.answer_id,usera.answer_text,
                        mpdict[usera.answer_text])
                    resp.answer_id=None
                    resp.selected_id=None
                    resp.user_response=json.dumps({'mprograms':[mpdict[usera.answer_text]]})

                    local_db_session.query(IuserPersonaUserProgram).filter(
                        IuserPersonaUserProgram.persona_id==usera.persona_id).delete()

                    ipr = IuserPersonaUserProgram(
                        persona_id=usera.persona_id,
                        userprogram_id=mpdict[usera.answer_text])

                    local_db_session.add(ipr)
                    local_db_session.commit()
                    local_db_session.begin()

            userq.question_type=21
            local_db_session.commit()
            local_db_session.begin()

        masterq.question_type=21
        local_db_session.commit()
        local_db_session.begin()

    del_answers = list(set(del_answers))
    del_answer_parents = list(set(del_answer_parents))
    import pdb;pdb.set_trace()
    local_db_session.commit()
    local_db_session = get_scoped_session()

    if del_answers:
        local_db_session.query(AnswerCopy).filter(AnswerCopy.id.in_(del_answers)).delete(synchronize_session=False)
        local_db_session.commit()
        local_db_session.begin()
    if del_answer_parents:
        local_db_session.query(AnswerCopy).filter(Answer.id.in_(del_answer_parents)).delete(synchronize_session=False)

    local_db_session.commit()
    local_db_session.begin()

    mpdict = {}
    mprograms = DBSession.query(MemberUserprogram).filter(
        MemberUserprogram.member_id==247
        ).filter(MemberUserprogram.hidden==False).all()
    for m in mprograms:
        mpdict[m.name] = m.id
    pprint.pprint(mpdict)

    del_answers = []
    del_answer_parents = []
    for masterq in local_db_session.query(Question).filter(
        Question.question_text.ilike('%mentoring programs in Colorado%')).all():
        for userq in local_db_session.query(QuestionCopy).filter(
            QuestionCopy.parent_id==masterq.id).all():
            for usera in local_db_session.query(AnswerCopy).filter(
                AnswerCopy.question_id==userq.id).all():
                del_answers.append(usera.id)
                del_answer_parents.append(usera.parent_id)
                for resp in local_db_session.query(UserResponse).filter(
                    UserResponse.answer_id==usera.id).all():
                    # Replace answer id with selected id
                    print "Replacing {0}{1} with mprogram {1}".format(
                        resp.answer_id,usera.answer_text,
                        mpdict[usera.answer_text])
                    resp.answer_id=None
                    resp.selected_id=None
                    resp.user_response=json.dumps({'mprograms':[mpdict[usera.answer_text]]})

                    local_db_session.query(IuserPersonaUserProgram).filter(
                        IuserPersonaUserProgram.persona_id==usera.persona_id).delete()

                    ipr = IuserPersonaUserProgram(
                        persona_id=usera.persona_id,
                        userprogram_id=mpdict[usera.answer_text])

                    local_db_session.add(ipr)
                    local_db_session.commit()
                    local_db_session.begin()

            userq.question_type=21
            local_db_session.commit()
            local_db_session.begin()

        masterq.question_type=21
        local_db_session.commit()
        local_db_session.begin()

    del_answers = list(set(del_answers))
    del_answer_parents = list(set(del_answer_parents))
    import pdb;pdb.set_trace()
    local_db_session.commit()
    local_db_session = get_scoped_session()

    if del_answers:
        local_db_session.query(AnswerCopy).filter(AnswerCopy.id.in_(del_answers)).delete(synchronize_session=False)
        local_db_session.commit()
        local_db_session.begin()
    if del_answer_parents:
        local_db_session.query(AnswerCopy).filter(Answer.id.in_(del_answer_parents)).delete(synchronize_session=False)

    local_db_session.commit()
            
if __name__ == "__main__":
    fix_partner_qs()
