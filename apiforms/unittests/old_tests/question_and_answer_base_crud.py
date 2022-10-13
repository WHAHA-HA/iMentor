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

#**********works!
    def test_get_by_id(self):
        qb = QuestionBase()
        print "Ids in database:",
        for data in db.session.query(Question).all():
            print data.id,
        print "\n#----------------------------------------------------------------"
        for data in db.session.query(Question).all():
            record = qb.get_records(data.id)
            #print "\n\nthis is records (data by id)", record
            self.assertTrue(record)
#        for r in qb.get_records(6):
#            print "This is the answers associated with id 6", r.answers # r.answers is a list within a list
        #qb.get_records(1)

#********works!
    def test_get_by_string(self):
        qb = QuestionBase()
        # intake_objs should give list of questions that fit criteria
        search_results = qb.get_records("this")
        self.assertTrue(search_results)
        #print "\nThese are the search results by string", search_results
#        for result in qb.get_records("work"):
#            print "This is result", result
##            print result.question_text

#**************works!
    def test_insert(self):
        sample_q = intake_objs.QuestionBase()
        #q = Question(member_location=1, weighted_val=2, is_required=True, 
        #             is_visible=True, is_immutable=True, question_text="Does this work?", ordinal= 5)
        q = Question(member_location=2, weighted_val=3, is_required=True, 
                     is_visible=True, is_immutable=True, dependent_on_question_id=1, 
                     dependent_on_question_condition="test", user_role_id=1,
                     question_text="Test insert in question_and_answer_base_crud.py!", question_type=5, ordinal= 6, if_answered_goto_question=1) # should ordinal be unique?
        sample_q.post_record(q)
        print "Question Object inserted into database:", Question.query.all()
        self.assertTrue(Question.query.all())

#---- works!
    def test_update(self):
        sample_q = intake_objs.QuestionBase()
        #q = Question(question_text="Let's do this again!!", is_visible=False, ordinal=2)
        q = Question(question_text="Test_Update inside of question_and_answer_base_crud for question!!", is_visible=False, ordinal=2)
        sample_q.post_record(q, 3)

#-------works!
    def test_delete(self):
        #sample_q = intake_objs.QuestionBase(member_location=1, weighted_val=2, is_required=True, 
        #           is_visible=True, is_immutable=True, question_text="Does this work?", ordinal=10)
        sample_q = intake_objs.QuestionBase()
        sample_q.delete_record(4)

#--- works, commented out because it's to see if the database can be inserted into, error checking
    def test_manual_insert(self):
        question = Question(member_location=2, weighted_val=7, is_required=True, is_visible=True, is_immutable=True, 
                  dependent_on_question_id=1, dependent_on_question_condition=None, 
                  user_role_id=2, question_text="Manual insert is the charm!", question_type=4, ordinal=14, if_answered_goto_question=1)
        db.session.add(question)
        db.session.commit()

#-----------------------------------
#~~~~~~~~~~~~~~~Answers~~~~~~~~~~~~~~
#-----------------------------------

#****works!
    def test_answer_get(self):
        choice_ans_obj = intake_objs.ChoiceAns()
        record = choice_ans_obj.get_arecords(1) # looking for answers that are associated to Q. 6
        for r in record:
            print "This is answer", r.answer
        self.assertTrue(record)

#*******works!
    def test_answer_insert(self):
        sample_choice_ans = intake_objs.ChoiceAns()
        choice_ans = ChoiceAnswer(question_id=2, answer_type_id=3, answer="It sure is!", ordinal=1, if_chosen_goto_question = 4)
        sample_choice_ans.post_arecord(choice_ans)
        print "Choice Answer Object inserted into database:", ChoiceAnswer.query.all()
        self.assertTrue(ChoiceAnswer.query.all())

#****works!
    def test_answer_update(self):
        sample_choice_ans = intake_objs.ChoiceAns()
        choice_ans_db = ChoiceAnswer(answer="Updated answer.", ordinal="2")
        sample_choice_ans.post_arecord(choice_ans_db, 3)

#****works!
    def test_answer_delete(self):
        choice_ans = intake_objs.ChoiceAns()
        choice_ans.delete_record(2)

if __name__ == '__main__':
    unittest.main()
