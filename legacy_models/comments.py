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


class CommentComment(Base,db.Model):
    __tablename__ = 'comment_comment'

    id = Column(Integer, primary_key=True, server_default=text("nextval('comment_comment_id_seq'::regclass)"))
    content_type_id = Column(ForeignKey(u'django_content_type.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    object_id = Column(Integer, nullable=False)
    member_id = Column(ForeignKey(u'member_member.id', deferrable=True, initially=u'DEFERRED'), index=True)
    user_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), index=True)
    name = Column(String(100), nullable=False)
    comment = Column(Text, nullable=False)
    submit_date = Column(DateTime(True), nullable=False)
    is_published = Column(Boolean, nullable=False, server_default="true")
    is_deleted = Column(Boolean, nullable=False, server_default="false")

    content_type = relationship(u'DjangoContentType')
    member = relationship(u'MemberMember')
    user = relationship(u'IuserUser')


