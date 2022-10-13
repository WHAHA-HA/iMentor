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


class BlogsBlog(Base,db.Model):
    __tablename__ = 'blogs_blog'

    id = Column(Integer, primary_key=True, server_default=text("nextval('blogs_blog_id_seq'::regclass)"))
    creator_id = Column(ForeignKey(u'iuser_persona.id', deferrable=True, initially=u'DEFERRED'), index=True)
    creator_user_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), index=True)
    title = Column(String(256), nullable=False)
    description = Column(Text, nullable=False)
    submit_date = Column(DateTime(True), nullable=False)
    date_modified = Column(DateTime(True), nullable=False)
    is_published = Column(Boolean, nullable=False, server_default="false")
    is_member_blog = Column(Boolean, nullable=False, server_default="false")
    is_deleted = Column(Boolean, nullable=False, server_default="false")
    member_id = Column(ForeignKey(u'member_member.id', deferrable=True, initially=u'DEFERRED'), index=True)
    photo_id = Column(ForeignKey(u'blogs_blogphoto.id', deferrable=True, initially=u'DEFERRED'), index=True)
    search_tsv = Column(TSVECTOR, index=True)

    creator = relationship(u'IuserPersona')
    creator_user = relationship(u'IuserUser')
    member = relationship(u'MemberMember')
    photo = relationship(u'BlogsBlogphoto')


