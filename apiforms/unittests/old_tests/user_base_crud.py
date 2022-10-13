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
from intake.models import Intake, Form, Question, ChoiceAnswer, UserIntake, UserForm, UserQuestion, UserChoiceAnswer
from intake.intake_objs import QuestionBase, QuestionBaseCopy

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
# Intake Copy
#==============================
    def test_intake_get(self):
        print "================================="
        print "Intake section get"
        print "================================="
        intake_base_obj = intake_objs.IntakeBaseCopy()
        record = intake_base_obj.get_intake(intake_id=3)
        for r in record:
            print "This is r.parent_id", r.parent_id
            print "This is r.user_id", r.user_id
            print "This is description", r.description
        self.assertTrue(record)

    def test_intake_insert(self):
        print "================================="
        print "Intake section insert"
        print "================================="
        id_num = 1
        sample_intake_base = intake_objs.IntakeBaseCopy()
        original_intake_records = Intake.query.filter(Intake.id == id_num)
        for record in original_intake_records:
            intake_base = UserIntake(parent_id=id_num, user_id=4, description=record.description)
            sample_intake_base.post_intake(intake_base)
        print "Intake Object inserted into database:", UserIntake.query.all()
        self.assertTrue(UserIntake.query.all())

    def test_intake_update(self):
        print "================================="
        print "Intake section update"
        print "================================="
        sample_intake_base = intake_objs.IntakeBaseCopy()
        intake_base_db = UserIntake(user_id=9, description="Updated Intake description")
        sample_intake_base.post_intake(intake_base_db, id_number=3)

    def test_intake_delete(self):
        print "================================="
        print "Intake section delete"
        print "================================="
        intake_base = intake_objs.IntakeBaseCopy()
        intake_base.delete_intake(4)

#==============================
# Form Copy
#==============================
    def test_form_get(self):
        print "================================="
        print "Form section get"
        print "================================="
        form_base_obj = intake_objs.FormBaseCopy()
        record = form_base_obj.get_form(form_id=2)
        for r in record:
            print "This is r.parent_id", r.parent_id
            print "This is r.user_id", r.user_id
            print "This is description", r.description
        self.assertTrue(record)

    def test_form_insert(self):
        print "================================="
        print "Form section insert"
        print "================================="
        id_num = 1
        sample_form_base = intake_objs.FormBaseCopy()
        original_form_records = Form.query.filter(Form.id == id_num)
        for record in original_form_records:
            form_base = UserForm(parent_id=id_num, user_id=4, description=record.description, intake_id=record.id)
            sample_form_base.post_form(form_base)
        print "Form Object inserted into database:", UserForm.query.all()
        self.assertTrue(UserForm.query.all())

    def test_form_update(self):
        print "================================="
        print "Form section update"
        print "================================="
        sample_form_base = intake_objs.FormBaseCopy()
        form_base_db = UserForm(user_id=9, description="Updated Form description**")
        sample_form_base.post_form(form_base_db, id_number=3)

    def test_form_delete(self):
        print "================================="
        print "Form section delete"
        print "================================="
        form_base = intake_objs.FormBaseCopy()
        form_base.delete_form(id_number=4)

#===================================
# QuestionCopy section
#===================================
    def test_get_by_id(self):
        print "================================="
        print "Question section get by id"
        print "================================="
        qb = QuestionBaseCopy()
        print "Ids in table:",
        for data in db.session.query(UserQuestion).all():
            print data.id,
        print "\n#----------------------------------------------------------------"
        for data in db.session.query(UserQuestion).all():
            record = qb.get_records(data.id)
            #print "\n\nthis is records (data by id)", record
            self.assertTrue(record)
#        for r in qb.get_records(6):
#            print "This is the answers associated with id 6", r.answers # r.answers is a list within a list
        #qb.get_records(1)

