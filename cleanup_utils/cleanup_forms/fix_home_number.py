# -*- coding: iso8859-15 -*-
import pdb
import pprint
import copy
import os,sys
import pymongo
from datetime import datetime,timedelta
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'../..'))
nprojdir = os.path.abspath(os.path.join(appdir,'../../..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)
    sys.path.append(nprojdir)

from config.project_globals import db,Base,metadata,DBSession,get_scoped_session
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
from sqlalchemy.sql import select

uresp = ResponseServices()

def fix_home_phone():
    '''
    Find blank first/last name in iuser_user and fill it in from form.
    '''
    count = 0
    local_db_session = get_scoped_session()

    for form in DBSession.query(FormCopy).order_by(FormCopy.id.desc()).all():
        print "Doing form %s" % form.id
        fn_resp = False

        user = DBSession.query(IuserUser).filter(
            IuserUser.id == form.user_id).one()

        sections = DBSession.query(SectionCopy).filter(
            SectionCopy.user_id==user.id).filter(
            SectionCopy.form_id==form.id).all()

        section_ids = [x.id for x in sections]

        main_phone = DBSession.query(QuestionCopy).filter(
            QuestionCopy.user_id==user.id).filter(
            and_(
                not_(QuestionCopy.question_text.ilike('%Parent%')),
                QuestionCopy.question_text.ilike('%Primary%'),
                QuestionCopy.question_text.ilike('%Phone%')
                )
            ).filter(QuestionCopy.section_id.in_(section_ids)).first()

        if not main_phone:
            print "Form {0}, user id {1}: no main phone question found? That's a bit weird.".format(
                form.id,user.id)
            continue

        text_array,mresp,mreturned_structs = uresp.answer_lookup(user.id,main_phone.id,return_struct=True)
        mainresp = None
        if not mresp:
            print "Skipping, no main number form response."
            continue

        mainresp = mresp.user_response
        if user.home_phone == mainresp:
            print "Matches, all is well."
            continue

        is_mcell_q = DBSession.query(QuestionCopy).filter(and_(
            QuestionCopy.user_id==user.id,
            QuestionCopy.ordinal==main_phone.ordinal,
            QuestionCopy.sub_ordinal==200,
            QuestionCopy.section_id==main_phone.section_id,
            )).first()

        mcell_field = 'home_phone_is_cell'
        mcell_resp = True
        if is_mcell_q:
            localqtext = main_phone.question_text.lower()
            if 'primary' in localqtext:
                mcell_field = 'home_phone_is_cell'
            elif 'secondary' in localqtext:
                mcell_field = 'work_phone_is_cell'
            elif 'parent' in localqtext:
                mcell_field = 'parent_home_phone_is_cell'
            else:
                mcell_field = 'home_phone_is_cell'
                print "What are THOOOOOOOSE? {0}".format(localqtext)

            text_array,iresp,ireturned_structs = uresp.answer_lookup(user.id,is_mcell_q.id,return_struct=True)
            if text_array:
                mcell_resp = False
                if 'yes' in ','.join([x.lower() for x in text_array]):
                    mcell_resp = True

        # Only mentees have this.
        parent_phone = DBSession.query(QuestionCopy).filter(
            QuestionCopy.user_id==user.id).filter(
            and_(
                QuestionCopy.question_text.ilike('%Parent%'),
                QuestionCopy.question_text.ilike('%Primary%'),
                QuestionCopy.question_text.ilike('%Phone%')
                )
            ).filter(QuestionCopy.section_id.in_(section_ids)).first()

        is_pcell_q = None
        if parent_phone:
            is_pcell_q = DBSession.query(QuestionCopy).filter(and_(
                QuestionCopy.user_id==user.id,
                QuestionCopy.ordinal==parent_phone.ordinal,
                QuestionCopy.sub_ordinal==200,
                QuestionCopy.section_id==parent_phone.section_id,
                )).first()

        if is_pcell_q:
            pcell_field = None
            localqtext = parent_phone.question_text.lower()
            if 'primary' in localqtext:
                pcell_field = 'home_phone_is_cell'
            elif 'secondary' in localqtext:
                pcell_field = 'work_phone_is_cell'
            elif 'parent' in localqtext:
                pcell_field = 'parent_home_phone_is_cell'
            else:
                print "What are THOOOOOOOSE? {0}".format(localqtext)

            text_array,iresp,ireturned_structs = uresp.answer_lookup(user.id,is_pcell_q.id,return_struct=True)
            if text_array:
                pcell_resp = False
                if 'yes' in ','.join([x.lower() for x in text_array]):
                    pcell_resp = True

        parentresp=None
        if parent_phone:
            text_array,presp,preturned_structs = uresp.answer_lookup(user.id,parent_phone.id,return_struct=True)
            if presp:
                parentresp = presp.user_response

        wrong_phones = DBSession.query(QuestionCopy).filter(
            QuestionCopy.user_id==user.id).filter(
            QuestionCopy.question_text.ilike('%Home Phone%')).filter(
            QuestionCopy.section_id.in_(section_ids)).all()

        wresps = []
        for w in wrong_phones:
            text_array,wresp,wreturned_structs = uresp.answer_lookup(user.id,w.id,return_struct=True)
            if wresp:
                wresps.append(wresp.user_response)
            
        if user.home_phone in wresps:
            print "User {0} phone: {1}, form primary phone: {2}, wrong from phones: {3}, , cell fields: {4}:{5} updating user record".format(
                user.id,user.home_phone,mainresp,pprint.pformat(wresps),mcell_field,mcell_resp)

            local_db_session.query(IuserUser).filter(IuserUser.id==user.id).update(
                {'home_phone':mainresp,mcell_field:mcell_resp})
            local_db_session.commit()
            local_db_session.begin()

        elif parentresp and user.home_phone != parentresp and \
            user.home_phone != mainresp:
            print "User {0} phone: {1}, form primary phone: {2}, parent phone: {3}, parent is cell field: {4}:{5}, updating user record".format(
                user.id,user.home_phone,mainresp,parentresp,pcell_field,pcell_resp)

            local_db_session.query(IuserUser).filter(IuserUser.id==user.id).update(
                {'home_phone':parentresp,pcell_field:pcell_resp})
            local_db_session.commit()
            local_db_session.begin()

        elif user.home_phone != mainresp:
            print "User {0} phone: {1}, form primary phone:{2}, is_cell info: {3}:{4}. Different from form, updating.".format(
                user.id,user.home_phone,mainresp,mcell_field,mcell_resp)
            local_db_session.query(IuserUser).filter(IuserUser.id==user.id).update(
                {'home_phone':mainresp,mcell_field:mcell_resp})
            local_db_session.commit()
            local_db_session.begin()


    local_db_session.commit()

if __name__ == "__main__":
    fix_home_phone()
