# -*- coding: iso8859-15 -*-
import os,sys

from sqlalchemy import func
from sqlalchemy.sql.expression import func, or_, not_, and_
from datetime import datetime,timedelta

appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import Base,metadata,DBSession
from config.settings import (ENV_TYPE,LOGIN_DISABLED,
    DEFAULT_TEST_USER_ID,FROM_EMAIL)

#Import 'app' object from auth as well
from auth import api, app
from legacy_models.iuser import IuserUser, MENTEE, MENTOR
from legacy_models.mailer import MailerMessage
from legacy_models.member import MemberMember
from conversations.models import Conversation
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

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def update_legacy_dependencies_upon_finish(local_db_session,current_user,conv):

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

    # We send email notifications for Conversations messages, only if
    # the user hasn't written a message within the past X minutes.
    # Our goal here is to balance timely email notifications with 
    # notification fatigue.
    lookback_time = datetime.utcnow() - timedelta(minutes = 45)
    conversation_details = DBSession.query(
        Conversation.id.label('conversation_id')).\
        filter(Conversation.user_id == current_user.id).\
        filter(Conversation.recipient_user_id == other.id).\
        filter(Conversation.received_by_server > lookback_time).\
        all()

    # All Conversations users are matched, so we don't check whether
    # the "other" variable is none here.
    # Furthermore, the message just written exists in the Conversations table,
    # which means only in cases of where that just-written message is the only
    # row in the rsults should we send an email notification.
    if len(conversation_details) == 1:
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
            subject = 'You have a new Conversations message from %s!' % party_name,
            message_body = 'Hi, %s. Please sign into the %s Platform at https://%s.imentor.org to see the latest Conversations message from %s. Thanks!' % (counterparty_name, member_details[0], member_details[1], party_name),
            priority = 2,
            content_subtype = ''
            )

        local_db_session.add(mailermsg)

    local_db_session.commit()
    local_db_session.begin()

    return