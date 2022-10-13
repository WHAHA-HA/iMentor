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


class DjangoAdminLog(Base,db.Model):
    __tablename__ = 'django_admin_log'

    id = Column(Integer, primary_key=True, server_default=text("nextval('django_admin_log_id_seq'::regclass)"))
    action_time = Column(DateTime(True), nullable=False)
    user_id = Column(ForeignKey(u'auth_user.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    content_type_id = Column(ForeignKey(u'django_content_type.id', deferrable=True, initially=u'DEFERRED'), index=True)
    object_id = Column(Text)
    object_repr = Column(String(200), nullable=False)
    action_flag = Column(SmallInteger, nullable=False)
    change_message = Column(Text, nullable=False)

    content_type = relationship(u'DjangoContentType')
    user = relationship(u'AuthUser')


class DjangoContentType(Base,db.Model):
    __tablename__ = 'django_content_type'
    __table_args__ = (
        Index('django_content_type_app_label_key', 'app_label', 'model', unique=True),
    )

    id = Column(Integer, primary_key=True, server_default=text("nextval('django_content_type_id_seq'::regclass)"))
    name = Column(String(100), nullable=False)
    app_label = Column(String(100), nullable=False)
    model = Column(String(100), nullable=False)


class DjangoSession(Base,db.Model):
    __tablename__ = 'django_session'

    session_key = Column(String(40), primary_key=True)
    session_data = Column(Text, nullable=False)
    expire_date = Column(DateTime(True), nullable=False)


class DjangodblogDateglitchtest(Base,db.Model):
    __tablename__ = 'djangodblog_dateglitchtest'

    id = Column(Integer, primary_key=True, server_default=text("nextval('djangodblog_dateglitchtest_id_seq'::regclass)"))
    message = Column(Text, nullable=False)
    def_datetime_now = Column(DateTime(True), nullable=False)
    datetime_now = Column(DateTime(True), nullable=False)
    user_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    server_name = Column(String(128), nullable=False)
    char_date = Column(String(128), nullable=False, server_default=text("''::character varying"))
    sys_date = Column(Integer, nullable=False, server_default="0")
    db_date = Column(DateTime(True))

    user = relationship(u'IuserUser')


class DjangodblogError(Base,db.Model):
    __tablename__ = 'djangodblog_error'

    id = Column(Integer, primary_key=True, server_default=text("nextval('djangodblog_error_id_seq'::regclass)"))
    class_name = Column(String(128), nullable=False)
    message = Column(Text, nullable=False)
    traceback = Column(Text, nullable=False)
    datetime = Column(DateTime(True), nullable=False, server_default=text("'2009-04-17 23:19:56.980329-04'::timestamp with time zone"))
    url = Column(String(200))
    server_name = Column(String(128), nullable=False, index=True)


class DjangodblogErrorbatch(Base,db.Model):
    __tablename__ = 'djangodblog_errorbatch'
    __table_args__ = (
        Index('djangodblog_errorbatch_class_name_66461e165a2044d4', 'class_name', 'server_name', 'checksum', unique=True),
    )

    id = Column(Integer, primary_key=True, server_default=text("nextval('djangodblog_errorbatch_id_seq'::regclass)"))
    class_name = Column(String(128), nullable=False)
    message = Column(Text, nullable=False)
    traceback = Column(Text, nullable=False)
    is_resolved = Column(Boolean, nullable=False, server_default="false")
    times_seen = Column(Integer, nullable=False, server_default=text("1"))
    last_seen = Column(DateTime(True), nullable=False, server_default=text("'2009-04-17 23:19:56.916415-04'::timestamp with time zone"))
    first_seen = Column(DateTime(True), nullable=False, server_default=text("'2009-04-17 23:19:56.916463-04'::timestamp with time zone"))
    url = Column(String(200))
    server_name = Column(String(128), nullable=False, index=True)
    checksum = Column(String(32), nullable=False, index=True)


