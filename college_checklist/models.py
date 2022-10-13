# -*- coding: iso8859-15 -*-
import os,sys
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import db,Base,metadata

from sqlalchemy import (BigInteger, Boolean, Column, Date, DateTime,
    Float, ForeignKey, Index, Integer, Numeric, SmallInteger,
    String, Table, Text, Time, text)
from sqlalchemy.dialects.postgresql.base import INET, TSVECTOR
from sqlalchemy.orm import relationship

YES = 1
NO = 2
NOT_APPLICABLE = 3

TARGET = 1
SAFETY = 2
REACH = 3

ACCEPTED = 1
REJECTED = 2
WAITLISTED = 3

GOING = 1
NOT_GOING = 2

class UtilsCollege(Base,db.Model):
    __tablename__ = 'utils_college'

    id = Column(Integer, primary_key=True, server_default=text("nextval('utils_college_id_seq'::regclass)"))
    name = Column(String(100), nullable=False, unique=True)
    alias = Column(Text, nullable=True, unique=False)
    uni_system_name = Column(String(100), nullable=True, unique=False)
    county_name = Column(String(100), nullable=True, unique=False)
    longitude = Column(Numeric(16, 8), nullable=False, server_default="0")
    latitude = Column(Numeric(16, 8), nullable=False, server_default="0")


class CollegeChecklist(Base,db.Model):
    __tablename__ = 'college_checklist'

    id = Column(Integer, primary_key=True, server_default=text("nextval('college_checklist_id_seq'::regclass)"))
    college_id = Column(ForeignKey(u'utils_college.id'), nullable=False)
    college = relationship(UtilsCollege,backref="college_checklist", uselist=False)
    user_id = Column(ForeignKey(u'iuser_user.id'), nullable=False)
    user = relationship("IuserUser",backref="college_count", uselist=False)
    app_deadline = Column(Date, nullable=True, server_default=None)
    app_completion = Column(Integer, nullable=True, server_default="0") #Y/N
    app_review = Column(Integer, nullable=True, server_default="0") # Y/N/NA
    app_submission = Column(Date, nullable=True, server_default=None)
    fee_payment = Column(Integer, nullable=True, server_default="0") # Y/N/NA
    transcript_submission = Column(Integer, nullable=True, server_default="0")
    test_submission = Column(Integer, nullable=True, server_default="0")
    essay_submission = Column(Integer, nullable=True, server_default="0")
    recommendation_submission = Column(Integer, nullable=True, server_default="0")
    fafsa_submission = Column(Integer, nullable=True, server_default="0")
    category_id = Column(Integer, ForeignKey('college_category.id'), nullable=True, server_default="0") #target?
    result = Column(Integer, nullable=True, server_default="0") #accepted?
    choice = Column(Integer, nullable=True, server_default="0") #going?
    
class CollegeCategory(Base,db.Model):
    __tablename__ = 'college_category'

    id = Column(Integer, primary_key=True, server_default=text("nextval('college_category_id_seq'::regclass)"))
    ordinal = Column(Integer, nullable=False, server_default="0")
    name = Column(String(100), nullable=False, unique=True) #target?
