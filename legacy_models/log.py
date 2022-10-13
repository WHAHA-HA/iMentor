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
from legacy_models.auth import AuthUser
from legacy_models.django import DjangoContentType

# Used for logging events in new code.
CONTENT_TYPE_USER=44

class LogLog(Base,db.Model):
    __tablename__ = 'log_log'

    id = Column(Integer, primary_key=True, server_default=text("nextval('log_log_id_seq'::regclass)"))
    content_type_id = Column(ForeignKey(u'django_content_type.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    object_id = Column(Integer, nullable=False, index=True)
    message = Column(Text, nullable=False)
    category = Column(String(200), nullable=False, index=True)
    datetime = Column(DateTime(True), nullable=False, index=True)

    content_type = relationship(u'DjangoContentType')


class LogMonitoringlog(Base,db.Model):
    __tablename__ = 'log_monitoringlog'

    id = Column(Integer, primary_key=True, server_default=text("nextval('log_monitoringlog_id_seq'::regclass)"))
    status = Column(Integer, nullable=False)
    message = Column(Text, nullable=False)
    data = Column(Text, nullable=False)
    datetime = Column(DateTime(True), nullable=False)


