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

class Conversation(Base, db.Model):
    __tablename__ = 'conversation'

    id = Column(Integer, primary_key=True, nullable=False)
    user_id = Column(Integer, ForeignKey(IuserUser.id), nullable=False, default=0)
    persona_id = Column(Integer, ForeignKey(IuserPersona.id), nullable=False, default=0)
    recipient_user_id = Column(Integer, ForeignKey(IuserUser.id), nullable=False, default=0)
    obo_user_posted = Column(Integer, ForeignKey(IuserUser.id), nullable=True, default=None)
    recipient_persona_id = Column(Integer, ForeignKey(IuserPersona.id), nullable=False, default=0)
    received_by_server = Column(DateTime, nullable=False, default=datetime.utcnow)
    sent_to_recipient = Column(DateTime, nullable=True, default=None)
    admin_last_viewed = Column(DateTime, nullable=True, default=None)
    data = Column(Text, nullable=True, default=None)
    # Hide dups while retaining message ordinal sequence. 
    visible = Column(Boolean, nullable=False, default=True)
    word_count = Column(Integer, nullable=False, default=0)
    sequence = Column(Integer, index=True, nullable=False, default=0)
    user = relationship(IuserUser, foreign_keys=[user_id])
    

class ConversationAutoSave(Base, db.Model):
    __tablename__ = 'conversation_auto_save'

    id = Column(Integer, primary_key=True, nullable=False)
    user_id = Column(Integer, ForeignKey(IuserUser.id), nullable=False, default=0)
    obo_user_posted = Column(Integer, ForeignKey(IuserUser.id), nullable=False, default=None)
    recipient_user_id = Column(Integer, ForeignKey(IuserUser.id), nullable=False, default=0)
    received_by_server = Column(DateTime, nullable=False, default=datetime.utcnow)
    data = Column(Text, nullable=True, default=None)
    user = relationship(IuserUser, foreign_keys=[user_id])


class ConversationLatestPoll(Base, db.Model):
    __tablename__ = 'conversation_latest_poll'

    id = Column(Integer, primary_key=True, nullable=False)
    user_id = Column(Integer, ForeignKey(IuserUser.id), unique = True, nullable=False, default=0)
    latest_poll_timestamp = Column(BigInteger, nullable=False, default=0)
    latest_live_get_timestamp = Column(BigInteger, nullable=False, default=0)
    user = relationship(IuserUser, foreign_keys=[user_id])
