# -*- coding: iso8859-15 -*-
import os,sys
import pprint
import logging
import re
import datetime
import argparse
from num2words import num2words
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)
from sms_notifications.models import (
    SMSMessage,SMSInvalidResponse,SMSStop)
from config.settings import (MONGO_HOST,MONGO_PORT,
    MONGO_DBNAME_LOGS,MONGO_GENERIC_LOGQUEUE_COLLNAME)
from config.project_globals import (app,db,DBSession,
    get_scoped_session,DOGPILE_CACHE_REGION,DOMAIN)
from config.caching_query import CachingQuery,FromCache
from config.settings import TWILIO_PHONE_NUMBER
from sqlalchemy import (BigInteger, Boolean, Column, Date, DateTime, 
    Float, ForeignKey, Index, Integer, Numeric, SmallInteger, 
    String, Table, Text, Time, text, func, or_, and_, update)
from sqlalchemy.orm.exc import NoResultFound
from sqlalchemy.orm import relationship, aliased
from legacy_models.iuser import IuserUser, IuserPersona, IuserPersonaPartner, IuserMatchhistory
from legacy_models.partners import PartnersPartner
from legacy_models.member import MemberMember
from legacy_models.calendars import CalendarsEvent, CalendarsEventtype, CalendarsInvitation
from legacy_models.mailer import MailerMessage
from legacy_models.log import CONTENT_TYPE_USER
from new_platform.utils import user_details

