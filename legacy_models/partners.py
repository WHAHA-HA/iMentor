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

from legacy_models.utils import UtilsCountry, UtilsState, UtilsTimezone

class PartnersPartner(Base,db.Model):
    __tablename__ = 'partners_partner'

    id = Column(Integer, primary_key=True, server_default=text("nextval('partners_partner_id_seq'::regclass)"))
    name = Column(String(120), nullable=False)
    member_id = Column(ForeignKey(u'member_member.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    status_id = Column(ForeignKey(u'partners_partnerstatus.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    abbreviated_name = Column(String(50), nullable=False)
    about = Column(Text, nullable=False)
    class_meeting_times = Column(String(255), nullable=False)
    location = Column(String(255), nullable=False)
    country_id = Column(ForeignKey(u'utils_country.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True, server_default=text("334"))
    street_address = Column(String(255), nullable=False)
    city = Column(String(255), nullable=False)
    state_id = Column(ForeignKey(u'utils_state.id', deferrable=True, initially=u'DEFERRED'), index=True)
    zip_code = Column(String(10), nullable=False)
    partner_long = Column(Numeric(11,7),nullable=True)
    partner_lat = Column(Numeric(11,7),nullable=True)
    phone = Column(String(30), nullable=False)
    fax = Column(String(20), nullable=False)
    website = Column(String(200), nullable=False)
    creation_date = Column(Date, nullable=False)
    time_zone_id = Column(ForeignKey(u'utils_timezone.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    obligation = Column(SmallInteger, nullable=False, server_default=text("1"))
    admin_obligation = Column(SmallInteger, nullable=False, server_default=text("1"))
    legacy = Column(Boolean, nullable=False, server_default="false")
    teacher_contact_id = Column(ForeignKey(u'iuser_persona.id', deferrable=True, initially=u'DEFERRED'), index=True)
    member_contact_id = Column(ForeignKey(u'iuser_persona.id', deferrable=True, initially=u'DEFERRED'), index=True)
    photo = Column(String(100), nullable=False, server_default=text("'upload/partner/default.jpg'::character varying"))
    directions = Column(Text)
    email_obligation = Column(SmallInteger, nullable=False)
    is_alumni = Column(Boolean, nullable=False)
    is_dummy = Column(Boolean, nullable=False)
    alumni_date = Column(Date)
    program_name = Column(String(100))
    program_length = Column(Integer)
    program_start_date = Column(DateTime)
    graduating_class_id = Column(ForeignKey(u'member_school.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    graduating_class = relationship(u'MemberSchool',primaryjoin='PartnersPartner.graduating_class_id==MemberSchool.id')

    country = relationship(u'UtilsCountry')
    member_contact = relationship(u'IuserPersona', primaryjoin='PartnersPartner.member_contact_id == IuserPersona.id')
    member = relationship(u'MemberMember')
    state = relationship(u'UtilsState')
    status = relationship(u'PartnersPartnerstatus')
    teacher_contact = relationship(u'IuserPersona', primaryjoin='PartnersPartner.teacher_contact_id == IuserPersona.id')
    time_zone = relationship(u'UtilsTimezone')


class PartnersPartnerUserProgram(Base,db.Model):
    __tablename__ = 'partners_partner_user_programs'

    id = Column(Integer, primary_key=True, server_default=text("nextval('partners_partner_user_programs_id_seq'::regclass)"))
    partner_id = Column(ForeignKey(u'partners_partner.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    userprogram_id = Column(ForeignKey(u'member_userprogram.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    partner = relationship(u'PartnersPartner')
    userprogram = relationship(u'MemberUserprogram')


class PartnersPartnerstatus(Base,db.Model):
    __tablename__ = 'partners_partnerstatus'

    id = Column(Integer, primary_key=True, server_default=text("nextval('partners_partnerstatus_id_seq'::regclass)"))
    name = Column(String(50), nullable=False)


class PartnersSession(Base,db.Model):
    __tablename__ = 'partners_session'

    id = Column(Integer, primary_key=True, server_default=text("nextval('partners_session_id_seq'::regclass)"))
    description = Column(String(255), nullable=False)
    #start = Column(DateTime(False))
    start = Column(DateTime(False))
    prompt_id = Column(ForeignKey(u'curriculum_prompt.id', deferrable=True, initially=u'DEFERRED'), index=True)
    status_id = Column(ForeignKey(u'partners_sessionstatus.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    partner_id = Column(ForeignKey(u'partners_partner.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    #end_date = Column(DateTime(False))
    end_date = Column(DateTime(False))
    activity_recorded = Column(Boolean, nullable=False, server_default="false")

    partner = relationship(u'PartnersPartner')
    prompt = relationship(u'CurriculumPrompt')
    status = relationship(u'PartnersSessionstatus')
    
class PartnersSessionstatus(Base,db.Model):
    __tablename__ = 'partners_sessionstatus'

    id = Column(Integer, primary_key=True, server_default=text("nextval('partners_sessionstatus_id_seq'::regclass)"))
    name = Column(String(50), nullable=False)
