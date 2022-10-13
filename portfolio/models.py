# -*- coding: iso8859-15 -*-
import os,sys
import re
import pdb
import pprint
import traceback
from datetime import datetime
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)
from config.project_globals import db,Base,metadata
#Import 'app' object from auth as well
from auth import api, app
from flask import current_app, request, redirect, render_template
from sqlalchemy import (BigInteger, Boolean, Column, Date, DateTime,
    Float, ForeignKey, Index, Integer, Numeric, SmallInteger,
    String, Table, Text, Time, text, DATE, func, UniqueConstraint)
from sqlalchemy.dialects.postgresql.base import INET, TSVECTOR
from sqlalchemy.sql.expression import func, or_, not_, and_
from sqlalchemy.orm import relationship
from canvas.models import GradeInfo, UnitInfo
from legacy_models.iuser import IuserUser, IuserPersona

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# This is NOT copied for each user. This implies no way to save card history.
class ReflectionCard(Base, db.Model):
    __tablename__ = 'portfolio_reflection_card'
    id = Column(Integer, primary_key=True, nullable=False)
    grade_id = Column(Integer, ForeignKey(GradeInfo.id), nullable=False, default=0)
    unit_id = Column(Integer, ForeignKey(UnitInfo.id), nullable=False, default=0)
    mentor_card_html = Column(Text, nullable=True, default=None)
    mentee_card_html = Column(Text, nullable=True, default=None)
    
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Modes, for ease of updates
STARTED = 1
COMPLETED = 2
LAST_VIEWED = 3

class ReflectionUserDetails(Base, db.Model):
    __tablename__ = 'portfolio_reflection_user_details'
    id = Column(Integer, primary_key=True, nullable=False)
    user_id = Column(Integer, ForeignKey(IuserUser.id), nullable=False, default=0)
    persona_id = Column(Integer, ForeignKey(IuserPersona.id), nullable=False, default=0)
    grade_id = Column(Integer, ForeignKey(GradeInfo.id), nullable=False, default=0)
    unit_id = Column(Integer, ForeignKey(UnitInfo.id), nullable=False, default=0)
    role = Column(Integer, nullable=False, default=0)
    reflection_card_id = Column(Integer, ForeignKey(ReflectionCard.id), nullable=False, default=0)
    started = Column(DateTime(timezone=False), nullable=True, default=None) # UTC
    completed = Column(DateTime(timezone=False), nullable=True, default=None) # UTC
    last_viewed = Column(DateTime(timezone=False), nullable=True, default=None) # UTC
    admin_last_viewed = Column(DateTime(timezone=False), nullable=True, default=None) # UTC
    reflection_card = relationship(ReflectionCard, foreign_keys=[reflection_card_id])
    __table_args__ = (UniqueConstraint('user_id', 'reflection_card_id'),)
    
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class ReflectionUserResponse(Base, db.Model):
    __tablename__ = 'portfolio_reflection_user_response'
    id = Column(Integer, primary_key=True, nullable=False)
    user_id = Column(Integer, ForeignKey(IuserUser.id), nullable=False, default=0)
    reflection_user_details_id = Column(Integer, ForeignKey(ReflectionUserDetails.id), nullable=False, default=0)
    reflection_html = Column(Text, nullable=True, default=None)
    reflection_text = Column(Text, nullable=True, default=None)
    words = Column(Integer, nullable=False, default=0)
    chars = Column(Integer, nullable=False, default=0)
    reflection_user_details = relationship(ReflectionUserDetails, foreign_keys=[reflection_user_details_id])
    user = relationship(IuserUser, foreign_keys=[user_id])
    __table_args__ = (UniqueConstraint('user_id', 'reflection_user_details_id'),)
    
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class ReflectionUserResponseHistory(Base, db.Model):
    __tablename__ = 'portfolio_reflection_user_response_history'
    id = Column(Integer, primary_key=True, nullable=False)
    user_id = Column(Integer, nullable=False, default=0)
    reflection_user_details_id = Column(Integer, nullable=False, default=0)
    reflection_html = Column(Text, nullable=True, default=None)
    reflection_text = Column(Text, nullable=True, default=None)
    words = Column(Integer, nullable=False, default=0)
    chars = Column(Integer, nullable=False, default=0)
    added_datetime = Column(DateTime, nullable=False, default=datetime.utcnow)
