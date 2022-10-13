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


class RatingsPairrating(Base,db.Model):
    __tablename__ = 'ratings_pairrating'
    __table_args__ = (
        Index('ratings_pairrating_mentor_rated_on_2d505ff3f2b1bced', 'mentor_rated_on', 'mentee_rated_on'),
    )

    id = Column(Integer, primary_key=True, server_default=text("nextval('ratings_pairrating_id_seq'::regclass)"))
    pair_id = Column(ForeignKey(u'iuser_matchhistory.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    period_id = Column(ForeignKey(u'ratings_ratingperiod.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    mentor_rating = Column(Integer, nullable=False, server_default="0")
    mentee_rating = Column(Integer, nullable=False, server_default="0")
    mentor_rated_on = Column(Date)
    mentee_rated_on = Column(Date)
    ratings_filled = Column(Boolean, nullable=False, server_default="false")
    variance = Column(Numeric(3, 2), nullable=False, server_default="0")

    pair = relationship(u'IuserMatchhistory')
    period = relationship(u'RatingsRatingperiod')


class RatingsRatingdefault(Base,db.Model):
    __tablename__ = 'ratings_ratingdefaults'

    id = Column(Integer, primary_key=True, server_default=text("nextval('ratings_ratingdefaults_id_seq'::regclass)"))
    member_id = Column(ForeignKey(u'member_member.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    active = Column(Boolean, nullable=False, server_default="false")
    start_date = Column(Date)
    frequency = Column(String(2), nullable=False, server_default=text("'1M'::character varying"))

    member = relationship(u'MemberMember')


class RatingsRatinginterval(Base,db.Model):
    __tablename__ = 'ratings_ratinginterval'

    id = Column(Integer, primary_key=True, server_default=text("nextval('ratings_ratinginterval_id_seq'::regclass)"))
    partner_id = Column(ForeignKey(u'partners_partner.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    active = Column(Boolean, nullable=False, server_default="false")
    start_date = Column(Date)
    frequency = Column(String(2), nullable=False, server_default=text("'1M'::character varying"))

    partner = relationship(u'PartnersPartner')


class RatingsRatingperiod(Base,db.Model):
    __tablename__ = 'ratings_ratingperiod'

    id = Column(Integer, primary_key=True, server_default=text("nextval('ratings_ratingperiod_id_seq'::regclass)"))
    partner_id = Column(ForeignKey(u'partners_partner.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    magnitude = Column(Integer, nullable=False, index=True, server_default="0")
    start_date = Column(Date)
    end_date = Column(Date)

    partner = relationship(u'PartnersPartner')


