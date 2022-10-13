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


class HackingChecksHackcheck(Base,db.Model):
    __tablename__ = 'hacking_checks_hackchecks'

    id = Column(Integer, primary_key=True, server_default=text("nextval('hacking_checks_hackchecks_id_seq'::regclass)"))
    user_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    latest_attack_dt_seconds = Column(Integer, nullable=False, index=True)
    hack_type = Column(Integer, nullable=False, server_default=text("1"))
    url_used = Column(Text, nullable=False)
    recorded_date = Column(DateTime(True), nullable=False)
    timing_records = Column(Text, nullable=False)
    user_saw_warning = Column(Boolean, nullable=False, server_default="false")
    ips = Column(Text, nullable=False)

    user = relationship(u'IuserUser')


