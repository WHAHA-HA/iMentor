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

from new_platform.utils.roles import Role

from legacy_models.iuser import (P_MATCH_STATUS_READY,
    P_MATCH_STATUS_MATCHED,P_MATCH_STATUS_CLOSED,P_MATCH_STATUS_NA,
    P_MATCH_STATUS_RESCREENING,P_MATCH_STATUS_NOT_MATCHING,
    MATCH_CHOICES)


PROGRAM_READINESS_NULL = 0
PROGRAM_READINESS_YES = 1
PROGRAM_READINESS_NO_M_REFUSAL = 2
PROGRAM_READINESS_NO_P_REFUSAL = 3
PROGRAM_READINESS_NO_S_REFUSAL = 4
PROGRAM_READINESS_NO_OTHER = 5

PROGRAM_READINESS_VALUES = {
    PROGRAM_READINESS_NULL: 'No status',
    PROGRAM_READINESS_YES: 'Yes',
    PROGRAM_READINESS_NO_M_REFUSAL: 'No - Mentee Refusal',
    PROGRAM_READINESS_NO_P_REFUSAL: 'No - Parent Refusal',
    PROGRAM_READINESS_NO_S_REFUSAL: 'No - School Refusal',
    PROGRAM_READINESS_NO_OTHER: 'No - Other'
    }

SCHOOL_ATTENDANCE_NULL = 0
SCHOOL_ATTENDANCE_YES = 1
SCHOOL_ATTENDANCE_NO_LEFT = 2
SCHOOL_ATTENDANCE_NO_ABSENT = 3
SCHOOL_ATTENDANCE_NO_OTHER = 4

SCHOOL_ATTENDANCE_VALUES = {
    SCHOOL_ATTENDANCE_NULL: 'No status',
    SCHOOL_ATTENDANCE_YES: 'Yes',
    SCHOOL_ATTENDANCE_NO_LEFT: 'No - Left School',
    SCHOOL_ATTENDANCE_NO_ABSENT:'No - Frequently Absent',
    SCHOOL_ATTENDANCE_NO_OTHER: 'No - Other'
    }

class MenteeReadinessSchool(Base,db.Model):
    __tablename__ = 'mentee_readiness_school'
    __table_args__ = {'extend_existing': True}

    id = Column(Integer, primary_key=True, server_default=text("nextval('mentee_readiness_school_id_seq'::regclass)"))
    user_id = Column(ForeignKey(u'iuser_user.id'), nullable=False, unique=True)
    persona_id = Column(ForeignKey(u'iuser_persona.id'), nullable=True, default=None)
    user = relationship("IuserUser", uselist=False)

    school_attendance = Column(Integer, nullable=False, default=0)
    program_readiness = Column(Integer, nullable=False, default=0)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def check_mentee_readiness_school(persona):
    # Only used for setting up new mentees.
    role = Role(persona.user.id)
    if role and role.is_mentee:

        mred = MenteeReadinessSchool.query.filter(
            MenteeReadinessSchool.user_id==persona.user.id).first()
        if not mred:
            # New mentees
            mred = MenteeReadinessSchool(
                user_id=persona.user.id,
                persona_id=persona.id,
                school_attendance=SCHOOL_ATTENDANCE_NULL,
                program_readiness=PROGRAM_READINESS_NULL
                )
            db.session.add(mred)
            db.session.commit()

        else:
            # Existing mentees whose persona has just changed.
            if mred.persona_id != persona.id:
                if mred.persona_id != None:
                    mred = MenteeReadinessSchool.query.filter(
                        MenteeReadinessSchool.user_id==persona.user.id).update(
                        {'persona_id':persona.id,'school_attendance':SCHOOL_ATTENDANCE_NULL,
                        'program_readiness':PROGRAM_READINESS_NULL})
                else:
                    mred = MenteeReadinessSchool.query.filter(
                        MenteeReadinessSchool.user_id==persona.user.id).update(
                        {'persona_id':persona.id})

                db.session.commit()
