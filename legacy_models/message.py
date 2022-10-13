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


class MessageContactgroup(Base,db.Model):
    __tablename__ = 'message_contactgroup'

    id = Column(Integer, primary_key=True, server_default=text("nextval('message_contactgroup_id_seq'::regclass)"))
    first_contact_id = Column(ForeignKey(u'iuser_persona.id', deferrable=True, initially=u'DEFERRED'), index=True)
    second_contact_id = Column(ForeignKey(u'iuser_persona.id', deferrable=True, initially=u'DEFERRED'), index=True)
    group_id = Column(ForeignKey(u'message_group.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    first_contact = relationship(u'IuserPersona', primaryjoin='MessageContactgroup.first_contact_id == IuserPersona.id')
    group = relationship(u'MessageGroup')
    second_contact = relationship(u'IuserPersona', primaryjoin='MessageContactgroup.second_contact_id == IuserPersona.id')


class MessageEmail(Base,db.Model):
    __tablename__ = 'message_email'

    id = Column(Integer, primary_key=True, server_default=text("nextval('message_email_id_seq'::regclass)"))
    sender_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), index=True)
    subject = Column(String(255), nullable=False)
    content = Column(Text, nullable=False)
    priority = Column(Integer, nullable=False)
    send_date = Column(DateTime(True), index=True)
    has_attachment = Column(Integer)
    nr_recipients = Column(Integer)
    nr_groups = Column(Integer)
    event_notification = Column(Boolean, nullable=False, server_default="false")
    legacy = Column(Boolean, nullable=False, server_default="false")
    stripped_content = Column(Text, nullable=False, server_default=text("''::text"))
    search_tsv = Column(TSVECTOR, index=True)

    sender = relationship(u'IuserUser')


class MessageEmailattachment(Base,db.Model):
    __tablename__ = 'message_emailattachment'

    id = Column(Integer, primary_key=True, server_default=text("nextval('message_emailattachment_id_seq'::regclass)"))
    email_id = Column(ForeignKey(u'message_email.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    name = Column(String(765), nullable=False)
    type = Column(String(765), nullable=False)
    size = Column(Integer, nullable=False)
    ordering = Column(Float(53), nullable=False)

    email = relationship(u'MessageEmail')


class MessageEmaildraft(Base,db.Model):
    __tablename__ = 'message_emaildraft'

    id = Column(Integer, primary_key=True, server_default=text("nextval('message_emaildraft_id_seq'::regclass)"))
    sender_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), index=True)
    subject = Column(String(255))
    content = Column(Text)
    priority = Column(Integer)
    draft_date = Column(DateTime(True), index=True)
    to_recipients = Column(Text)
    cc_recipients = Column(Text)
    bcc_recipients = Column(Text)
    gto_recipients = Column(Text)
    gcc_recipients = Column(Text)
    gbcc_recipients = Column(Text)

    sender = relationship(u'IuserUser')


class MessageEmaildraftattachment(Base,db.Model):
    __tablename__ = 'message_emaildraftattachment'

    id = Column(Integer, primary_key=True, server_default=text("nextval('message_emaildraftattachment_id_seq'::regclass)"))
    email_id = Column(ForeignKey(u'message_emaildraft.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    name = Column(String(765), nullable=False)
    type = Column(String(765), nullable=False)
    size = Column(Integer, nullable=False)
    ordering = Column(Float(53), nullable=False)

    email = relationship(u'MessageEmaildraft')


class MessageEmailfolder(Base,db.Model):
    __tablename__ = 'message_emailfolder'

    id = Column(Integer, primary_key=True, server_default=text("nextval('message_emailfolder_id_seq'::regclass)"))
    user_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), index=True)
    name = Column(String(765), nullable=False, index=True)
    ordering = Column(Float(53))
    legacy = Column(Boolean, nullable=False, server_default="false")

    user = relationship(u'IuserUser')


