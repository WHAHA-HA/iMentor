# -*- coding: iso8859-15 -*-
import json
import pdb
import os,sys
import pprint
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'../..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import db,Base,metadata

from sqlalchemy import (BigInteger, Boolean, Column, Date, DateTime,
    Float, ForeignKey, Index, Integer, Numeric, SmallInteger,
    String, Table, Text, Time, text, DATE, func)
from sqlalchemy.dialects.postgresql.base import INET, TSVECTOR
from sqlalchemy.sql.expression import func, or_, not_, and_
from sqlalchemy.orm import relationship

from apiforms.models import AnswerCopy,UserResponse,QuestionCopy
from legacy_models.iuser import IuserAcademicfield

for i in [
    'Looking at the list below, which options most closely resemble your major%',
    'Even if you did not focus on this area of study in college%',
    'Which subjects do you think you want to study%',
    'Even if you don''t want to major in them, what other academic subjects%'
    ]:
    db.session.execute("update forms_section_answer set is_active=false where question_id in (select id from forms_section_question where question_text ilike '{0}' and question_type = 7)".format(i))
    db.session.execute("update forms_section_question set question_type=20 where question_text ilike '{0}' and question_type = 7".format(i))
    db.session.commit()

    db.session.execute("update forms_section_answer_copy set is_active=false where question_id in (select id from forms_section_question_copy where parent_id in (select id from forms_section_question where question_text ilike '{0}' and question_type = 20))".format(i))
    db.session.execute("update forms_section_question_copy set question_type=20 where parent_id in (select id from forms_section_question where question_text ilike '{0}' and question_type = 20)".format(i))
    db.session.commit()

for row in db.session.execute("select id,user_id,question_id,answer_id,selected_id,user_response from forms_section_user_response where question_id in (select id from forms_section_question_copy where parent_id in (select id  from forms_section_question where question_type = 20))"):

  user_response = row[5]
  question_id = row[2]

  q_obj = QuestionCopy.query.filter(QuestionCopy.id==question_id)
  q = q_obj.one()
  db.session.commit()

  print "Question id and text: {0} {1}, user_response: {2}".format(question_id,q.question_text,user_response)
  if 'answer_ids' in user_response:
    afields = []
    for i in json.loads(user_response)['answer_ids']:
        ac = AnswerCopy.query.filter(AnswerCopy.id==i).one()
        print "Remapping {0}".format(ac.answer_text)
        if ac.answer_text == 'Math':
            record = IuserAcademicfield.query.filter(
                IuserAcademicfield.name=='Mathematics').one()
        elif ac.answer_text == 'Science':
            record = IuserAcademicfield.query.filter(
                IuserAcademicfield.name=='Chemistry').one()
        elif ac.answer_text == 'Art and/or Music':
            record = IuserAcademicfield.query.filter(
                IuserAcademicfield.name=='Art Studio').one()
        elif ac.answer_text == 'Learning how to speak English':
            record = IuserAcademicfield.query.filter(
                IuserAcademicfield.name=='Foreign Language, Literatures, and Linguistics').one()
        elif ac.answer_text == 'Any - No Preference':
            record = IuserAcademicfield.query.filter(
                IuserAcademicfield.name=='Other').one()
        else:
            record = IuserAcademicfield.query.filter(
                IuserAcademicfield.name==ac.answer_text).one()
        afields.append(record.id)
    UserResponse.query.filter(UserResponse.question_id==question_id).update(
        {'user_response' : json.dumps({'afields':afields})})
    db.session.commit()