class BlogsBlogPartner(Base,db.Model):
    __tablename__ = 'blogs_blog_partners'

    id = Column(Integer, primary_key=True, server_default=text("nextval('blogs_blog_partners_id_seq'::regclass)"))
    blog_id = Column(ForeignKey(u'blogs_blog.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    partner_id = Column(ForeignKey(u'partners_partner.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    blog = relationship(u'BlogsBlog')
    partner = relationship(u'PartnersPartner')


class BlogsBlogTag(Base,db.Model):
    __tablename__ = 'blogs_blog_tags'

    id = Column(Integer, primary_key=True, server_default=text("nextval('blogs_blog_tags_id_seq'::regclass)"))
    blog_id = Column(ForeignKey(u'blogs_blog.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    blogtag_id = Column(ForeignKey(u'blogs_blogtag.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    blog = relationship(u'BlogsBlog')
    blogtag = relationship(u'BlogsBlogtag')


class BlogsBlogalert(Base,db.Model):
    __tablename__ = 'blogs_blogalert'

    id = Column(Integer, primary_key=True, server_default=text("nextval('blogs_blogalert_id_seq'::regclass)"))
    name = Column(String(50), nullable=False)
    persona_id = Column(ForeignKey(u'iuser_persona.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    frequency = Column(String(2), nullable=False)

    persona = relationship(u'IuserPersona')


class BlogsBlogalertAssignedusertype(Base,db.Model):
    __tablename__ = 'blogs_blogalert_assignedusertypes'

    id = Column(Integer, primary_key=True, server_default=text("nextval('blogs_blogalert_assignedusertypes_id_seq'::regclass)"))
    blogalert_id = Column(ForeignKey(u'blogs_blogalert.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    assignedusertype_id = Column(ForeignKey(u'iuser_assignedusertype.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    assignedusertype = relationship(u'IuserAssignedusertype')
    blogalert = relationship(u'BlogsBlogalert')


class BlogsBlogalertGroup(Base,db.Model):
    __tablename__ = 'blogs_blogalert_groups'

    id = Column(Integer, primary_key=True, server_default=text("nextval('blogs_blogalert_groups_id_seq'::regclass)"))
    blogalert_id = Column(ForeignKey(u'blogs_blogalert.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    group_id = Column(ForeignKey(u'message_group.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    blogalert = relationship(u'BlogsBlogalert')
    group = relationship(u'MessageGroup')


class BlogsBlogalertKeyword(Base,db.Model):
    __tablename__ = 'blogs_blogalert_keywords'

    id = Column(Integer, primary_key=True, server_default=text("nextval('blogs_blogalert_keywords_id_seq'::regclass)"))
    blogalert_id = Column(ForeignKey(u'blogs_blogalert.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    blogalertkeyword_id = Column(ForeignKey(u'blogs_blogalertkeyword.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    blogalert = relationship(u'BlogsBlogalert')
    blogalertkeyword = relationship(u'BlogsBlogalertkeyword')


class BlogsBlogalertMember(Base,db.Model):
    __tablename__ = 'blogs_blogalert_members'

    id = Column(Integer, primary_key=True, server_default=text("nextval('blogs_blogalert_members_id_seq'::regclass)"))
    blogalert_id = Column(ForeignKey(u'blogs_blogalert.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    member_id = Column(ForeignKey(u'member_member.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    blogalert = relationship(u'BlogsBlogalert')
    member = relationship(u'MemberMember')


class BlogsBlogalertPartner(Base,db.Model):
    __tablename__ = 'blogs_blogalert_partners'

    id = Column(Integer, primary_key=True, server_default=text("nextval('blogs_blogalert_partners_id_seq'::regclass)"))
    blogalert_id = Column(ForeignKey(u'blogs_blogalert.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    partner_id = Column(ForeignKey(u'partners_partner.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    blogalert = relationship(u'BlogsBlogalert')
    partner = relationship(u'PartnersPartner')


class BlogsBlogalertUsertype(Base,db.Model):
    __tablename__ = 'blogs_blogalert_usertypes'

    id = Column(Integer, primary_key=True, server_default=text("nextval('blogs_blogalert_usertypes_id_seq'::regclass)"))
    blogalert_id = Column(ForeignKey(u'blogs_blogalert.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    usertype_id = Column(ForeignKey(u'iuser_usertype.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    blogalert = relationship(u'BlogsBlogalert')
    usertype = relationship(u'IuserUsertype')


class BlogsBlogalertkeyword(Base,db.Model):
    __tablename__ = 'blogs_blogalertkeyword'

    id = Column(Integer, primary_key=True, server_default=text("nextval('blogs_blogalertkeyword_id_seq'::regclass)"))
    keyword = Column(String(100), nullable=False)


class BlogsBlogalertmatch(Base,db.Model):
    __tablename__ = 'blogs_blogalertmatch'

    id = Column(Integer, primary_key=True, server_default=text("nextval('blogs_blogalertmatch_id_seq'::regclass)"))
    alert_id = Column(ForeignKey(u'blogs_blogalert.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    post_id = Column(ForeignKey(u'blogs_post.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    date_added = Column(DateTime(True), nullable=False)
    date_to_send = Column(DateTime(True), nullable=False)

    alert = relationship(u'BlogsBlogalert')
    post = relationship(u'BlogsPost')


class BlogsBlogalertmatchKeyword(Base,db.Model):
    __tablename__ = 'blogs_blogalertmatch_keywords'

    id = Column(Integer, primary_key=True, server_default=text("nextval('blogs_blogalertmatch_keywords_id_seq'::regclass)"))
    blogalertmatch_id = Column(ForeignKey(u'blogs_blogalertmatch.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    blogalertkeyword_id = Column(ForeignKey(u'blogs_blogalertkeyword.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    blogalertkeyword = relationship(u'BlogsBlogalertkeyword')
    blogalertmatch = relationship(u'BlogsBlogalertmatch')


class BlogsBlogphoto(Base,db.Model):
    __tablename__ = 'blogs_blogphoto'

    id = Column(Integer, primary_key=True, server_default=text("nextval('blogs_blogphoto_id_seq'::regclass)"))
    photo = Column(String(100), nullable=False)


class BlogsBlogpostphoto(Base,db.Model):
    __tablename__ = 'blogs_blogpostphoto'

    id = Column(Integer, primary_key=True, server_default=text("nextval('blogs_blogpostphoto_id_seq'::regclass)"))
    photo = Column(String(100), nullable=False)


class BlogsBlogtag(Base,db.Model):
    __tablename__ = 'blogs_blogtag'

    id = Column(Integer, primary_key=True, server_default=text("nextval('blogs_blogtag_id_seq'::regclass)"))
    name = Column(String(256), nullable=False)


class BlogsPost(Base,db.Model):
    __tablename__ = 'blogs_post'

    id = Column(Integer, primary_key=True, server_default=text("nextval('blogs_post_id_seq'::regclass)"))
    title = Column(String(256), nullable=False)
    text = Column(Text, nullable=False)
    submit_date = Column(DateTime(True), nullable=False)
    date_modified = Column(DateTime(True), nullable=False)
    is_published = Column(Boolean, nullable=False, server_default="false")
    is_deleted = Column(Boolean, nullable=False, server_default="false")
    blog_id = Column(ForeignKey(u'blogs_blog.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    photo_id = Column(ForeignKey(u'blogs_blogpostphoto.id', deferrable=True, initially=u'DEFERRED'), index=True)
    posted_by_user_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    posted_by_id = Column(ForeignKey(u'iuser_persona.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    flagged = Column(Boolean, nullable=False, server_default="false")
    flagged_by_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), index=True)
    flag_comment = Column(Text, nullable=False, server_default="''::text")
    search_tsv = Column(TSVECTOR, index=True)

    blog = relationship(u'BlogsBlog')
    flagged_by = relationship(u'IuserUser', primaryjoin='BlogsPost.flagged_by_id == IuserUser.id')
    photo = relationship(u'BlogsBlogpostphoto')
    posted_by = relationship(u'IuserPersona')
    posted_by_user = relationship(u'IuserUser', primaryjoin='BlogsPost.posted_by_user_id == IuserUser.id')


class BlogsPostTag(Base,db.Model):
    __tablename__ = 'blogs_post_tags'

    id = Column(Integer, primary_key=True, server_default=text("nextval('blogs_post_tags_id_seq'::regclass)"))
    post_id = Column(ForeignKey(u'blogs_post.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    blogtag_id = Column(ForeignKey(u'blogs_blogtag.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    blogtag = relationship(u'BlogsBlogtag')
    post = relationship(u'BlogsPost')


