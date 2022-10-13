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


class ToolkitsSavedtoolkit(Base,db.Model):
    __tablename__ = 'toolkits_savedtoolkit'

    id = Column(Integer, primary_key=True, server_default=text("nextval('toolkits_savedtoolkit_id_seq'::regclass)"))
    user_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), index=True)
    toolkit_id = Column(ForeignKey(u'toolkits_toolkit.id', deferrable=True, initially=u'DEFERRED'), index=True)
    date_saved = Column(DateTime(True), nullable=False)
    order = Column(Integer)

    toolkit = relationship(u'ToolkitsToolkit')
    user = relationship(u'IuserUser')


class ToolkitsToolkit(Base,db.Model):
    __tablename__ = 'toolkits_toolkit'

    id = Column(Integer, primary_key=True, server_default=text("nextval('toolkits_toolkit_id_seq'::regclass)"))
    creator_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), index=True)
    title = Column(String(256), nullable=False)
    description = Column(Text, nullable=False)
    is_featured = Column(Boolean, nullable=False, server_default="false")
    submit_date = Column(DateTime(True), nullable=False)
    date_modified = Column(DateTime(True), nullable=False)
    deadline = Column(DateTime(True))
    is_published = Column(Boolean, nullable=False, server_default="false")
    is_deleted = Column(Boolean, nullable=False, server_default="false")
    status = Column(Integer, nullable=False)
    toolkit_type = Column(Integer, nullable=False)
    embed_code = Column(String(500), nullable=False)
    link_name = Column(String(500), nullable=False)
    link = Column(String(500), nullable=False)
    attachment_id = Column(ForeignKey(u'toolkits_toolkitattachment.id', deferrable=True, initially=u'DEFERRED'), index=True)
    photo_id = Column(ForeignKey(u'toolkits_toolkitphoto.id', deferrable=True, initially=u'DEFERRED'), index=True)

    attachment = relationship(u'ToolkitsToolkitattachment')
    creator = relationship(u'IuserUser')
    photo = relationship(u'ToolkitsToolkitphoto')


