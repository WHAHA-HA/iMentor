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


class ResourcesResource(Base,db.Model):
    __tablename__ = 'resources_resource'

    id = Column(Integer, primary_key=True, server_default=text("nextval('resources_resource_id_seq'::regclass)"))
    creator_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), index=True)
    title = Column(String(256), nullable=False)
    description = Column(Text, nullable=False)
    is_featured = Column(Boolean, nullable=False, server_default="false")
    submit_date = Column(DateTime(True), nullable=False)
    date_modified = Column(DateTime(True), nullable=False)
    deadline = Column(DateTime(True))
    is_published = Column(Boolean, nullable=False, server_default="false")
    is_deleted = Column(Boolean, nullable=False, server_default="false")
    creation_member_id = Column(ForeignKey(u'member_member.id', deferrable=True, initially=u'DEFERRED'), index=True)
    status = Column(Integer, nullable=False)
    resource_type = Column(Integer, nullable=False)
    embed_code = Column(Text, nullable=False)
    link_name = Column(String(500), nullable=False)
    link = Column(String(500), nullable=False)
    photo_id = Column(ForeignKey(u'resources_resourcephoto.id', deferrable=True, initially=u'DEFERRED'), index=True)
    attachment_id = Column(ForeignKey(u'resources_resourceattachment.id', deferrable=True, initially=u'DEFERRED'), index=True)

    attachment = relationship(u'ResourcesResourceattachment')
    creation_member = relationship(u'MemberMember')
    creator = relationship(u'IuserUser')
    photo = relationship(u'ResourcesResourcephoto')