class MessageEmailrecipient(Base,db.Model):
    __tablename__ = 'message_emailrecipient'

    id = Column(Integer, primary_key=True, server_default=text("nextval('message_emailrecipient_id_seq'::regclass)"))
    email_id = Column(ForeignKey(u'message_email.id', deferrable=True, initially=u'DEFERRED'), index=True)
    user_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), index=True)
    recipient_type = Column(Integer)
    group_id = Column(ForeignKey(u'message_group.id'))
    folder_id = Column(ForeignKey(u'message_emailfolder.id', deferrable=True, initially=u'DEFERRED'), index=True)
    read_flag = Column(Boolean, nullable=False, server_default="false")
    legacy = Column(Boolean, nullable=False, server_default="false")
    gto_recipients = Column(Text)
    gcc_recipients = Column(Text)
    gbcc_recipients = Column(Text)
    visible = Column(Boolean, nullable=False, server_default="true")

    email = relationship(u'MessageEmail')
    folder = relationship(u'MessageEmailfolder')
    group = relationship(u'MessageGroup')
    user = relationship(u'IuserUser')


class MessageGroup(Base,db.Model):
    __tablename__ = 'message_group'

    id = Column(Integer, primary_key=True, server_default=text("nextval('message_group_id_seq'::regclass)"))
    name = Column(String(765))
    abbr = Column(String(100))
    type_id = Column(ForeignKey(u'message_grouptype.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    description = Column(Text)
    member_id = Column(ForeignKey(u'member_member.id', deferrable=True, initially=u'DEFERRED'), index=True)
    created_by_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), index=True)
    created_date = Column(DateTime(True))
    status_id = Column(ForeignKey(u'message_groupstatus.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    subtype = Column(Integer)
    allow_intercom = Column(Boolean, nullable=False, server_default="false")
    partner_id = Column(ForeignKey(u'partners_partner.id', deferrable=True, initially=u'DEFERRED'), index=True)
    oneway_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), index=True)
    photo = Column(String(100), nullable=False, server_default=text("'upload/group/default.jpg'::character varying"))
    legacy = Column(Boolean, nullable=False, server_default="false")
    legacy_auto = Column(Boolean, nullable=False, server_default="false")
    deleted = Column(Boolean, nullable=False, server_default="false")
    owner_id = Column(ForeignKey(u'iuser_persona.id', deferrable=True, initially=u'DEFERRED'), index=True)
    message_cnt = Column(Integer, nullable=False, server_default="0")

    created_by = relationship(u'IuserUser', primaryjoin='MessageGroup.created_by_id == IuserUser.id')
    member = relationship(u'MemberMember')
    oneway = relationship(u'IuserUser', primaryjoin='MessageGroup.oneway_id == IuserUser.id')
    owner = relationship(u'IuserPersona')
    partner = relationship(u'PartnersPartner')
    status = relationship(u'MessageGroupstatus')
    type = relationship(u'MessageGrouptype')


class MessageGrouppersona(Base,db.Model):
    __tablename__ = 'message_grouppersona'

    id = Column(Integer, primary_key=True, server_default=text("nextval('message_grouppersona_id_seq'::regclass)"))
    group_id = Column(ForeignKey(u'message_group.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    persona_id = Column(ForeignKey(u'iuser_persona.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    group = relationship(u'MessageGroup')
    persona = relationship(u'IuserPersona')


class MessageGroupstatus(Base,db.Model):
    __tablename__ = 'message_groupstatus'

    id = Column(Integer, primary_key=True, server_default=text("nextval('message_groupstatus_id_seq'::regclass)"))
    name = Column(String(50), nullable=False)


class MessageGrouptype(Base,db.Model):
    __tablename__ = 'message_grouptype'

    id = Column(Integer, primary_key=True, server_default=text("nextval('message_grouptype_id_seq'::regclass)"))
    name = Column(String(50), nullable=False)


class MessageGroupuser(Base,db.Model):
    __tablename__ = 'message_groupuser'

    id = Column(Integer, primary_key=True, server_default=text("nextval('message_groupuser_id_seq'::regclass)"))
    group_id = Column(ForeignKey(u'message_group.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    user_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    group = relationship(u'MessageGroup')
    user = relationship(u'IuserUser')


