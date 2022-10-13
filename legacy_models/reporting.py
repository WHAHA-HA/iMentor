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


class ReportingAlertafter(Base,db.Model):
    __tablename__ = 'reporting_alertafter'

    id = Column(Integer, primary_key=True, server_default=text("nextval('reporting_alertafter_id_seq'::regclass)"))
    description = Column(String(256), nullable=False)
    code = Column(String(2), nullable=False)


class ReportingAlertnotification(Base,db.Model):
    __tablename__ = 'reporting_alertnotification'

    id = Column(Integer, primary_key=True, server_default=text("nextval('reporting_alertnotification_id_seq'::regclass)"))
    description = Column(String(256), nullable=False)
    code = Column(String(2), nullable=False)
    time_delta = Column(String(2), nullable=False)


class ReportingAlertnotify(Base,db.Model):
    __tablename__ = 'reporting_alertnotify'

    id = Column(Integer, primary_key=True, server_default=text("nextval('reporting_alertnotify_id_seq'::regclass)"))
    description = Column(String(256), nullable=False)
    code = Column(String(2), nullable=False)


class ReportingAllmatchemail(Base,db.Model):
    __tablename__ = 'reporting_allmatchemail'

    id = Column(Integer, primary_key=True, server_default=text("nextval('reporting_allmatchemail_id_seq'::regclass)"))
    email_id = Column(ForeignKey(u'message_email.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    match_history_id = Column(ForeignKey(u'iuser_matchhistory.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    member_id = Column(ForeignKey(u'member_member.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    partner_id = Column(ForeignKey(u'partners_partner.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    send_date = Column(DateTime(True), nullable=False, index=True)
    mentee_to_mentor = Column(Boolean, nullable=False, server_default="true")
    orig_partner_id = Column(ForeignKey(u'partners_partner.id', deferrable=True, initially=u'DEFERRED'), index=True)
    sess_id = Column(ForeignKey(u'partners_session.id', deferrable=True, initially=u'DEFERRED'), index=True)

    email = relationship(u'MessageEmail')
    match_history = relationship(u'IuserMatchhistory')
    member = relationship(u'MemberMember')
    orig_partner = relationship(u'PartnersPartner', primaryjoin='ReportingAllmatchemail.orig_partner_id == PartnersPartner.id')
    partner = relationship(u'PartnersPartner', primaryjoin='ReportingAllmatchemail.partner_id == PartnersPartner.id')
    sess = relationship(u'PartnersSession')
    sessions = relationship(u'PartnersSession', secondary='reporting_allmatchsessions')


t_reporting_allmatchsessions = Table(
    'reporting_allmatchsessions', metadata,
    Column('ame_id', ForeignKey(u'reporting_allmatchemail.id', deferrable=True, initially=u'DEFERRED'), primary_key=True, index=True),
    Column('session_id', ForeignKey(u'partners_session.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
)


class ReportingEmailalert(Base,db.Model):
    __tablename__ = 'reporting_emailalert'

    id = Column(Integer, primary_key=True, server_default=text("nextval('reporting_emailalert_id_seq'::regclass)"))
    name = Column(String(50), nullable=False)
    created_by_id = Column(ForeignKey(u'iuser_persona.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    frequency = Column(String(2), nullable=False)
    alerts_destination = Column(String(2), nullable=False, server_default=text("'I'::character varying"))
    is_active = Column(Boolean, nullable=False)

    created_by = relationship(u'IuserPersona')


class ReportingEmailalertAssignedusertype(Base,db.Model):
    __tablename__ = 'reporting_emailalert_assignedusertypes'

    id = Column(Integer, primary_key=True, server_default=text("nextval('reporting_emailalert_assignedusertypes_id_seq'::regclass)"))
    emailalert_id = Column(ForeignKey(u'reporting_emailalert.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    assignedusertype_id = Column(ForeignKey(u'iuser_assignedusertype.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    assignedusertype = relationship(u'IuserAssignedusertype')
    emailalert = relationship(u'ReportingEmailalert')


class ReportingEmailalertGroup(Base,db.Model):
    __tablename__ = 'reporting_emailalert_groups'

    id = Column(Integer, primary_key=True, server_default=text("nextval('reporting_emailalert_groups_id_seq'::regclass)"))
    emailalert_id = Column(ForeignKey(u'reporting_emailalert.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    group_id = Column(ForeignKey(u'message_group.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    emailalert = relationship(u'ReportingEmailalert')
    group = relationship(u'MessageGroup')


class ReportingEmailalertKeyword(Base,db.Model):
    __tablename__ = 'reporting_emailalert_keywords'

    id = Column(Integer, primary_key=True, server_default=text("nextval('reporting_emailalert_keywords_id_seq'::regclass)"))
    emailalert_id = Column(ForeignKey(u'reporting_emailalert.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    emailalertkeyword_id = Column(ForeignKey(u'reporting_emailalertkeyword.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    emailalert = relationship(u'ReportingEmailalert')
    emailalertkeyword = relationship(u'ReportingEmailalertkeyword')


class ReportingEmailalertMember(Base,db.Model):
    __tablename__ = 'reporting_emailalert_members'

    id = Column(Integer, primary_key=True, server_default=text("nextval('reporting_emailalert_members_id_seq'::regclass)"))
    emailalert_id = Column(ForeignKey(u'reporting_emailalert.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    member_id = Column(ForeignKey(u'member_member.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    emailalert = relationship(u'ReportingEmailalert')
    member = relationship(u'MemberMember')


class ReportingEmailalertPartner(Base,db.Model):
    __tablename__ = 'reporting_emailalert_partners'

    id = Column(Integer, primary_key=True, server_default=text("nextval('reporting_emailalert_partners_id_seq'::regclass)"))
    emailalert_id = Column(ForeignKey(u'reporting_emailalert.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    partner_id = Column(ForeignKey(u'partners_partner.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    emailalert = relationship(u'ReportingEmailalert')
    partner = relationship(u'PartnersPartner')


class ReportingEmailalertUsertype(Base,db.Model):
    __tablename__ = 'reporting_emailalert_usertypes'

    id = Column(Integer, primary_key=True, server_default=text("nextval('reporting_emailalert_usertypes_id_seq'::regclass)"))
    emailalert_id = Column(ForeignKey(u'reporting_emailalert.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    usertype_id = Column(ForeignKey(u'iuser_usertype.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    emailalert = relationship(u'ReportingEmailalert')
    usertype = relationship(u'IuserUsertype')


class ReportingEmailalertkeyword(Base,db.Model):
    __tablename__ = 'reporting_emailalertkeyword'

    id = Column(Integer, primary_key=True, server_default=text("nextval('reporting_emailalertkeyword_id_seq'::regclass)"))
    keyword = Column(String(100), nullable=False)


class ReportingEmailalertmatch(Base,db.Model):
    __tablename__ = 'reporting_emailalertmatch'

    id = Column(Integer, primary_key=True, server_default=text("nextval('reporting_emailalertmatch_id_seq'::regclass)"))
    alert_id = Column(ForeignKey(u'reporting_emailalert.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    email_log_id = Column(ForeignKey(u'reporting_emaillog.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    date_added = Column(DateTime(True), nullable=False)
    date_to_send = Column(DateTime(True), nullable=False)

    alert = relationship(u'ReportingEmailalert')
    email_log = relationship(u'ReportingEmaillog')


class ReportingEmailalertmatchKeyword(Base,db.Model):
    __tablename__ = 'reporting_emailalertmatch_keywords'

    id = Column(Integer, primary_key=True, server_default=text("nextval('reporting_emailalertmatch_keywords_id_seq'::regclass)"))
    emailalertmatch_id = Column(ForeignKey(u'reporting_emailalertmatch.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    emailalertkeyword_id = Column(ForeignKey(u'reporting_emailalertkeyword.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    emailalertkeyword = relationship(u'ReportingEmailalertkeyword')
    emailalertmatch = relationship(u'ReportingEmailalertmatch')


class ReportingEmaillog(Base,db.Model):
    __tablename__ = 'reporting_emaillog'

    id = Column(Integer, primary_key=True, server_default=text("nextval('reporting_emaillog_id_seq'::regclass)"))
    sent_date = Column(DateTime(True), nullable=False, index=True)
    sender_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    user_type_id = Column(ForeignKey(u'iuser_usertype.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    partner_name_list = Column(String(2000), nullable=False)
    email_id = Column(ForeignKey(u'message_email.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    recipient_name = Column(String(200), nullable=False)
    recipient_url = Column(String(200), nullable=False)
    persona_id = Column(ForeignKey(u'iuser_persona.id', deferrable=True, initially=u'DEFERRED'), index=True)
    member_id = Column(ForeignKey(u'member_member.id', deferrable=True, initially=u'DEFERRED'), index=True)
    flagged = Column(Boolean, nullable=False, server_default="false")
    flagged_by_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), index=True)
    flag_comment = Column(Text, nullable=False, server_default=text("''::text"))

    email = relationship(u'MessageEmail')
    flagged_by = relationship(u'IuserUser', primaryjoin='ReportingEmaillog.flagged_by_id == IuserUser.id')
    member = relationship(u'MemberMember')
    persona = relationship(u'IuserPersona')
    sender = relationship(u'IuserUser', primaryjoin='ReportingEmaillog.sender_id == IuserUser.id')
    user_type = relationship(u'IuserUsertype')


class ReportingEmaillogGroup(Base,db.Model):
    __tablename__ = 'reporting_emaillog_groups'

    id = Column(Integer, primary_key=True, server_default=text("nextval('reporting_emaillog_groups_id_seq'::regclass)"))
    group_id = Column(ForeignKey(u'message_group.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    emaillog_id = Column(ForeignKey(u'reporting_emaillog.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    emaillog = relationship(u'ReportingEmaillog')
    group = relationship(u'MessageGroup')


class ReportingEmaillogPartner(Base,db.Model):
    __tablename__ = 'reporting_emaillog_partners'

    id = Column(Integer, primary_key=True, server_default=text("nextval('reporting_emaillog_partners_id_seq'::regclass)"))
    partner_id = Column(ForeignKey(u'partners_partner.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    emaillog_id = Column(ForeignKey(u'reporting_emaillog.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    emaillog = relationship(u'ReportingEmaillog')
    partner = relationship(u'PartnersPartner')


class ReportingEmaillogRecipient(Base,db.Model):
    __tablename__ = 'reporting_emaillog_recipients'

    id = Column(Integer, primary_key=True, server_default=text("nextval('reporting_emaillog_recipients_id_seq'::regclass)"))
    user_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    emaillog_id = Column(ForeignKey(u'reporting_emaillog.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    emaillog = relationship(u'ReportingEmaillog')
    user = relationship(u'IuserUser')


class ReportingEmailpair(Base,db.Model):
    __tablename__ = 'reporting_emailpairs'
    __table_args__ = (
        Index('reporting_emailpairs_session_start_date_55aa87add47549d1', 'session_start_date', 'session_end_date'),
    )

    id = Column(Integer, primary_key=True, server_default=text("nextval('reporting_emailpairs_id_seq'::regclass)"))
    match_history_id = Column(ForeignKey(u'iuser_matchhistory.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    mentor_id = Column(ForeignKey(u'iuser_persona.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    mentee_id = Column(ForeignKey(u'iuser_persona.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    member_id = Column(ForeignKey(u'member_member.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    partner_id = Column(ForeignKey(u'partners_partner.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    session_id = Column(ForeignKey(u'partners_session.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    session_start_date = Column(DateTime(True), nullable=False)
    session_end_date = Column(DateTime(True))
    mentor_to_mentee_cnt = Column(Integer, server_default="0")
    mentee_to_mentor_cnt = Column(Integer, server_default="0")

    match_history = relationship(u'IuserMatchhistory')
    member = relationship(u'MemberMember')
    mentee = relationship(u'IuserPersona', primaryjoin='ReportingEmailpair.mentee_id == IuserPersona.id')
    mentor = relationship(u'IuserPersona', primaryjoin='ReportingEmailpair.mentor_id == IuserPersona.id')
    partner = relationship(u'PartnersPartner')
    session = relationship(u'PartnersSession')


class ReportingEmailtrackeralert(Base,db.Model):
    __tablename__ = 'reporting_emailtrackeralert'

    id = Column(Integer, primary_key=True, server_default=text("nextval('reporting_emailtrackeralert_id_seq'::regclass)"))
    name = Column(String(50), nullable=False)
    after_id = Column(ForeignKey(u'reporting_alertafter.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    send_notification_id = Column(ForeignKey(u'reporting_alertnotification.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    created_by_id = Column(ForeignKey(u'iuser_persona.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    partner_id = Column(ForeignKey(u'partners_partner.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    alerts_destination = Column(String(2), nullable=False, server_default=text("'I'::character varying"))
    is_active = Column(Boolean, nullable=False)
    notify_me_id = Column(ForeignKey(u'reporting_alertnotify.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    after = relationship(u'ReportingAlertafter')
    created_by = relationship(u'IuserPersona')
    notify_me = relationship(u'ReportingAlertnotify')
    partner = relationship(u'PartnersPartner')
    send_notification = relationship(u'ReportingAlertnotification')


class ReportingEventalertnotification(Base,db.Model):
    __tablename__ = 'reporting_eventalertnotification'

    id = Column(Integer, primary_key=True, server_default=text("nextval('reporting_eventalertnotification_id_seq'::regclass)"))
    description = Column(String(256), nullable=False)
    code = Column(String(2), nullable=False)
    time_delta = Column(String(2), nullable=False)


class ReportingEventlog(Base,db.Model):
    __tablename__ = 'reporting_eventlog'
    __table_args__ = (
        Index('reporting_eventlog_date_67b6f2c0cd5f9687', 'date', 'start', 'end'),
    )

    id = Column(Integer, primary_key=True, server_default=text("nextval('reporting_eventlog_id_seq'::regclass)"))
    event_id = Column(ForeignKey(u'calendars_event.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    event_name = Column(String(255), nullable=False)
    event_url = Column(String(255), nullable=False)
    date = Column(Date, nullable=False)
    start = Column(Time)
    end = Column(Time)
    event_type_id = Column(ForeignKey(u'calendars_eventtype.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    event_type_name = Column(String(100), nullable=False)
    event_type_url = Column(String(255), nullable=False)
    creator_id = Column(ForeignKey(u'iuser_persona.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    creator_user_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    creator_user_name = Column(String(100), nullable=False)
    creator_user_url = Column(String(255), nullable=False)
    creator_user_type_id = Column(ForeignKey(u'iuser_usertype.id', deferrable=True, initially=u'DEFERRED'), index=True)
    creator_user_type_name = Column(String(100), nullable=False)
    creator_assigned_user_type_id = Column(ForeignKey(u'iuser_assignedusertype.id', deferrable=True, initially=u'DEFERRED'), index=True)
    creator_assigned_user_type_name = Column(String(100), nullable=False)
    member_name = Column(String(100), nullable=False)
    partner_name = Column(String(100), nullable=False)
    partner_url = Column(String(255), nullable=False)
    invited_cnt = Column(Integer, nullable=False, server_default="0")
    attended_cnt = Column(Integer, nullable=False, server_default="0")
    rsvp_yes_cnt = Column(Integer, nullable=False, server_default="0")
    rsvp_no_cnt = Column(Integer, nullable=False, server_default="0")
    rsvp_nr_cnt = Column(Integer, nullable=False, server_default="0")
    rsvp_ni_cnt = Column(Integer, nullable=False, server_default="0")
    member_url = Column(String(255), nullable=False, server_default=text("''::character varying"))
    status = Column(String(2), nullable=False, server_default=text("''::character varying"))
    pair_cnt = Column(Integer, nullable=False)
    attended_perc = Column(Numeric(5, 2), nullable=False)
    rsvp_yes_perc = Column(Numeric(5, 2), nullable=False)
    rsvp_no_perc = Column(Numeric(5, 2), nullable=False)
    rsvp_maybe_cnt = Column(Integer, nullable=False)
    rsvp_maybe_perc = Column(Numeric(5, 2), nullable=False)
    rsvp_nr_perc = Column(Numeric(5, 2), nullable=False)
    rsvp_ni_perc = Column(Numeric(5, 2), nullable=False)
    rsvp_nrni_cnt = Column(Integer, nullable=False)
    rsvp_nrni_perc = Column(Numeric(5, 2), nullable=False)

    creator_assigned_user_type = relationship(u'IuserAssignedusertype')
    creator = relationship(u'IuserPersona')
    creator_user = relationship(u'IuserUser')
    creator_user_type = relationship(u'IuserUsertype')
    event = relationship(u'CalendarsEvent')
    event_type = relationship(u'CalendarsEventtype')


class ReportingEventlogGroup(Base,db.Model):
    __tablename__ = 'reporting_eventlog_groups'

    id = Column(Integer, primary_key=True, server_default=text("nextval('reporting_eventlog_groups_id_seq'::regclass)"))
    eventlog_id = Column(ForeignKey(u'reporting_eventlog.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    group_id = Column(ForeignKey(u'message_group.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    eventlog = relationship(u'ReportingEventlog')
    group = relationship(u'MessageGroup')


class ReportingEventlogMember(Base,db.Model):
    __tablename__ = 'reporting_eventlog_members'

    id = Column(Integer, primary_key=True, server_default=text("nextval('reporting_eventlog_members_id_seq'::regclass)"))
    eventlog_id = Column(ForeignKey(u'reporting_eventlog.id', deferrable=True, initially=u'DEFERRED'), index=True)
    member_id = Column(ForeignKey(u'member_member.id', deferrable=True, initially=u'DEFERRED'), index=True)

    eventlog = relationship(u'ReportingEventlog')
    member = relationship(u'MemberMember')


class ReportingEventlogPartner(Base,db.Model):
    __tablename__ = 'reporting_eventlog_partners'

    id = Column(Integer, primary_key=True, server_default=text("nextval('reporting_eventlog_partners_id_seq'::regclass)"))
    eventlog_id = Column(ForeignKey(u'reporting_eventlog.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    partner_id = Column(ForeignKey(u'partners_partner.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    eventlog = relationship(u'ReportingEventlog')
    partner = relationship(u'PartnersPartner')


class ReportingEventtrackeralert(Base,db.Model):
    __tablename__ = 'reporting_eventtrackeralert'

    id = Column(Integer, primary_key=True, server_default=text("nextval('reporting_eventtrackeralert_id_seq'::regclass)"))
    name = Column(String(50), nullable=False)
    send_notification_id = Column(ForeignKey(u'reporting_eventalertnotification.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    created_by_id = Column(ForeignKey(u'iuser_persona.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    alerts_destination = Column(String(2), nullable=False, server_default=text("'I'::character varying"))
    is_active = Column(Boolean, nullable=False)

    created_by = relationship(u'IuserPersona')
    send_notification = relationship(u'ReportingEventalertnotification')


class ReportingEventtrackeralertPartner(Base,db.Model):
    __tablename__ = 'reporting_eventtrackeralert_partners'

    id = Column(Integer, primary_key=True, server_default=text("nextval('reporting_eventtrackeralert_partners_id_seq'::regclass)"))
    eventtrackeralert_id = Column(ForeignKey(u'reporting_eventtrackeralert.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    partner_id = Column(ForeignKey(u'partners_partner.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    eventtrackeralert = relationship(u'ReportingEventtrackeralert')
    partner = relationship(u'PartnersPartner')


class ReportingMatchcompletesession(Base,db.Model):
    __tablename__ = 'reporting_matchcompletesession'

    id = Column(Integer, primary_key=True, server_default=text("nextval('reporting_matchcompletesession_id_seq'::regclass)"))
    match_history_id = Column(ForeignKey(u'iuser_matchhistory.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    session_id = Column(ForeignKey(u'partners_session.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    session_start_date = Column(DateTime(True), nullable=False)
    session_end_date = Column(DateTime(True))
    member_id = Column(ForeignKey(u'member_member.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    orig_partner_id = Column(ForeignKey(u'partners_partner.id', deferrable=True, initially=u'DEFERRED'), index=True)
    partner_id = Column(ForeignKey(u'partners_partner.id', deferrable=True, initially=u'DEFERRED'), index=True)
    mentor_to_mentee_cnt = Column(Integer, server_default="0")
    mentee_to_mentor_cnt = Column(Integer, server_default="0")

    match_history = relationship(u'IuserMatchhistory')
    member = relationship(u'MemberMember')
    orig_partner = relationship(u'PartnersPartner', primaryjoin='ReportingMatchcompletesession.orig_partner_id == PartnersPartner.id')
    partner = relationship(u'PartnersPartner', primaryjoin='ReportingMatchcompletesession.partner_id == PartnersPartner.id')
    session = relationship(u'PartnersSession')


class ReportingMatcheventtracker(Base,db.Model):
    __tablename__ = 'reporting_matcheventtracker'

    id = Column(Integer, primary_key=True, server_default=text("nextval('reporting_matcheventtracker_id_seq'::regclass)"))
    event_id = Column(ForeignKey(u'calendars_event.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    member_id = Column(ForeignKey(u'member_member.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    partner_id = Column(ForeignKey(u'partners_partner.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    match_history_id = Column(ForeignKey(u'iuser_matchhistory.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    mentor_id = Column(ForeignKey(u'iuser_persona.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    mentee_id = Column(ForeignKey(u'iuser_persona.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    mentor_attended = Column(Boolean, nullable=False, server_default="false")
    mentee_attended = Column(Boolean, nullable=False, server_default="false")
    mentor_rsvp = Column(String(2), nullable=False)
    mentee_rsvp = Column(String(2), nullable=False)
    match_history_status = Column(Integer, nullable=False, server_default="0")

    event = relationship(u'CalendarsEvent')
    match_history = relationship(u'IuserMatchhistory')
    member = relationship(u'MemberMember')
    mentee = relationship(u'IuserPersona', primaryjoin='ReportingMatcheventtracker.mentee_id == IuserPersona.id')
    mentor = relationship(u'IuserPersona', primaryjoin='ReportingMatcheventtracker.mentor_id == IuserPersona.id')
    partner = relationship(u'PartnersPartner')


class ReportingPaeventtracker(Base,db.Model):
    __tablename__ = 'reporting_paeventtracker'

    id = Column(Integer, primary_key=True, server_default=text("nextval('reporting_paeventtracker_id_seq'::regclass)"))
    event_id = Column(ForeignKey(u'calendars_event.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    member_id = Column(ForeignKey(u'member_member.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    partner_id = Column(ForeignKey(u'partners_partner.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    pa_id = Column(ForeignKey(u'iuser_persona.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    attended = Column(Boolean, nullable=False, server_default="false")
    rsvp = Column(String(2), nullable=False)

    event = relationship(u'CalendarsEvent')
    member = relationship(u'MemberMember')
    pa = relationship(u'IuserPersona')
    partner = relationship(u'PartnersPartner')


class ReportingPartnerhistory(Base,db.Model):
    __tablename__ = 'reporting_partnerhistory'

    id = Column(Integer, primary_key=True, server_default=text("nextval('reporting_partnerhistory_id_seq'::regclass)"))
    partner_id = Column(ForeignKey(u'partners_partner.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    match_id = Column(ForeignKey(u'iuser_matchhistory.id', deferrable=True, initially=u'DEFERRED'), index=True)
    added_date = Column(DateTime(True))
    removed_date = Column(DateTime(True))

    match = relationship(u'IuserMatchhistory')
    partner = relationship(u'PartnersPartner')


class ReportingReportinglog(Base,db.Model):
    __tablename__ = 'reporting_reportinglog'

    id = Column(Integer, primary_key=True, server_default=text("nextval('reporting_reportinglog_id_seq'::regclass)"))
    last_update = Column(DateTime(True), nullable=False)
    report_name = Column(String(200), nullable=False)


class ReportingReportinglogentry(Base,db.Model):
    __tablename__ = 'reporting_reportinglogentry'

    id = Column(Integer, primary_key=True, server_default=text("nextval('reporting_reportinglogentry_id_seq'::regclass)"))
    info_id = Column(ForeignKey(u'reporting_reportinglog.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    text = Column(String(200), nullable=False)
    when = Column(DateTime(True), nullable=False, index=True)

    info = relationship(u'ReportingReportinglog')


class ReportingSwitchedmatchtotal(Base,db.Model):
    __tablename__ = 'reporting_switchedmatchtotal'

    id = Column(Integer, primary_key=True, server_default=text("nextval('reporting_switchedmatchtotal_id_seq'::regclass)"))
    match_history_id = Column(ForeignKey(u'iuser_matchhistory.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    member_id = Column(ForeignKey(u'member_member.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    partner_id = Column(ForeignKey(u'partners_partner.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    active_session_cnt = Column(Integer, nullable=False, server_default="0")
    mentor_email_session_cnt = Column(Integer, nullable=False, server_default="0")
    mentee_email_session_cnt = Column(Integer, nullable=False, server_default="0")
    perfect_email_session_cnt = Column(Integer, nullable=False, server_default="0")
    mentor_to_mentee_cnt = Column(Integer, nullable=False, server_default="0")
    mentee_to_mentor_cnt = Column(Integer, nullable=False, server_default="0")
    total_cnt = Column(Integer, nullable=False, server_default="0")
    when = Column(DateTime(True), nullable=False)

    match_history = relationship(u'IuserMatchhistory')
    member = relationship(u'MemberMember')
    partner = relationship(u'PartnersPartner')


