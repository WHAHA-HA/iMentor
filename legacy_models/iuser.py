# -*- coding: iso8859-15 -*-
import os,sys
import pprint
import logging
import datetime
import re
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'../..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)
from config.project_globals import db,Base,metadata,DBSession,DOGPILE_CACHE_REGION
from config.caching_query import CachingQuery,FromCache
from sqlalchemy import (BigInteger, Boolean, Column, Date, DateTime, 
    Float, ForeignKey, Index, Integer, Numeric, SmallInteger, 
    String, Table, Text, Time, text, func, UniqueConstraint)
from sqlalchemy.dialects.postgresql.base import INET, TSVECTOR
from sqlalchemy.orm import relationship
from sqlalchemy.dialects.postgresql import UUID
from college_checklist.models import UtilsCollege
from legacy_models.member import MemberMember
from legacy_models.partners import PartnersPartner

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Constants
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# IuserUsertypes:
BASIC_USER = 0
MEMBER_ADMIN = 1
REGIONAL_ADMIN = 2
PARTNER_ADMIN = 3
MENTOR = 4
MENTEE = 5
SUPER_ADMIN = 6
E_MEMBER_ADMIN = 7

USERTYPES = ( 
    (BASIC_USER, 'Basic User'),
    (MEMBER_ADMIN, 'Member Admin'),
    (REGIONAL_ADMIN, 'Regional Admin'),
    (PARTNER_ADMIN, 'Partner Admin'),
    (MENTOR, 'Mentor'),
    (MENTEE, 'Mentee'),
    (SUPER_ADMIN, 'Super Admin'),
    (E_MEMBER_ADMIN, 'Enhanced Member Admin'),
    )

USERTYPE_MAP = {
    BASIC_USER: 'Basic User',
    MEMBER_ADMIN: 'Member Admin',
    REGIONAL_ADMIN: 'Regional Admin',
    PARTNER_ADMIN: 'Partner Admin',
    MENTOR: 'Mentor',
    MENTEE: 'Mentee',
    SUPER_ADMIN: 'Super Admin',
    E_MEMBER_ADMIN: 'Enhanced Member Admin',
    }

STATUS_CHOICES = (("A", "Active"),
                  ("AI", "Application Incomplete"),
                  ("SI", "Screening Incomplete"),
                  ("IR", "Inactive Rejected"),
                  ("IW", "Inactive Withdrawn"),
                  ("ID", "Inactive Deleted"))


USER_STATUS_ACTIVE = "A"
USER_STATUS_APPLICATION_INCOMPLETE = "AI"
USER_STATUS_SCREENING_INCOMPLETE = "SI"
USER_STATUS_INACTIVE_REJECTED = 'IR'
USER_STATUS_INTACTIVE_WITHDRAWN = 'IW'
USER_STATUS_INTACTIVE_DELETED = 'ID'

USER_STATUS_MAP = {
   "A":"Active",
   "AI":"Application Incomplete",
   "SI":"Screening Incomplete",
   "IR":"Inactive Rejected",
   "IW":"Inactive Withdrawn",
   "ID":"Inactive Deleted",
   }


P_MATCH_STATUS_READY = 'RTBM'
P_MATCH_STATUS_MATCHED = 'M'
P_MATCH_STATUS_CLOSED = 'C'
P_MATCH_STATUS_NA = 'NA'
P_MATCH_STATUS_RESCREENING = 'RS'
P_MATCH_STATUS_NOT_MATCHING = 'NM'

MATCH_CHOICES = {P_MATCH_STATUS_READY: "Ready to be Matched",
                P_MATCH_STATUS_MATCHED: "Matched",
                P_MATCH_STATUS_CLOSED: "Closed",
                P_MATCH_STATUS_NA: "N/A",
                P_MATCH_STATUS_RESCREENING: "Rescreening",
                P_MATCH_STATUS_NOT_MATCHING: "Not Matching",
                }

GENDER_CHOICES = { 
    "Male":"M",
    "Female":"F",
    "Neither, I identify as...":"N"
}

MARITAL_STATUS_CHOICES = {
    "N/A":'N',
    "I'd prefer not to answer":'A',
    "Married":'M',
    "Single":'S',
    "Engaged":'E',
    "Divorced":'D',
    "Widow/Widower":'W',
    "Significant Other":'O',
    "Domestic Partner":'P'
}

primary_addr_choices = ( ("H", "Home"), ("W", "Work") )
primary_phone_choices = ( ("H", "Home"), ("W", "Work"), ("C", "Cell") )

mentor_phone_choices = ( ("H", "Home"), ("C", "Cell") )

TRAINING_ATTENDANCE_CHOICES = (('Y', 'Yes'),
                               ('N', 'No',),
                               ('R', 'RSVPed'))