class ResourcesResourceCategory(Base,db.Model):
    __tablename__ = 'resources_resource_categories'

    id = Column(Integer, primary_key=True, server_default=text("nextval('resources_resource_categories_id_seq'::regclass)"))
    resource_id = Column(ForeignKey(u'resources_resource.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    resourcecategory_id = Column(ForeignKey(u'resources_resourcecategory.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    resource = relationship(u'ResourcesResource')
    resourcecategory = relationship(u'ResourcesResourcecategory')


class ResourcesResourceSubCategory(Base,db.Model):
    __tablename__ = 'resources_resource_sub_categories'

    id = Column(Integer, primary_key=True, server_default=text("nextval('resources_resource_sub_categories_id_seq'::regclass)"))
    resource_id = Column(ForeignKey(u'resources_resource.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    resourcesubcategory_id = Column(ForeignKey(u'resources_resourcesubcategory.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    resource = relationship(u'ResourcesResource')
    resourcesubcategory = relationship(u'ResourcesResourcesubcategory')


class ResourcesResourceTag(Base,db.Model):
    __tablename__ = 'resources_resource_tags'

    id = Column(Integer, primary_key=True, server_default=text("nextval('resources_resource_tags_id_seq'::regclass)"))
    resource_id = Column(ForeignKey(u'resources_resource.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    resourcetag_id = Column(ForeignKey(u'resources_resourcetag.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    resource = relationship(u'ResourcesResource')
    resourcetag = relationship(u'ResourcesResourcetag')


class ResourcesResourceadmin(Base,db.Model):
    __tablename__ = 'resources_resourceadmin'

    id = Column(Integer, primary_key=True, server_default=text("nextval('resources_resourceadmin_id_seq'::regclass)"))
    user_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    member_id = Column(ForeignKey(u'member_member.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    member = relationship(u'MemberMember')
    user = relationship(u'IuserUser')


class ResourcesResourceattachment(Base,db.Model):
    __tablename__ = 'resources_resourceattachment'

    id = Column(Integer, primary_key=True, server_default=text("nextval('resources_resourceattachment_id_seq'::regclass)"))
    attachment = Column(String(100), nullable=False)
    name = Column(String(100), nullable=False)


class ResourcesResourcecategory(Base,db.Model):
    __tablename__ = 'resources_resourcecategory'

    id = Column(Integer, primary_key=True, server_default=text("nextval('resources_resourcecategory_id_seq'::regclass)"))
    name = Column(String(256), nullable=False)
    order = Column(Integer)


class ResourcesResourcecategorysuggestion(Base,db.Model):
    __tablename__ = 'resources_resourcecategorysuggestion'

    id = Column(Integer, primary_key=True, server_default=text("nextval('resources_resourcecategorysuggestion_id_seq'::regclass)"))
    name = Column(String(256), nullable=False)
    user_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), index=True)
    submit_date = Column(DateTime(True), nullable=False)

    user = relationship(u'IuserUser')


class ResourcesResourcedigg(Base,db.Model):
    __tablename__ = 'resources_resourcediggs'

    id = Column(Integer, primary_key=True, server_default=text("nextval('resources_resourcediggs_id_seq'::regclass)"))
    member_id = Column(ForeignKey(u'member_member.id', deferrable=True, initially=u'DEFERRED'), index=True)
    resource_id = Column(ForeignKey(u'resources_resource.id', deferrable=True, initially=u'DEFERRED'), index=True)
    count = Column(Integer)

    member = relationship(u'MemberMember')
    resource = relationship(u'ResourcesResource')


class ResourcesResourcediggsUser(Base,db.Model):
    __tablename__ = 'resources_resourcediggs_users'

    id = Column(Integer, primary_key=True, server_default=text("nextval('resources_resourcediggs_users_id_seq'::regclass)"))
    resourcediggs_id = Column(ForeignKey(u'resources_resourcediggs.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    user_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    resourcediggs = relationship(u'ResourcesResourcedigg')
    user = relationship(u'IuserUser')


class ResourcesResourcephoto(Base,db.Model):
    __tablename__ = 'resources_resourcephoto'

    id = Column(Integer, primary_key=True, server_default=text("nextval('resources_resourcephoto_id_seq'::regclass)"))
    photo = Column(String(100), nullable=False)


class ResourcesResourcesubcategory(Base,db.Model):
    __tablename__ = 'resources_resourcesubcategory'

    id = Column(Integer, primary_key=True, server_default=text("nextval('resources_resourcesubcategory_id_seq'::regclass)"))
    name = Column(String(256), nullable=False)
    category_id = Column(ForeignKey(u'resources_resourcecategory.id', deferrable=True, initially=u'DEFERRED'), index=True)
    order = Column(Integer)

    category = relationship(u'ResourcesResourcecategory')


class ResourcesResourcesubcategorysuggestion(Base,db.Model):
    __tablename__ = 'resources_resourcesubcategorysuggestion'

    id = Column(Integer, primary_key=True, server_default=text("nextval('resources_resourcesubcategorysuggestion_id_seq'::regclass)"))
    name = Column(String(256), nullable=False)
    user_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), index=True)
    submit_date = Column(DateTime(True), nullable=False)
    category_id = Column(ForeignKey(u'resources_resourcecategory.id', deferrable=True, initially=u'DEFERRED'), index=True)

    category = relationship(u'ResourcesResourcecategory')
    user = relationship(u'IuserUser')


class ResourcesResourcetag(Base,db.Model):
    __tablename__ = 'resources_resourcetag'

    id = Column(Integer, primary_key=True, server_default=text("nextval('resources_resourcetag_id_seq'::regclass)"))
    name = Column(String(256), nullable=False)


class ResourcesResourceview(Base,db.Model):
    __tablename__ = 'resources_resourceviews'

    id = Column(Integer, primary_key=True, server_default=text("nextval('resources_resourceviews_id_seq'::regclass)"))
    member_id = Column(ForeignKey(u'member_member.id', deferrable=True, initially=u'DEFERRED'), index=True)
    resource_id = Column(ForeignKey(u'resources_resource.id', deferrable=True, initially=u'DEFERRED'), index=True)
    count = Column(Integer)

    member = relationship(u'MemberMember')
    resource = relationship(u'ResourcesResource')


class ResourcesResourceviewsUser(Base,db.Model):
    __tablename__ = 'resources_resourceviews_users'

    id = Column(Integer, primary_key=True, server_default=text("nextval('resources_resourceviews_users_id_seq'::regclass)"))
    resourceviews_id = Column(ForeignKey(u'resources_resourceviews.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    user_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    resourceviews = relationship(u'ResourcesResourceview')
    user = relationship(u'IuserUser')


class ResourcesSavedresource(Base,db.Model):
    __tablename__ = 'resources_savedresource'

    id = Column(Integer, primary_key=True, server_default=text("nextval('resources_savedresource_id_seq'::regclass)"))
    user_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), index=True)
    resource_id = Column(ForeignKey(u'resources_resource.id', deferrable=True, initially=u'DEFERRED'), index=True)
    date_saved = Column(DateTime(True), nullable=False)
    order = Column(Integer)

    resource = relationship(u'ResourcesResource')
    user = relationship(u'IuserUser')


