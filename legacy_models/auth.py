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


class AuthGroup(Base,db.Model):
    __tablename__ = 'auth_group'

    id = Column(Integer, primary_key=True, server_default=text("nextval('auth_group_id_seq'::regclass)"))
    name = Column(String(80), nullable=False, unique=True)


class AuthGroupPermission(Base,db.Model):
    __tablename__ = 'auth_group_permissions'
    __table_args__ = (
        Index('auth_group_permissions_group_id_key', 'group_id', 'permission_id', unique=True),
    )

    id = Column(Integer, primary_key=True, server_default=text("nextval('auth_group_permissions_id_seq'::regclass)"))
    group_id = Column(ForeignKey(u'auth_group.id', deferrable=True, initially=u'DEFERRED'), nullable=False)
    permission_id = Column(ForeignKey(u'auth_permission.id', deferrable=True, initially=u'DEFERRED'), nullable=False)

    group = relationship(u'AuthGroup')
    permission = relationship(u'AuthPermission')


class AuthMessage(Base,db.Model):
    __tablename__ = 'auth_message'

    id = Column(Integer, primary_key=True, server_default=text("nextval('auth_message_id_seq'::regclass)"))
    user_id = Column(ForeignKey(u'auth_user.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    message = Column(Text, nullable=False)

    user = relationship(u'AuthUser')


class AuthPermission(Base,db.Model):
    __tablename__ = 'auth_permission'
    __table_args__ = (
        Index('auth_permission_content_type_id_key', 'content_type_id', 'codename', unique=True),
    )

    id = Column(Integer, primary_key=True, server_default=text("nextval('auth_permission_id_seq'::regclass)"))
    name = Column(String(50), nullable=False)
    content_type_id = Column(ForeignKey(u'django_content_type.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    codename = Column(String(100), nullable=False)

    content_type = relationship(u'DjangoContentType')


class AuthUser(Base,db.Model):
    __tablename__ = 'auth_user'

    id = Column(Integer, primary_key=True, server_default=text("nextval('auth_user_id_seq'::regclass)"))
    username = Column(String(30), nullable=False, unique=True)
    first_name = Column(String(30), nullable=False)
    last_name = Column(String(30), nullable=False)
    email = Column(String(75), nullable=False)
    password = Column(String(128), nullable=False)
    is_staff = Column(Boolean, nullable=False)
    is_active = Column(Boolean, nullable=False)
    is_superuser = Column(Boolean, nullable=False)
    last_login = Column(DateTime(True), nullable=False)
    date_joined = Column(DateTime(True), nullable=False)


class AuthUserGroup(Base,db.Model):
    __tablename__ = 'auth_user_groups'
    __table_args__ = (
        Index('auth_user_groups_user_id_key', 'user_id', 'group_id', unique=True),
    )

    id = Column(Integer, primary_key=True, server_default=text("nextval('auth_user_groups_id_seq'::regclass)"))
    user_id = Column(ForeignKey(u'auth_user.id', deferrable=True, initially=u'DEFERRED'), nullable=False)
    group_id = Column(ForeignKey(u'auth_group.id', deferrable=True, initially=u'DEFERRED'), nullable=False)

    group = relationship(u'AuthGroup')
    user = relationship(u'AuthUser')


class AuthUserUserPermission(Base,db.Model):
    __tablename__ = 'auth_user_user_permissions'
    __table_args__ = (
        Index('auth_user_user_permissions_user_id_key', 'user_id', 'permission_id', unique=True),
    )

    id = Column(Integer, primary_key=True, server_default=text("nextval('auth_user_user_permissions_id_seq'::regclass)"))
    user_id = Column(ForeignKey(u'auth_user.id', deferrable=True, initially=u'DEFERRED'), nullable=False)
    permission_id = Column(ForeignKey(u'auth_permission.id', deferrable=True, initially=u'DEFERRED'), nullable=False)

    permission = relationship(u'AuthPermission')
    user = relationship(u'AuthUser')


