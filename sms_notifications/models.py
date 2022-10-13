# -*- coding: iso8859-15 -*-
import os, sys
import pprint
from datetime import datetime
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from sqlalchemy_utils import Timestamp
from sqlalchemy_utils.types.phone_number import PhoneNumberType
from legacy_models.iuser import IuserUser

from sqlalchemy import (BigInteger, Boolean, Column, Date, DateTime,
    Float, ForeignKey, Index, Integer, Numeric, SmallInteger,
    String, Table, Text, Time, text, DATE, func, UniqueConstraint)

from sqlalchemy.orm import relationship

from config.project_globals import db,Base,metadata
from legacy_models.calendars import CalendarsEventtype
from legacy_models.message import MessageGroupstatus
from legacy_models.message import MessageGroup
from legacy_models.curriculum import CurriculumPrompt
from legacy_models.member import MemberMember
from legacy_models.partners import PartnersPartner

SMS_MESSAGE_LENGTH = 160
SMS_SID_LENGTH = 34
PHONE_LENGTH = 10

class SMSStop(Base, db.Model):
    __tablename__ = 'sms_stop'
    # User sent a STOP, we record it and never text them again 
    # (unless they send START)
    id = Column(Integer, primary_key=True, nullable=False)
    user_id = Column(Integer, ForeignKey(IuserUser.id), nullable=False, default=0)
    from_phone = Column(String(PHONE_LENGTH), nullable=False)
    date_stopped = Column(DateTime, nullable=False, default=datetime.utcnow)
    user = relationship(IuserUser, foreign_keys=[user_id])


class SMSMessage(Base, db.Model, Timestamp):
    __tablename__ = 'sms_message'

    # Messages related to table data will have an associated table name and id.
    id = Column(Integer, primary_key=True, nullable=False)
    text = Column(Text, nullable=False)
    date_sent = Column(DateTime, nullable=False, default=datetime.utcnow)
    to_phone = Column(String(PHONE_LENGTH), nullable=False)
    from_phone = Column(String(PHONE_LENGTH), nullable=False)
    admin_id = Column(Integer, ForeignKey(IuserUser.id), nullable=True, default=None)
    sender_id = Column(Integer, ForeignKey(IuserUser.id), nullable=True, default=None)
    recipient_id = Column(Integer, ForeignKey(IuserUser.id), nullable=True, default=None)
    foreign_table_name = Column(String, nullable=True)
    foreign_table_id = Column(Integer, nullable=True)
    sid = Column(String(SMS_SID_LENGTH), nullable=False)
    parent_id = Column(Integer, nullable=True)
    sender = relationship(IuserUser, foreign_keys=[sender_id])
    recipient = relationship(IuserUser, foreign_keys=[recipient_id])
    admin = relationship(IuserUser, foreign_keys=[admin_id])

    def __unicode__(self):
        return '%s (sid %s): from %s (id %s) --> to %s (id %s), %s (%s:%s), allow response retry: ' % (
                self.id,
                self.sid,
                self.from_phone,
                self.sender_id,
                self.to_phone,
                self.recipient_id,
                self.text,
                self.foreign_table_name,
                self.foreign_table_id,
        )

    def __str__(self):
        return unicode(self).encode('utf-8')


class SMSInvalidResponse(Base, db.Model):
    __tablename__ = 'sms_invalid_response'

    # Messagesa related to table data will have an associated table name and id.
    id = Column(Integer, primary_key=True, nullable=False)
    user_id = Column(Integer, ForeignKey(IuserUser.id), nullable=False, default=0)
    from_phone = Column(String(PHONE_LENGTH), nullable=False)
    response = Column(Text, nullable=True)
    status = Column(String(200), nullable=False)
    date_received = Column(DateTime, nullable=False, default=datetime.utcnow)
