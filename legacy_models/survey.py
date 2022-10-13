# -*- coding: iso8859-15 -*-
import os,sys
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import db,Base,metadata

from sqlalchemy import (BigInteger, Boolean, Column, Date, DateTime, 
    Float, ForeignKey, Index, Integer, Numeric, SmallInteger, 
    String, Table, Text, Time, text)
from sqlalchemy.dialects.postgresql.base import INET, TSVECTOR
from sqlalchemy.orm import relationship


class SurveyAnswerresult(Base,db.Model):
    __tablename__ = 'survey_answerresult'

    id = Column(Integer, primary_key=True, server_default=text("nextval('survey_answerresult_id_seq'::regclass)"))
    survey_id = Column(ForeignKey(u'survey_survey.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    question_id = Column(ForeignKey(u'survey_surveyquestion.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    persona_id = Column(ForeignKey(u'iuser_persona.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    result_id = Column(ForeignKey(u'survey_result.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    persona = relationship(u'IuserPersona')
    question = relationship(u'SurveySurveyquestion')
    result = relationship(u'SurveyResult')
    survey = relationship(u'SurveySurvey')


class SurveyDefaultanswer(Base,db.Model):
    __tablename__ = 'survey_defaultanswer'

    id = Column(Integer, primary_key=True, server_default=text("nextval('survey_defaultanswer_id_seq'::regclass)"))
    question_id = Column(ForeignKey(u'survey_defaultquestion.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    text = Column(Text)
    min = Column(Integer)
    max = Column(Integer)
    lowtag = Column(String(150))
    midtag = Column(String(150))
    hitag = Column(String(150))

    question = relationship(u'SurveyDefaultquestion')


class SurveyDefaultmatchanswer(Base,db.Model):
    __tablename__ = 'survey_defaultmatchanswer'

    id = Column(Integer, primary_key=True, server_default=text("nextval('survey_defaultmatchanswer_id_seq'::regclass)"))
    question_id = Column(ForeignKey(u'survey_defaultmatchquestion.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    text = Column(Text)
    min = Column(Integer)
    max = Column(Integer)
    lowtag = Column(String(150))
    midtag = Column(String(150))
    hitag = Column(String(150))
    pre = Column(Boolean, nullable=False, server_default="true")
    post = Column(Boolean, nullable=False, server_default="false")
    matching_answer_id = Column(SmallInteger, nullable=False, server_default="0")

    question = relationship(u'SurveyDefaultmatchquestion')


class SurveyDefaultmatchquestion(Base,db.Model):
    __tablename__ = 'survey_defaultmatchquestion'

    id = Column(Integer, primary_key=True, server_default=text("nextval('survey_defaultmatchquestion_id_seq'::regclass)"))
    type = Column(String(10), nullable=False)
    text = Column(Text, nullable=False)
    required = Column(Boolean, nullable=False)
    for_mentor = Column(Boolean, nullable=False)
    for_mentee = Column(Boolean, nullable=False)
    pre = Column(Boolean, nullable=False, server_default="true")
    post = Column(Boolean, nullable=False, server_default="false")
    radio_limit = Column(Integer, nullable=False, server_default="10")
    matching_points = Column(SmallInteger, nullable=False, server_default="0")
    matching_points_max = Column(SmallInteger, nullable=False, server_default="0")
    matching_question_id = Column(SmallInteger, nullable=False, server_default="0")
    category_id = Column(ForeignKey(u'survey_surveyquestioncategory.id', deferrable=True, initially=u'DEFERRED'), index=True)
    order = Column(SmallInteger, nullable=False)

    category = relationship(u'SurveySurveyquestioncategory')


class SurveyDefaultquestion(Base,db.Model):
    __tablename__ = 'survey_defaultquestion'

    id = Column(Integer, primary_key=True, server_default=text("nextval('survey_defaultquestion_id_seq'::regclass)"))
    type = Column(String(10), nullable=False)
    text = Column(Text, nullable=False)
    required = Column(Boolean, nullable=False)
    order = Column(Integer, nullable=False)
    for_mentor = Column(Boolean, nullable=False)
    for_mentee = Column(Boolean, nullable=False)
    pre = Column(Boolean, nullable=False, server_default="true")
    post = Column(Boolean, nullable=False, server_default="false")


class SurveyDefaultreferenceanswer(Base,db.Model):
    __tablename__ = 'survey_defaultreferenceanswer'

    id = Column(Integer, primary_key=True, server_default=text("nextval('survey_defaultreferenceanswer_id_seq'::regclass)"))
    question_id = Column(ForeignKey(u'survey_defaultreferencequestion.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    text = Column(Text)

    question = relationship(u'SurveyDefaultreferencequestion')


class SurveyDefaultreferencequestion(Base,db.Model):
    __tablename__ = 'survey_defaultreferencequestion'

    id = Column(Integer, primary_key=True, server_default=text("nextval('survey_defaultreferencequestion_id_seq'::regclass)"))
    type = Column(String(5), nullable=False)
    order = Column(Integer, nullable=False)
    text = Column(Text, nullable=False)
    required = Column(Boolean, nullable=False)
    visible = Column(Boolean, nullable=False)
    legacy_field_name = Column(String(50), nullable=False)


class SurveyIntakeinstruction(Base,db.Model):
    __tablename__ = 'survey_intakeinstructions'

    id = Column(Integer, primary_key=True, server_default=text("nextval('survey_intakeinstructions_id_seq'::regclass)"))
    text = Column(Text)
    member_id = Column(ForeignKey(u'member_member.id', deferrable=True, initially=u'DEFERRED'), index=True)
    type = Column(String(1), nullable=False, server_default="'S'::character varying")
    hidden = Column(Boolean, nullable=False, server_default="false")

    member = relationship(u'MemberMember')


class SurveyMatchinglog(Base,db.Model):
    __tablename__ = 'survey_matchinglog'

    id = Column(Integer, primary_key=True, server_default=text("nextval('survey_matchinglog_id_seq'::regclass)"))
    user_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    datetime = Column(DateTime(True), nullable=False, server_default=text("'2009-04-09 14:12:40.71119-04'::timestamp with time zone"))
    message = Column(Text, nullable=False)

    user = relationship(u'IuserUser')


class SurveyReferencequestionpermission(Base,db.Model):
    __tablename__ = 'survey_referencequestionpermission'

    id = Column(Integer, primary_key=True, server_default=text("nextval('survey_referencequestionpermission_id_seq'::regclass)"))
    question_id = Column(ForeignKey(u'survey_defaultreferencequestion.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    permission_id = Column(ForeignKey(u'permissions_permission.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    permission = relationship(u'PermissionsPermission')
    question = relationship(u'SurveyDefaultreferencequestion')


class SurveyResult(Base,db.Model):
    __tablename__ = 'survey_result'

    id = Column(Integer, primary_key=True, server_default=text("nextval('survey_result_id_seq'::regclass)"))
    answer_id = Column(ForeignKey(u'survey_surveyanswer.id', deferrable=True, initially=u'DEFERRED'), index=True)
    text = Column(Text, nullable=False)

    answer = relationship(u'SurveySurveyanswer')


class SurveySurvey(Base,db.Model):
    __tablename__ = 'survey_survey'
    __table_args__ = (
        Index('survey_survey_name_85d64fee0b5fb07', 'name', 'type'),
    )

    id = Column(Integer, primary_key=True, server_default=text("nextval('survey_survey_id_seq'::regclass)"))
    name = Column(String(100), nullable=False)
    type = Column(String(1), nullable=False)
    abbreviation = Column(String(50), nullable=False)
    description = Column(Text, nullable=False)
    created_on = Column(Date, nullable=False)
    status = Column(String(1), nullable=False, server_default=text("'N'::character varying"))
    close_date = Column(Date)
    splash_screen = Column(Boolean, nullable=False, server_default="false")
    splash_title = Column(String(150), nullable=False)
    splash_text = Column(Text, nullable=False)
    view_results = Column(String(1), nullable=False, server_default=text("'I'::character varying"))
    created_by_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), index=True)
    member_id = Column(ForeignKey(u'member_member.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    retrievable = Column(String(1), nullable=False)

    created_by = relationship(u'IuserUser')
    member = relationship(u'MemberMember')


class SurveySurveyanswer(Base,db.Model):
    __tablename__ = 'survey_surveyanswer'

    id = Column(Integer, primary_key=True, server_default=text("nextval('survey_surveyanswer_id_seq'::regclass)"))
    question_id = Column(ForeignKey(u'survey_surveyquestion.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    text = Column(Text)
    min = Column(Integer)
    max = Column(Integer)
    lowtag = Column(String(150))
    midtag = Column(String(150))
    hitag = Column(String(150))
    matching_answer_id = Column(SmallInteger, nullable=False, server_default="0")
    order = Column(SmallInteger, nullable=False, index=True, server_default="0")
    active = Column(Boolean, nullable=False, server_default="true")
    hidden = Column(Boolean, nullable=False, server_default="false")

    question = relationship(u'SurveySurveyquestion')


class SurveySurveyinvitation(Base,db.Model):
    __tablename__ = 'survey_surveyinvitation'
    __table_args__ = (
        Index('survey_surveyinvitation_status_752fc584305b3df7', 'status', 'invited_on', 'submit_date'),
    )

    id = Column(Integer, primary_key=True, server_default=text("nextval('survey_surveyinvitation_id_seq'::regclass)"))
    survey_id = Column(ForeignKey(u'survey_survey.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    user_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    status = Column(String(10), nullable=False)
    invited_on = Column(Date, nullable=False)
    submit_date = Column(Date)
    invitation_sent = Column(Boolean, nullable=False, server_default="false")

    survey = relationship(u'SurveySurvey')
    user = relationship(u'IuserUser')


class SurveySurveyquestion(Base,db.Model):
    __tablename__ = 'survey_surveyquestion'
    __table_args__ = (
        Index('survey_surveyquestion_type_46a272ca8c28e681', 'type', 'order'),
    )

    id = Column(Integer, primary_key=True, server_default=text("nextval('survey_surveyquestion_id_seq'::regclass)"))
    type = Column(String(10), nullable=False)
    survey_id = Column(ForeignKey(u'survey_survey.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    text = Column(Text, nullable=False)
    required = Column(Boolean, nullable=False, server_default="false")
    pre = Column(Boolean, nullable=False, server_default="false")
    post = Column(Boolean, nullable=False, server_default="false")
    pre_question_id = Column(ForeignKey(u'survey_surveyquestion.id', deferrable=True, initially=u'DEFERRED'), index=True)
    radio_limit = Column(Integer, nullable=False, server_default="10")
    matching_points = Column(SmallInteger, nullable=False, server_default="0")
    matching_points_max = Column(SmallInteger, nullable=False, server_default="0")
    matching_question_id = Column(SmallInteger, nullable=False, server_default="0")
    category_id = Column(ForeignKey(u'survey_surveyquestioncategory.id', deferrable=True, initially=u'DEFERRED'), index=True)
    abbr = Column(String(100), nullable=False)
    legacy_field_name = Column(String(50), nullable=False)
    order = Column(SmallInteger, nullable=False)
    active = Column(Boolean, nullable=False, server_default="true")
    hidden = Column(Boolean, nullable=False, server_default="false")

    category = relationship(u'SurveySurveyquestioncategory')
    pre_question = relationship(u'SurveySurveyquestion', remote_side=[id])
    survey = relationship(u'SurveySurvey')


class SurveySurveyquestionCategory(Base,db.Model):
    __tablename__ = 'survey_surveyquestion_categories'

    id = Column(Integer, primary_key=True, server_default=text("nextval('survey_surveyquestion_categories_id_seq'::regclass)"))
    surveyquestion_id = Column(ForeignKey(u'survey_surveyquestion.id', deferrable=True, initially=u'DEFERRED'), index=True)
    surveyquestioncategory_id = Column(ForeignKey(u'survey_surveyquestioncategory.id', deferrable=True, initially=u'DEFERRED'), index=True)

    surveyquestion = relationship(u'SurveySurveyquestion')
    surveyquestioncategory = relationship(u'SurveySurveyquestioncategory')


class SurveySurveyquestioncategory(Base,db.Model):
    __tablename__ = 'survey_surveyquestioncategory'

    id = Column(Integer, primary_key=True, server_default=text("nextval('survey_surveyquestioncategory_id_seq'::regclass)"))
    name = Column(String(200), nullable=False)
    member_id = Column(ForeignKey(u'member_member.id', deferrable=True, initially=u'DEFERRED'), index=True)
    order = Column(SmallInteger, nullable=False, server_default=text("1"))
    survey_id = Column(ForeignKey(u'survey_survey.id', deferrable=True, initially=u'DEFERRED'), index=True)

    member = relationship(u'MemberMember')
    survey = relationship(u'SurveySurvey')


