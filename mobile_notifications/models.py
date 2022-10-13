# -*- coding: iso8859-15 -*-
import os,sys
import re
import pdb
import pprint
import traceback
from datetime import datetime
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
projdir2 = os.path.abspath(os.path.join(appdir,'../..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)
    sys.path.append(projdir2)

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
from legacy_models.member import MemberMember
from legacy_models.iuser import IuserUser,IuserPersona,USERTYPE_MAP
from new_platform.utils.user_details import (get_persona_obj_for_user,
    get_latest_mentee_user_for_mentor, get_latest_mentor_user_for_mentee,
    get_partners_for_user)
from new_platform.utils.roles import Role

class PushDevice(Base, db.Model):
    __tablename__ = 'mobile_push_device'

    id = Column(Integer, primary_key=True, nullable=False)
    user_id = Column(Integer, ForeignKey(IuserUser.id), nullable=False, default=0)
    persona_id = Column(Integer, ForeignKey(IuserPersona.id), nullable=False, default=0)
    push_token = Column(Text, nullable=False, default="No Value")
    badge = Column(Integer, nullable=False, default=0)
    device_type = Column(Text, nullable=True, default=None)
    device_notes = Column(Text, nullable=True, default=None)
    active = Column(Boolean, nullable=True, default=True)
    user = relationship(IuserUser, foreign_keys=[user_id])
    __table_args__ = (UniqueConstraint('user_id', 'push_token','device_type'),)
    

class PushNotification(Base, db.Model):
    __tablename__ = 'mobile_push_notification'

    id = Column(Integer, primary_key=True, nullable=False)
    push_device_id = Column(Integer, ForeignKey(PushDevice.id), nullable=False, default=0)
    message = Column(Text, nullable=True, default=None)
    sound = Column(Text, nullable=True, default=None)
    badge_value = Column(Integer, nullable=False, default=0)
    push_datetime = Column(DateTime, nullable=False, default=datetime.utcnow)
    push_device = relationship(PushDevice, foreign_keys=[push_device_id])


