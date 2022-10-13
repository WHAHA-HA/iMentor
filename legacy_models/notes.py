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


class NotesNote(Base,db.Model):
    __tablename__ = 'notes_note'

    id = Column(Integer, primary_key=True, server_default=text("nextval('notes_note_id_seq'::regclass)"))
    content_type_id = Column(ForeignKey(u'django_content_type.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    object_id = Column(Integer, nullable=False)
    user_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), index=True)
    name = Column(String(100), nullable=False)
    note = Column(Text, nullable=False)
    submit_date = Column(DateTime(True), nullable=False)
    is_published = Column(Boolean, nullable=False, server_default="true")
    is_deleted = Column(Boolean, nullable=False, server_default="false")
    date_modified = Column(DateTime(True), nullable=False)
    is_legacy = Column(Boolean, nullable=False, server_default="true")

    content_type = relationship(u'DjangoContentType')
    user = relationship(u'IuserUser')


class NotesSupportcategory(Base,db.Model):
    __tablename__ = 'notes_supportcategory'

    id = Column(Integer, primary_key=True, server_default=text("nextval('notes_supportcategory_id_seq'::regclass)"))
    name = Column(String(100), nullable=False, index=True)
    order = Column(Integer, nullable=False)


class NotesSupportnote(Base,db.Model):
    __tablename__ = 'notes_supportnote'

    id = Column(Integer, primary_key=True, server_default=text("nextval('notes_supportnote_id_seq'::regclass)"))
    has_support = Column(Boolean, nullable=False, index=True, server_default=text("true"))
    admin_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), index=True)
    for_pair_id = Column(ForeignKey(u'iuser_matchhistory.id', deferrable=True, initially=u'DEFERRED'), index=True)
    for_partner_id = Column(ForeignKey(u'partners_partner.id', deferrable=True, initially=u'DEFERRED'), index=True)
    for_persona_id = Column(ForeignKey(u'iuser_persona.id', deferrable=True, initially=u'DEFERRED'), index=True)
    subject = Column(String(100), nullable=False, index=True)
    note = Column(Text, nullable=False)
    total_time = Column(Integer, nullable=False, index=True)
    created_date = Column(DateTime(True), nullable=False, index=True)
    date_modified = Column(DateTime(True), nullable=False, index=True)
    is_deleted = Column(Boolean, nullable=False, index=True, server_default=text("false"))
    is_legacy = Column(Boolean, nullable=False, index=True, server_default=text("false"))
    flagged = Column(Boolean, nullable=False, index=True, server_default=text("false"))
    flagged_by_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), index=True)
    flag_comment = Column(Text, nullable=False, server_default=text("''::text"))

    admin = relationship(u'IuserUser', primaryjoin='NotesSupportnote.admin_id == IuserUser.id')
    flagged_by = relationship(u'IuserUser', primaryjoin='NotesSupportnote.flagged_by_id == IuserUser.id')
    for_pair = relationship(u'IuserMatchhistory')
    for_partner = relationship(u'PartnersPartner')
    for_persona = relationship(u'IuserPersona')


class NotesSupportnoteCategory(Base,db.Model):
    __tablename__ = 'notes_supportnote_categories'
    __table_args__ = (
        Index('notes_supportnote_categorie_supportnote_id_a5dd65e3b34bd20_uniq', 'supportnote_id', 'supportcategory_id', unique=True),
    )

    id = Column(Integer, primary_key=True, server_default=text("nextval('notes_supportnote_categories_id_seq'::regclass)"))
    supportnote_id = Column(ForeignKey(u'notes_supportnote.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    supportcategory_id = Column(ForeignKey(u'notes_supportcategory.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    supportcategory = relationship(u'NotesSupportcategory')
    supportnote = relationship(u'NotesSupportnote')


class NotesSupportnoteCopiesTo(Base,db.Model):
    __tablename__ = 'notes_supportnote_copies_to'
    __table_args__ = (
        Index('notes_supportnote_copies_to_supportnote_id_44c83901232a81d_uniq', 'supportnote_id', 'user_id', unique=True),
    )

    id = Column(Integer, primary_key=True, server_default=text("nextval('notes_supportnote_copies_to_id_seq'::regclass)"))
    supportnote_id = Column(ForeignKey(u'notes_supportnote.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    user_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    supportnote = relationship(u'NotesSupportnote')
    user = relationship(u'IuserUser')


class NotesSupportnoteForList(Base,db.Model):
    __tablename__ = 'notes_supportnote_for_list'
    __table_args__ = (
        Index('notes_supportnote_for_list_supportnote_id_44064ab308cbe9c1_uniq', 'supportnote_id', 'persona_id', unique=True),
    )

    id = Column(Integer, primary_key=True, server_default=text("nextval('notes_supportnote_for_list_id_seq'::regclass)"))
    supportnote_id = Column(ForeignKey(u'notes_supportnote.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    persona_id = Column(ForeignKey(u'iuser_persona.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    persona = relationship(u'IuserPersona')
    supportnote = relationship(u'NotesSupportnote')


class NotesSupportnoteForPair(Base,db.Model):
    __tablename__ = 'notes_supportnote_for_pairs'
    __table_args__ = (
        Index('notes_supportnote_for_pair_supportnote_id_43475df30f518dc3_uniq', 'supportnote_id', 'matchhistory_id', unique=True),
    )

    id = Column(Integer, primary_key=True, server_default=text("nextval('notes_supportnote_for_pairs_id_seq'::regclass)"))
    supportnote_id = Column(ForeignKey(u'notes_supportnote.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    matchhistory_id = Column(ForeignKey(u'iuser_matchhistory.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    matchhistory = relationship(u'IuserMatchhistory')
    supportnote = relationship(u'NotesSupportnote')


class NotesSupportnoteForPartner(Base,db.Model):
    __tablename__ = 'notes_supportnote_for_partners'
    __table_args__ = (
        Index('notes_supportnote_for_part_supportnote_id_568a33a3a2c3a880_uniq', 'supportnote_id', 'partner_id', unique=True),
    )

    id = Column(Integer, primary_key=True, server_default=text("nextval('notes_supportnote_for_partners_id_seq'::regclass)"))
    supportnote_id = Column(ForeignKey(u'notes_supportnote.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    partner_id = Column(ForeignKey(u'partners_partner.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    partner = relationship(u'PartnersPartner')
    supportnote = relationship(u'NotesSupportnote')


class NotesSupportnoteWho(Base,db.Model):
    __tablename__ = 'notes_supportnote_who'
    __table_args__ = (
        Index('notes_supportnote_who_supportnote_id_55b101b6f2a3f18e_uniq', 'supportnote_id', 'supportwho_id', unique=True),
    )

    id = Column(Integer, primary_key=True, server_default=text("nextval('notes_supportnote_who_id_seq'::regclass)"))
    supportnote_id = Column(ForeignKey(u'notes_supportnote.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    supportwho_id = Column(ForeignKey(u'notes_supportwho.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    supportnote = relationship(u'NotesSupportnote')
    supportwho = relationship(u'NotesSupportwho')


class NotesSupportwho(Base,db.Model):
    __tablename__ = 'notes_supportwho'

    id = Column(Integer, primary_key=True, server_default=text("nextval('notes_supportwho_id_seq'::regclass)"))
    method = Column(String(1), nullable=False, index=True, server_default=text("'P'::character varying"))
    who = Column(String(1), nullable=False, index=True, server_default=text("'E'::character varying"))
    time = Column(Integer, index=True)


