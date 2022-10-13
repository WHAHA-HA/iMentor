# -*- coding: iso8859-15 -*-
import os,sys
import pprint
import logging
import datetime
import re
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'../..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import db,Base,metadata,DBSession,DOGPILE_CACHE_REGION
from config.caching_query import CachingQuery,FromCache

from sqlalchemy import (BigInteger, Boolean, Column, Date, DateTime,
    Float, ForeignKey, Index, Integer, Numeric, SmallInteger,
    String, Table, Text, Time, text, func)
from sqlalchemy.dialects.postgresql.base import INET, TSVECTOR
from sqlalchemy.orm import relationship
from  sqlalchemy.sql.expression import func, or_, not_, and_

from legacy_models.survey import *
from legacy_models.iuser import IuserUser
from legacy_models.permissions import PermissionsPermission

def survey_copy():
    # We're removing forms that were stuffed into survey tables.
    forms = SurveySurvey.query.filter(
        or_(
            SurveySurvey.name.ilike('%Mentor Eval%'),
            SurveySurvey.name.ilike('%Mentor Matching%'),
            SurveySurvey.name.ilike('%Reference%')
        )).all()

    for form in forms:
        questions = SurveySurveyquestion.query.filter(
            SurveySurveyquestion.survey_id == form.id
            ).all()
        for question in questions:
            answers = SurveySurveyanswer.query.filter(
                SurveySurveyanswer.question_id == question.id
                ).all()

            for answer in answers:
                surveyresult = SurveyResult.query.filter(
                    SurveyResult.answer_id == answer.id
                    ).first()

                print "Form: {0}\n	question {1}\n	answer text {2}".format(
                    form,pprint.pformat(question.__dict__),pprint.pformat(answer.text))
                if surveyresult:
                    print "Survey result {0}".format(surveyresult.__dict__)

            results = SurveyAnswerresult.query.filter(
                SurveyAnswerresult.survey_id == form.id
                ).filter(
                SurveyAnswerresult.question_id == question.id
                ).all()

            for r in results:
                print "Persona id: {0}".format(r.persona_id)
            import pdb
            pdb.set_trace()
             

            '''
            formcopy = FormCopy(
                FormCopy.description=form.name
                FormRoleCopy.member_site_id=formcopy.member.id
                FormRoleCopy.user_id= ?? - from answer?
                )
            db.session.add(formcopy)
            db.session.flush()

            formrole = FormRoleCopy(
                FormRoleCopy.role_id_can_modify=SUPER_ADMIN,
                FormRoleCopy.form_id=formcopy.id,
            )
            db.session.add(formrole)
            db.session.flush()

            sectioncopy = SectionCopy(
                SectionCopy.form_id=formcopy.id,
                )
            db.session.add(sectioncopy)
            db.session.flush()

            '''

if __name__ == "__main__":
    survey_copy()
