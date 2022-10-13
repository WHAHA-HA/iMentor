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

from forms.models import AnswerCopy,UserResponse

for row in db.session.execute("select id,user_id,question_id,answer_id,selected_id,user_response from forms_section_user_response where question_id in (select id from forms_section_question_copy where parent_id in (select id  from forms_section_question where question_text ilike 'With which race or races do you identify?%'))"):

  user_response = row[5]
  question_id = row[2]

  if 'answer_ids' in user_response:
    rgroups = []
    for i in json.loads(user_response)['answer_ids']:
        ac = AnswerCopy.query.filter(AnswerCopy.id==i).one()
        if "Asian/Pacific Islander" in ac.answer_text:
            rgroups.append(10)
        elif "Black/African American" in ac.answer_text:
            rgroups.append(11)
        elif "Hispanic (may be of any race)" in ac.answer_text:
            rgroups.append(15)
        elif "Native American (Aleutian Islander)" in ac.answer_text:
            rgroups.append(16)
        elif "White (Non-Hispanic)" in ac.answer_text:
            rgroups.append(9)
        elif "I identify with a race not listed here" in ac.answer_text:
            rgroups.append(12)
        elif "I would prefer not to indicate my race" in ac.answer_text:
            rgroups.append(13)
    UserResponse.query.filter(UserResponse.question_id==question_id).update(
        {'user_response' : json.dumps({'rgroups':rgroups})})
    db.session.commit()

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
for row in db.session.execute("select id,user_id,question_id,answer_id,selected_id,user_response from forms_section_user_response where question_id in (select id from forms_section_question_copy where parent_id in (select id  from forms_section_question where question_text ilike 'Program Preferences%'))"):

  user_response = row[5]
  question_id = row[2]

  if 'answer_ids' in user_response:
    mprograms = []
    for i in json.loads(user_response)['answer_ids']:
        ac = AnswerCopy.query.filter(AnswerCopy.id==i).one()

        if "Houston College Ready (Grades 9-12)" in ac.answer_text:
            #79740 | Houston College Ready (Grades 9-12)
            mprograms.append(79740)
        elif "Fort Worth College Ready (Grades 9-12)" in ac.answer_text:
            #79745 | Fort Worth College Ready (Grades 9-12)
            mprograms.append(79745)
        elif "College Success 3 Year Match" in ac.answer_text:
            #78649|1|3 year match - College Success (11th grade, 12th grade, and first year of college)
            mprograms.append(78649)
        elif "College Ready 4 Year Match" in ac.answer_text:
            #79458|1|4 year match - College Ready (9th grade through 12th grade
            mprograms.append(79458)
        elif "Dallas/Irving College Ready (Grades 9-12)" in ac.answer_text:
            #79658|191| Dallas/Irving College Ready (Grades 9-12)
            mprograms.append(79658)

    UserResponse.query.filter(UserResponse.question_id==question_id).update(
        {'user_response' : json.dumps({'mprograms':mprograms})})
    db.session.commit()
