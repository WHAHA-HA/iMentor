# -*- coding: iso8859-15 -*-
import os,sys
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import db,Base,metadata
#Import 'app' object from auth as well
from auth import api, app
from flask import  current_app, request, redirect, render_template
from sqlalchemy import (BigInteger, Boolean, Column, Date, DateTime,
    Float, ForeignKey, Index, Integer, Numeric, SmallInteger,
    String, Table, Text, Time, text, DATE, func, UniqueConstraint)
from sqlalchemy.dialects.postgresql.base import INET, TSVECTOR
from sqlalchemy.sql.expression import func, or_, not_, and_
from sqlalchemy.orm import relationship
from legacy_models.iuser import IuserUser, IuserPersona

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Mentor Rubric Data Models:
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

class ProgramYear(Base, db.Model):
    __tablename__ = 'program_year'
    id = Column(Integer, primary_key=True, nullable=False)
    start_datetime = Column(DateTime(timezone=False), nullable=False, default=None) # UTC
    end_datetime = Column(DateTime(timezone=False), nullable=False, default=None) # UTC
    description = Column(Text, nullable=True, default=None)

class MentorRubric(Base, db.Model):
    __tablename__ = 'mentor_rubric'
    id = Column(Integer, primary_key=True, nullable=False)
    user_id = Column(Integer, ForeignKey(IuserUser.id), nullable=False, default=0)
    persona_id = Column(Integer, ForeignKey(IuserPersona.id), nullable=False, default=0)
    strengths_based = Column(Integer, nullable=False, default=0)
    resources = Column(Integer, nullable=False, default=0)
    response_time = Column(Integer, nullable=False, default=0)
    curriculum = Column(Integer, nullable=False, default=0)
    program_year_id = Column(Integer, ForeignKey(ProgramYear.id), nullable=False, default=0)
    admin_completed_datetime = Column(DateTime(timezone=False), nullable=False, default=None) # UTC