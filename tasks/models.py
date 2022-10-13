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
from sqlalchemy.orm import relationship
from legacy_models.member import MemberMember
from legacy_models.iuser import (IuserUser,IuserPersona,
    MENTOR,USERTYPE_MAP)
from new_platform.utils.user_details import (get_persona_obj_for_user,
    get_latest_mentee_user_for_mentor, get_latest_mentor_user_for_mentee,
    get_partners_for_user,get_persona_for_user)
from new_platform.utils.roles import Role

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class Rating(Base,db.Model):
    __tablename__ = 'tasks_ratings'

    id = Column(Integer, primary_key=True, nullable=False, server_default=text("nextval('tasks_ratings_id_seq'::regclass)"))
    mentee_persona_id = Column(Integer, ForeignKey(u'iuser_persona.id'), nullable=False)
    mentor_persona_id = Column(Integer, ForeignKey(u'iuser_persona.id'), nullable=False)
    # Note that the mentor_rating field refers to the rating that the mentor received from the mentee.
    # Likewise, the mentor_rated_on field refers to the date on which the mentor was rated by the mentee.
    # The inverse is true for mentee_rating and mentee_rated_on.
    mentor_rating = Column(Integer, nullable=True, server_default="null")
    mentee_rating = Column(Integer, nullable=True, server_default="null")
    mentor_rated_on = Column(DateTime, nullable=True)
    mentee_rated_on = Column(DateTime, nullable=True)    
    mentee_user_id = Column(Integer, ForeignKey(u'iuser_user.id'), nullable=False)
    mentor_user_id = Column(Integer, ForeignKey(u'iuser_user.id'), nullable=False)    
    #period_id = Column(Integer, ForeignKey(u'tasks_ratings_period.id'), nullable=False)    
    mentee_persona = db.relationship(u'IuserPersona', foreign_keys = [mentee_persona_id])
    mentor_persona = db.relationship(u'IuserPersona', foreign_keys = [mentor_persona_id])
    #period = db.relationship(u'Period', foreign_keys = [period_id])


class RatingPeriod(Base,db.Model):
    __tablename__ = 'tasks_ratings_period'

    id = Column(Integer, primary_key=True, nullable=False, server_default=text("nextval('tasks_ratings_period_id_seq'::regclass)"))
    frequency_month = Column(Integer, nullable=False, server_default="1")
    # These frequency values are normally 0, and exist mostly for testing.
    frequency_day = Column(Integer, nullable=False, server_default="0")
    frequency_hour = Column(Integer, nullable=False, server_default="0")
    frequency_minute = Column(Integer, nullable=False, server_default="0")
    #start_date = Column(DateTime, nullable=True,default=datetime.now)
    start_date = Column(Date, nullable=False,default=datetime.now)
    __table_args__ = (UniqueConstraint('frequency_month', 'start_date'),)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class Announcement(Base,db.Model):
    __tablename__ = 'tasks_announcement'
    id = Column(Integer, primary_key=True, nullable=False, server_default=text("nextval('tasks_announcement_id_seq'::regclass)"))
    announcement_description = Column(Text, nullable=False, server_default="NOT SET")
    announcement_html = Column(Text, nullable=False, server_default="NOT SET")
    start_date = Column(DateTime, nullable=True,default=datetime.utcnow) # No time zone, UTC
    end_date = Column(DateTime, nullable=True,default=datetime.utcnow) # No time zone, UTC
    is_active = Column(Boolean, nullable=False,default=True)

class AnnouncementAck(Base,db.Model):
    __tablename__ = 'tasks_announcement_ack'
    id = Column(Integer, primary_key=True, nullable=False, server_default=text("nextval('tasks_announcement_ack_id_seq'::regclass)"))
    announcement_id = Column(Integer, ForeignKey(u'tasks_announcement.id'), nullable=False)    
    user_id = Column(Integer, ForeignKey(u'iuser_user.id'), nullable=False)
    user_acked_date = Column(DateTime, nullable=False,default=datetime.utcnow) # No time zone, UTC
    announcement = db.relationship(u'Announcement', foreign_keys = [announcement_id])

class AnnouncementLocal(Base,db.Model):
    __tablename__ = 'tasks_announcement_localization'
    id = Column(Integer, primary_key=True, nullable=False, server_default=text("nextval('tasks_announcement_localization_id_seq'::regclass)"))
    announcement_id = Column(Integer, ForeignKey(u'tasks_announcement.id'), nullable=False)    
    # Either member or partner should be set, allowing for varying granularity.
    member_id = Column(Integer, ForeignKey(u'member_member.id'), nullable=True, default=None)
    partner_id = Column(Integer, ForeignKey(u'partners_partner.id'), nullable=True, default=None)
    role_id = Column(Integer, nullable=False, default=MENTOR)
    announcement = db.relationship(u'Announcement', foreign_keys = [announcement_id])
    __table_args__ = (UniqueConstraint('announcement_id', 'member_id','partner_id','role_id'),)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class RecurringInfoUpdate(Base,db.Model):
    __tablename__ = 'tasks_recurring_info_update'
    id = Column(Integer, primary_key=True, nullable=False, server_default=text("nextval('tasks_recurring_info_update_id_seq'::regclass)"))
    info_description = Column(Text, nullable=False, server_default="NOT SET")
    interval_days = Column(Integer, nullable=False, default=180)
    is_active = Column(Boolean, nullable=False,default=True)

class RecurringInfoUpdateAck(Base,db.Model):
    __tablename__ = 'tasks_recurring_info_update_ack'
    id = Column(Integer, primary_key=True, nullable=False, server_default=text("nextval('tasks_recurring_info_update_ack_id_seq'::regclass)"))
    recurring_info_update_id = Column(Integer, ForeignKey(u'tasks_recurring_info_update.id'), nullable=False)    
    user_id = Column(Integer, ForeignKey(u'iuser_user.id'), nullable=False)
    user_acked_date = Column(DateTime, nullable=False,default=datetime.utcnow) # No time zone, UTC
    recurring_info_update = db.relationship(u'RecurringInfoUpdate', foreign_keys = [recurring_info_update_id])

class RecurringInfoUpdateLocal(Base,db.Model):
    __tablename__ = 'tasks_recurring_info_update_localization'
    id = Column(Integer, primary_key=True, nullable=False, server_default=text("nextval('tasks_recurring_info_update_localization_id_seq'::regclass)"))
    recurring_info_update_id = Column(Integer, ForeignKey(u'tasks_recurring_info_update.id'), nullable=False)    
    # Either member or partner should be set, allowing for varying granularity.
    member_id = Column(Integer, ForeignKey(u'member_member.id'), nullable=True, default=None)
    partner_id = Column(Integer, ForeignKey(u'partners_partner.id'), nullable=True, default=None)
    role_id = Column(Integer, nullable=False, default=MENTOR)
    recurring_info_update = db.relationship(u'RecurringInfoUpdate', foreign_keys = [recurring_info_update_id])
    __table_args__ = (UniqueConstraint('recurring_info_update_id', 'member_id','partner_id','role_id'),)
