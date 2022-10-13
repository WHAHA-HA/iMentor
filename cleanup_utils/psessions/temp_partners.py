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

class TempPartnersSession(Base,db.Model):
    __tablename__ = 'partners_session'
    __table_args__ = {'extend_existing': True}

    id = Column(Integer, primary_key=True, server_default=text("nextval('partners_session_id_seq'::regclass)"))
    description = Column(String(255), nullable=False)
    start = Column(DateTime(True))
    new_start = Column(DateTime(False))
    prompt_id = Column(ForeignKey(u'curriculum_prompt.id', deferrable=True, initially=u'DEFERRED'), index=True)
    status_id = Column(ForeignKey(u'partners_sessionstatus.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    partner_id = Column(ForeignKey(u'partners_partner.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    end_date = Column(DateTime(True))
    new_end_date = Column(DateTime(False))
    activity_recorded = Column(Boolean, nullable=False, server_default="false")

    partner = relationship(u'PartnersPartner')
    prompt = relationship(u'CurriculumPrompt')
    status = relationship(u'PartnersSessionstatus')
    
