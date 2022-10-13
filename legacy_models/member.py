# -*- coding: iso8859-15 -*-
import os,sys
from datetime import datetime
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import db,Base,metadata

from sqlalchemy import (BigInteger, Boolean, Column, Date, DateTime, 
    Float, ForeignKey, Index, Integer, Numeric, SmallInteger, 
    String, Table, Text, Time, text, UniqueConstraint)
from sqlalchemy.dialects.postgresql.base import INET, TSVECTOR
from sqlalchemy.orm import relationship


class MemberMember(Base,db.Model):
    __tablename__ = 'member_member'

    id = Column(Integer, primary_key=True, server_default=text("nextval('member_member_id_seq'::regclass)"))
    name = Column(String(100), nullable=False)
    abbreviation = Column(String(20), nullable=False)
    address = Column(String(256), nullable=False)
    city = Column(String(256), nullable=False)
    state_id = Column(ForeignKey(u'utils_state.id', deferrable=True, initially=u'DEFERRED'), index=True)
    zip_code = Column(String(256), nullable=False)
    member_long = Column(Numeric(11,7),nullable=True)
    member_lat = Column(Numeric(11,7),nullable=True)
    country_id = Column(ForeignKey(u'utils_country.id', deferrable=True, initially=u'DEFERRED'), index=True)
    phone = Column(String(256), nullable=False)
    fax_number = Column(String(256), nullable=False)
    time_zone_id = Column(ForeignKey(u'utils_timezone.id', deferrable=True, initially=u'DEFERRED'), index=True)
    picture_logo = Column(String(256), nullable=False)
    number_contracted_users = Column(Integer)
    status_id = Column(ForeignKey(u'member_memberstatus.id', deferrable=True, initially=u'DEFERRED'), index=True)
    is_type_template = Column(Boolean, nullable=False, server_default="false")
    type_template_id = Column(ForeignKey(u'member_member.id', deferrable=True, initially=u'DEFERRED'), index=True)
    member_sign_up_date = Column(Date)
    member_expiration_date = Column(Date)
    contract_start_date = Column(Date)
    contract_end_date = Column(Date)
    location = Column(String(256), nullable=False)
    location_plural = Column(String(256), nullable=False)
    geographic_area = Column(String(256), nullable=False)
    editor_language_id = Column(ForeignKey(u'utils_editorlanguage.id', deferrable=True, initially=u'DEFERRED'), index=True)
    header_color = Column(String(30), nullable=False)
    font_color = Column(String(30), nullable=False)
    web_site = Column(String(256), nullable=False)
    embed_url = Column(String(256), nullable=False)
    url_name = Column(String(256), nullable=False)
    about_site = Column(Text, nullable=False)
    travel_direction = Column(Text, nullable=False)
    last_modify_date = Column(DateTime(True))
    primary_contact_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), index=True)
    assigned_super_admin_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), index=True)
    modified_by_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), index=True)
    created_by_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), index=True)
    personal_event_type_id = Column(ForeignKey(u'calendars_eventtype.id', deferrable=True, initially=u'DEFERRED'), unique=True)
    matching_template_type = Column(String(2), nullable=False, server_default=text("'S'::character varying"))
    logo = Column(String(100), nullable=False, server_default=text("'upload/member/default.jpg'::character varying"))
    allowed_undo_match_time = Column(Integer, nullable=False)
    retrievable_survey_label = Column(String(10), nullable=False)

    assigned_super_admin = relationship(u'IuserUser', primaryjoin='MemberMember.assigned_super_admin_id == IuserUser.id')
    country = relationship(u'UtilsCountry')
    created_by = relationship(u'IuserUser', primaryjoin='MemberMember.created_by_id == IuserUser.id')
    editor_language = relationship(u'UtilsEditorlanguage')
    modified_by = relationship(u'IuserUser', primaryjoin='MemberMember.modified_by_id == IuserUser.id')
    personal_event_type = relationship(u'CalendarsEventtype', primaryjoin='MemberMember.personal_event_type_id == CalendarsEventtype.id')
    primary_contact = relationship(u'IuserUser', primaryjoin='MemberMember.primary_contact_id == IuserUser.id')
    state = relationship(u'UtilsState')
    status = relationship(u'MemberMemberstatus')
    time_zone = relationship(u'UtilsTimezone')
    type_template = relationship(u'MemberMember', remote_side=[id])


