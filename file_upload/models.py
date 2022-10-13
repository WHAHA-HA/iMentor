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

from legacy_models.iuser import IuserUser

# Make this larger to avoid the 80,000 recommended inode limit (max files per dir, max dirs per dir).
# Right now we're accommodating about 100K users. 
MAX_BINS = 1000 

class FileUploadAllowList(Base, db.Model):
    __tablename__ = 'file_upload_allow_list'

    id = Column(Integer, primary_key=True, nullable=False)
    file_extension = Column(String(30), unique=True, nullable=False, default='Not Set')

class FileUploadUserBin(Base, db.Model):
    __tablename__ = 'file_upload_user_bin'

    id = Column(Integer, primary_key=True, nullable=False)
    user_id = Column(Integer, ForeignKey(IuserUser.id), unique=True, nullable=False, default=0)
    # This is a zero-padded number preceeded with a 'B', to make sorting easier.
    bin_name = Column(String(20), nullable=False, default='Not Set')

class FileUploadLatestBinNum(Base, db.Model):
    __tablename__ = 'file_upload_latest_bin_num'

    # Bins are created/used on a round-robin basis. This is a rolling counter.
    # There should only be one record.
    id = Column(Integer, primary_key=True, nullable=False)
    latest_bin_num = Column(Integer, nullable=False, default=1)
