# -*- coding: iso8859-15 -*-
import os,sys
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import db,Base,metadata

# coding: utf-8
from sqlalchemy import (BigInteger, Boolean, Column, Date, DateTime, 
    Float, ForeignKey, Index, Integer, Numeric, SmallInteger, 
    String, Table, Text, Time, text)
from sqlalchemy.dialects.postgresql.base import INET, TSVECTOR
from sqlalchemy.orm import relationship


class UtilsCountry(Base,db.Model):
    __tablename__ = 'utils_country'

    id = Column(Integer, primary_key=True, server_default=text("nextval('utils_country_id_seq'::regclass)"))
    name = Column(String(100), nullable=False, unique=True)
    abbr = Column(String(6), nullable=False, server_default=text("''::character varying"))
    order = Column(Integer, nullable=False)


class UtilsEditorlanguage(Base,db.Model):
    __tablename__ = 'utils_editorlanguage'

    id = Column(Integer, primary_key=True, server_default=text("nextval('utils_editorlanguage_id_seq'::regclass)"))
    name = Column(String(30), nullable=False)
    abbr = Column(String(6), nullable=False, server_default=text("''::character varying"))
    order = Column(Integer, nullable=False)


class UtilsSitesetting(Base,db.Model):
    __tablename__ = 'utils_sitesetting'

    id = Column(Integer, primary_key=True, server_default=text("nextval('utils_sitesetting_id_seq'::regclass)"))
    name = Column(String(100), nullable=False, unique=True)
    state = Column(String(255))


class UtilsState(Base,db.Model):
    __tablename__ = 'utils_state'

    id = Column(Integer, primary_key=True, server_default=text("nextval('utils_state_id_seq'::regclass)"))
    name = Column(String(100), nullable=False, unique=True)
    abbr = Column(String(6), nullable=False, server_default=text("''::character varying"))
    order = Column(Integer, nullable=False)


class UtilsTimezone(Base,db.Model):
    __tablename__ = 'utils_timezone'

    id = Column(Integer, primary_key=True, server_default=text("nextval('utils_timezone_id_seq'::regclass)"))
    name = Column(String(30), nullable=False)
    abbr = Column(String(6), nullable=False, server_default=text("''::character varying"))
    order = Column(Integer, nullable=False)
    country_id = Column(ForeignKey(u'utils_country.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    country = relationship(u'UtilsCountry')


class UtilsCareer(Base,db.Model):
    __tablename__ = 'utils_career'

    id = Column(Integer, primary_key=True, server_default=text("nextval('utils_career_id_seq'::regclass)"))
    name = Column(Text, nullable=False, unique=True)


class UtilsOccupation(Base,db.Model):
    __tablename__ = 'utils_occupation'

    id = Column(Integer, primary_key=True, server_default=text("nextval('utils_occupation_id_seq'::regclass)"))
    name = Column(Text, nullable=False, unique=True)

    career_id = Column(ForeignKey(u'utils_career.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    career = relationship(u'UtilsCareer')