BACKGROUND_CHECK_CHOICES = (('S', 'Submitted'),
                            ('A', 'Approved'),
                            ('D', 'Denied'),
                            ('F', 'Further Investigation'),
                            ('V', '2nd Vendor Approved'),
                            ('E', 'Error'))

REFERENCE_CHECK_CHOICES = (('Y', 'Yes'),
                           ('N', 'No'))



RATING_CHOICES =(
    ('N', 'N'),
    ('1', '1'),
    ('2', '2'),
    ('3', '3'),
    ('4', '4'),
)

ACTIVE_PERSONA_STATUS = 'A'
INACTIVE_PERSONA_STATUS = 'I'

PERSONA_STATUS_CHOICES = (
    (ACTIVE_PERSONA_STATUS, "Active"),
    (INACTIVE_PERSONA_STATUS, "Inactive"),
)

IMI_HEAR_CHOICES = (
    ('FF', 'Friend / Family'),
    ('SW', 'Surfing the Web'),
    ('VW', 'Volunteer Website'),
    ('VF', 'Volunteer Fair'),
    ('CWE', 'Co-worker / Employer'),
    ('NA', 'News Article'),
    ('O', 'Other')
)

ALERTS_DESTINATION_INTERNAL = 'I'
ALERTS_DESTINATION_EXTERNAL = 'E'
ALERTS_DESTINATONS = ((ALERTS_DESTINATION_INTERNAL, 'Send to Internal Email'),
                      (ALERTS_DESTINATION_EXTERNAL, 'Send to External Email'))


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Models
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

class IuserAcademicfield(Base,db.Model):
    __tablename__ = 'iuser_academicfield'

    id = Column(Integer, primary_key=True, server_default=text("nextval('iuser_academicfield_id_seq'::regclass)"))
    name = Column(String(500), nullable=False, unique=True)


