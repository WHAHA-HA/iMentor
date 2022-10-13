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


class SmarttagsSmarttag(Base,db.Model):
    __tablename__ = 'smarttags_smarttag'
    __table_args__ = (
        Index('smarttags_smarttag_key_e6c41a46ae83d95', 'key', 'tag'),
    )

    id = Column(Integer, primary_key=True, server_default=text("nextval('smarttags_smarttag_id_seq'::regclass)"))
    tag = Column(String(100), nullable=False)
    key = Column(String(100), nullable=False)
    attribute = Column(String(100), nullable=False)


