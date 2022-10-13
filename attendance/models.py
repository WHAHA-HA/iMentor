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
from legacy_models.partners import PartnersPartner
from canvas.models import Curriculum

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Attendance Constants:
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

NOT_TAKEN = 1
PRESENT = 2
ABSENT = 3

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Attendance Data Models:
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

class AttendanceDetail(Base, db.Model):
    __tablename__ = 'attendance_detail'
    id = Column(Integer, primary_key=True, nullable=False)
    description = Column(Text, nullable=True, default=None)

class Attendance(Base, db.Model):
    __tablename__ = 'attendance'
    id = Column(Integer, primary_key=True, nullable=False)
    user_id = Column(Integer, ForeignKey(IuserUser.id), nullable=False, default=0)
    persona_id = Column(Integer, ForeignKey(IuserPersona.id), nullable=False, default=0)
    partner_id = Column(Integer, ForeignKey(PartnersPartner.id), nullable=False, default=0)
    curriculum_id = Column(Integer, ForeignKey(Curriculum.id), nullable=False, default=0)
    detail_id = Column(Integer, ForeignKey(AttendanceDetail.id), nullable=False, default=0)
    admin_completed_datetime = Column(DateTime(timezone=False), nullable=False, default=None) # UTC