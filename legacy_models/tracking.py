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


class TrackingBannedip(Base,db.Model):
    __tablename__ = 'tracking_bannedip'

    id = Column(Integer, primary_key=True, server_default=text("nextval('tracking_bannedip_id_seq'::regclass)"))
    ip_address = Column(INET, nullable=False)


class TrackingUntrackeduseragent(Base,db.Model):
    __tablename__ = 'tracking_untrackeduseragent'

    id = Column(Integer, primary_key=True, server_default=text("nextval('tracking_untrackeduseragent_id_seq'::regclass)"))
    keyword = Column(String(100), nullable=False)


class TrackingVisitor(Base,db.Model):
    __tablename__ = 'tracking_visitor'
    __table_args__ = (
        Index('tracking_visitor_session_key_ea8579ea9a3e2cf_uniq', 'session_key', 'ip_address', unique=True),
    )

    id = Column(Integer, primary_key=True, server_default=text("nextval('tracking_visitor_id_seq'::regclass)"))
    session_key = Column(String(40), nullable=False)
    ip_address = Column(String(20), nullable=False)
    user_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), index=True)
    user_agent = Column(String(255), nullable=False)
    referrer = Column(String(255), nullable=False)
    url = Column(String(255), nullable=False)
    page_views = Column(Integer, nullable=False, server_default="0")
    session_start = Column(DateTime(True), nullable=False)
    last_update = Column(DateTime(True), nullable=False)

    user = relationship(u'IuserUser')


