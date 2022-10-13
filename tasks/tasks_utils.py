# -*- coding: iso8859-15 -*-
import os,sys
import datetime
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import (db, Base, metadata, app, DBSession,
    DOGPILE_CACHE_REGION, get_scoped_session)
from config.caching_query import FromCache

#Import 'app' object from auth as well
from auth import api, app
from config.settings import FROM_EMAIL
from flask import  current_app, request, redirect, render_template

from sqlalchemy import (BigInteger, Boolean, Column, Date, DateTime,
    Float, ForeignKey, Index, Integer, Numeric, SmallInteger,
    String, Table, Text, Time, text, DATE, func, UniqueConstraint, cast)
from sqlalchemy.dialects.postgresql.base import INET, TSVECTOR
from sqlalchemy.sql.expression import func, or_, not_, and_
from sqlalchemy.orm import relationship, sessionmaker, aliased
from legacy_models.member import MemberMember
from legacy_models.message import MessageGroup
from legacy_models.calendars import CalendarsEvent, CalendarsInvitation
from legacy_models.iuser import IuserUser,IuserPersona,USERTYPE_MAP
from new_platform.utils.user_details import (get_persona_obj_for_user,
    get_latest_mentee_user_for_mentor, get_latest_mentor_user_for_mentee,
    get_partners_for_user, get_persona_for_user, get_latest_mentor_for_mentee,
    get_latest_mentee_for_mentor)
from new_platform.utils.roles import Role
from new_platform.utils import user_details
from tasks.models import Rating, RatingPeriod
from legacy_models.mailer import MailerMessage
from legacy_models.partners import PartnersPartner
from legacy_models.iuser import (IuserUser, IuserPersona, IuserPersonaPartner,
    IuserAssignedusertype, IuserUsertype)

TIME_FORMAT = '%-I:%M %p'
DATE_FORMAT = '%-m/%-d/%y'

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class ratings_update_obj:
    def __init__(self, iam_mentee,mentor_persona_id,mentee_persona_id,last_rating,last_rated,
        mentor_user_id,mentee_user_id,frequency_month,frequency_day,frequency_hour,
        frequency_minute,startdate,rated_before, peer_name):
        self.iam_mentee = iam_mentee
        self.mentor_persona_id = mentor_persona_id
        self.mentee_persona_id = mentee_persona_id
        self.last_rating = last_rating
        self.last_rated = last_rated
        self.mentor_user_id = mentor_user_id
        self.mentee_user_id = mentee_user_id
        self.frequency_month = frequency_month
        self.frequency_day = frequency_day
        self.frequency_hour = frequency_hour
        self.frequency_minute = frequency_minute
        self.startdate = startdate
        self.rated_before = rated_before
        self.peer_name = peer_name