from config.settings import DEFAULT_DAYS_BEFORE_EVENT


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_most_recent_invitation(user):

    latest_persona_subq = user_details.get_latest_persona(filtered = True, user_id = None)
    latest_partner_site_subq = user_details.get_latest_partner_site()

    results = DBSession.query(
        IuserUser.id.label('user_id'),
        IuserPersona.id.label('persona_id'),
        IuserUser.first_name.label('first_name'),
        IuserUser.last_name.label('last_name'),
        IuserUser.email.label('email'),
        IuserUser.cell_phone.label('cell_phone'),
        IuserUser.home_phone.label('home_phone'),
        IuserUser.work_phone.label('work_phone'),
        CalendarsInvitation.event_id.label('event_id'),
        CalendarsInvitation.id.label('rsvp_id'),
        CalendarsEvent.date.label('event_date'),
        MemberMember.name.label('member_site_name'),
        PartnersPartner.name.label('partner_site_name')).\
        options(FromCache(DOGPILE_CACHE_REGION)).\
        join(MemberMember, IuserUser.member_id == MemberMember.id).\
        join(latest_persona_subq, IuserUser.id == latest_persona_subq.c.user_id).\
        join(IuserPersona, latest_persona_subq.c.latest_persona_id == IuserPersona.id).\
        join(latest_partner_site_subq, IuserPersona.id == latest_partner_site_subq.c.persona_id).\
        join(PartnersPartner, latest_partner_site_subq.c.latest_partner_id == PartnersPartner.id).\
        join(CalendarsInvitation, IuserPersona.id == CalendarsInvitation.invitee_id).\
        join(CalendarsEvent, CalendarsInvitation.event_id == CalendarsEvent.id).\
        filter(or_(IuserUser.cell_phone != '', IuserUser.home_phone != '', IuserUser.work_phone != '')).\
        filter(CalendarsEvent.status == 'A').\
        filter(IuserUser.id == user.id).\
        order_by(CalendarsEvent.date.desc()).\
        first()

    if results:
        app.logger.warning("Not a warning. get_most_recent_invitation() thinks this is the right one for user {0}: {1}:".format(user.id,results.rsvp_id))
    else:
        app.logger.warning("Not a warning. get_most_recent_invitation() couldn't find one for user {0}:".format(user.id))

    return results

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_tentative_rsvp_mentors(days_to_event):

    event_date = datetime.date.today() + datetime.timedelta(days = days_to_event)
    latest_persona_subq = user_details.get_latest_persona(filtered = True, user_id = None)
    latest_partner_site_subq = user_details.get_latest_partner_site()
    CalendarsInvitation2 = aliased(CalendarsInvitation)

    # We ensure the mentor has at least a cell, home, or work number.
    # Phone number fields in IuserUser are an empty string by default, not NULL.
    # For our pilot in February 2016, we limit results to our few pilot classes.
    # Currently excluding Pittsburg and Charlotte
    results = DBSession.query(
        IuserUser.id.label('user_id'),
        IuserPersona.id.label('persona_id'),
        IuserUser.first_name.label('first_name'),
        IuserUser.last_name.label('last_name'),
        IuserUser.email.label('email'),
        IuserUser.cell_phone.label('cell_phone'),
        IuserUser.home_phone.label('home_phone'),
        IuserUser.work_phone.label('work_phone'),
        CalendarsInvitation.event_id.label('event_id'),
        CalendarsInvitation.id.label('rsvp_id'),
        CalendarsEvent.date.label('event_date'),
        MemberMember.name.label('member_site_name'),
        PartnersPartner.name.label('partner_site_name')).\
        options(FromCache(DOGPILE_CACHE_REGION)).\
        join(MemberMember, IuserUser.member_id == MemberMember.id).\
        join(latest_persona_subq, IuserUser.id == latest_persona_subq.c.user_id).\
        join(IuserPersona, latest_persona_subq.c.latest_persona_id == IuserPersona.id).\
        join(latest_partner_site_subq, IuserPersona.id == latest_partner_site_subq.c.persona_id).\
        join(PartnersPartner, latest_partner_site_subq.c.latest_partner_id == PartnersPartner.id).\
        join(IuserMatchhistory, IuserPersona.id == IuserMatchhistory.mentor_id).\
        join(CalendarsInvitation, IuserPersona.id == CalendarsInvitation.invitee_id).\
        join(CalendarsEvent, CalendarsInvitation.event_id == CalendarsEvent.id).\
        join(CalendarsInvitation2, and_(IuserMatchhistory.mentee_id == CalendarsInvitation2.invitee_id, CalendarsEvent.id == CalendarsInvitation2.event_id)).\
        filter(or_(IuserUser.cell_phone != '', IuserUser.home_phone != '', IuserUser.work_phone != '')).\
        filter(CalendarsEvent.status == 'A').\
        filter(CalendarsEvent.date == event_date).\
        filter(CalendarsInvitation2.rsvp.in_(['Y', 'NR', 'M'])).\
        filter(CalendarsInvitation.rsvp.in_(['NR', 'M'])).\
        filter(PartnersPartner.id.notin_([233,234])).\
        order_by(IuserUser.last_name.asc()).\
        all()

    app.logger.debug("Event date is %s" % (event_date))

    return results

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def find_cell(user):
    '''
    We check first for a cell phone, then a home phone and work phone as backups.
    Due to the storage of cell phone flags with the new Intake Application product,
    and due to user error during Intake Application data entry,
    it's possible that home and work phones actually are cell phones.
    '''
    to_phone = None
    if user.cell_phone not in ('',None):
        to_phone = re.sub(r'[^\d]+', '', user.cell_phone)
    elif user.home_phone not in ('',None):
        to_phone = re.sub(r'[^\d]+', '', user.home_phone)
    elif user.work_phone not in ('',None):
        to_phone = re.sub(r'[^\d]+', '', user.work_phone)

    return to_phone

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def should_send(foreign_table,foreign_table_id,user_id):
    '''
    Did user issue a STOP? Did they already receive this particular
    message? If so don't send.
    '''
    if DBSession.query(SMSMessage)\
        .filter(SMSMessage.foreign_table_name == foreign_table)\
        .filter(SMSMessage.recipient_id == user_id)\
        .filter(SMSMessage.foreign_table_id == foreign_table_id)\
        .count() >= 1:
        return False # don't re-send

    if DBSession.query(SMSStop).filter(SMSStop.user_id==user_id).first():
        return False # user issued STOP

    return True

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_event_details(rsvp_id):

    IuserPersona2 = aliased(IuserPersona)
    IuserUser2 = aliased(IuserUser)
    IuserPersona3 = aliased(IuserPersona)
    IuserUser3 = aliased(IuserUser)

    result = DBSession.query(
        CalendarsInvitation.id.label('rsvp_id'),
        IuserUser.first_name.label('mentor_first_name'),
        IuserUser2.first_name.label('mentee_first_name'),
        IuserUser2.email.label('mentee_email'),
        CalendarsEvent.name.label('event_name'),
        CalendarsEvent.date.label('event_date'),
        CalendarsEvent.start.label('event_time'),
        CalendarsEvent.address.label('event_address'),
        IuserUser3.email.label('staff_email')).\
        options(FromCache(DOGPILE_CACHE_REGION)).\
        join(IuserPersona, CalendarsInvitation.invitee_id == IuserPersona.id).\
        join(IuserUser, IuserPersona.user_id == IuserUser.id).\
        join(IuserMatchhistory, IuserPersona.id == IuserMatchhistory.mentor_id).\
        join(CalendarsEvent, CalendarsInvitation.event_id == CalendarsEvent.id).\
        join(IuserPersona2, IuserMatchhistory.mentee_id == IuserPersona2.id).\
        join(IuserUser2, IuserPersona2.user_id == IuserUser2.id).\
        join(IuserPersonaPartner, IuserPersona.id == IuserPersonaPartner.persona_id).\
        join(PartnersPartner, IuserPersonaPartner.partner_id == PartnersPartner.id).\
        join(IuserPersona3, PartnersPartner.member_contact_id == IuserPersona3.id).\
        join(IuserUser3, IuserPersona3.user_id == IuserUser3.id).\
        filter(CalendarsInvitation.id == rsvp_id).\
        first()
        
    return result

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def send_mail(local_db_session,from_address, to_address, subject, message_body):
    """Inserts records into legacy tables in order to send emails"""
    mail = MailerMessage(
        from_address=from_address,
        to_address=to_address,
        subject=subject,
        message_body=message_body,
        when_added=datetime.datetime.now()
    )

    local_db_session.add(mail)
    local_db_session.commit()
    local_db_session.begin()
