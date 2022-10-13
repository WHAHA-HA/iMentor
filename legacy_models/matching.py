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


class MatchingMatchingqueue(Base,db.Model):
    __tablename__ = 'matching_matchingqueue'

    id = Column(Integer, primary_key=True, server_default=text("nextval('matching_matchingqueue_id_seq'::regclass)"))
    persona_id = Column(ForeignKey(u'iuser_persona.id', deferrable=True, initially=u'DEFERRED'), index=True)
    added = Column(DateTime(True))
    processing_started_on = Column(DateTime(True))
    processed_by_id = Column(ForeignKey(u'matching_matchingworkerserver.id', deferrable=True, initially=u'DEFERRED'), index=True)
    completed_on = Column(DateTime(True))
    status = Column(String(1), nullable=False, server_default=text("'W'::character varying"))

    persona = relationship(u'IuserPersona')
    processed_by = relationship(u'MatchingMatchingworkerserver')


class MatchingMatchingworkerserver(Base,db.Model):
    __tablename__ = 'matching_matchingworkerserver'

    id = Column(Integer, primary_key=True, server_default=text("nextval('matching_matchingworkerserver_id_seq'::regclass)"))
    name = Column(String(200), nullable=False)
    active = Column(Boolean, nullable=False, server_default="true")
    brought_online = Column(DateTime(True))
    went_offline = Column(DateTime(True))


class MatchingPotentialmatch(Base,db.Model):
    __tablename__ = 'matching_potentialmatch'

    id = Column(Integer, primary_key=True, server_default=text("nextval('matching_potentialmatch_id_seq'::regclass)"))
    mentee_id = Column(ForeignKey(u'iuser_persona.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    mentor_id = Column(ForeignKey(u'iuser_persona.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    som = Column(Numeric(5, 2), nullable=False, server_default="0")
    career_som = Column(Numeric(5, 2), nullable=False, server_default="0")
    academic_som = Column(Numeric(5, 2), nullable=False, server_default="0")
    personal_som = Column(Numeric(5, 2), nullable=False, server_default="0")
    unweighted_som = Column(Numeric(5, 2), nullable=False, server_default="0")
    unweighted_career_som = Column(Numeric(5, 2), nullable=False, server_default="0")
    unweighted_academic_som = Column(Numeric(5, 2), nullable=False, server_default="0")
    unweighted_personal_som = Column(Numeric(5, 2), nullable=False, server_default="0")

    mentee = relationship(u'IuserPersona', primaryjoin='MatchingPotentialmatch.mentee_id == IuserPersona.id')
    mentor = relationship(u'IuserPersona', primaryjoin='MatchingPotentialmatch.mentor_id == IuserPersona.id')


