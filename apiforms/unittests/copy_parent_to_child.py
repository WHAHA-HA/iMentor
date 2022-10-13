# -*- coding: iso8859-15 -*-
import pdb
import pprint
import copy
import os,sys
import unittest

appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..', '..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import db,Base,metadata
from config.settings import ENV_TYPE

from flask import Response, jsonify, make_response
from flask import  current_app, request, redirect, render_template
from flask.views import View, MethodView
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.sql.expression import func, or_, not_, and_
from sqlalchemy.orm import sessionmaker 
from flask_login import (current_user,
                             login_user, logout_user, UserMixin,
                             confirm_login, fresh_login_required)
from flask_restful import Resource, Api, fields, marshal_with
#from flask_wtf import Form, RadioField

#Import 'app' object from auth as well
from auth import api, app, login_required

from forms import forms
from forms.models import *

from legacy_models.iuser import IuserUser
from legacy_models.utils import UtilsState
from legacy_models.partners import PartnersAttributes
from legacy_models.member import MemberMember
from college_checklist.models import UtilsCollege
from sqlalchemy.sql import select


class TestCase(unittest.TestCase):
    def setUp(self):
        app.config['TESTING'] = True
#        app.config['SQLALCHEMY_DATABASE_URI'] = SQLALCHEMY_DATABASE_URI
        self.app = app.test_client()
        db.create_all()

    def tearDown(self):
#        FormUser.query.filter(FormUser.user_id == 1201).delete()
#        SectionUser.query.filter(SectionUser.user_id == 1201).delete()
#        QuestionUser.query.filter(QuestionUser.user_id == 1201).delete()
#        AnswerUser.query.filter(AnswerUser.user_id == 1201).delete()
        db.session.remove()
        db.drop_all()
       

#==============================
# Parent to Child Copy
#==============================
    def test_copy_parent_to_child(self):
        print "================================="
        print "Cascade Copy"
        print "================================="
        # get member_site_id based on user_id
        user_id = 1215
        persona_id = 12268
        #form_id = 1
        #user_id_query = db.session.query(IuserUser).filter(IuserUser.id == user_id).one() # comment this out if can't find column
        for form_id in range (1, len(Form.query.all())+1):
            copy_form_cascade(form_id, user_id, persona_id, member_site_id=1) # replace with member_site_id=user_id_query.member_id if column exists

if __name__ == '__main__':
    unittest.main()
