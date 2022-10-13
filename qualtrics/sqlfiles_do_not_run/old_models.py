# -*- coding: utf-8 -*-
import os, sys
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir, '../..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from sqlalchemy import Column, Integer, String, Date
from psycopg2 import * 
from sqlalchemy import *
from sqlalchemy.dialects.postgresql import *

from config.project_globals import *
from flask_login import UserMixin , login_user
from sqlalchemy.orm import relationship, backref
import sha, random
from sqlalchemy.ext.declarative import declarative_base

from legacy_models.iuser import IuserUser, USERTYPES
from legacy_models.member import MemberMember


class OldQualtricsInvites(Base, db.Model):
    __tablename__ = 'old_user_qualtrics_surveys'
    id = db.Column(db.Integer, primary_key=True)
    persona_id = db.Column(db.Integer)
    survey_id = db.Column(db.Integer)
    survey_invitation_status = db.Column(db.String(50))
    member_id = db.Column(db.Integer)
    invited_by = db.Column(db.Integer)
    date_invited = db.Column(db.Date)
    survey_link = db.Column(db.String(100))

    #def __repr__(self):
    #    return self.survey_invitation_status or ''

class OldQualtricsIDS(Base, db.Model):
    __tablename__ = 'old_qualtrics_ids'
    id = db.Column(db.Integer, primary_key=True)
    member_id = db.Column(db.Integer)
    survey_id = db.Column(db.Integer)
    panel_id = db.Column(db.String(50))
    distribution_id_mentor = db.Column(db.String(100))
    distribution_id_mentee = db.Column(db.String(100))
    start_date = db.Column(db.Date)
    end_date = db.Column(db.Date)
    library_id = db.Column(db.String(100))
    user_type = db.Column(db.String(50))