class MemberMemberAdminEmailRecipient(Base,db.Model):
    __tablename__ = 'member_member_admin_email_recipients'

    id = Column(Integer, primary_key=True, server_default=text("nextval('member_member_admin_email_recipients_id_seq'::regclass)"))
    member_id = Column(ForeignKey(u'member_member.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    user_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    member = relationship(u'MemberMember')
    user = relationship(u'IuserUser')


class MemberMemberimage(Base,db.Model):
    __tablename__ = 'member_memberimage'

    id = Column(Integer, primary_key=True, server_default=text("nextval('member_memberimage_id_seq'::regclass)"))
    _image = Column(String(100), nullable=False)
    _original = Column(String(100), nullable=False)
    uploaded_on = Column(DateTime(True), nullable=False)
    member_id = Column(ForeignKey(u'member_member.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    member = relationship(u'MemberMember')


class MemberMemberlogo(Base,db.Model):
    __tablename__ = 'member_memberlogo'

    id = Column(Integer, primary_key=True, server_default=text("nextval('member_memberlogo_id_seq'::regclass)"))
    _image = Column(String(100), nullable=False)
    _original = Column(String(100), nullable=False)
    uploaded_on = Column(DateTime(True), nullable=False)
    member_id = Column(ForeignKey(u'member_member.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    member = relationship(u'MemberMember')


class MemberMembermessage(Base,db.Model):
    __tablename__ = 'member_membermessages'

    id = Column(Integer, primary_key=True, server_default=text("nextval('member_membermessages_id_seq'::regclass)"))
    member_id = Column(ForeignKey(u'member_member.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    order = Column(Integer, nullable=False)
    key = Column(String(100), nullable=False)
    name = Column(String(100), nullable=False, index=True)
    subject = Column(String(200), nullable=False)
    text = Column(Text, nullable=False)
    is_email = Column(Boolean, nullable=False, server_default="true")

    member = relationship(u'MemberMember')


class MemberMemberstatus(Base,db.Model):
    __tablename__ = 'member_memberstatus'

    id = Column(Integer, primary_key=True, server_default=text("nextval('member_memberstatus_id_seq'::regclass)"))
    type = Column(String(120), nullable=False)


class MemberMembertype(Base,db.Model):
    __tablename__ = 'member_membertype'

    id = Column(Integer, primary_key=True, server_default=text("nextval('member_membertype_id_seq'::regclass)"))
    type = Column(String(120), nullable=False)


class MemberMenteecustomization(Base,db.Model):
    __tablename__ = 'member_menteecustomizations'

    id = Column(Integer, primary_key=True, server_default=text("nextval('member_menteecustomizations_id_seq'::regclass)"))
    member_id = Column(ForeignKey(u'member_member.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    member = relationship(u'MemberMember')


class MemberMentorcustomization(Base,db.Model):
    __tablename__ = 'member_mentorcustomizations'

    id = Column(Integer, primary_key=True, server_default=text("nextval('member_mentorcustomizations_id_seq'::regclass)"))
    member_id = Column(ForeignKey(u'member_member.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    member = relationship(u'MemberMember')


class MemberUserprogram(Base,db.Model):
    __tablename__ = 'member_userprogram'

    id = Column(Integer, primary_key=True, server_default=text("nextval('member_userprogram_id_seq'::regclass)"))
    member_id = Column(ForeignKey(u'member_member.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    name = Column(String(100), nullable=False)
    abbr = Column(String(20), nullable=False)
    created_date = Column(DateTime(True))
    hidden = Column(Boolean, nullable=False, server_default="false")
    ordering = Column(Integer, nullable=False, server_default="0")

    member = relationship(u'MemberMember')


class MemberSchool(Base,db.Model):
    __tablename__ = 'member_school'
    id = Column(Integer, primary_key=True, server_default=text("nextval('member_attributes_id_seq'::regclass)"))
    member_id = Column(ForeignKey(u'member_member.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    school = Column(String(100))
    graduating_class = Column(Integer)
    __table_args__ = (UniqueConstraint('member_id', 'school', 'graduating_class'),)

    @property
    def grade(self):
        return 12 - (self.graduating_class - datetime.now().year)