class IuserAssignedusertype(Base,db.Model):
    __tablename__ = 'iuser_assignedusertype'

    id = Column(Integer, primary_key=True, server_default=text("nextval('iuser_assignedusertype_id_seq'::regclass)"))
    member_id = Column(ForeignKey(u'member_member.id', deferrable=True, initially=u'DEFERRED'), index=True)
    order = Column(SmallInteger, nullable=False)
    usertype_id = Column(ForeignKey(u'iuser_usertype.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    name = Column(String(120), nullable=False)
    abbr = Column(String(20), nullable=False)
    fixed = Column(Boolean, nullable=False, server_default="false")

    member = relationship(u'MemberMember')
    usertype = relationship(u'IuserUsertype')


class IuserCareer(Base,db.Model):
    __tablename__ = 'iuser_career'

    id = Column(Integer, primary_key=True, server_default=text("nextval('iuser_career_id_seq'::regclass)"))
    name = Column(String(500), nullable=False, unique=True)


class IuserChild(Base,db.Model):
    __tablename__ = 'iuser_child'

    id = Column(Integer, primary_key=True, server_default=text("nextval('iuser_child_id_seq'::regclass)"))
    user_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    date_of_birth = Column(DateTime(True))

    user = relationship(u'IuserUser')


class IuserCollapseduser(Base,db.Model):
    __tablename__ = 'iuser_collapseduser'

    id = Column(Integer, primary_key=True)
    user_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    user = relationship(u'IuserUser')


class IuserEmployer(Base,db.Model):
    __tablename__ = 'iuser_employer'

    id = Column(Integer, primary_key=True, server_default=text("nextval('iuser_employer_id_seq'::regclass)"))
    name = Column(String(255), nullable=False, unique=True)


class IuserEmployerMember(Base,db.Model):
    __tablename__ = 'iuser_employer_members'

    id = Column(Integer, primary_key=True, server_default=text("nextval('iuser_employer_members_id_seq'::regclass)"))
    employer_id = Column(ForeignKey(u'iuser_employer.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    member_id = Column(ForeignKey(u'member_member.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    employer = relationship(u'IuserEmployer')
    member = relationship(u'MemberMember')


class IuserGopassinfo(Base,db.Model):
    __tablename__ = 'iuser_gopassinfo'

    id = Column(Integer, primary_key=True, server_default=text("nextval('iuser_gopassinfo_id_seq'::regclass)"))
    go_pass_upload_id = Column(ForeignKey(u'iuser_gopassupload.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    user_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), index=True)
    name = Column(String(256), nullable=False)
    dob = Column(Date)
    keycard = Column(String(256), nullable=False)
    email_address = Column(String(256), nullable=False)
    primary_phone = Column(String(256), nullable=False)
    project = Column(String(256), nullable=False)
    rosterstatus = Column(String(256), nullable=False)
    eligibilitystatus = Column(String(256), nullable=False)
    eligibilitydescription = Column(String(512), nullable=False)
    status_change = Column(String(512), nullable=False)

    go_pass_upload = relationship(u'IuserGopassupload')
    user = relationship(u'IuserUser')


class IuserGopassupload(Base,db.Model):
    __tablename__ = 'iuser_gopassupload'

    id = Column(Integer, primary_key=True, server_default=text("nextval('iuser_gopassupload_id_seq'::regclass)"))
    csv_file = Column(String(100), nullable=False)
    upload_date = Column(Date, nullable=False)


class IuserIntakefieldquestion(Base,db.Model):
    __tablename__ = 'iuser_intakefieldquestion'

    id = Column(Integer, primary_key=True, server_default=text("nextval('iuser_intakefieldquestion_id_seq'::regclass)"))
    question = Column(Text, nullable=False)
    model_field = Column(String(255), nullable=False)


class IuserIntakefieldquestioninstruction(Base,db.Model):
    __tablename__ = 'iuser_intakefieldquestioninstructions'

    id = Column(Integer, primary_key=True, server_default=text("nextval('iuser_intakefieldquestioninstructions_id_seq'::regclass)"))
    text = Column(Text)


class IuserIntakefield(Base,db.Model):
    __tablename__ = 'iuser_intakefield'

    id = Column(Integer, primary_key=True, server_default=text("nextval('iuser_intakefield_id_seq'::regclass)"))
    member_id = Column(ForeignKey(u'member_member.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    question_id = Column(ForeignKey(u'iuser_intakefieldquestion.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    assignedusertype_id = Column(ForeignKey(u'iuser_assignedusertype.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    is_hidden = Column(Boolean, nullable=False, server_default="false")
    is_required = Column(Boolean, nullable=False, server_default="false")
    order = Column(SmallInteger, nullable=False)
    instructions_id = Column(ForeignKey(u'iuser_intakefieldquestioninstructions.id', deferrable=True, initially=u'DEFERRED'), index=True)

    assignedusertype = relationship(u'IuserAssignedusertype')
    instructions = relationship(u'IuserIntakefieldquestioninstruction')
    member = relationship(u'MemberMember')
    question = relationship(u'IuserIntakefieldquestion')


class IuserInterview(Base,db.Model):
    __tablename__ = 'iuser_interview'

    id = Column(Integer, primary_key=True, server_default=text("nextval('iuser_interview_id_seq'::regclass)"))
    training_attendance = Column(String(2), nullable=False, unique=True)
    training_attendance_date = Column(DateTime(True))
    training_attendance_persona_id = Column(ForeignKey(u'iuser_persona.id', deferrable=True, initially=u'DEFERRED'), index=True)
    training_date = Column(DateTime(True))
    training_date_date = Column(DateTime(True))
    training_date_persona_id = Column(ForeignKey(u'iuser_persona.id', deferrable=True, initially=u'DEFERRED'), index=True)
    background_check = Column(String(2), nullable=False, unique=True)
    background_check_date = Column(DateTime(True))
    background_check_persona_id = Column(ForeignKey(u'iuser_persona.id', deferrable=True, initially=u'DEFERRED'), index=True)
    employment_check_complete = Column(Boolean, nullable=False, server_default="false")
    notes = Column(Text, nullable=False)

    background_check_persona = relationship(u'IuserPersona', primaryjoin='IuserInterview.background_check_persona_id == IuserPersona.id')
    training_attendance_persona = relationship(u'IuserPersona', primaryjoin='IuserInterview.training_attendance_persona_id == IuserPersona.id')
    training_date_persona = relationship(u'IuserPersona', primaryjoin='IuserInterview.training_date_persona_id == IuserPersona.id')


class IuserMatch(Base,db.Model):
    __tablename__ = 'iuser_match'

    id = Column(Integer, primary_key=True, server_default=text("nextval('iuser_match_id_seq'::regclass)"))
    start = Column(Date, nullable=False)
    end = Column(Date)
    mentee_comments = Column(Text, nullable=False)
    mentor_comments = Column(Text, nullable=False)


class IuserMatchclosecategory(Base,db.Model):
    __tablename__ = 'iuser_matchclosecategory'

    id = Column(Integer, primary_key=True, server_default=text("nextval('iuser_matchclosecategory_id_seq'::regclass)"))
    text = Column(Text, nullable=False)
    sort_order = Column(Integer, nullable=False, server_default="0")
    visible = Column(Boolean, nullable=False, server_default="true")


class IuserMatchclosereason(Base,db.Model):
    __tablename__ = 'iuser_matchclosereason'

    id = Column(Integer, primary_key=True, server_default=text("nextval('iuser_matchclosereason_id_seq'::regclass)"))
    sort_order = Column(Integer, nullable=False, server_default="0")
    text = Column(Text, nullable=False)
    visible = Column(Boolean, nullable=False, server_default="true")
    category_id = Column(ForeignKey(u'iuser_matchclosecategory.id', deferrable=True, initially=u'DEFERRED'), index=True)

    category = relationship(u'IuserMatchclosecategory')


class IuserMatchcloserecord(Base,db.Model):
    __tablename__ = 'iuser_matchcloserecord'

    id = Column(Integer, primary_key=True, server_default=text("nextval('iuser_matchcloserecord_id_seq'::regclass)"))
    match_id = Column(ForeignKey(u'iuser_matchhistory.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    reason_id = Column(ForeignKey(u'iuser_matchclosereason.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    reopened = Column(Boolean, nullable=False, server_default="false")
    end = Column(DateTime(True))
    closed_by_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    closed_by = relationship(u'IuserUser')
    match = relationship(u'IuserMatchhistory')
    reason = relationship(u'IuserMatchclosereason')


class IuserMatchhistory(Base,db.Model):
    __tablename__ = 'iuser_matchhistory'
    __table_args__ = (
        Index('iuser_matchhistory_mentor_movement_2_29251bfd1056d683', 'mentor_movement_2', 'mentee_movement_2', 'mentor_movement_4', 'mentee_movement_4', 'mentor_movement_6', 'mentee_movement_6', 'mentor_movement_10', 'mentee_movement_10', 'mentor_movement_life', 'mentee_movement_life'),
    )

    id = Column(Integer, primary_key=True, server_default=text("nextval('iuser_matchhistory_id_seq'::regclass)"))
    start = Column(DateTime(True), nullable=False)
    end = Column(DateTime(True))
    mentor_id = Column(ForeignKey(u'iuser_persona.id', deferrable=True, initially=u'DEFERRED'), index=True)
    mentee_id = Column(ForeignKey(u'iuser_persona.id', deferrable=True, initially=u'DEFERRED'), index=True)
    status = Column(SmallInteger, nullable=False)
    mentor_comments = Column(Text, nullable=False, server_default=text("''::text"))
    mentee_comments = Column(Text, nullable=False, server_default=text("''::text"))
    mentor_movement_2 = Column(Integer, nullable=False)
    mentee_movement_2 = Column(Integer, nullable=False)
    mentor_movement_4 = Column(Integer, nullable=False)
    mentee_movement_4 = Column(Integer, nullable=False)
    mentor_movement_6 = Column(Integer, nullable=False)
    mentee_movement_6 = Column(Integer, nullable=False)
    mentor_movement_10 = Column(Integer, nullable=False)
    mentee_movement_10 = Column(Integer, nullable=False)
    mentor_movement_life = Column(Integer, nullable=False)
    mentee_movement_life = Column(Integer, nullable=False)
    is_communicating = Column(Boolean, nullable=False)

    mentee = relationship(u'IuserPersona', primaryjoin='IuserMatchhistory.mentee_id == IuserPersona.id')
    mentor = relationship(u'IuserPersona', primaryjoin='IuserMatchhistory.mentor_id == IuserPersona.id')


class IuserOccupation(Base,db.Model):
    __tablename__ = 'iuser_occupation'

    id = Column(Integer, primary_key=True, server_default=text("nextval('iuser_occupation_id_seq'::regclass)"))
    name = Column(String(500), nullable=False, unique=True)


class IuserPersona(Base,db.Model):
    __tablename__ = 'iuser_persona'

    id = Column(Integer, primary_key=True, server_default=text("nextval('iuser_persona_id_seq'::regclass)"))
    user_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    assigned_usertype_id = Column(ForeignKey(u'iuser_assignedusertype.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    match_status = Column(String(20), nullable=False, server_default=text("'NA'::character varying"))
    match_id = Column(ForeignKey(u'iuser_match.id', deferrable=True, initially=u'DEFERRED'), index=True)
    memberprofile_edit_messaging = Column(Boolean, nullable=False, server_default="false")
    memberprofile_edit_assign_curriculum = Column(Boolean, nullable=False, server_default="false")
    memberprofile_edit_intake_application = Column(Boolean, nullable=False, server_default="false")
    memberprofile_evaluation_page = Column(Boolean, nullable=False, server_default="false")
    memberblog_editor = Column(Boolean, nullable=False, server_default="false")
    bugreporting_ability_to_report_bugs = Column(Boolean, nullable=False, server_default="false")
    status = Column(String(4), nullable=False, index=True, server_default=text("'I'::character varying"))
    hold = Column(Boolean, nullable=False, server_default="false")
    hold_by_id = Column(ForeignKey(u'iuser_persona.id', deferrable=True, initially=u'DEFERRED'), index=True)
    hold_comment = Column(Text, nullable=False, server_default=text("''::text"))
    alerts_destination = Column(String(2), nullable=False, server_default=text("'I'::character varying"))
    alerts_digest = Column(Boolean, nullable=False, server_default="false")
    intake_last_updated = Column(DateTime(True), nullable=False, default=datetime.datetime.now)
    about = Column(Text, nullable=False, server_default=text("''::text"))
    status_blurb = Column(String(400), nullable=False, server_default=text("''::character varying"))
    announcement_edit = Column(Boolean, nullable=False, server_default="false")
    announcement_delete = Column(Boolean, nullable=False, server_default="false")
    qualtrics_panel_member_id = Column(String)

    assigned_usertype = relationship(u'IuserAssignedusertype')
    hold_by = relationship(u'IuserPersona', remote_side=[id])
    match = relationship(u'IuserMatch')
    user = relationship(u'IuserUser')


class IuserPersonaNetworkPersona(Base,db.Model):
    __tablename__ = 'iuser_persona_network_personas'

    id = Column(Integer, primary_key=True, server_default=text("nextval('iuser_persona_network_personas_id_seq'::regclass)"))
    from_persona_id = Column(ForeignKey(u'iuser_persona.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    to_persona_id = Column(ForeignKey(u'iuser_persona.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    from_persona = relationship(u'IuserPersona', primaryjoin='IuserPersonaNetworkPersona.from_persona_id == IuserPersona.id')
    to_persona = relationship(u'IuserPersona', primaryjoin='IuserPersonaNetworkPersona.to_persona_id == IuserPersona.id')


class IuserPersonaPartner(Base,db.Model):
    __tablename__ = 'iuser_persona_partners'

    id = Column(Integer, primary_key=True, server_default=text("nextval('iuser_persona_partners_id_seq'::regclass)"))
    persona_id = Column(ForeignKey(u'iuser_persona.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    partner_id = Column(ForeignKey(u'partners_partner.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    partner = relationship(u'PartnersPartner')
    persona = relationship(u'IuserPersona')


class IuserPersonaUserProgram(Base,db.Model):
    __tablename__ = 'iuser_persona_user_programs'

    id = Column(Integer, primary_key=True, server_default=text("nextval('iuser_persona_user_programs_id_seq'::regclass)"))
    persona_id = Column(ForeignKey(u'iuser_persona.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    userprogram_id = Column(ForeignKey(u'member_userprogram.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    persona = relationship(u'IuserPersona')
    userprogram = relationship(u'MemberUserprogram')


class IuserPersonalegacyuserid(Base,db.Model):
    __tablename__ = 'iuser_personalegacyuserid'

    id = Column(Integer, primary_key=True, server_default=text("nextval('iuser_personalegacyuserid_id_seq'::regclass)"))
    user_id = Column(Integer, nullable=False)
    persona_id = Column(ForeignKey(u'iuser_persona.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    persona = relationship(u'IuserPersona')


class IuserRacialgroup(Base,db.Model):
    __tablename__ = 'iuser_racialgroup'

    id = Column(Integer, primary_key=True, server_default=text("nextval('iuser_racialgroup_id_seq'::regclass)"))
    ordinal = Column(Integer, nullable=False, default=0)
    group = Column(String(100), nullable=False, unique=True)


class IuserReferencecheck(Base,db.Model):
    __tablename__ = 'iuser_referencecheck'

    id = Column(Integer, primary_key=True, server_default=text("nextval('iuser_referencecheck_id_seq'::regclass)"))
    interview_status = Column(String(2))
    interview_complete_date = Column(DateTime(True))
    interview_completed_by_id = Column(ForeignKey(u'iuser_persona.id', deferrable=True, initially=u'DEFERRED'), index=True)
    employment_status = Column(String(2))
    employment_complete_date = Column(DateTime(True))
    employment_completed_by_id = Column(ForeignKey(u'iuser_persona.id', deferrable=True, initially=u'DEFERRED'), index=True)
    first_reference_status = Column(String(2))
    first_reference_complete_date = Column(DateTime(True))
    first_reference_completed_by_id = Column(ForeignKey(u'iuser_persona.id', deferrable=True, initially=u'DEFERRED'), index=True)
    first_reference_notes = Column(Text, default=None)
    second_reference_status = Column(String(2))
    second_reference_complete_date = Column(DateTime(True))
    second_reference_completed_by_id = Column(ForeignKey(u'iuser_persona.id', deferrable=True, initially=u'DEFERRED'), index=True)
    second_reference_notes = Column(Text, default=None)
    third_reference_status = Column(String(2))
    third_reference_complete_date = Column(DateTime(True))
    third_reference_completed_by_id = Column(ForeignKey(u'iuser_persona.id', deferrable=True, initially=u'DEFERRED'), index=True)
    third_reference_notes = Column(Text, default=None)
    fourth_reference_status = Column(String(2))
    fourth_reference_complete_date = Column(DateTime(True))
    fourth_reference_completed_by_id = Column(ForeignKey(u'iuser_persona.id', deferrable=True, initially=u'DEFERRED'), index=True)
    fourth_reference_notes = Column(Text, default=None)
    background_status = Column(String(2))
    background_complete_date = Column(DateTime(True))
    background_completed_by_id = Column(ForeignKey(u'iuser_persona.id', deferrable=True, initially=u'DEFERRED'), index=True)
    training_status = Column(String(2))
    training_complete_date = Column(DateTime(True))
    training_completed_by_id = Column(ForeignKey(u'iuser_persona.id', deferrable=True, initially=u'DEFERRED'), index=True)
    employment_check_complete = Column(Boolean)
    notes = Column(Text)
    training_date = Column(DateTime(True))
    training_date_complete_date = Column(DateTime(True))
    training_date_completed_by_id = Column(ForeignKey(u'iuser_persona.id', deferrable=True, initially=u'DEFERRED'), index=True)
    notes_complete_date = Column(DateTime(True))
    notes_completed_by_id = Column(ForeignKey(u'iuser_persona.id', deferrable=True, initially=u'DEFERRED'), index=True)
    interview_complete = Column(Boolean)
    first_reference_complete = Column(Boolean)
    second_reference_complete = Column(Boolean)
    third_reference_complete = Column(Boolean)
    fourth_reference_complete = Column(Boolean)

    background_completed_by = relationship(u'IuserPersona', primaryjoin='IuserReferencecheck.background_completed_by_id == IuserPersona.id')
    employment_completed_by = relationship(u'IuserPersona', primaryjoin='IuserReferencecheck.employment_completed_by_id == IuserPersona.id')
    first_reference_completed_by = relationship(u'IuserPersona', primaryjoin='IuserReferencecheck.first_reference_completed_by_id == IuserPersona.id')
    fourth_reference_completed_by = relationship(u'IuserPersona', primaryjoin='IuserReferencecheck.fourth_reference_completed_by_id == IuserPersona.id')
    interview_completed_by = relationship(u'IuserPersona', primaryjoin='IuserReferencecheck.interview_completed_by_id == IuserPersona.id')
    notes_completed_by = relationship(u'IuserPersona', primaryjoin='IuserReferencecheck.notes_completed_by_id == IuserPersona.id')
    second_reference_completed_by = relationship(u'IuserPersona', primaryjoin='IuserReferencecheck.second_reference_completed_by_id == IuserPersona.id')
    third_reference_completed_by = relationship(u'IuserPersona', primaryjoin='IuserReferencecheck.third_reference_completed_by_id == IuserPersona.id')
    training_completed_by = relationship(u'IuserPersona', primaryjoin='IuserReferencecheck.training_completed_by_id == IuserPersona.id')
    training_date_completed_by = relationship(u'IuserPersona', primaryjoin='IuserReferencecheck.training_date_completed_by_id == IuserPersona.id')


class IuserSplituser(Base,db.Model):
    __tablename__ = 'iuser_splituser'

    id = Column(Integer, primary_key=True, server_default=text("nextval('iuser_splituser_id_seq'::regclass)"))
    orig_email = Column(String(75), nullable=False)
    user_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    user = relationship(u'IuserUser')


class IuserUser(Base,db.Model):
    __tablename__ = 'iuser_user'
    __table_args__ = (
        Index('iuser_user_email_4d49e14b415af150', 'email', 'date_of_birth', 'application_submit_date', 'date_joined'),
    )

    id = Column(Integer, primary_key=True, server_default=text("nextval('iuser_user_id_seq'::regclass)"))
    email = Column(String(256), nullable=False, unique=True)
    password = Column(String(256), nullable=False)
    password_question = Column(String(256), nullable=False)
    password_answer = Column(String(256), nullable=False)
    legacy = Column(Boolean, nullable=False, server_default="false")
    first_name = Column(String(256), nullable=False)
    last_name = Column(String(256), nullable=False)
    maiden_name = Column(String(256), nullable=False)
    middle_name = Column(String(256), nullable=False)
    gender = Column(String(1), nullable=False, server_default=text("''::character varying"))
    address1 = Column(String(200), nullable=False, server_default=text("''::character varying"))
    city = Column(String(256), nullable=False, server_default=text("''::character varying"))
    state_id = Column(ForeignKey(u'utils_state.id', deferrable=True, initially=u'DEFERRED'), index=True)
    country_id = Column(ForeignKey(u'utils_country.id', deferrable=True, initially=u'DEFERRED'), index=True)
    zip_code = Column(String(256), nullable=False)
    work_address = Column(String(200), nullable=False, server_default=text("''::character varying"))
    work_city = Column(String(256), nullable=False, server_default=text("''::character varying"))
    work_state_id = Column(ForeignKey(u'utils_state.id', deferrable=True, initially=u'DEFERRED'), index=True)
    work_zip_code = Column(String(256), nullable=False)
    previous_address = Column(String(200), nullable=False, server_default=text("''::character varying"))
    previous_city = Column(String(256), nullable=False, server_default=text("''::character varying"))
    previous_state_id = Column(ForeignKey(u'utils_state.id', deferrable=True, initially=u'DEFERRED'), index=True)
    previous_zip_code = Column(String(256), nullable=False)
    primary_address = Column(String(1), nullable=False, server_default=text("''::character varying"))
    home_phone = Column(String(60), nullable=False)
    work_phone = Column(String(60), nullable=False)
    cell_phone = Column(String(60), nullable=False)
    work_fax = Column(String(60), nullable=False)
    work_long = Column(Numeric(11,7), nullable=True)
    work_lat = Column(Numeric(11,7), nullable=True)
    home_long = Column(Numeric(11,7), nullable=True)
    home_lat = Column(Numeric(11,7), nullable=True)
    primary_phone_member = Column(String(1), nullable=False, server_default=text("''::character varying"))
    primary_phone_staff = Column(String(1), nullable=False, server_default=text("''::character varying"))
    home_phone_is_cell = Column(Boolean, nullable=False, server_default="false")
    work_phone_is_cell = Column(Boolean, nullable=False, server_default="false")
    grade = Column(Integer)
    marital_status = Column(String(1), nullable=False)
    has_children = Column(Boolean, nullable=False, server_default="false")
    number_children = Column(Integer, nullable=False, server_default="0")
    date_of_birth = Column(DateTime(True))
    application_submit_date = Column(DateTime(True))
    last_login = Column(DateTime(True), nullable=False, default=datetime.datetime.now)
    date_joined = Column(DateTime(True))
    last_modified_date = Column(DateTime(True))
    last_modified_by_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), index=True)
    work_ny = Column(Boolean, nullable=False, server_default="false")
    live_ny = Column(Boolean, nullable=False, server_default="false")
    borough_ny = Column(String(256), nullable=False)
    neighborhood = Column(String(256), nullable=False)
    employer_id = Column(ForeignKey(u'iuser_employer.id', deferrable=True, initially=u'DEFERRED'), index=True)
    employer_other = Column(String(100), nullable=False)
    career_id = Column(ForeignKey(u'utils_career.id', deferrable=True, initially=u'DEFERRED'), index=True)
    occupation_id = Column(ForeignKey(u'utils_occupation.id', deferrable=True, initially=u'DEFERRED'), index=True)
    job_title = Column(String(500), nullable=False)
    imentor_hear = Column(String(100), nullable=False)
    imentor_other = Column(Text, nullable=False)
    affiliate_program = Column(String(100), nullable=False)
    mentee_consent_form = Column(Boolean, nullable=False, server_default="false")
    meet_out_of_program = Column(Boolean, nullable=False, server_default="false")
    has_additional_email = Column(Boolean, nullable=False, server_default="false")
    additional_email = Column(String(256), nullable=False)
    parent_name = Column(String(100), nullable=False)
    parent_address = Column(String(200), nullable=False, server_default=text("''::character varying"))
    parent_city = Column(String(256), nullable=False, server_default=text("''::character varying"))
    parent_state_id = Column(ForeignKey(u'utils_state.id', deferrable=True, initially=u'DEFERRED'), index=True)
    parent_zip_code = Column(String(256), nullable=False)
    parent_home_phone = Column(String(60), nullable=False)
    parent_work_phone = Column(String(60), nullable=False)
    parent_cell_phone = Column(String(60), nullable=False)
    parent_home_phone_is_cell = Column(Boolean, nullable=False, server_default="false")
    parent_work_phone_is_cell = Column(Boolean, nullable=False, server_default="false")
    parent_fax = Column(String(60), nullable=False)
    parent_contact = Column(String(1), nullable=False)
    is_superuser = Column(Boolean, nullable=False, server_default="false")
    status = Column(String(2), nullable=False, index=True, server_default=text("'I'::character varying"))
    member_id = Column(ForeignKey(u'member_member.id', deferrable=True, initially=u'DEFERRED'), index=True)
    photo = Column(String(100), nullable=False, server_default=text("'upload/iuser/default.jpg'::character varying"))
    reference_check_id = Column(ForeignKey(u'iuser_referencecheck.id', deferrable=True, initially=u'DEFERRED'), unique=True)
    rating = Column(String(2), nullable=False, server_default=text("'N'::character varying"))
    parent_email = Column(String(256), nullable=False, server_default=text("''::character varying"))
    event_reminder_period = Column(Integer, nullable=False, server_default="0")
    event_reminder_is_internal = Column(Boolean, nullable=False, server_default="true")
    highest_degree = Column(String(500))
    legal_first_name = Column(String(256), nullable=False)
    legal_last_name = Column(String(256), nullable=False)
    go_pass_key = Column(String(256), nullable=False)

    country = relationship(u'UtilsCountry')
    employer = relationship(u'IuserEmployer')
    last_modified_by = relationship(u'IuserUser', remote_side=[id])
    member = relationship(u'MemberMember', primaryjoin='IuserUser.member_id == MemberMember.id')
    career = relationship(u'UtilsCareer')
    occupation = relationship(u'UtilsOccupation')
    parent_state = relationship(u'UtilsState', primaryjoin='IuserUser.parent_state_id == UtilsState.id')
    previous_state = relationship(u'UtilsState', primaryjoin='IuserUser.previous_state_id == UtilsState.id')
    reference_check = relationship(u'IuserReferencecheck')
    state = relationship(u'UtilsState', primaryjoin='IuserUser.state_id == UtilsState.id')
    work_state = relationship(u'UtilsState', primaryjoin='IuserUser.work_state_id == UtilsState.id')

    def is_authenticated(self):
        # If we have an id, we decyphered the cookie, we're in.
        return self.id != None

    def is_active(self):
        return self.status not in (USER_STATUS_INACTIVE_REJECTED,
            USER_STATUS_INTACTIVE_WITHDRAWN,USER_STATUS_INTACTIVE_DELETED)

    def is_anonymous(self):
        return False

    def get_id(self):
        return unicode(self.id)


class IuserUserAcademicField(Base,db.Model):
    __tablename__ = 'iuser_user_academic_fields'

    id = Column(Integer, primary_key=True, server_default=text("nextval('iuser_user_academic_fields_id_seq'::regclass)"))
    user_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    academicfield_id = Column(ForeignKey(u'iuser_academicfield.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    academicfield = relationship(u'IuserAcademicfield')
    user = relationship(u'IuserUser')
    __table_args__ = (UniqueConstraint('user_id', 'academicfield_id'),)


class IuserUserCollege(Base,db.Model):
    __tablename__ = 'iuser_user_colleges'

    id = Column(Integer, primary_key=True, server_default=text("nextval('iuser_user_colleges_id_seq'::regclass)"))
    user_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    college_id = Column(ForeignKey(u'utils_college.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    college = relationship(u'UtilsCollege')
    user = relationship(u'IuserUser')
    __table_args__ = (UniqueConstraint('user_id', 'college_id'),)


class IuserUserNetworkUser(Base,db.Model):
    __tablename__ = 'iuser_user_network_users'

    id = Column(Integer, primary_key=True, server_default=text("nextval('iuser_user_network_users_id_seq'::regclass)"))
    from_user_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    to_user_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    from_user = relationship(u'IuserUser', primaryjoin='IuserUserNetworkUser.from_user_id == IuserUser.id')
    to_user = relationship(u'IuserUser', primaryjoin='IuserUserNetworkUser.to_user_id == IuserUser.id')


class IuserUserRacialgroup(Base,db.Model):
    __tablename__ = 'iuser_user_racialgroup'

    id = Column(Integer, primary_key=True, server_default=text("nextval('iuser_user_racialgroup_id_seq'::regclass)"))
    user_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    racialgroup_id = Column(ForeignKey(u'iuser_racialgroup.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    racialgroup = relationship(u'IuserRacialgroup')
    user = relationship(u'IuserUser')
    __table_args__ = (UniqueConstraint('user_id', 'racialgroup_id'),)


class IuserUsertype(Base,db.Model):
    __tablename__ = 'iuser_usertype'

    id = Column(Integer, primary_key=True, server_default=text("nextval('iuser_usertype_id_seq'::regclass)"))
    type = Column(String(120), nullable=False, unique=True)
    abbr = Column(String(20), nullable=False)
    parent_id = Column(ForeignKey(u'iuser_usertype.id', deferrable=True, initially=u'DEFERRED'), index=True)

    parent = relationship(u'IuserUsertype', remote_side=[id])


class MentorSiteList(Base,db.Model):
    __tablename__ = 'mentor_site_list'

    id = Column(Integer, primary_key=True, server_default=text("nextval('mentor_site_list_id_seq'::regclass)"))
    user_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), nullable=False)
    member_school_id = Column(ForeignKey(u'member_school.id', deferrable=True, initially=u'DEFERRED'), nullable=False)


class IuserUUID(Base,db.Model):
    __tablename__ = 'iuser_uuid'
    id = Column(Integer, primary_key=True, server_default=text("nextval('iuser_uuid_id_seq'::regclass)"))
    user_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), nullable=False)
    uuid = Column(UUID,nullable=True,default=None)
    user = relationship(u'IuserUser')

class IuserToken(Base,db.Model):
    __tablename__ = 'iuser_token'
    id = Column(Integer, primary_key=True, server_default=text("nextval('iuser_token_id_seq'::regclass)"))
    user_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), nullable=False)
    session_token = Column(Text,nullable=True,default=None)
    date_created = Column(DateTime(True),default=datetime.datetime.now)
    is_active = Column(Boolean, nullable=False, server_default="true")
    user = relationship(u'IuserUser')
