# -*- coding: iso8859-15 -*-
import os,sys
import pprint
import logging
from dateutil import tz
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'../..'))
projdir2 = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)
    sys.path.append(projdir2)
from config.project_globals import (db,Base,metadata,
    DBSession,DOGPILE_CACHE_REGION)
from config.caching_query import CachingQuery,FromCache
#Import 'app' object from auth as well
#from auth import api, app

from sqlalchemy import (BigInteger, Boolean, Column, Date, DateTime, 
    Float, ForeignKey, Index, Integer, Numeric, SmallInteger, 
    String, Table, Text, Time, text, func, or_)
from sqlalchemy.sql.expression import func, or_, not_, and_
from sqlalchemy.orm import sessionmaker, aliased
from sqlalchemy.orm.exc import NoResultFound, MultipleResultsFound
from legacy_models.partners import PartnersPartner
from legacy_models.curriculum import CurriculumPrompt
from legacy_models.calendars import CalendarsEventtype
from legacy_models.member import MemberMember,MemberSchool
from legacy_models.utils import UtilsTimezone
from legacy_models.iuser import (IuserAssignedusertype,
    IuserUser,IuserUsertype,IuserPersona,IuserPersonaPartner,
    ACTIVE_PERSONA_STATUS,P_MATCH_STATUS_MATCHED,IuserMatchhistory,
    MentorSiteList)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_persona_for_user(user_id=None,email=None,get_all_active=False,
    ignore_match_status=False,ignore_active_status=False):

    '''
    We are looking for the persona with a match status
    of Matched and a persona status of Active... And if there are
    2 personas that meet that condition we are looking for the
    largest number.

    '''

    if user_id:

        results = DBSession.query(IuserUser,IuserPersona).\
            options(FromCache(DOGPILE_CACHE_REGION)).\
            filter(IuserPersona.user_id==IuserUser.id).\
            filter(IuserUser.id==user_id).\
            order_by(IuserPersona.id.desc())

    else: # email

        results = DBSession.query(IuserUser,IuserPersona).\
            options(FromCache(DOGPILE_CACHE_REGION)).\
            filter(IuserPersona.user_id==IuserUser.id).\
            filter(func.lower(IuserUser.email)==func.lower(email)).\
            order_by(IuserPersona.id.desc())

    if not ignore_match_status:
        results = results.filter(IuserPersona.match_status==P_MATCH_STATUS_MATCHED)

    if not ignore_active_status:
        results = results.filter(IuserPersona.status==ACTIVE_PERSONA_STATUS)

    results = results.all()

    """

    if not results:

        '''

        Give some useful info on what does exist for this user,
        for debugging.

        '''

        d_results = DBSession.query(IuserUser,IuserPersona).\
            filter(IuserPersona.user_id==IuserUser.id).\
            filter(func.lower(IuserUser.email)==func.lower(email)).\
            order_by(IuserPersona.id.desc()).\
            all()

        print "Could not find active/matched personas for this user %s, but here is what I did find: %s" \

            % pprint.pformat(dict([(x.__dict__,y.__dict__) for x,y in d_results]))
    """
    # Django has difficulty letting this fall out of scope. Try committing.
    db.session.commit()

    if get_all_active or (not results):
        return results

    return results[0]

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_persona_obj_for_user(user_id=None,email=None,get_all_active=False,
    ignore_match_status=False,ignore_active_status=False):

    pobjs = get_persona_for_user(user_id=user_id,email=email,
        get_all_active=get_all_active,ignore_match_status=ignore_match_status,
        ignore_active_status=ignore_active_status)

    if pobjs:
        return pobjs[1]
    
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_details_for_user(user_id=None,email=None,ignore_partner_site=False):

    '''
    
    We are looking for details about the user that are valuable in many contexts, eg member site ID, partner site ID, and type.
    We allow multiple personas to return for the given user ID, which is expected.
    However, we assume that each of these personas will have the same user type.
    If multiple personas of the same user have different user types, the data likely is bad, or it is a highly unusual case, eg a mentee who became a mentor later in life.
    We'll order the results by persona ID, so that we easily can obtain the user type of the latest persona.
    
    '''

    if user_id:

        if ignore_partner_site:
            result = DBSession.query(IuserUser,IuserPersona,MemberMember,IuserAssignedusertype,IuserUsertype).\
                options(FromCache(DOGPILE_CACHE_REGION)).\
                filter(IuserUser.id==user_id).\
                filter(IuserAssignedusertype.id==IuserPersona.assigned_usertype_id).\
                filter(IuserUsertype.id==IuserAssignedusertype.usertype_id).\
                join(IuserPersona,IuserPersona.user_id==IuserUser.id).\
                outerjoin(MemberMember, MemberMember.id==IuserUser.member_id).\
                order_by(IuserPersona.id.desc()).\
                limit(1)

        else:
            result = DBSession.query(IuserUser,IuserPersona,IuserPersonaPartner,PartnersPartner,MemberMember,IuserAssignedusertype,IuserUsertype).\
                options(FromCache(DOGPILE_CACHE_REGION)).\
                filter(IuserUser.id==user_id).\
                filter(IuserAssignedusertype.id==IuserPersona.assigned_usertype_id).\
                filter(IuserUsertype.id==IuserAssignedusertype.usertype_id).\
                join(IuserPersona,IuserPersona.user_id==IuserUser.id).\
                outerjoin(IuserPersonaPartner, IuserPersonaPartner.persona_id==IuserPersona.id).\
                outerjoin(PartnersPartner, PartnersPartner.id==IuserPersonaPartner.partner_id).\
                outerjoin(MemberMember, MemberMember.id==IuserUser.member_id).\
                order_by(IuserPersona.id.desc()).\
                limit(1)

    else: # email

        if ignore_partner_site:
            result = DBSession.query(IuserUser,IuserPersona,MemberMember,IuserAssignedusertype,IuserUsertype).\
                options(FromCache(DOGPILE_CACHE_REGION)).\
                filter(func.lower(IuserUser.email)==func.lower(email)).\
                filter(IuserAssignedusertype.id==IuserPersona.assigned_usertype_id).\
                filter(IuserUsertype.id==IuserAssignedusertype.usertype_id).\
                join(IuserPersona,IuserPersona.user_id==IuserUser.id).\
                outerjoin(MemberMember, MemberMember.id==IuserUser.member_id).\
                order_by(IuserPersona.id.desc()).\
                limit(1)

        else:
            result = DBSession.query(IuserUser,IuserPersona,IuserPersonaPartner,PartnersPartner,MemberMember,IuserAssignedusertype,IuserUsertype).\
                options(FromCache(DOGPILE_CACHE_REGION)).\
                filter(func.lower(IuserUser.email)==func.lower(email)).\
                filter(IuserAssignedusertype.id==IuserPersona.assigned_usertype_id).\
                filter(IuserUsertype.id==IuserAssignedusertype.usertype_id).\
                join(IuserPersona,IuserPersona.user_id==IuserUser.id).\
                outerjoin(IuserPersonaPartner, IuserPersonaPartner.persona_id==IuserPersona.id).\
                outerjoin(PartnersPartner, PartnersPartner.id==IuserPersonaPartner.partner_id).\
                outerjoin(MemberMember, MemberMember.id==IuserUser.member_id).\
                order_by(IuserPersona.id.desc()).\
                limit(1)

    result = result.first()

    # Django has trouble letting this fall out of scope. Try commit.
    db.session.commit()

    return result

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def is_user_in_same_member_site(
    user_member_id,other_user_id=None,other_user_email=None):

    if other_user_id:
        other_user = DBSession.query(IuserUser).filter(IuserUser.id==other_user_id).one()
    else:
        other_user = DBSession.query(IuserUser).filter(IuserUser.email==other_user_email).one()

    return other_user.member.id == user_member_id

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def find_active_test_accounts():
    for i in DBSession.query(IuserUser).filter(IuserUser.member_id==196):
        x = get_details_for_user(user_id=i.id)
        if x[0].status != 'A':
            continue
        print "user id %s, %s, site id %s, status: %s" % (i.id,USERTYPES[x[5].usertype_id][1],x[0].member_id,x[0].status)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_latest_persona(user_id = None, filtered = False):

    # Some apps require no filters (active but no match), eg the Intake Application export.

    if filtered == False: # Active, no match
    
        # We filter for active and matched personas, so that unmatched mentors cannot use the College Checklist and other products that rely on mentees.
        if not user_id:
    
            latest_persona_subq = DBSession.query(
                IuserPersona.user_id.label('user_id'),
                func.last_value(IuserPersona.id).\
                    over(partition_by=IuserPersona.user_id, order_by=IuserPersona.id.desc()).\
                    label('latest_persona_id'),
                func.last_value(IuserPersona.status).\
                    over(partition_by=IuserPersona.user_id, order_by=IuserPersona.id.desc()).\
                    label('latest_persona_status'),
                func.last_value(IuserPersona.match_status).\
                    over(partition_by=IuserPersona.user_id, order_by=IuserPersona.id.desc()).\
                    label('latest_persona_match_status')
                ).\
                options(FromCache(DOGPILE_CACHE_REGION)).\
                distinct(IuserPersona.user_id).\
                filter(IuserPersona.status == ACTIVE_PERSONA_STATUS).\
                subquery()
        
        else:
        
            latest_persona_subq = DBSession.query(
                IuserPersona.user_id.label('user_id'),
                func.last_value(IuserPersona.id).\
                    over(partition_by=IuserPersona.user_id, order_by=IuserPersona.id.desc()).\
                    label('latest_persona_id'),
                func.last_value(IuserPersona.status).\
                    over(partition_by=IuserPersona.user_id, order_by=IuserPersona.id.desc()).\
                    label('latest_persona_status'),
                func.last_value(IuserPersona.match_status).\
                    over(partition_by=IuserPersona.user_id, order_by=IuserPersona.id.desc()).\
                    label('latest_persona_match_status')
                ).\
                options(FromCache(DOGPILE_CACHE_REGION)).\
                distinct(IuserPersona.user_id).\
                filter(IuserPersona.user_id == user_id).\
                filter(IuserPersona.status == ACTIVE_PERSONA_STATUS).\
                subquery()
    else:

        # We filter for active and matched personas, so that unmatched mentors cannot use the College Checklist and other products that rely on mentees.
        if not user_id:
    
            latest_persona_subq = DBSession.query(
                IuserPersona.user_id.label('user_id'),
                func.last_value(IuserPersona.id).\
                    over(partition_by=IuserPersona.user_id, order_by=IuserPersona.id.desc()).\
                    label('latest_persona_id'),
                func.last_value(IuserPersona.status).\
                    over(partition_by=IuserPersona.user_id, order_by=IuserPersona.id.desc()).\
                    label('latest_persona_status'),
                func.last_value(IuserPersona.match_status).\
                    over(partition_by=IuserPersona.user_id, order_by=IuserPersona.id.desc()).\
                    label('latest_persona_match_status')
                ).\
                options(FromCache(DOGPILE_CACHE_REGION)).\
                filter(IuserPersona.status == ACTIVE_PERSONA_STATUS).\
                filter(IuserPersona.match_status == P_MATCH_STATUS_MATCHED).\
                distinct(IuserPersona.user_id).\
                subquery()
        
        else:
        
            latest_persona_subq = DBSession.query(
                IuserPersona.user_id.label('user_id'),
                func.last_value(IuserPersona.id).\
                    over(partition_by=IuserPersona.user_id, order_by=IuserPersona.id.desc()).\
                    label('latest_persona_id'),
                func.last_value(IuserPersona.status).\
                    over(partition_by=IuserPersona.user_id, order_by=IuserPersona.id.desc()).\
                    label('latest_persona_status'),
                func.last_value(IuserPersona.match_status).\
                    over(partition_by=IuserPersona.user_id, order_by=IuserPersona.id.desc()).\
                    label('latest_persona_match_status')
                ).\
                options(FromCache(DOGPILE_CACHE_REGION)).\
                distinct(IuserPersona.user_id).\
                filter(IuserPersona.status == ACTIVE_PERSONA_STATUS).\
                filter(IuserPersona.match_status == P_MATCH_STATUS_MATCHED).\
                filter(IuserPersona.user_id == user_id).\
                subquery()

    # Django has difficulty letting this fall out of scope. Try committing.
    db.session.commit()

    # We return a subquery for use in the queries of other functions such as the form export function.
    return latest_persona_subq

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_latest_partner_site():

    latest_partner_site_subq = DBSession.query(
        IuserPersonaPartner.persona_id.label('persona_id'),
        func.last_value(IuserPersonaPartner.partner_id).\
            over(partition_by=IuserPersonaPartner.persona_id, order_by=IuserPersonaPartner.id.desc()).\
            label('latest_partner_id')
        ).\
        options(FromCache(DOGPILE_CACHE_REGION)).\
        distinct(IuserPersonaPartner.persona_id).\
        subquery()

    # Django has difficulty letting this fall out of scope. Try committing.
    db.session.commit()

    # We return a subquery for use in the queries of other functions such as the form export function.
    return latest_partner_site_subq

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def latest_mentee_for_mentor_subq(latest_persona_subq):
    return DBSession.query(
        IuserMatchhistory.mentee_id.label('mentee_persona_id'),
        IuserMatchhistory.id.label('match_history_id'),
        IuserMatchhistory.start.label('match_start_date'),
        IuserMatchhistory.end.label('match_end_date'),
        latest_persona_subq.c.user_id.label('mentor_user_id'),
        latest_persona_subq.c.latest_persona_id.label('mentor_persona_id')
        ).\
        options(FromCache(DOGPILE_CACHE_REGION)).\
        join(latest_persona_subq,IuserMatchhistory.mentor_id==latest_persona_subq.c.latest_persona_id).\
        subquery()

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_latest_mentee_for_mentor(user_id):

    # When we pass a user ID to get_latest_persona(), we get the latest persona only for that user ID.
    latest_persona_subq = get_latest_persona(filtered = True, user_id = user_id)

    latest_match_subq = latest_mentee_for_mentor_subq(latest_persona_subq)

    # We expect only one row of results, since we're retrieving the latest active match for the latest persona.
    # We retrieve the latest match history record, since some users such as the mentor with persona ID 49594
    # have multiple match history records for the same persona ID, which is bad data.
    result = DBSession.query(
        IuserPersona.user_id.label('mentee_user_id'),
        latest_match_subq.c.mentee_persona_id,
        latest_match_subq.c.mentor_user_id,
        latest_match_subq.c.mentor_persona_id,
        latest_match_subq.c.match_history_id,
        latest_match_subq.c.match_start_date,
        latest_match_subq.c.match_end_date).\
        options(FromCache(DOGPILE_CACHE_REGION)).\
        join(latest_match_subq,IuserPersona.id==latest_match_subq.c.mentee_persona_id).\
        order_by(latest_match_subq.c.match_history_id.desc()).\
        first()

    # Django has difficulty letting this fall out of scope. Try committing.
    db.session.commit()

    return result

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_latest_mentee_user_for_mentor(user_id):
    result = get_latest_mentee_for_mentor(user_id)
    if result:
        return DBSession.query(IuserUser).filter(IuserUser.id==result[0]).one()
    
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def latest_mentor_for_mentee_subq(latest_persona_subq):

    return DBSession.query(
        IuserMatchhistory.mentor_id.label('mentor_persona_id'),
        IuserMatchhistory.id.label('match_history_id'),
        IuserMatchhistory.start.label('match_start_date'),
        IuserMatchhistory.end.label('match_end_date'),
        latest_persona_subq.c.user_id.label('mentee_user_id'),
        latest_persona_subq.c.latest_persona_id.label('mentee_persona_id')
        ).\
        options(FromCache(DOGPILE_CACHE_REGION)).\
        join(latest_persona_subq,IuserMatchhistory.mentee_id==latest_persona_subq.c.latest_persona_id).\
        subquery()


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_latest_mentor_for_mentee(user_id):

    # When we pass a user ID to get_latest_persona(), we get the latest persona only for that user ID.
    latest_persona_subq = get_latest_persona(filtered = True, user_id = user_id)

    latest_match_subq = latest_mentor_for_mentee_subq(latest_persona_subq)

    # We expect only one row of results, since we're retrieving the latest match for the latest persona.
    # We retrieve the latest match history record, since some users such as the mentee with persona ID 69412
    # have multiple match history records for the same persona ID, which is bad data.
    result = DBSession.query(
        IuserPersona.user_id.label('mentor_user_id'),
        latest_match_subq.c.mentor_persona_id,
        latest_match_subq.c.mentee_user_id,
        latest_match_subq.c.mentee_persona_id,
        latest_match_subq.c.match_history_id,
        latest_match_subq.c.match_start_date,
        latest_match_subq.c.match_end_date).\
        options(FromCache(DOGPILE_CACHE_REGION)).\
        join(latest_match_subq,IuserPersona.id==latest_match_subq.c.mentor_persona_id).\
        order_by(latest_match_subq.c.match_history_id.desc()).\
        first()

    # Django has difficulty letting this fall out of scope. Try committing.
    db.session.commit()
    return result

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_latest_mentor_user_for_mentee(user_id):
    result = get_latest_mentor_for_mentee(user_id)
    if result:
        return DBSession.query(IuserUser).filter(IuserUser.id==result[0]).one()
    
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_admin_for_user(user_id,filtered=True):

    # We expect only one row of results, since users have only one member administrator ("MA").
    
    latest_persona_subq = get_latest_persona(filtered = filtered, user_id = user_id)
    latest_partner_site_subq = get_latest_partner_site()
    IuserPersona2 = aliased(IuserPersona)
    
    result = DBSession.query(
        IuserPersona.user_id.label('user_id'),
        IuserPersona.id.label('persona_id'),
        PartnersPartner.id.label('partner_id'),
        PartnersPartner.name.label('partner_name'),
        IuserPersona2.user_id.label('admin_user_id'),
        IuserPersona2.id.label('admin_persona_id'),
        IuserUser.first_name.label('admin_first_name'),
        IuserUser.last_name.label('admin_last_name')).\
        options(FromCache(DOGPILE_CACHE_REGION)).\
        join(latest_persona_subq, IuserPersona.id == latest_persona_subq.c.latest_persona_id).\
        join(latest_partner_site_subq, IuserPersona.id == latest_partner_site_subq.c.persona_id).\
        join(PartnersPartner, latest_partner_site_subq.c.latest_partner_id == PartnersPartner.id).\
        join(IuserPersona2, PartnersPartner.member_contact_id == IuserPersona2.id).\
        join(IuserUser, IuserPersona2.user_id == IuserUser.id).\
        first()

    # Django has difficulty letting this fall out of scope. Try committing.
    db.session.commit()
    return result

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_partner_site_for_user(user_id, all_sites = False):

    # We only want the latest persona IDs here to prevent conflicting partner site IDs.
    latest_persona_subq = get_latest_persona(filtered = False, user_id = user_id)

    # Partner admins ("PAs") often have access to multiple partner sites
    # and need to see them all in our products such as Snapshot and Flipbook.
    # Mentors and mentees should have access only to one partner site.
    if all_sites:
        results = DBSession.query(
            PartnersPartner).\
            options(FromCache(DOGPILE_CACHE_REGION)).\
            join(IuserPersonaPartner, PartnersPartner.id == IuserPersonaPartner.partner_id).\
            join(IuserPersona, IuserPersonaPartner.persona_id == IuserPersona.id).\
            join(latest_persona_subq, IuserPersona.id == latest_persona_subq.c.latest_persona_id).\
            join(IuserUser, IuserPersona.user_id == IuserUser.id).\
            filter(IuserUser.id == user_id).\
            order_by(PartnersPartner.name.asc()).\
            all()
            
        # Django has difficulty letting this fall out of scope. Try committing.
        db.session.commit()
        return results
    else:
        result = DBSession.query(
            IuserUser.id.label('user_id'),
            IuserPersonaPartner.partner_id.label('latest_partner_id'),
            latest_persona_subq.c.latest_persona_id.label('latest_persona_id')).\
            options(FromCache(DOGPILE_CACHE_REGION)).\
            join(IuserPersona, IuserUser.id == IuserPersona.user_id).\
            join(latest_persona_subq, IuserPersona.id == latest_persona_subq.c.latest_persona_id).\
            join(IuserPersonaPartner, latest_persona_subq.c.latest_persona_id == IuserPersonaPartner.persona_id).\
            join(IuserAssignedusertype, IuserPersona.assigned_usertype_id == IuserAssignedusertype.id).\
            join(IuserUsertype, IuserAssignedusertype.usertype_id == IuserUsertype.id).\
            filter(IuserUser.id == user_id).\
            first()
        
        # Django has difficulty letting this fall out of scope. Try committing.
        db.session.commit()
        return result

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_admin_obj_for_user(user_id,filtered=True):
    result = get_admin_for_user(user_id,filtered=filtered)
    if not result:
        return 

    return DBSession.query(IuserUser).filter(IuserUser.id==result.admin_user_id).one()

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_users_for_admin(user_id):

    # We expect many results, since a member administrator ("MA") typically manages many users.
    # MAs are not assigned to partner sites, so they will not be comingled with the mentors and mentees in the partners sites they manage.
    
    # We set filtering to false for latest personas, since MAs are not matched with a mentee.
    latest_persona_subq = get_latest_persona(filtered = False, user_id = user_id)
    IuserPersona2 = aliased(IuserPersona)
    
    results = DBSession.query(
        IuserPersona.user_id.label('admin_user_id'),
        IuserPersona.id.label('admin_persona_id'),
        PartnersPartner.id.label('partner_id'),
        PartnersPartner.name.label('partner_name'),
        IuserPersona2.user_id.label('user_id'),
        IuserPersona2.id.label('persona_id'),
        IuserUser.first_name.label('first_name'),
        IuserUser.last_name.label('last_name'),
        IuserUsertype.id.label('user_type_id'),
        IuserUsertype.type.label('user_type_name')).\
        options(FromCache(DOGPILE_CACHE_REGION)).\
        join(latest_persona_subq, IuserPersona.id == latest_persona_subq.c.latest_persona_id).\
        join(PartnersPartner, IuserPersona.id == PartnersPartner.member_contact_id).\
        join(IuserPersonaPartner, PartnersPartner.id == IuserPersonaPartner.partner_id).\
        join(IuserPersona2, IuserPersonaPartner.persona_id == IuserPersona2.id).\
        join(IuserAssignedusertype, IuserPersona2.assigned_usertype_id == IuserAssignedusertype.id).\
        join(IuserUsertype, IuserAssignedusertype.usertype_id == IuserUsertype.id).\
        join(IuserUser, IuserPersona2.user_id == IuserUser.id).\
        order_by(PartnersPartner.name.asc()).\
        all()

    # Django has difficulty letting this fall out of scope. Try committing.
    db.session.commit()
    return results

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_latest_mentor_user_for_mentee(user_id):
    result = get_latest_mentor_for_mentee(user_id)
    if result:
        return DBSession.query(IuserUser).filter(IuserUser.id==result[0]).one()
    
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_partner_admins_for_partners(partner_ids):
    # 3 = partner admin. We can't pull in iuser model here, so use constants.
    results = DBSession.query(IuserPersona,IuserPersonaPartner,IuserAssignedusertype,IuserUsertype).\
        options(FromCache(DOGPILE_CACHE_REGION)).\
        filter(IuserPersonaPartner.partner_id.in_(partner_ids)).\
        filter(IuserUsertype.id==3).\
        filter(IuserPersona.id==IuserPersonaPartner.persona_id).\
        join(IuserAssignedusertype,IuserAssignedusertype.id==IuserPersona.assigned_usertype_id).\
        join(IuserUsertype,IuserUsertype.id==IuserAssignedusertype.usertype_id).all()

    # Django has difficulty letting this fall out of scope. Try committing.
    db.session.commit()
    return [x[0].user for x in results]

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_users_for_partners(partner_ids):
    # 4 = Mentor,5 = Mentee. We can't pull in iuser model here, so use constants.
    results = DBSession.query(IuserPersona,IuserPersonaPartner,IuserAssignedusertype,IuserUsertype).\
        options(FromCache(DOGPILE_CACHE_REGION)).\
        filter(IuserPersonaPartner.partner_id.in_(partner_ids)).\
        filter(or_(IuserUsertype.id.notin_((4,5)),and_(IuserUsertype.id==5,IuserPersona.status=='A',IuserPersona.match_status!='C'),and_(IuserUsertype.id==4,IuserPersona.status=='A',IuserPersona.match_status=='M'))).\
        filter(IuserPersona.id==IuserPersonaPartner.persona_id).\
        join(IuserAssignedusertype,IuserAssignedusertype.id==IuserPersona.assigned_usertype_id).\
        join(IuserUsertype,IuserUsertype.id==IuserAssignedusertype.usertype_id).all()

    # Django has difficulty letting this fall out of scope. Try committing.
    db.session.commit()
    return [x[0].user for x in results]

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_partners_for_user(user,role,get_alumni=False,active_only=True):

    if role.is_member_admin or role.is_enhanced_member_admin or role.is_regional_admin:
        # Treat both as member level.
        if get_alumni:
            if active_only:
                partner_objs = DBSession.query(PartnersPartner).filter(
                    PartnersPartner.member_id==user.member_id).filter(
                    PartnersPartner.status_id==1)
            else:
                partner_objs = DBSession.query(PartnersPartner).filter(
                    PartnersPartner.member_id==user.member_id)
        else:
            if active_only:
                partner_objs = DBSession.query(PartnersPartner).filter(
                    PartnersPartner.member_id==user.member_id).filter(
                    PartnersPartner.is_alumni==False).filter(
                    PartnersPartner.status_id==1)
            else:
                partner_objs = DBSession.query(PartnersPartner).filter(
                    PartnersPartner.member_id==user.member_id).filter(
                    PartnersPartner.is_alumni==False)

        results = partner_objs.order_by('name').all()

        # Django has difficulty letting this fall out of scope. Try committing.
        db.session.commit()

        return results

    if role.is_partner_admin:
        results = get_partner_site_for_user(user.id, all_sites = True)

        if not results:
            # Django has difficulty letting this fall out of scope. Try committing.
            db.session.commit()
    
            return []
        else:
            return results
            
    if role.is_super_admin:
        if get_alumni:
            if active_only:
                results = DBSession.query(PartnersPartner).filter(
                    PartnersPartner.status_id==1
                    ).order_by('name').all()

                # Django has difficulty letting this fall out of scope. Try committing.
                db.session.commit()

                return results
            else:
                results = DBSession.query(PartnersPartner).order_by('name').all()

                # Django has difficulty letting this fall out of scope. Try committing.
                db.session.commit()

                return results
        else:
            if active_only:
                results = DBSession.query(PartnersPartner).filter(
                    PartnersPartner.is_alumni==False).filter(
                    PartnersPartner.status_id==1
                    ).order_by('name').all()

                # Django has difficulty letting this fall out of scope. Try committing.
                db.session.commit()

                return results

            else:
                results = DBSession.query(PartnersPartner).filter(
                    PartnersPartner.is_alumni==False).filter(
                    ).order_by('name').all()

                # Django has difficulty letting this fall out of scope. Try committing.
                db.session.commit()

                return results

    # All other users only see the partner info matching the partner to which they belong.
    partner_info = get_partner_site_for_user(user.id)
    #print "Partner info: {0}".format(pprint.pformat(partner_info))
    if not partner_info:
        # Django has difficulty letting this fall out of scope. Try committing.
        db.session.commit()

        return []

    results = [DBSession.query(PartnersPartner).filter(PartnersPartner.id==partner_info[1]).one()]
    # Django has difficulty letting this fall out of scope. Try committing.
    db.session.commit()

    return results

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_mentee_school_year_grade(user,role):

    if role.is_mentee:
        partners = get_partners_for_user(user,role)
        if partners:
            gclass = partners[0].graduating_class
            # school, year, grade
            return gclass.school,gclass.graduating_class,gclass.grade

    return None,None,None

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def user_timezone(user_id):
    user_timezone = DBSession.query(
        UtilsTimezone.name.label('name')).\
        join(MemberMember, UtilsTimezone.id == MemberMember.time_zone_id).\
        join(IuserUser, MemberMember.id == IuserUser.member_id).\
        filter(IuserUser.id == user_id).\
        first()

    return tz.gettz(user_timezone.name)
    
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
if __name__=="__main__":
    '''
    get_partner_site_for_user(168473, all_sites = True)
    print get_admin_obj_for_user(147207)
    print get_latest_mentor_for_mentee(user_id = 147115)
    print get_latest_mentor_for_mentee(user_id = 147115).mentor_user_id
    print get_latest_mentor_for_mentee(user_id = 147115).mentor_persona_id
    print get_latest_mentor_for_mentee(user_id = 147115).match_history_id
    print get_persona_obj_for_user(user_id = 128357).id
    print get_latest_mentee_for_mentor(user_id = 141418)
    print get_users_for_partners([2438])
    from utils.roles import Role
    from roles import Role
    import pdb
    pdb.set_trace()
    x=get_partner_site_for_user(168681)
    user = DBSession.query(IuserUser).filter(IuserUser.id==151937).one()
    role = Role(user.id)
    x = get_partners_for_user(user,role)
    print x
    y=get_users_for_partners([x[0].id])
    #get_users_for_admin(153864)
    from roles import Role
    import pdb
    pdb.set_trace()
    user = DBSession.query(IuserUser).filter(IuserUser.id==172811).one()
    role = Role(user.id)
    x = get_partners_for_user(user,role)
    get_admin_for_user(151737)
    get_latest_persona()
    get_latest_partner_site()
    print get_latest_mentee_for_mentor(100092)
    import pdb
    pdb.set_trace()
    print get_persona_obj_for_user(user_id=157353).id
    print get_persona_for_user(user_id=170941,ignore_match_status=True)[1].id
    print get_persona_for_user(user_id=158083)[1].id

    for i in range(100092,111000):
        x = get_latest_mentee_for_mentor(user_id = i)
        if x:
            y = get_latest_mentor_for_mentee(user_id = x[0])
            print x[0],y[0]
    get_details_for_user(email='jnunn@bbbstx.org',ignore_partner_site=True)
    '''
