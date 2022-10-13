# -*- coding: iso8859-15 -*-
import os,sys

from dateutil import tz
from sqlalchemy import func
from sqlalchemy.sql.expression import func, or_, not_, and_
from datetime import datetime,timedelta

appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import (Base,metadata,DBSession,
    get_scoped_session)
from config.settings import (ENV_TYPE,LOGIN_DISABLED,
    DEFAULT_TEST_USER_ID,FROM_EMAIL)

#Import 'app' object from auth as well
from auth import api, app
from legacy_models.iuser import IuserUser, MENTEE, MENTOR
from legacy_models.mailer import MailerMessage
from legacy_models.curriculum import CurriculumPrompt
from legacy_models.partners import PartnersSession
from legacy_models.member import MemberMember
from models import PartnersSessionCurriculum, Curriculum
from new_platform.utils.roles import Role
from new_platform.utils.user_details import get_latest_mentor_user_for_mentee, get_latest_mentee_user_for_mentor

class DupRoleException(Exception):
    pass

class NoPartnerException(Exception):
    pass

class MissingDateException(Exception):
    pass

class PersonaException(Exception):
    pass

class BadRangeException(Exception):
    pass

def update_legacy_dependencies_with_new_canvas_set(
    curr_id,partner_id,start_date,end_date,backfill=False):

    local_db_session = get_scoped_session()
    # This is called during scheduling. If lesson was already
    # scheduled, don't duplicate history, get out.
    curr = DBSession.query(Curriculum).filter(
        Curriculum.id==curr_id).one()

    psc_res = DBSession.query(PartnersSessionCurriculum,PartnersSession).\
        filter(PartnersSessionCurriculum.curr_id==curr_id).\
        filter(PartnersSessionCurriculum.p_session_id==PartnersSession.id).\
        filter(PartnersSession.partner_id==partner_id).first()

    if psc_res:
        #pc_map = psc_res[0]
        #psession = psc_res[1]

        # It's history was already recorded.
        psc = dict([(x,y) for x,y in psc.__dict__.iteritems() if x != '_sa_instance_state'])
        psession = dict([(x,y) for x,y in psession.__dict__.iteritems() if x != '_sa_instance_state'])

        local_db_session.commit()
        return (psc,psession,curr)

    cprompt = CurriculumPrompt(
        title=curr.description,
        description=curr.description,
        prompt_text=curr.description,
        created_date=start_date.replace(tzinfo=tz.gettz('UTC')),
        modified_date=start_date.replace(tzinfo=tz.gettz('UTC')),
        status_id=3,
        created_by_id=1,
        modified_by_id=153864,
        is_deleted=False)

    local_db_session.add(cprompt)
    local_db_session.flush()

    psession = PartnersSession(
        description=curr.description,
        start=start_date.replace(tzinfo=None),
        prompt_id=cprompt.id,
        partner_id=partner_id,
        end_date=end_date.replace(tzinfo=None),
        status_id = 1,
        activity_recorded = False)

    local_db_session.add(psession)
    local_db_session.flush()

    pc_map = PartnersSessionCurriculum(
        curr_id=curr.id,
        p_session_id=psession.id)

    local_db_session.add(pc_map)
    local_db_session.flush()

    # Close last legacy session.
    local_db_session.query(PartnersSession).filter(PartnersSession.end_date==None).filter(
        PartnersSession.partner_id==partner_id).update(
        {'end_date':start_date.replace(tzinfo=tz.gettz('UTC')) - timedelta(seconds = 1)})

    pc_map = dict([(x,y) for x,y in pc_map.__dict__.iteritems() if x != '_sa_instance_state'])
    psession = dict([(x,y) for x,y in psession.__dict__.iteritems() if x != '_sa_instance_state'])

    local_db_session.commit()
    return (pc_map,psession,curr)

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def update_legacy_dependencies_upon_finish(local_db_session,current_user,canvas_set_copy_id,
    backfill=False):

    # On 5/11/16, we deleted the majority of the legacy update code here,
    # since we released the new Safety Alerts feature and no longer needed to populate
    # legacy email tables and allow the legacy Keyword Alerts feature to scan those tables.
    # If you'd like to review the legacy update code, check commits to Git on 5/11/16.
    role = Role(current_user.id)
    other = None

    if role.role == MENTEE:
        other = get_latest_mentor_user_for_mentee(current_user.id)
    else:
        other = get_latest_mentee_user_for_mentor(current_user.id)

    # We send an email notification only when a counterparty exists.
    if not backfill and other:
        user_details = DBSession.query(
            IuserUser.first_name.label('user_first_name')).\
            filter(IuserUser.id==current_user.id).first()
    
        member_details = DBSession.query(
            MemberMember.name.label('member_name'),
            MemberMember.url_name.label('member_url')).\
            filter(MemberMember.id==current_user.member_id).first()
    
        # We're adjusting case here, but plan to do so in the database soon.
        party_name = user_details[0].capitalize()
        counterparty_name = other.first_name.capitalize()
    
        mailermsg = MailerMessage(
            to_address = other.email,
            when_added = datetime.now(),
            from_address = FROM_EMAIL,
            subject = 'You have new Canvas content from %s!' % party_name,
            message_body = 'Hi, %s. Please sign into the %s Platform at https://%s.imentor.org to see the latest Canvas content from %s and respond before the next class. Thanks!' % (counterparty_name, member_details[0], member_details[1], party_name),
            priority = 2,
            content_subtype = ''
            )

        local_db_session.add(mailermsg)

    local_db_session.commit()
    local_db_session.begin()
    
    return