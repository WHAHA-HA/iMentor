# -*- coding: iso8859-15 -*-
import os,sys
from datetime import datetime
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


class MailerDontsendentry(Base,db.Model):
    __tablename__ = 'mailer_dontsendentry'

    id = Column(Integer, primary_key=True, server_default=text("nextval('mailer_dontsendentry_id_seq'::regclass)"))
    to_address = Column(String(50), nullable=False)
    when_added = Column(DateTime(True), nullable=False)


class MailerMessage(Base,db.Model):
    __tablename__ = 'mailer_message'

    id = Column(Integer, primary_key=True, server_default=text("nextval('mailer_message_id_seq'::regclass)"))
    to_address = Column(String(50), nullable=False)
    from_address = Column(String(50), nullable=False)
    subject = Column(String(100), nullable=False)
    message_body = Column(Text, nullable=False)
    when_added = Column(DateTime(True), nullable=False, default=datetime.now)
    priority = Column(String(1), nullable=False, server_default=text("'2'::character varying"))
    content_subtype = Column(String(100), nullable=False, server_default=text("''::character varying"))


class MailerMessagelog(Base,db.Model):
    __tablename__ = 'mailer_messagelog'

    id = Column(Integer, primary_key=True, server_default=text("nextval('mailer_messagelog_id_seq'::regclass)"))
    to_address = Column(String(50), nullable=False)
    from_address = Column(String(50), nullable=False)
    subject = Column(String(100), nullable=False)
    message_body = Column(Text, nullable=False)
    when_added = Column(DateTime(True), nullable=False)
    priority = Column(String(1), nullable=False)
    when_attempted = Column(DateTime(True), nullable=False, server_default=text("'2009-01-21 01:05:53.202977-05'::timestamp with time zone"))
    result = Column(String(1), nullable=False)
    log_message = Column(Text, nullable=False)


