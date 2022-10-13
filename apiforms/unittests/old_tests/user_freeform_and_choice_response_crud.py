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
from intake.models import * # Did import for everything for now
from intake.intake_objs import QuestionBase, FreeformAnswerResponseBase

class TestCase(unittest.TestCase):
    def setUp(self):
        app.config['TESTING'] = True
#        app.config['SQLALCHEMY_DATABASE_URI'] = SQLALCHEMY_DATABASE_URI
        self.app = app.test_client()
        db.create_all()

    def tearDown(self):
        db.session.remove()
        db.drop_all()

#-----------------------------------
#~~~~~~~~UserFreeformResponses~~~~~~~~~~~~~
#-----------------------------------

#****works!
    def test_fanswer_get(self):
        freeform_ans_obj = intake_objs.FreeformAnswerResponseBase()
        record = freeform_ans_obj.get_response(question_search_id=1, user_search_id=3) 
        print "++++++++++++++++++++++++++"
        for r in record:
            print "This is the freeform answer for user_id=", r.user_id, "Here is its response:", r.answer
        print "\n"
        self.assertTrue(record)

##******works!
    def test_fanswer_insert(self):
        sample_freeform_ans = intake_objs.FreeformAnswerResponseBase()
        freeform_ans = UserFreeformResponse(user_id=4, question_id=3, answer="This is inserted into freeform answer!")
        sample_freeform_ans.post_response(freeform_ans)
        print "++++++++++++++++++++++++++"
        print "UserFreeformResponse Object inserted into database:", UserFreeformResponse.query.all()
        print "\n"
        self.assertTrue(UserFreeformResponse.query.all())

#***works!
    def test_fanswer_update(self):
        sample_freeform_ans = intake_objs.FreeformAnswerResponseBase()
        freeform_ans_db = UserFreeformResponse(user_id=4, question_id=1, answer="Babaloo")
        updated_freeform = sample_freeform_ans.post_response(freeform_ans_db, id_number=6)
        print "++++++++++++++++++++++++++"
        for updated_record in updated_freeform:
            print "Freeform question of id=%d now has updated record:" % (updated_record.id), \
                  updated_record.user_id, updated_record.question_id, updated_record.answer
        print "\n"

#***works!
    def test_fanswer_delete(self):
        freeform_ans = intake_objs.FreeformAnswerResponseBase()
        freeform_ans.delete_response(del_id_num=8)

#=========================================
# For choice answer responses
#=========================================
    def test_canswer_get(self):
        choice_ans_obj = intake_objs.ChoiceAnswerResponseBase()
        response_record = choice_ans_obj.get_response(question_search_id=2, user_search_id=2) 
        print "++++++++++++++++++++++++++"
        for record in response_record:
            choice_answers_responded_to = UserChoiceAnswer.query.filter(UserChoiceAnswer.id == record.record_id)
            for r in choice_answers_responded_to:
                print "The user with user_id=%d chose this as an answer for question_id=%d %s:\n" % (r.user_id, r.question_id, r.answer)

##******works!
    def test_canswer_insert(self):
        sample_choice_ans = intake_objs.ChoiceAnswerResponseBase()
        choice_ans = UserChoiceResponse(user_id=2, question_id=2, record_id=1)
        sample_choice_ans.post_response(choice_ans)
        print "++++++++++++++++++++++++++"
        print "UserChoiceResponse Object inserted into database:", UserChoiceResponse.query.all()
        print "\n"
        self.assertTrue(UserChoiceResponse.query.all())

##***works!
    def test_canswer_update(self):
        sample_choice_ans = intake_objs.ChoiceAnswerResponseBase()
        choice_ans_db = UserChoiceResponse(user_id=4, question_id=1, record_id=1)
        updated_choice = sample_choice_ans.post_response(choice_ans_db, id_number=1)
        print "++++++++++++++++++++++++++"
        for updated_record in updated_choice:
            print "Freeform question of id=%d now has updated record:" % (updated_record.id), \
                  updated_record.user_id, updated_record.question_id, updated_record.record_id
        print "\n"

##***works!
    def test_canswer_delete(self):
        choice_ans = intake_objs.ChoiceAnswerResponseBase()
        choice_ans.delete_response(del_id_num=2)

def populate_choice():
    choice_response1 = UserChoiceResponse(user_id=2, question_id=2, record_id=1)

if __name__ == '__main__':
    unittest.main()
