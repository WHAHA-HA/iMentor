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


class PermissionsAssignedcategory(Base,db.Model):
    __tablename__ = 'permissions_assignedcategory'

    id = Column(Integer, primary_key=True, server_default=text("nextval('permissions_assignedcategory_id_seq'::regclass)"))
    member_id = Column(ForeignKey(u'member_member.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    category_id = Column(ForeignKey(u'permissions_category.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    enabled = Column(Boolean, nullable=False, server_default="true")

    category = relationship(u'PermissionsCategory')
    member = relationship(u'MemberMember')


class PermissionsAssignedpermission(Base,db.Model):
    __tablename__ = 'permissions_assignedpermission'
    __table_args__ = (
        Index('permissions_assignedpermission_assignedusertype_id_20cb15bbde6e', 'assignedusertype_id', 'permission_id', unique=True),
    )

    id = Column(Integer, primary_key=True, server_default=text("nextval('permissions_assignedpermission_id_seq'::regclass)"))
    assignedusertype_id = Column(ForeignKey(u'iuser_assignedusertype.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    permission_id = Column(ForeignKey(u'permissions_permission.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    assignedusertype = relationship(u'IuserAssignedusertype')
    permission = relationship(u'PermissionsPermission')


class PermissionsCategory(Base,db.Model):
    __tablename__ = 'permissions_category'

    id = Column(Integer, primary_key=True, server_default=text("nextval('permissions_category_id_seq'::regclass)"))
    name = Column(String(200), nullable=False, unique=True)
    order = Column(SmallInteger, nullable=False)


class PermissionsPermission(Base,db.Model):
    __tablename__ = 'permissions_permission'

    id = Column(Integer, primary_key=True, server_default=text("nextval('permissions_permission_id_seq'::regclass)"))
    code = Column(String(100), nullable=False, unique=True)
    description = Column(String(200), nullable=False)
    category_id = Column(ForeignKey(u'permissions_category.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    fine_grained = Column(Boolean, nullable=False, server_default="false")
    order = Column(SmallInteger, nullable=False)

    category = relationship(u'PermissionsCategory')


