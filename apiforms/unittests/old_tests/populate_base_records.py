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

#------------------------------------
# For populating records
#------------------------------------
def populate_records():
    """ populates intake, question_table, and choice_answer """
    print "-------------------- Populating records--------------------"
    intake_data1 = Intake(description="This is intake for aaa")
    intake_data2 = Intake(description="This is intake for bbb")
    intake_data3 = Intake(description="This is intake for ccc")

    db.session.add(intake_data1)
    db.session.add(intake_data2)
    db.session.add(intake_data3)
    db.session.commit()
    db.session.flush()

    form_data1 = Form(description="This is form for aaa", intake_id=1)
    form_data2 = Form(description="This is form for bbb", intake_id=2)
    form_data3 = Form(description="This is form for ccc", intake_id=3)

    db.session.add(form_data1)
    db.session.add(form_data2)
    db.session.add(form_data3)
    db.session.commit()
    db.session.flush()

    q_table_data1 = Question(member_location=1, weighted_val=2, is_required=True, is_visible=True,
                    is_immutable=True, user_role_id=3, question_text="This is a test", question_type=4,
                    form_id=1, ordinal=1, if_answered_goto_question=2)
    q_table_data2 = Question(member_location=1, weighted_val=3, is_required=True, is_visible=True,
                    is_immutable=True, user_role_id=3, question_text="This is another test", question_type=4,
                    form_id=1, ordinal=2, if_answered_goto_question=3)
    q_table_data3 = Question(member_location=2, weighted_val=2, is_required=True, is_visible=True,
                    is_immutable=True, user_role_id=3, question_text="This is test 3", question_type=4,
                    form_id=1, ordinal=3, if_answered_goto_question=3)
    q_table_data4 = Question(member_location=1, weighted_val=2, is_required=True, is_visible=True,
                    is_immutable=True, user_role_id=3, question_text="This is test 4", question_type=4,
                    form_id=1, ordinal=4, if_answered_goto_question=3)

    db.session.add(q_table_data1)
    db.session.add(q_table_data2)
    db.session.add(q_table_data3)
    db.session.add(q_table_data4)
    db.session.commit()
    db.session.flush()

    c_answer_data1 = ChoiceAnswer(question_id=1, answer_type_id=1, answer="Good", ordinal=1, if_chosen_goto_question=1)
    c_answer_data2 = ChoiceAnswer(question_id=1, answer_type_id=1, answer="Great", ordinal=2, if_chosen_goto_question=2)
    c_answer_data3 = ChoiceAnswer(question_id=1, answer_type_id=1, answer="Excellent", ordinal=3, if_chosen_goto_question=3)

    db.session.add(c_answer_data1)
    db.session.add(c_answer_data2)
    db.session.add(c_answer_data3)
    db.session.commit()
    db.session.flush()
    
    c_answer_data4 = ChoiceAnswer(question_id=2, answer_type_id=3, answer="AAAAAA", ordinal=1, if_chosen_goto_question=1)
    c_answer_data5 = ChoiceAnswer(question_id=2, answer_type_id=3, answer="BBBBB", ordinal=2, if_chosen_goto_question=2)
    c_answer_data6 = ChoiceAnswer(question_id=2, answer_type_id=3, answer="CCCCCCC", ordinal=3, if_chosen_goto_question=3)

    db.session.add(c_answer_data4)
    db.session.add(c_answer_data5)
    db.session.add(c_answer_data6)
    db.session.commit()
    db.session.flush()

    c_answer_data7 = ChoiceAnswer(question_id=3, answer_type_id=3, answer="DDDDDDD", ordinal=1, if_chosen_goto_question=1)
    c_answer_data8 = ChoiceAnswer(question_id=3, answer_type_id=3, answer="EEEEEEE", ordinal=2, if_chosen_goto_question=2)
    c_answer_data9 = ChoiceAnswer(question_id=3, answer_type_id=3, answer="FFFFFFFF", ordinal=3, if_chosen_goto_question=3)

    db.session.add(c_answer_data7)
    db.session.add(c_answer_data8)
    db.session.add(c_answer_data9)
    db.session.commit()
    db.session.flush()
    
    #f_answer_data1 = UserFreeformResponse(user_id=2, question_id=4, answer="This is a freeform")

    db.session.add(c_answer_data7)
    db.session.add(c_answer_data8)
    db.session.add(c_answer_data9)
    db.session.add(f_answer_data1)
    db.session.commit()
    db.session.flush()

if __name__ == '__main__':
    populate_records()  # If you're running this test on a fresh start (w/no data, run this first)
