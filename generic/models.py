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

# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
# Content Type Constants
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

GOOGLE = 1 # Documents, Spreadsheets, Drawings, Slides, and PDFs
VIMEO = 2
YOUTUBE = 3
SOUNDCLOUD = 4

# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
# Product Type Constants
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

CANVAS = 1 # noload_error.product_record_id relates to canvas_set_copy.id in this case.
TASKS = 2 # noload_error.product_record_id relates to tasks_announcement.id in this case.

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# No-Load Data Models:
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

class NoLoadContentType(Base, db.Model):
    __tablename__ = 'noload_content_type'
    id = Column(Integer, primary_key=True, nullable=False)
    description = Column(Text, nullable=True, default=None)
    
class NoLoadProductType(Base, db.Model):
    __tablename__ = 'noload_product_type'
    id = Column(Integer, primary_key=True, nullable=False)
    description = Column(Text, nullable=True, default=None)

class NoLoadError(Base, db.Model):
    __tablename__ = 'noload_error'
    id = Column(Integer, primary_key=True, nullable=False)
    user_id = Column(Integer, ForeignKey(IuserUser.id), nullable=False, default=0)
    persona_id = Column(Integer, ForeignKey(IuserPersona.id), nullable=False, default=0)
    product_type_id = Column(Integer, ForeignKey(NoLoadProductType.id), nullable=False, default=0)
    product_record_id = Column(Integer, nullable=False, default=0)
    content_type_id = Column(Integer, ForeignKey(NoLoadContentType.id), nullable=False, default=0)
    content_url = Column(Text, nullable=True, default=None)
    error_datetime = Column(DateTime(timezone=False), nullable=False, default=None) # UTC