#!flask/bin/python
import pdb
import os, sys
import unittest
import flask
from flask import testing
from flask import Blueprint

appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..', '..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import db,Base,metadata,app
from intake import intake_app, intake_objs 
from intake.models import *
from intake.intake_objs import QuestionBase


class TestCase(unittest.TestCase):
    def setUp(self):
        app.config['TESTING'] = True
##        app.config['SQLALCHEMY_DATABASE_URI'] = SQLALCHEMY_DATABASE_URI
        self.app = app.test_client()
        db.create_all()

    def tearDown(self):
        db.session.remove()
        db.drop_all()

#-----------------------------------------
# Unit tests start here
#-----------------------------------------
    def test_copies(self):
        """ copies in this order: intake_user, form_user, question_table_user, choice_answer_user """
        def copy_intake():
            ## copies intake
            for i in range(1,4):
                copy_form_and_intake_data(Intake, UserIntake, p_id=i, u_id=i+1) 
      
        def copy_form():
            ## copies form
            for i in range(1,4):
                copy_form_and_intake_data(Form, UserForm, p_id=i, u_id=i+1, i_id=i) 

        def copy_question_table():
            ## copies question_table
            copy_question_data(Question, UserQuestion, p_id=1, u_id=3, f_id=2) 
            for i in range(2,5):
                copy_question_data(Question, UserQuestion, p_id=i, u_id=i+1, f_id=i-1, depend_id=i-1)

        def copy_choice_answer():
            ## copies choice_answer
            copy_choice_answer_data(ChoiceAnswer, UserChoiceAnswer, p_id=2, q_id=2, u_id=2)
            copy_choice_answer_data(ChoiceAnswer, UserChoiceAnswer, p_id=3, q_id=2, u_id=2)

        copy_intake()
        copy_form()
        copy_question_table()
        copy_choice_answer()

if __name__ == '__main__':
    unittest.main()
