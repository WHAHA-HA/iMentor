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

from flask import  current_app, request, redirect, render_template

from sqlalchemy import (BigInteger, Boolean, Column, Date, DateTime,
    Float, ForeignKey, Index, Integer, Numeric, SmallInteger,
    String, Table, Text, Time, text, DATE, func, UniqueConstraint)
from sqlalchemy.dialects.postgresql.base import INET, TSVECTOR
from sqlalchemy.sql.expression import func, or_, not_, and_
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.orm import relationship

class LiveSession(Base, db.Model):
    __tablename__ = 'rzone_user_live_session'

    id = Column(Integer, primary_key=True, nullable=False)
    session_id = Column(Text,unique=True,nullable=False,default='')
    user_id = Column(Integer,ForeignKey(u'iuser_user.id'), unique=True, nullable=False, default=0)
    user = relationship(u'iuser_user', foreign_keys=[user_id])

class LiveSessionMobile(Base, db.Model):
    __tablename__ = 'rzone_user_live_session_mobile'

    id = Column(Integer, primary_key=True, nullable=False)
    session_id = Column(Text,unique=True,nullable=False,default='')
    user_id = Column(Integer,ForeignKey(u'iuser_user.id'), unique=True, nullable=False, default=0)
    user = relationship(u'iuser_user', foreign_keys=[user_id])
