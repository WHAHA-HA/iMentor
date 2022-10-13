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

from config.settings import ESEARCH_INDEXED_APPS
from config.project_globals import db,Base,metadata
from legacy_models.iuser import IuserUser,IuserPersona
from legacy_models.partners import PartnersPartner

#Import 'app' object from auth as well
from auth import api, app

from flask import current_app, request, redirect, render_template

from sqlalchemy import (BigInteger, Boolean, Column, Date, DateTime,
    Float, ForeignKey, Index, Integer, Numeric, SmallInteger,
    String, Table, Text, Time, text, DATE, func, UniqueConstraint)
from sqlalchemy.dialects.postgresql.base import INET, TSVECTOR
from sqlalchemy.sql.expression import func, or_, not_, and_
from sqlalchemy.orm import relationship
from legacy_models.member import MemberMember
from legacy_models.iuser import IuserUser,IuserPersona,USERTYPE_MAP
from utils.user_details import (get_persona_obj_for_user,
    get_latest_mentee_user_for_mentor, get_latest_mentor_user_for_mentee,
    get_partners_for_user)
from utils.roles import Role

ALERT_FREQUENCY_HOURLY = 1
ALERT_FREQUENCY_DAILY  = 2

SAFETY_CHECK_CANVAS        =1
SAFETY_CHECK_PORTFOLIO     =2
SAFETY_CHECK_CONVERSATIONS =3

SAFETY_APPS = ESEARCH_INDEXED_APPS.keys()

SAFETY_APP_NAMES = {
    'canvas':       'Canvas',
    'portfolio':    'Portfolio',
    'conversation': 'Conversations'
    }

SAFETY_FREQUENCY = {
    ALERT_FREQUENCY_HOURLY:'Hourly',
    ALERT_FREQUENCY_DAILY:'Daily'
    }

# Safety app settings are a combo of global elasticsearch settings and
# those specific to safety DB tables and app lookup URLs.
# This makes code a bit abstract, but unified into one chunk, and
# easily configurable from here and config/settings/__init__.py
APP_SETTINGS = {
    'canvas': {
     'url':'/canvas/lesson/{1}/{0}/',      # Relative url for back link. Position 0 always = user_id
     'text_field_name':ESEARCH_INDEXED_APPS['canvas']['main_text_field'],  # Field name to search for safety words.
     'url_field1':'canvas_set_parent_id',  # Field containing ID for content URL.
     'app_name':ESEARCH_INDEXED_APPS['canvas']['index'],
     'app_id': SAFETY_CHECK_CANVAS,        #
     'doc_type':ESEARCH_INDEXED_APPS['canvas']['doc_type'] # app_name/doc_type for elasticsearch path, i.e., canvas/response
     },
    'conversation': {
     'url':'/snapshot/#/?user={0}&start={1}&end={2}', # Relative url for back link. Position 0 always = user id
     'text_field_name':ESEARCH_INDEXED_APPS['conversation']['main_text_field'], # Field name to search for safety words.
     'url_field1':'received_by_server',              # Field containing ID for content URL.
     'app_name':ESEARCH_INDEXED_APPS['conversation']['index'],
     'app_id': SAFETY_CHECK_CONVERSATIONS, #
     'doc_type':ESEARCH_INDEXED_APPS['conversation']['doc_type']  # app_name/doc_type for elasticsearch path, i.e., conversation/message
     },
    'portfolio': {
     'url':'/portfolio/{0}/#/grade/{1}/unit/{2}/', # Relative url for back link. Position 0 always = user id
     'text_field_name':ESEARCH_INDEXED_APPS['portfolio']['main_text_field'],  # Field name to search for safety words.
     'url_field1':'grade_id',               # Field containing ID for content URL.
     'url_field2':'unit_id',                # Field containing ID for content URL.
     'app_name':ESEARCH_INDEXED_APPS['portfolio']['index'],
     'app_id': SAFETY_CHECK_PORTFOLIO,     #
     'doc_type':ESEARCH_INDEXED_APPS['portfolio']['doc_type'] # app_name/doc_type for elasticsearch path, i.e., portfolio/reflection
     }
}


class SafetyWordSource(Base, db.Model):
    # This is the external source of the word: The national/state list used, etc.
    __tablename__ = 'safety_word_source'
    id = Column(Integer, primary_key=True, nullable=False)
    name = Column(String(300), nullable=False, default="Not Set")

class SafetyWordContact(Base, db.Model):
    __tablename__ = 'safety_word_contact'
    id = Column(Integer, primary_key=True, nullable=False)
    # None = default to the current partners_partner.member_contact_id
    alert_recipient_user_id = Column(Integer, ForeignKey(IuserUser.id), nullable=True, default=None)
    # This is a comma-separated list of emails.
    additional_recipient_emails = Column(Text, nullable=True, default=None)
    __table_args__ = (UniqueConstraint('alert_recipient_user_id','additional_recipient_emails'),) 

class SafetyPhrase(Base, db.Model):
    __tablename__ = 'safety_phrase'
    id = Column(Integer, primary_key=True, nullable=False)
    word_or_phrase = Column(String(200), nullable=False, default="Not Set")
    word_source_id = Column(Integer, ForeignKey(SafetyWordSource.id), nullable=False, default=0)
    # Member and partner sites are optional. Default is all if not set.
    member_site_id = Column(Integer, ForeignKey(MemberMember.id), nullable=True, default=None)
    partner_site_id = Column(Integer, ForeignKey(PartnersPartner.id), nullable=True, default=None)
    # None = default to the current partners_partner.member_contact_id, no additional email contacts.
    alert_user_info_id = Column(Integer, ForeignKey(SafetyWordContact.id), nullable=True, default=None)
    alert_frequency = Column(Integer, nullable=False, default=ALERT_FREQUENCY_DAILY)
    __table_args__ = (UniqueConstraint('word_or_phrase','member_site_id','partner_site_id'),) 
    alert_user = relationship(SafetyWordContact,foreign_keys=[alert_user_info_id])

class SafetyCheckTracking(Base, db.Model):
    __tablename__ = 'safety_check_tracking'
    id = Column(Integer, primary_key=True, nullable=False)
    # Canvas, portfolio, conversations, etc
    app = Column(Integer, nullable=False, default=0)
    frequency = Column(Integer, nullable=False, default=0)
    epoch_time_last_checked = Column(BigInteger, nullable=False, default=0)
    __table_args__ = (UniqueConstraint('app', 'frequency'),) 