#********works!
    def test_get_by_string(self):
        print "================================="
        print "Question section get by string"
        print "================================="
        qb = QuestionBaseCopy()
        # intake_objs should give list of questions that fit criteria
        search_results = qb.get_records("test ")
        #self.assertTrue(search_results)
        print "\nThese are the search results by string", search_results
        for result in qb.get_records("work"):
            print "This is result", result
            print result.question_text
    
    def test_insert(self):
        print "================================="
        print "Question section insert"
        print "================================="
        sample_q = intake_objs.QuestionBaseCopy()
        #q = Question(member_location=1, weighted_val=2, is_required=True, 
        #             is_visible=True, is_immutable=True, question_text="Does this work?", ordinal= 5)
        q = UserQuestion(parent_id=6, user_id=7, member_location=2, weighted_val=3, is_required=True, 
                     is_visible=True, is_immutable=True, dependent_on_question_id=1, 
                     dependent_on_question_condition="test", user_role_id=1,
                     question_text="Let's try this again!", question_type=5, ordinal= 6, if_answered_goto_question=1) # should ordinal be unique?
        sample_q.post_record(q)
        print "UserQuestion Object inserted into database:", UserQuestion.query.all()
        self.assertTrue(UserQuestion.query.all())

#---- works!
    def test_update(self):
        print "================================="
        print "Question section update"
        print "================================="
        sample_q = intake_objs.QuestionBaseCopy()
        #q = Question(question_text="Let's do this again!!", is_visible=False, ordinal=2)
        q = UserQuestion(question_text="Updated Question Copy, yeah!", is_visible=False, ordinal=2)
        sample_q.post_record(q_instance=q, id_number=7)

#-------works!
    def test_delete(self):
        print "================================="
        print "Question section delete"
        print "================================="
        #sample_q = intake_objs.QuestionBaseCopy(member_location=1, weighted_val=2, is_required=True, 
        #           is_visible=True, is_immutable=True, question_text="Does this work?", ordinal=10)
        sample_q = intake_objs.QuestionBaseCopy()
        sample_q.delete_record(6)


#-----------------------------------
#~~~~~~~~~~~~~~~Answers~~~~~~~~~~~~~~
#-----------------------------------

#****works!
    def test_answer_get(self):
        print "================================="
        print "Answer section get"
        print "================================="
        """ this looks for all of the answers that share the same question id"""
        choice_ans_obj = intake_objs.ChoiceAnsCopy()
        record = choice_ans_obj.get_arecords(search_question_id=2)
        print "This is record for user choice answer", record
        print "+++++++++++++++++++++++++$$$$$$$$$$$$$$$$$"
        for r in record:
            print "This is user choice answer", r.answer
        print "\n"
        self.assertTrue(record)

#*******works!
    def test_answer_insert(self):
        print "================================="
        print "Answer section insert"
        print "================================="
        sample_choice_ans = intake_objs.ChoiceAnsCopy()
        choice_ans = UserChoiceAnswer(parent_id=4, user_id=7, question_id=4, answer_type_id=3, answer="User answer table insert!", ordinal=1, if_chosen_goto_question = 8)
        sample_choice_ans.post_arecord(choice_ans)
        print "Choice Answer Object inserted", UserChoiceAnswer.query.all()
        self.assertTrue(UserChoiceAnswer.query.all())

#****works!
    def test_answer_update(self):
        print "================================="
        print "Answer section update"
        print "================================="
        sample_choice_ans = intake_objs.ChoiceAnsCopy()
        choice_ans_db = UserChoiceAnswer(answer="Updated choice answer in user db.", ordinal="2")
        sample_choice_ans.post_arecord(choice_ans_db, 2)

#****works!
    def test_answer_delete(self):
        print "================================="
        print "Answer section delete"
        print "================================="
        choice_ans = intake_objs.ChoiceAnsCopy()
        choice_ans.delete_record(9)

if __name__ == '__main__':
    unittest.main()
