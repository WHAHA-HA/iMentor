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


class ThumbnailKvstore(Base,db.Model):
    __tablename__ = 'thumbnail_kvstore'

    key = Column(String(200), primary_key=True)
    value = Column(Text, nullable=False)


t_tmppartneryear = Table(
    'tmppartneryear', metadata,
    Column('partnerid', Integer),
    Column('school', String(30)),
    Column('grade', String(30)),
    Column('graduationyear', String(30))
)