def get_user_credentials(current_user):
        iam_mentee=True
        rated=False
        last_rated=None
        last_rating=None
        peer_name = ""
        startdate=None
        frequency_month=None
        frequency_day=None
        frequency_hour=None
        frequency_minute=None


        if Role(user_id = current_user.id).is_mentor:
            iam_mentee=False
            act_on_user = user_details.get_latest_mentee_user_for_mentor(user_id=current_user.id)
            if not act_on_user:
                print("User {0} has no peer".format(current_user.email))
                return  None
            mentor_usr_id=current_user.id
            mentee_usr_id=act_on_user.id
        else:
            act_on_user = user_details.get_latest_mentor_user_for_mentee(user_id=current_user.id)
            if not act_on_user:
                print("User {0} has no peer".format(current_user.email))
                return  None

            mentee_usr_id=current_user.id
            mentor_usr_id=act_on_user.id

        my_name=current_user.first_name
        peer_name=act_on_user.first_name

        persona_0=(get_persona_for_user(user_id=current_user.id))[1].id
        persona_1=(get_persona_for_user(user_id=act_on_user.id))[1].id

        if(iam_mentee==True):
            my_persona_mentor=persona_1
            my_persona_mentee=persona_0
        else:
            my_persona_mentee=persona_1
            my_persona_mentor=persona_0

        if(iam_mentee==True):
            rating_record = db.session.query(Rating).filter(
                Rating.mentee_persona_id==my_persona_mentee,
                Rating.mentor_persona_id==my_persona_mentor,
                Rating.mentor_rated_on != None
                ).order_by(Rating.id.desc()).first()
        else:
            rating_record = db.session.query(Rating).filter(
                Rating.mentee_persona_id==my_persona_mentee,
                Rating.mentor_persona_id==my_persona_mentor,
                Rating.mentee_rated_on != None
                ).order_by(Rating.id.desc()).first()

        if rating_record:   
            if(iam_mentee==True):
                last_rated=rating_record.mentor_rated_on
                last_rating=rating_record.mentor_rating
            else:
                last_rated=rating_record.mentee_rated_on
                last_rating=rating_record.mentee_rating
            
        #period_data=rating_record.period_id
        period_data=db.session.query(RatingPeriod).first()
        startdate=period_data.start_date
        frequency_month=period_data.frequency_month
        frequency_day=period_data.frequency_day
        frequency_hour=period_data.frequency_hour
        frequency_minute=period_data.frequency_minute

        if last_rated:
            rated=True          
        

        ret_obj=ratings_update_obj(iam_mentee=iam_mentee,mentor_persona_id=my_persona_mentor,
            mentee_persona_id=my_persona_mentee,last_rated=last_rated,mentor_user_id=mentor_usr_id,
            mentee_user_id=mentee_usr_id,frequency_month=frequency_month,frequency_day=frequency_day,
            frequency_hour=frequency_hour,frequency_minute=frequency_minute,startdate=startdate,rated_before=rated,
            last_rating=last_rating, peer_name=peer_name)

        return ret_obj

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_upcoming_events(user_id):

    user_role = Role(user_id)
    # We ignore any user types other than mentee (5) and mentor (4).
    if not (user_role.is_mentee or user_role.is_mentor):
        return
        
    if user_role.is_mentee:
        latest_counterparty = get_latest_mentor_for_mentee(user_id)
    else:
        latest_counterparty = get_latest_mentee_for_mentor(user_id)

    # We only consider events for matched users.
    if not latest_counterparty:
        return

    latest_persona_subq = user_details.get_latest_persona(filtered = True, user_id = user_id)
    CalendarsInvitation2 = aliased(CalendarsInvitation)
    IuserUser2 = aliased(IuserUser)
    counterparty_persona_id = latest_counterparty[1]
    counterparty_user_id = latest_counterparty[0]
    event_date = datetime.date.today()

    results = DBSession.query(
        IuserUser.first_name.label('party_first_name'),
        CalendarsInvitation.rsvp.label('party_rsvp'),
        IuserUser2.first_name.label('counterparty_first_name'),
        CalendarsInvitation2.rsvp.label('counterparty_rsvp'),
        CalendarsInvitation.id.label('rsvp_id'),
        CalendarsInvitation.event_id.label('event_id'),
        CalendarsEvent.name.label('event_name'),
        CalendarsEvent.date.label('event_date'),
        CalendarsEvent.start.label('event_time'),
        CalendarsEvent.address.label('event_address')).\
        options(FromCache(DOGPILE_CACHE_REGION)).\
        join(latest_persona_subq, IuserUser.id == latest_persona_subq.c.user_id).\
        join(IuserPersona, latest_persona_subq.c.latest_persona_id == IuserPersona.id).\
        join(CalendarsInvitation, IuserPersona.id == CalendarsInvitation.invitee_id).\
        join(CalendarsEvent, CalendarsInvitation.event_id == CalendarsEvent.id).\
        join(CalendarsInvitation2, and_(counterparty_persona_id == CalendarsInvitation2.invitee_id, CalendarsEvent.id == CalendarsInvitation2.event_id)).\
        join(IuserUser2, counterparty_user_id == IuserUser2.id).\
        filter(IuserUser.id == user_id).\
        filter(CalendarsEvent.status == 'A').\
        filter(CalendarsEvent.date >= event_date).\
        filter(~CalendarsInvitation.rsvp.in_(['Y', 'N', 'NI'])).\
        order_by(CalendarsEvent.date.asc()).\
        all()

    return results

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def update_rsvp(local_db_session,current_user, rsvp_id, rsvp_selection):

    local_db_session.query(CalendarsInvitation).\
        filter(CalendarsInvitation.id == rsvp_id).\
        update({'rsvp': rsvp_selection})
    local_db_session.commit()
    local_db_session.begin()

    # We send an email confirmation to the counterparty only for "Y" and "N" RSVPs.
    if rsvp_selection in ['Y', 'N']:
        role = Role(current_user.id)
        if role.is_mentee:
            other = get_latest_mentor_user_for_mentee(current_user.id)
        else:
            other = get_latest_mentee_user_for_mentor(current_user.id)
    
        user_details = DBSession.query(
            IuserUser.first_name.label('user_first_name')).\
            filter(IuserUser.id == current_user.id).\
            first()
    
        member_details = DBSession.query(
            MemberMember.name.label('member_name'),
            MemberMember.url_name.label('member_url')).\
            filter(MemberMember.id == current_user.member_id).\
            first()
    
        # We're adjusting case here, but plan to do so in the database soon.
        party_name = user_details[0].capitalize()
        counterparty_name = other.first_name.capitalize()
    
        if rsvp_selection == 'Y':
            rsvp_phrase = 'is going'
        elif rsvp_selection == 'N':
            rsvp_phrase = "isn't going"
    
        event_details = DBSession.query(
            CalendarsEvent.name.label('event_name'),
            CalendarsEvent.date.label('event_date'),
            CalendarsEvent.start.label('event_time')).\
            join(CalendarsInvitation, CalendarsEvent.id == CalendarsInvitation.event_id).\
            filter(CalendarsInvitation.id == rsvp_id).\
            first()
    
        mailermsg = MailerMessage(
            to_address = other.email,
            when_added = datetime.datetime.now(),
            from_address = FROM_EMAIL,
            subject = 'You have a new event RSVP from %s!' % party_name,
            message_body = 'Hi, %s. %s %s to the event named %s on %s at %s. Please sign into the %s Platform at https://%s.imentor.org to see any outstanding RSVP you may have for this event. Thanks!' % (counterparty_name, party_name, rsvp_phrase, event_details[0], event_details[1].strftime(DATE_FORMAT), event_details[2].strftime(TIME_FORMAT) if event_details[2] else '', member_details[0], member_details[1]),
            priority = 2,
            content_subtype = ''
            )
    
        local_db_session.add(mailermsg)
        local_db_session.commit()
        local_db_session.begin()

    return

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def send_rsvp_confirmations(confirmation_type):

    # Joey sends email confirmations of RSVPs to mentors just before the event.
    lookforward_date = datetime.datetime.now().date() + datetime.timedelta(days = 1)

    IuserPersona2 = aliased(IuserPersona)
    IuserUser2 = aliased(IuserUser)

    mentor_event_details = DBSession.query(
        CalendarsEvent.id.label('event_id'),
        CalendarsEvent.start.label('event_time'),
        CalendarsEvent.address.label('event_address'),
        IuserUser.id.label('user_id'),
        IuserUser.first_name.label('first_name'),
        IuserUser.email.label('email'),
        IuserUser2.first_name.label('pc_first_name'),
        IuserUser2.cell_phone.label('pc_phone'),
        IuserUser2.email.label('pc_email'),
        PartnersPartner.name.label('class_name'),
        MemberMember.id.label('member_id')).\
        join(CalendarsInvitation, CalendarsEvent.id == CalendarsInvitation.event_id).\
        join(IuserPersona, CalendarsInvitation.invitee_id == IuserPersona.id).\
        join(IuserPersonaPartner, IuserPersona.id == IuserPersonaPartner.persona_id).\
        join(IuserAssignedusertype, IuserPersona.assigned_usertype_id == IuserAssignedusertype.id).\
        join(IuserUsertype, IuserAssignedusertype.usertype_id == IuserUsertype.id).\
        join(IuserUser, IuserPersona.user_id == IuserUser.id).\
        join(PartnersPartner, IuserPersonaPartner.partner_id == PartnersPartner.id).\
        join(IuserPersona2, PartnersPartner.member_contact_id == IuserPersona2.id).\
        join(IuserUser2, IuserPersona2.user_id == IuserUser2.id).\
        join(MemberMember, IuserUser.member_id == MemberMember.id).\
        filter(IuserUsertype.id == 4).\
        filter(CalendarsEvent.status == 'A').\
        filter(CalendarsInvitation.rsvp == 'Y').\
        filter(CalendarsEvent.date == lookforward_date).\
        all()

    count = 0
    for mentor in mentor_event_details:
        mentee = get_latest_mentee_user_for_mentor(mentor.user_id)
        
        if mentee:
            mentee_rsvp = []
            if confirmation_type == 'Y:Y':
                mentee_rsvp = ['Y']
            elif confirmation_type == 'Y:N':
                mentee_rsvp = ['N']
            elif confirmation_type == 'Y:MNR':
                mentee_rsvp = ['M', 'NR']

            mentee_event_details = DBSession.query(
                CalendarsEvent.id.label('event_id'),
                IuserUser.first_name.label('first_name')).\
                join(CalendarsInvitation, CalendarsEvent.id == CalendarsInvitation.event_id).\
                join(IuserPersona, CalendarsInvitation.invitee_id == IuserPersona.id).\
                join(IuserUser, IuserPersona.user_id == IuserUser.id).\
                filter(CalendarsInvitation.rsvp.in_(mentee_rsvp)).\
                filter(IuserUser.id == mentee.id).\
                filter(CalendarsEvent.id == mentor.event_id).\
                first()
    
            if mentee_event_details:
                # We're adjusting case here, but plan to do so in the database soon.
                mentor_first_name = mentor.first_name.capitalize()
                mentee_first_name = mentee_event_details.first_name.capitalize()
                pc_first_name = mentor.pc_first_name.capitalize()
                
                if mentor.member_id in [1, 244, 248]:
                    member_name = 'iMentor'
                else:
                    member_name = 'mentor2.0'

                if confirmation_type == 'Y:Y':

                    confirmation_subject = '%s: You and your mentee are confirmed for the event tomorrow!' % member_name
                    confirmation_body = '''Dear %s,

You and %s are confirmed to attend the event tomorrow night from %s at %s!

If for any reason your availability changes, please do not respond to this email. Reach out directly to your Program Manager, %s, at %s or %s.

Thank you,
%s Team''' % (mentor_first_name, mentee_first_name, mentor.event_time.strftime(TIME_FORMAT) if mentor.event_time else '', mentor.event_address,
    pc_first_name, str(mentor.pc_phone).strip(), mentor.pc_email, mentor.class_name)

                elif confirmation_type == 'Y:N':

                    confirmation_subject = '%s: Your mentee is not attending the event tomorrow!' % member_name
                    confirmation_body = '''Dear %s,

%s RSVPed "no" for tomorrow's event. Please look for an invitation for the next meeting opportunity soon.

For any questions, please reach out directly to your Program Manager, %s, at %s or %s.

Thank you,
%s Team''' % (mentor_first_name, mentee_first_name, pc_first_name,
    str(mentor.pc_phone).strip(), mentor.pc_email, mentor.class_name)

                elif confirmation_type == 'Y:MNR':

                    confirmation_subject = '%s: Your mentee has not RSVPed for the event tomorrow!' % member_name
                    confirmation_body = '''Dear %s,

Your mentee has not confirmed their attendance at tomorrow's event. Please reach out to %s directly before attending. If %s is able to solicit an RSVP from your mentee, we will reach out to you directly.

If you have questions, please reach out directly to your Program Manager, %s, at %s or %s.

Thank you,
%s Team''' % (mentor_first_name, mentee_first_name, pc_first_name,
    pc_first_name, str(mentor.pc_phone).strip(), mentor.pc_email, mentor.class_name)

                mailermsg = MailerMessage(
                    to_address = mentor.email,
                    when_added = datetime.datetime.now(),
                    from_address = FROM_EMAIL,
                    subject = confirmation_subject,
                    message_body = confirmation_body,
                    priority = 2,
                    content_subtype = ''
                    )

                local_db_session = get_scoped_session()
                local_db_session.add(mailermsg)
                local_db_session.commit()
                local_db_session.begin()
                
                count += 1

    return count

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_low_ratings(user_type, admin_id):

    start_date = get_start_date()

    if user_type == 'mentor':
        results = DBSession.query(
            Rating.mentor_user_id.label('user_id'),
            Rating.mentee_rating.label('rating'),
            Rating.mentee_rated_on.label('rating_date'),
            IuserUser.first_name.label('first_name'),
            IuserUser.last_name.label('last_name'),
            IuserUser.email.label('email'),
            PartnersPartner.name.label('class_name')).\
            options(FromCache(DOGPILE_CACHE_REGION)).\
            join(IuserUser, Rating.mentor_user_id == IuserUser.id).\
            join(IuserPersonaPartner, Rating.mentor_persona_id == IuserPersonaPartner.persona_id).\
            join(PartnersPartner, IuserPersonaPartner.partner_id == PartnersPartner.id).\
            filter(PartnersPartner.member_contact_id == admin_id).\
            filter(cast(Rating.mentee_rated_on, Date) >= start_date).\
            filter(Rating.mentee_rating <= 4).\
            order_by(Rating.mentee_rated_on.desc()).\
            all()
    elif user_type == 'mentee':
        results = DBSession.query(
            Rating.mentee_user_id.label('user_id'),
            Rating.mentor_rating.label('rating'),
            Rating.mentor_rated_on.label('rating_date'),
            IuserUser.first_name.label('first_name'),
            IuserUser.last_name.label('last_name'),
            IuserUser.email.label('email'),
            PartnersPartner.name.label('class_name')).\
            options(FromCache(DOGPILE_CACHE_REGION)).\
            join(IuserUser, Rating.mentee_user_id == IuserUser.id).\
            join(IuserPersonaPartner, Rating.mentee_persona_id == IuserPersonaPartner.persona_id).\
            join(PartnersPartner, IuserPersonaPartner.partner_id == PartnersPartner.id).\
            filter(PartnersPartner.member_contact_id == admin_id).\
            filter(cast(Rating.mentor_rated_on, Date) >= start_date).\
            filter(Rating.mentor_rating <= 4).\
            order_by(Rating.mentor_rated_on.desc()).\
            all()

    return results
    
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_ratings_drops(user_type, admin_id):

    start_date = get_start_date()

    if user_type == 'mentor':
        current_ratings = DBSession.query(
            Rating.mentor_user_id.label('user_id'),
            Rating.mentee_rating.label('rating'),
            Rating.mentee_rated_on.label('rating_date'),
            IuserUser.first_name.label('first_name'),
            IuserUser.last_name.label('last_name'),
            IuserUser.email.label('email'),
            PartnersPartner.name.label('class_name')).\
            options(FromCache(DOGPILE_CACHE_REGION)).\
            join(IuserUser, Rating.mentor_user_id == IuserUser.id).\
            join(IuserPersonaPartner, Rating.mentor_persona_id == IuserPersonaPartner.persona_id).\
            join(PartnersPartner, IuserPersonaPartner.partner_id == PartnersPartner.id).\
            filter(PartnersPartner.member_contact_id == admin_id).\
            filter(cast(Rating.mentee_rated_on, Date) >= start_date).\
            all()
    
        outer_list = []
        for current_rating in current_ratings:
            previous_rating = DBSession.query(
                Rating.mentee_rating.label('rating'),
                Rating.mentee_rated_on.label('rating_date')).\
                options(FromCache(DOGPILE_CACHE_REGION)).\
                filter(Rating.mentor_user_id == current_rating.user_id).\
                filter(Rating.mentee_rated_on < current_rating.rating_date).\
                order_by(Rating.mentee_rated_on.desc()).\
                limit(1).\
                offset(0).\
                first()
    
            if previous_rating:
                if previous_rating.rating - current_rating.rating  >= 3:
                    inner_list = []
                    inner_list.append(current_rating.first_name)
                    inner_list.append(current_rating.last_name)
                    inner_list.append(previous_rating.rating)
                    inner_list.append(previous_rating.rating_date)
                    inner_list.append(current_rating.rating)
                    inner_list.append(current_rating.rating_date)
                    inner_list.append(current_rating.email)
                    inner_list.append(current_rating.class_name)
        
                    outer_list.append(tuple(inner_list))
    if user_type == 'mentee':
        current_ratings = DBSession.query(
            Rating.mentee_user_id.label('user_id'),
            Rating.mentor_rating.label('rating'),
            Rating.mentor_rated_on.label('rating_date'),
            IuserUser.first_name.label('first_name'),
            IuserUser.last_name.label('last_name'),
            IuserUser.email.label('email'),
            PartnersPartner.name.label('class_name')).\
            options(FromCache(DOGPILE_CACHE_REGION)).\
            join(IuserUser, Rating.mentee_user_id == IuserUser.id).\
            join(IuserPersonaPartner, Rating.mentee_persona_id == IuserPersonaPartner.persona_id).\
            join(PartnersPartner, IuserPersonaPartner.partner_id == PartnersPartner.id).\
            filter(PartnersPartner.member_contact_id == admin_id).\
            filter(cast(Rating.mentor_rated_on, Date) >= start_date).\
            all()
    
        outer_list = []
        for current_rating in current_ratings:
            previous_rating = DBSession.query(
                Rating.mentor_rating.label('rating'),
                Rating.mentor_rated_on.label('rating_date')).\
                options(FromCache(DOGPILE_CACHE_REGION)).\
                filter(Rating.mentee_user_id == current_rating.user_id).\
                filter(Rating.mentor_rated_on < current_rating.rating_date).\
                order_by(Rating.mentor_rated_on.desc()).\
                limit(1).\
                offset(0).\
                first()
    
            if previous_rating:
                if previous_rating.rating - current_rating.rating  >= 3:
                    inner_list = []
                    inner_list.append(current_rating.first_name)
                    inner_list.append(current_rating.last_name)
                    inner_list.append(previous_rating.rating)
                    inner_list.append(previous_rating.rating_date)
                    inner_list.append(current_rating.rating)
                    inner_list.append(current_rating.rating_date)
                    inner_list.append(current_rating.email)
                    inner_list.append(current_rating.class_name)
        
                    outer_list.append(tuple(inner_list))

    return outer_list

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_ratings_differences(admin_id):

    start_date = get_start_date()

    mentor_ratings = DBSession.query(
        Rating.mentor_user_id.label('user_id'),
        Rating.mentee_rating.label('rating'),
        Rating.mentee_rated_on.label('rating_date'),
        IuserUser.first_name.label('first_name'),
        IuserUser.last_name.label('last_name'),
        IuserUser.email.label('email'),
        PartnersPartner.name.label('class_name')).\
        options(FromCache(DOGPILE_CACHE_REGION)).\
        join(IuserUser, Rating.mentor_user_id == IuserUser.id).\
        join(IuserPersonaPartner, Rating.mentor_persona_id == IuserPersonaPartner.persona_id).\
        join(PartnersPartner, IuserPersonaPartner.partner_id == PartnersPartner.id).\
        filter(PartnersPartner.member_contact_id == admin_id).\
        filter(cast(Rating.mentee_rated_on, Date) >= start_date).\
        filter(Rating.mentee_rating != None).\
        all()

    outer_list = []
    for mentor_rating in mentor_ratings:
        mentee = get_latest_mentee_user_for_mentor(mentor_rating.user_id)

        # In rare cases, mentors with ratings may no longer have mentees.
        if mentee:    
            mentee_rating = DBSession.query(
                Rating.mentor_rating.label('rating'),
                Rating.mentor_rated_on.label('rating_date'),
                IuserUser.first_name.label('first_name'),
                IuserUser.last_name.label('last_name'),
                IuserUser.email.label('email')).\
                options(FromCache(DOGPILE_CACHE_REGION)).\
                join(IuserUser, Rating.mentee_user_id == IuserUser.id).\
                filter(cast(Rating.mentor_rated_on, Date) >= start_date).\
                filter(Rating.mentor_rating != None).\
                filter(Rating.mentee_user_id == mentee.id).\
                first()
    
            if mentee_rating:
                if abs(mentor_rating.rating - mentee_rating.rating) >= 4:
                    inner_list = []
                    inner_list.append(mentor_rating.first_name)
                    inner_list.append(mentor_rating.last_name)
                    inner_list.append(mentee_rating.first_name)
                    inner_list.append(mentee_rating.last_name)
                    inner_list.append(mentor_rating.rating)
                    inner_list.append(mentor_rating.rating_date)
                    inner_list.append(mentee_rating.rating)
                    inner_list.append(mentee_rating.rating_date)
                    inner_list.append(mentor_rating.email)
                    inner_list.append(mentee_rating.email)
                    inner_list.append(mentor_rating.class_name)
        
                    outer_list.append(tuple(inner_list))

    return outer_list

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_start_date():

    # We begin on the first day of the current month.
    start_date = str(datetime.datetime.utcnow().month) + '/1/' + str(datetime.datetime.utcnow().year)
        
    return start_date

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
if __name__=="__main__":
    #get_upcoming_events(151865)
    send_rsvp_confirmations('Y:MNR')
    #get_low_ratings('mentee', 75476)
    #get_ratings_drops('mentor', 75476)
    #get_ratings_differences(75476)
