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


class SouthMigrationhistory(Base,db.Model):
    __tablename__ = 'south_migrationhistory'

    id = Column(Integer, primary_key=True, server_default=text("nextval('south_migrationhistory_id_seq'::regclass)"))
    app_name = Column(String(255), nullable=False)
    migration = Column(String(255), nullable=False)
    applied = Column(DateTime(True))


