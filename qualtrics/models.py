#!/usr/bin/env python
from datetime import date

from sqlalchemy import Column, Integer, String, Date
from psycopg2 import * 
from sqlalchemy import *
from sqlalchemy.dialects.postgresql import *
from config.project_globals import Base,db
from flask_login import UserMixin , login_user
from sqlalchemy.orm import relationship, backref
import sha, random
from sqlalchemy.ext.declarative import declarative_base

from legacy_models.iuser import IuserUser, USERTYPES
from legacy_models.member import MemberMember


QUALTRICS_NOT_INVITED = 1
QUALTRICS_INVITED = 2
QUALTRICS_INCOMPLETE = 3
QUALTRICS_COMPLETE = 4
QUALTRICS_INCOMPLETE_CLOSED = 5
QUALTRICS_INVITED_CLOSED = 6

QUALTRICS_STATUS_MAP = {
    QUALTRICS_NOT_INVITED:'Not Invited',
    QUALTRICS_INVITED:'Not Started',
    QUALTRICS_INCOMPLETE:'Incomplete',
    QUALTRICS_COMPLETE:'Complete',
    QUALTRICS_INCOMPLETE_CLOSED:'Started, incomplete - Closed',
    QUALTRICS_INVITED_CLOSED:'Invited, never started - Closed',
    }

QUALTRICS_STATUS_REVERSE_MAP = {
    'Not Invited':QUALTRICS_NOT_INVITED,
    'Not Started':QUALTRICS_INVITED,
    'Incomplete':QUALTRICS_INCOMPLETE,
    'Completed':QUALTRICS_COMPLETE,
    'Started, incomplete - Closed':QUALTRICS_INCOMPLETE_CLOSED,
    'Invited, never started - Closed':QUALTRICS_INVITED_CLOSED,
    }

class QualtricsLibPanel(Base, db.Model):
    __tablename__ = 'qualtrics_library_panel'

    # This is used globally on all surveys for all member sites. 
    # There should only be one active record.
    # If you need to update this, deactivate older records.
    id = Column(Integer, primary_key=True, nullable=False)
    library_string = Column(Text, nullable=False)
    panel_string = Column(Text, nullable=False)
    record_is_active = Column(Boolean, nullable=False, default=True)

    __table_args__ = (UniqueConstraint('library_string', 'panel_string'),)


class QualtricsSurvey(Base, db.Model):
    __tablename__ = 'qualtrics_survey'

    # Assumption that mentors and mentees always receive different surveys.
    id = Column(Integer, primary_key=True, nullable=False)
    description = Column(Text, nullable=False, default='BAD VALUE')
    # If member_id is null, it's for all members.
    member_id = Column(Integer, ForeignKey('member_member.id'), default=None)
    library_string = Column(Text, nullable=False)
    panel_string = Column(Text, nullable=False)
    distribution_string = Column(Text, nullable=False, default='BAD VALUE')
    survey_string = Column(Text, nullable=False, default='BAD VALUE')
    user_type = Column(Integer, nullable=False)
    start_date = Column(Date, nullable=True, default=date.today)
    end_date = Column(Date, nullable=False)
    survey_is_active = Column(Boolean, nullable=False, default=True)

    member = relationship(MemberMember)
    __table_args__ = (UniqueConstraint('user_type', 'survey_string','member_id'),)


class QualtricsInvite(Base, db.Model):
    __tablename__ = 'qualtrics_invite'

    id = Column(Integer, primary_key=True, nullable=False)
    persona_id = Column(Integer, ForeignKey('iuser_persona.id'), nullable=False)
    user_id = Column(Integer, ForeignKey('iuser_user.id'), nullable=False)
    invited_by_user_id = Column(Integer, ForeignKey('iuser_user.id'), nullable=False)
    survey_id = Column(Integer, ForeignKey('qualtrics_survey.id'), nullable=False)
    survey_status = Column(Integer, nullable=False)
    date_invited = Column(Date, nullable=False, default=date.today)
    last_modified = Column(Date, nullable=True)
    survey_link = Column(Text, nullable=False)

    survey = relationship(QualtricsSurvey)
    __table_args__ = (UniqueConstraint('user_id', 'persona_id', 'survey_link'),)
