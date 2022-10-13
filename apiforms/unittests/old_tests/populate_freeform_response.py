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

def populate_freeform():
    freeform_response1 = UserFreeformResponse(user_id=2, question_id=1, answer="#1 This is a freeform text answer")
    freeform_response2 = UserFreeformResponse(user_id=2, question_id=2, answer="#2 This is a freeform text answer")
    freeform_response3 = UserFreeformResponse(user_id=2, question_id=3, answer="#3 This is a freeform text answer")

    freeform_response4 = UserFreeformResponse(user_id=3, question_id=1, answer="#1 This is a freeform text answer for user_id 3")
    freeform_response5 = UserFreeformResponse(user_id=3, question_id=2, answer="#2 This is a freeform text answer for user id 3")
    freeform_response6 = UserFreeformResponse(user_id=3, question_id=3, answer="#3 This is a freeform text answer for user id 3")

    db.session.add(freeform_response1)
    db.session.add(freeform_response2)
    db.session.add(freeform_response3)
    db.session.add(freeform_response4)
    db.session.add(freeform_response5)
    db.session.add(freeform_response6)

    db.session.commit()
    db.session.flush()

if __name__ == '__main__':
    populate_freeform() # good idea to call this fn if table is clean
