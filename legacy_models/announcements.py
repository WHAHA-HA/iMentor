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

class AnnouncementsAnnouncement(Base,db.Model):
    __tablename__ = 'announcements_announcement'

    id = Column(Integer, primary_key=True, server_default=text("nextval('announcements_announcement_id_seq'::regclass)"))
    creator_id = Column(ForeignKey(u'iuser_user.id', deferrable=True, initially=u'DEFERRED'), index=True)
    title = Column(String(60), nullable=False)
    text = Column(Text, nullable=False)
    submit_date = Column(DateTime(True), nullable=False)
    date_modified = Column(DateTime(True), nullable=False)
    close_date = Column(DateTime(True), nullable=False)
    is_deleted = Column(Boolean, nullable=False, server_default="false")
    is_published = Column(Boolean, nullable=False, server_default="true")
    search_tsv = Column(TSVECTOR, index=True)

    creator = relationship(u'IuserUser')


class AnnouncementsAnnouncementAssignedUserType(Base,db.Model):
    __tablename__ = 'announcements_announcement_assigned_user_types'

    id = Column(Integer, primary_key=True, server_default=text("nextval('announcements_announcement_assigned_user_types_id_seq'::regclass)"))
    announcement_id = Column(ForeignKey(u'announcements_announcement.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    assignedusertype_id = Column(ForeignKey(u'iuser_assignedusertype.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    announcement = relationship(u'AnnouncementsAnnouncement')
    assignedusertype = relationship(u'IuserAssignedusertype')


class AnnouncementsAnnouncementGroup(Base,db.Model):
    __tablename__ = 'announcements_announcement_groups'

    id = Column(Integer, primary_key=True, server_default=text("nextval('announcements_announcement_groups_id_seq'::regclass)"))
    announcement_id = Column(ForeignKey(u'announcements_announcement.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    group_id = Column(ForeignKey(u'message_group.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    announcement = relationship(u'AnnouncementsAnnouncement')
    group = relationship(u'MessageGroup')


class AnnouncementsAnnouncementMember(Base,db.Model):
    __tablename__ = 'announcements_announcement_members'

    id = Column(Integer, primary_key=True, server_default=text("nextval('announcements_announcement_members_id_seq'::regclass)"))
    announcement_id = Column(ForeignKey(u'announcements_announcement.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    member_id = Column(ForeignKey(u'member_member.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    announcement = relationship(u'AnnouncementsAnnouncement')
    member = relationship(u'MemberMember')


class AnnouncementsAnnouncementPartner(Base,db.Model):
    __tablename__ = 'announcements_announcement_partners'

    id = Column(Integer, primary_key=True, server_default=text("nextval('announcements_announcement_partners_id_seq'::regclass)"))
    announcement_id = Column(ForeignKey(u'announcements_announcement.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    partner_id = Column(ForeignKey(u'partners_partner.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    announcement = relationship(u'AnnouncementsAnnouncement')
    partner = relationship(u'PartnersPartner')


class AnnouncementsAnnouncementUserType(Base,db.Model):
    __tablename__ = 'announcements_announcement_user_types'

    id = Column(Integer, primary_key=True, server_default=text("nextval('announcements_announcement_user_types_id_seq'::regclass)"))
    announcement_id = Column(ForeignKey(u'announcements_announcement.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)
    usertype_id = Column(ForeignKey(u'iuser_usertype.id', deferrable=True, initially=u'DEFERRED'), nullable=False, index=True)

    announcement = relationship(u'AnnouncementsAnnouncement')
    usertype = relationship(u'IuserUsertype')


