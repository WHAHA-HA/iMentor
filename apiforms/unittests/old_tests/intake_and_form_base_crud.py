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
from intake.models import Intake, Form, Question, ChoiceAnswer
from intake.intake_objs import QuestionBase

class TestCase(unittest.TestCase):
    def setUp(self):
        app.config['TESTING'] = True
#        app.config['SQLALCHEMY_DATABASE_URI'] = SQLALCHEMY_DATABASE_URI
        self.app = app.test_client()
        db.create_all()

    def tearDown(self):
        db.session.remove()
        db.drop_all()
       
#==============================
# Intake 
#==============================
    def test_intake_get(self):
        intake_base_obj = intake_objs.IntakeBase()
        record = intake_base_obj.get_intake(intake_id=2)
        for r in record:
            print "This is description", r.description
        self.assertTrue(record)

    def test_intake_insert(self):
        sample_intake_base = intake_objs.IntakeBase()
        intake_base = Intake(description="An inserted intake")
        sample_intake_base.post_intake(intake_base)
        print "Intake Object inserted into database:", Intake.query.all()
        self.assertTrue(Intake.query.all())

    def test_intake_update(self):
        sample_intake_base = intake_objs.IntakeBase()
        intake_base_db = Intake(description="Updated Intake description")
        sample_intake_base.post_intake(intake_base_db, id_number=3)

    def test_intake_delete(self):
        intake_base = intake_objs.IntakeBase()
        intake_base.delete_intake(4)

    def test_form_get(self):
        form_base_obj = intake_objs.FormBase()
        record = form_base_obj.get_form(form_id=2)
        for r in record:
            print "This is description", r.description
        self.assertTrue(record)

    def test_form_insert(self):
        sample_form_base = intake_objs.FormBase()
        form_base = Form(description="An inserted intake", intake_id=2)
        sample_form_base.post_form(form_base)
        print "Intake Object inserted into database:", Form.query.all()
        self.assertTrue(Form.query.all())

    def test_form_update(self):
        sample_form_base = intake_objs.FormBase()
        form_base_db = Form(description="Updated Intake description", intake_id=1)
        sample_form_base.post_form(form_base_db, id_number=3)

    def test_form_delete(self):
        form_base = intake_objs.FormBase()
        form_base.delete_form(4)

if __name__ == '__main__':
    unittest.main()
