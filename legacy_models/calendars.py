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


class CalendarsEvent(Base,db.Model):
    __tablename__ = 'calendars_event'
    __table_args__ = (
        Index('calendars_event_name_b06e7966c999b82', 'name', 'date'),
    )

    id = Column(Integer, primary_key=True, server_default=text("nextval('calendars_event_id_seq'::regclass)"))
    name = Column(String(100), nullable=False)
    abbreviation = Column(String(20), nullable=False)
    type_id = Column(ForeignKey(u'calendars_eventtype.id', deferrable=True, initially=u'DEFERRED'), index=True)
    date = Column(Date, nullable=False)
    all_day = Column(Boolean, nullable=False, server_default="false")
    start = Column(Time, index=True)
    end = Column(Time, index=True)
    address = Column(Text, nullable=False)
    directions = Column(Text, nullable=False)
    description = Column(Text, nullable=False)
    created_on = Column(DateTime(True), nullable=False, index=True, server_default=text("'2009-01-10 00:38:00.419597-05'::timestamp with time zone"))
    modified_on = Column(DateTime(True), nullable=False, index=True)
    creator_id = Column(ForeignKey(u'iuser_persona.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    status = Column(String(2), nullable=False, index=True, server_default=text("'A'::character varying"))
    recurring = Column(String(2), nullable=False, server_default=text("'N'::character varying"))
    recurring_parent_id = Column(ForeignKey(u'calendars_event.id', deferrable=True, initially=u'DEFERRED'), index=True)
    mdata_id = Column(ForeignKey(u'calendars_eventmeta.id', deferrable=True, initially=u'DEFERRED'), unique=True,name=u'metadata_id')

    creator = relationship(u'IuserPersona')
    mdata = relationship(u'CalendarsEventmeta')
    recurring_parent = relationship(u'CalendarsEvent', remote_side=[id])
    type = relationship(u'CalendarsEventtype')


class CalendarsEventMember(Base,db.Model):
    __tablename__ = 'calendars_event_members'

    id = Column(Integer, primary_key=True, server_default=text("nextval('calendars_event_members_id_seq'::regclass)"))
    event_id = Column(ForeignKey(u'calendars_event.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    member_id = Column(ForeignKey(u'member_member.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    event = relationship(u'CalendarsEvent')
    member = relationship(u'MemberMember')


class CalendarsEventPartner(Base,db.Model):
    __tablename__ = 'calendars_event_partners'

    id = Column(Integer, primary_key=True, server_default=text("nextval('calendars_event_partners_id_seq'::regclass)"))
    event_id = Column(ForeignKey(u'calendars_event.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    partner_id = Column(ForeignKey(u'partners_partner.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    event = relationship(u'CalendarsEvent')
    partner = relationship(u'PartnersPartner')


class CalendarsEventStaff(Base,db.Model):
    __tablename__ = 'calendars_event_staff'
    __table_args__ = (
        Index('calendars_event_staff_event_id_23ae65d690bfa90_uniq', 'event_id', 'persona_id', unique=True),
    )

    id = Column(Integer, primary_key=True, server_default=text("nextval('calendars_event_staff_id_seq'::regclass)"))
    event_id = Column(ForeignKey(u'calendars_event.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    persona_id = Column(ForeignKey(u'iuser_persona.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    event = relationship(u'CalendarsEvent')
    persona = relationship(u'IuserPersona')


class CalendarsEventmeta(Base,db.Model):
    __tablename__ = 'calendars_eventmeta'

    id = Column(Integer, primary_key=True, server_default=text("nextval('calendars_eventmeta_id_seq'::regclass)"))
    pairs_invited_cnt = Column(Integer, nullable=False, server_default="0")
    pairs_attended_cnt = Column(Integer, nullable=False, server_default="0")
    pairs_attendance_perc = Column(Numeric(5, 2), nullable=False, server_default="0")
    stood_up_perc = Column(Numeric(5, 2), nullable=False, server_default="0")
    rsvp_noshow_perc = Column(Numeric(5, 2), nullable=False, server_default="0")
    pair_rsvp_yes_cnt = Column(Integer, nullable=False, server_default="0")
    mentee_rsvp_yes_cnt = Column(Integer, nullable=False, server_default="0")
    mentor_rsvp_yes_cnt = Column(Integer, nullable=False, server_default="0")
    pair_rsvp_no_cnt = Column(Integer, nullable=False, server_default="0")
    pair_no_response_cnt = Column(Integer, nullable=False, server_default="0")


class CalendarsEventtype(Base,db.Model):
    __tablename__ = 'calendars_eventtype'

    id = Column(Integer, primary_key=True, server_default=text("nextval('calendars_eventtype_id_seq'::regclass)"))
    name = Column(String(100), nullable=False, index=True)
    color = Column(String(7), nullable=False, server_default=text("'#0000FF'::character varying"))
    text_color = Column(String(7), nullable=False, server_default=text("'#0000FF'::character varying"))
    member_id = Column(ForeignKey(u'member_member.id', deferrable=True, initially=u'DEFERRED'), index=True)
    created_on = Column(DateTime(True), nullable=False, server_default=text("'2009-01-10 00:38:00.436834-05'::timestamp with time zone"))
    modified_on = Column(DateTime(True), nullable=False)
    active = Column(Boolean, nullable=False, server_default="true")
    fixed = Column(Boolean, nullable=False, server_default="false")
    creator_id = Column(ForeignKey(u'iuser_persona.id', deferrable=True, initially=u'DEFERRED'), index=True)

    creator = relationship(u'IuserPersona')
    member = relationship(u'MemberMember', primaryjoin='CalendarsEventtype.member_id == MemberMember.id')


class CalendarsInvitation(Base,db.Model):
    __tablename__ = 'calendars_invitation'
    __table_args__ = (
        Index('calendars_invitation_rsvp_794e539259a0fe50', 'rsvp', 'modified', 'status'),
    )

    id = Column(Integer, primary_key=True, server_default=text("nextval('calendars_invitation_id_seq'::regclass)"))
    event_id = Column(ForeignKey(u'calendars_event.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    rsvp = Column(String(2), nullable=False, server_default=text("'NI'::character varying"))
    created = Column(DateTime(True), nullable=False, index=True, server_default=text("'2009-01-10 00:38:09.769199-05'::timestamp with time zone"))
    modified = Column(DateTime(True), nullable=False, index=True)
    attended = Column(Boolean, nullable=False, server_default="false")
    invitee_id = Column(ForeignKey(u'iuser_persona.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    invitor_id = Column(ForeignKey(u'iuser_persona.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    message_sent = Column(Boolean, nullable=False, server_default="false")
    rsvp_comment = Column(Text, nullable=False, server_default=text("''::text"))
    status = Column(String(2), nullable=False, index=True, server_default=text("'A'::character varying"))

    event = relationship(u'CalendarsEvent')
    invitee = relationship(u'IuserPersona', primaryjoin='CalendarsInvitation.invitee_id == IuserPersona.id')
    invitor = relationship(u'IuserPersona', primaryjoin='CalendarsInvitation.invitor_id == IuserPersona.id')


class CalendarsPairinvitation(Base,db.Model):
    __tablename__ = 'calendars_pairinvitation'

    id = Column(Integer, primary_key=True, server_default=text("nextval('calendars_pairinvitation_id_seq'::regclass)"))
    pair_id = Column(ForeignKey(u'iuser_matchhistory.id', deferrable=True, initially=u'DEFERRED'), index=True)
    mentee_invitation_id = Column(ForeignKey(u'calendars_invitation.id', deferrable=True, initially=u'DEFERRED'), index=True)
    mentor_invitation_id = Column(ForeignKey(u'calendars_invitation.id', deferrable=True, initially=u'DEFERRED'), index=True)
    event_id = Column(ForeignKey(u'calendars_event.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    event = relationship(u'CalendarsEvent')
    mentee_invitation = relationship(u'CalendarsInvitation', primaryjoin='CalendarsPairinvitation.mentee_invitation_id == CalendarsInvitation.id')
    mentor_invitation = relationship(u'CalendarsInvitation', primaryjoin='CalendarsPairinvitation.mentor_invitation_id == CalendarsInvitation.id')
    pair = relationship(u'IuserMatchhistory')