class ToolkitsToolkitCategory(Base,db.Model):
    __tablename__ = 'toolkits_toolkit_categories'

    id = Column(Integer, primary_key=True, server_default=text("nextval('toolkits_toolkit_categories_id_seq'::regclass)"))
    toolkit_id = Column(ForeignKey(u'toolkits_toolkit.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    toolkitcategory_id = Column(ForeignKey(u'toolkits_toolkitcategory.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    toolkit = relationship(u'ToolkitsToolkit')
    toolkitcategory = relationship(u'ToolkitsToolkitcategory')


class ToolkitsToolkitSubCategory(Base,db.Model):
    __tablename__ = 'toolkits_toolkit_sub_categories'

    id = Column(Integer, primary_key=True, server_default=text("nextval('toolkits_toolkit_sub_categories_id_seq'::regclass)"))
    toolkit_id = Column(ForeignKey(u'toolkits_toolkit.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    toolkitsubcategory_id = Column(ForeignKey(u'toolkits_toolkitsubcategory.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    toolkit = relationship(u'ToolkitsToolkit')
    toolkitsubcategory = relationship(u'ToolkitsToolkitsubcategory')


class ToolkitsToolkitTag(Base,db.Model):
    __tablename__ = 'toolkits_toolkit_tags'

    id = Column(Integer, primary_key=True, server_default=text("nextval('toolkits_toolkit_tags_id_seq'::regclass)"))
    toolkit_id = Column(ForeignKey(u'toolkits_toolkit.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    toolkittag_id = Column(ForeignKey(u'toolkits_toolkittag.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    toolkit = relationship(u'ToolkitsToolkit')
    toolkittag = relationship(u'ToolkitsToolkittag')


class ToolkitsToolkitattachment(Base,db.Model):
    __tablename__ = 'toolkits_toolkitattachment'

    id = Column(Integer, primary_key=True, server_default=text("nextval('toolkits_toolkitattachment_id_seq'::regclass)"))
    attachment = Column(String(100), nullable=False)
    name = Column(String(100), nullable=False)


class ToolkitsToolkitcategory(Base,db.Model):
    __tablename__ = 'toolkits_toolkitcategory'

    id = Column(Integer, primary_key=True, server_default=text("nextval('toolkits_toolkitcategory_id_seq'::regclass)"))
    name = Column(String(256), nullable=False)
    order = Column(Integer)


class ToolkitsToolkitcategorysuggestion(Base,db.Model):
    __tablename__ = 'toolkits_toolkitcategorysuggestion'

    id = Column(Integer, primary_key=True, server_default=text("nextval('toolkits_toolkitcategorysuggestion_id_seq'::regclass)"))
    name = Column(String(256), nullable=False)
    user_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), index=True)
    submit_date = Column(DateTime(True), nullable=False)

    user = relationship(u'IuserUser')


class ToolkitsToolkitdigg(Base,db.Model):
    __tablename__ = 'toolkits_toolkitdiggs'

    id = Column(Integer, primary_key=True, server_default=text("nextval('toolkits_toolkitdiggs_id_seq'::regclass)"))
    member_id = Column(ForeignKey(u'member_member.id', deferrable=True, initially=u'DEFERRED'), index=True)
    toolkit_id = Column(ForeignKey(u'toolkits_toolkit.id', deferrable=True, initially=u'DEFERRED'), index=True)
    count = Column(Integer)

    member = relationship(u'MemberMember')
    toolkit = relationship(u'ToolkitsToolkit')


class ToolkitsToolkitdiggsUser(Base,db.Model):
    __tablename__ = 'toolkits_toolkitdiggs_users'

    id = Column(Integer, primary_key=True, server_default=text("nextval('toolkits_toolkitdiggs_users_id_seq'::regclass)"))
    toolkitdiggs_id = Column(ForeignKey(u'toolkits_toolkitdiggs.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    user_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    toolkitdiggs = relationship(u'ToolkitsToolkitdigg')
    user = relationship(u'IuserUser')


class ToolkitsToolkitphoto(Base,db.Model):
    __tablename__ = 'toolkits_toolkitphoto'

    id = Column(Integer, primary_key=True, server_default=text("nextval('toolkits_toolkitphoto_id_seq'::regclass)"))
    photo = Column(String(100), nullable=False)


class ToolkitsToolkitsubcategory(Base,db.Model):
    __tablename__ = 'toolkits_toolkitsubcategory'

    id = Column(Integer, primary_key=True, server_default=text("nextval('toolkits_toolkitsubcategory_id_seq'::regclass)"))
    name = Column(String(256), nullable=False)
    category_id = Column(ForeignKey(u'toolkits_toolkitcategory.id', deferrable=True, initially=u'DEFERRED'), index=True)
    order = Column(Integer)

    category = relationship(u'ToolkitsToolkitcategory')


class ToolkitsToolkitsubcategorysuggestion(Base,db.Model):
    __tablename__ = 'toolkits_toolkitsubcategorysuggestion'

    id = Column(Integer, primary_key=True, server_default=text("nextval('toolkits_toolkitsubcategorysuggestion_id_seq'::regclass)"))
    name = Column(String(256), nullable=False)
    user_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), index=True)
    submit_date = Column(DateTime(True), nullable=False)
    category_id = Column(ForeignKey(u'toolkits_toolkitcategory.id', deferrable=True, initially=u'DEFERRED'), index=True)

    category = relationship(u'ToolkitsToolkitcategory')
    user = relationship(u'IuserUser')


class ToolkitsToolkittag(Base,db.Model):
    __tablename__ = 'toolkits_toolkittag'

    id = Column(Integer, primary_key=True, server_default=text("nextval('toolkits_toolkittag_id_seq'::regclass)"))
    name = Column(String(256), nullable=False)


class ToolkitsToolkitview(Base,db.Model):
    __tablename__ = 'toolkits_toolkitviews'

    id = Column(Integer, primary_key=True, server_default=text("nextval('toolkits_toolkitviews_id_seq'::regclass)"))
    member_id = Column(ForeignKey(u'member_member.id', deferrable=True, initially=u'DEFERRED'), index=True)
    toolkit_id = Column(ForeignKey(u'toolkits_toolkit.id', deferrable=True, initially=u'DEFERRED'), index=True)
    count = Column(Integer)

    member = relationship(u'MemberMember')
    toolkit = relationship(u'ToolkitsToolkit')


