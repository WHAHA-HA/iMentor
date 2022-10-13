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


class CurriculumCurriculum(Base,db.Model):
    __tablename__ = 'curriculum_curriculum'

    id = Column(Integer, primary_key=True, server_default=text("nextval('curriculum_curriculum_id_seq'::regclass)"))
    name = Column(String(100), nullable=False, index=True)


class CurriculumCurriculumprompt(Base,db.Model):
    __tablename__ = 'curriculum_curriculumprompt'

    id = Column(Integer, primary_key=True, server_default=text("nextval('curriculum_curriculumprompt_id_seq'::regclass)"))
    prompt_id = Column(ForeignKey(u'curriculum_prompt.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    curriculum_id = Column(ForeignKey(u'curriculum_curriculum.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    ordering = Column(Integer)

    curriculum = relationship(u'CurriculumCurriculum')
    prompt = relationship(u'CurriculumPrompt')


class CurriculumMemberprompt(Base,db.Model):
    __tablename__ = 'curriculum_memberprompt'

    id = Column(Integer, primary_key=True, server_default=text("nextval('curriculum_memberprompt_id_seq'::regclass)"))
    prompt_id = Column(ForeignKey(u'curriculum_prompt.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    member_id = Column(ForeignKey(u'member_member.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    ordering = Column(Integer)

    member = relationship(u'MemberMember')
    prompt = relationship(u'CurriculumPrompt')


class CurriculumPartnerprompt(Base,db.Model):
    __tablename__ = 'curriculum_partnerprompt'

    id = Column(Integer, primary_key=True, server_default=text("nextval('curriculum_partnerprompt_id_seq'::regclass)"))
    prompt_id = Column(ForeignKey(u'curriculum_prompt.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    partner_id = Column(ForeignKey(u'partners_partner.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    ordering = Column(Integer)

    partner = relationship(u'PartnersPartner')
    prompt = relationship(u'CurriculumPrompt')


class CurriculumPrompt(Base,db.Model):
    __tablename__ = 'curriculum_prompt'

    id = Column(Integer, primary_key=True, server_default=text("nextval('curriculum_prompt_id_seq'::regclass)"))
    title = Column(String(120), nullable=False)
    description = Column(Text)
    prompt_text = Column(Text, nullable=False)
    status_id = Column(ForeignKey(u'curriculum_promptstatus.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    created_by_id = Column(ForeignKey(u'member_member.id', deferrable=True, initially=u'DEFERRED'), index=True)
    created_date = Column(DateTime(True))
    modified_date = Column(DateTime(True))
    modified_by_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), index=True)
    is_deleted = Column(Boolean, nullable=False, server_default="false")

    created_by = relationship(u'MemberMember')
    modified_by = relationship(u'IuserUser')
    status = relationship(u'CurriculumPromptstatu')


class CurriculumPromptCategory(Base,db.Model):
    __tablename__ = 'curriculum_prompt_category'

    id = Column(Integer, primary_key=True, server_default=text("nextval('curriculum_prompt_category_id_seq'::regclass)"))
    prompt_id = Column(ForeignKey(u'curriculum_prompt.id', deferrable=True, initially=u'DEFERRED'), index=True)
    prompttype_id = Column(ForeignKey(u'curriculum_prompttype.id', deferrable=True, initially=u'DEFERRED'), index=True)

    prompt = relationship(u'CurriculumPrompt')
    prompttype = relationship(u'CurriculumPrompttype')


class CurriculumPromptstatu(Base,db.Model):
    __tablename__ = 'curriculum_promptstatus'

    id = Column(Integer, primary_key=True, server_default=text("nextval('curriculum_promptstatus_id_seq'::regclass)"))
    name = Column(String(100), nullable=False)


class CurriculumPrompttype(Base,db.Model):
    __tablename__ = 'curriculum_prompttype'

    id = Column(Integer, primary_key=True, server_default=text("nextval('curriculum_prompttype_id_seq'::regclass)"))
    name = Column(String(100), nullable=False)
    member_id = Column(ForeignKey(u'member_member.id', deferrable=True, initially=u'DEFERRED'), index=True)

    member = relationship(u'MemberMember')


