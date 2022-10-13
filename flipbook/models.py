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
from legacy_models.iuser import IuserUser
from canvas.models import CanvasSetCopy
from conversations.models import Conversation
from portfolio.models import ReflectionUserDetails

# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
# Flag Constants
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

REVIEW_FLAG = 1
SAFETY_FLAG = 2
STORY_FLAG = 3

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Flag Data Models:
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

class FlagType(Base, db.Model):
    __tablename__ = 'flag_type'
    id = Column(Integer, primary_key=True, nullable=False)
    description = Column(Text, nullable=True, default=None)

class FlagCanvas(Base, db.Model):
    __tablename__ = 'flag_canvas'
    id = Column(Integer, primary_key=True, nullable=False)
    flag_type_id = Column(Integer, ForeignKey(FlagType.id), nullable=False, default=0)
    canvas_id = Column(Integer, ForeignKey(CanvasSetCopy.id), nullable=False, default=0)
    admin_added_id = Column(Integer, ForeignKey(IuserUser.id), nullable=False, default=0)
    admin_added_datetime = Column(DateTime(timezone=False), nullable=False, default=None) # UTC
    admin_removed_id = Column(Integer, ForeignKey(IuserUser.id), nullable=False, default=0)
    admin_removed_datetime = Column(DateTime(timezone=False), nullable=False, default=None) # UTC
    notes = Column(Text, nullable=True, default=None)
    
class FlagConversation(Base, db.Model):
    __tablename__ = 'flag_conversation'
    id = Column(Integer, primary_key=True, nullable=False)
    flag_type_id = Column(Integer, ForeignKey(FlagType.id), nullable=False, default=0)
    conversation_id = Column(Integer, ForeignKey(Conversation.id), nullable=False, default=0)
    admin_added_id = Column(Integer, ForeignKey(IuserUser.id), nullable=False, default=0)
    admin_added_datetime = Column(DateTime(timezone=False), nullable=False, default=None) # UTC
    admin_removed_id = Column(Integer, ForeignKey(IuserUser.id), nullable=False, default=0)
    admin_removed_datetime = Column(DateTime(timezone=False), nullable=False, default=None) # UTC
    notes = Column(Text, nullable=True, default=None)
    
class FlagReflection(Base, db.Model):
    __tablename__ = 'flag_reflection'
    id = Column(Integer, primary_key=True, nullable=False)
    flag_type_id = Column(Integer, ForeignKey(FlagType.id), nullable=False, default=0)
    reflection_id = Column(Integer, ForeignKey(ReflectionUserDetails.id), nullable=False, default=0)
    admin_added_id = Column(Integer, ForeignKey(IuserUser.id), nullable=False, default=0)
    admin_added_datetime = Column(DateTime(timezone=False), nullable=False, default=None) # UTC
    admin_removed_id = Column(Integer, ForeignKey(IuserUser.id), nullable=False, default=0)
    admin_removed_datetime = Column(DateTime(timezone=False), nullable=False, default=None) # UTC
    notes = Column(Text, nullable=True, default=None)