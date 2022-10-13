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


class FiltersSavedfilterform(Base,db.Model):
    __tablename__ = 'filters_savedfilterform'

    id = Column(Integer, primary_key=True, server_default=text("nextval('filters_savedfilterform_id_seq'::regclass)"))
    name = Column(String(100), nullable=False)
    key = Column(String(100), nullable=False)
    user_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), index=True)
    persona_id = Column(ForeignKey(u'iuser_persona.id', deferrable=True, initially=u'DEFERRED'), index=True)
    data = Column(Text, nullable=False)
    created = Column(DateTime(True), nullable=False)
    updated = Column(DateTime(True), nullable=False)

    persona = relationship(u'IuserPersona')
    user = relationship(u'IuserUser')


