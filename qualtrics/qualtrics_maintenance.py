# -*- coding: iso8859-15 -*-
import copy
from datetime import datetime,timedelta
import httplib
import json
import math
import re
import pdb
import pprint
import random
import requests
import string
import traceback
import os,sys
from sqlalchemy.sql.expression import func, or_, not_, and_

appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import (Base,metadata,
    DBSession,get_scoped_session)
from config.settings import (ENV_TYPE,LOGIN_DISABLED,
    DEFAULT_TEST_USER_ID,EMAIL_HOST_USER,QUALTRICS_URI,
    QUALTRICS_USER,QUALTRICS_TOKEN,QUALTRICS_API_SELECT,
    QUALTRICS_API_FORMAT,QUALTRICS_API_VERSION)


#Import 'app' object from auth as well
from auth import api, app

from legacy_models.iuser import (IuserUser,IuserPersona,IuserPersonaPartner,
    IuserUsertype,IuserAssignedusertype,ACTIVE_PERSONA_STATUS,USERTYPE_MAP,
    USER_STATUS_MAP,MATCH_CHOICES,USER_STATUS_INACTIVE_REJECTED,
    USER_STATUS_INTACTIVE_WITHDRAWN,USER_STATUS_INTACTIVE_DELETED,
    USER_STATUS_ACTIVE, USER_STATUS_APPLICATION_INCOMPLETE,
    USER_STATUS_SCREENING_INCOMPLETE,
    MENTEE,MENTOR)
from legacy_models.partners import PartnersPartner
from legacy_models.member import MemberSchool
from college_checklist.models import CollegeChecklist
from new_platform.utils.roles import Role
from new_platform.utils.user_details import (get_persona_obj_for_user,
    get_partners_for_user,get_latest_mentor_user_for_mentee,
    get_latest_mentee_user_for_mentor,get_admin_for_user,
    get_latest_mentee_for_mentor,get_latest_mentor_for_mentee)
from qualtrics.models import (QualtricsSurvey,QualtricsInvite,QualtricsLibPanel,
    QUALTRICS_STATUS_MAP,QUALTRICS_NOT_INVITED,
    QUALTRICS_INVITED,QUALTRICS_INCOMPLETE,QUALTRICS_COMPLETE,QUALTRICS_INCOMPLETE_CLOSED)
from email_crash_report import send_crash_report

from qualtrics_3rd_party import (_api_call,
    FailedQualtricsAPICall,add_user_to_qualtrics,gen_new_survey_link)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_all_panel_dups():
    '''
    We use one universal panel and library, stored in one table.
    '''
    qid = DBSession.query(QualtricsLibPanel).filter(QualtricsLibPanel.record_is_active==True).one()
    request_payload = {
        'LibraryID':qid.library_string,
        'PanelID':qid.panel_string
        }

    dup_users = []
    persona_ids = []

    # Don't use 'Email' field, use the embedded data email.
    result = _api_call('getPanel',request_payload)
    for r in result:
        if r['ExternalDataReference'] in persona_ids:
            dup_users.append(r['ExternalDataReference']) # persona id
        else:
            persona_ids.append(r['ExternalDataReference'])

    if dup_users:
        # Print to stderr, in case this is run by cron.
        sys.stderr.write('Dup persona IDs: {0}'.format(pprint.pformat(dup_users)))

    return True if dup_users else False


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def resolve_dups():
    if ENV_TYPE != "Production":
        app.logger.exception("resolve_dups(): Not running on production, disabled. This is to prevent dev data from being injected into the production panel. To override, change this code.")
        return
      
    '''
    We use one universal panel and library, stored in one table.
    '''
    qid = DBSession.query(QualtricsLibPanel).filter(QualtricsLibPanel.record_is_active==True).one()
    request_payload = {
        'LibraryID':qid.library_string,
        'PanelID':qid.panel_string
        }

    dup_users = []
    persona_ids = []
    all_persona_panel = {}
    dup_persona_panel = {}

    # Don't use 'Email' field, use the embedded data email.

    # Check for duplicate persona IDs. Use the panel ID currently in our DB
    result = _api_call('getPanel',request_payload)
    for r in result:
        # Save all and dup persona IDs and associated panel IDs.
        if r['ExternalDataReference'] in persona_ids:
            dup_users.append(r['ExternalDataReference']) # persona id

            if r['ExternalDataReference'] in dup_persona_panel:
                dup_persona_panel[int(r['ExternalDataReference'])].append(r['RecipientID'])
            else:
                dup_persona_panel[int(r['ExternalDataReference'])] = [r['RecipientID']]
            dup_persona_panel[int(r['ExternalDataReference'])].append(all_persona_panel[int(r['ExternalDataReference'])])
        else:
            persona_ids.append(r['ExternalDataReference'])
            all_persona_panel[int(r['ExternalDataReference'])] = r['RecipientID']

    if dup_users:
        for dup_persona in dup_users:
            # Loop through and remove dups from the Qulatrics panel which do not appear in our DB.
            # We check this by comparing the qualtrics_panel_member_id in our DB to the RecipientID
            # returned by qualtrics.
            q_persona = DBSession.query(IuserPersona).filter(IuserPersona.id==dup_persona).first()
            curr_persona = get_persona_obj_for_user(q_persona.user.id,ignore_match_status=True)
            if curr_persona and q_persona != curr_persona:
                if curr_persona.id not in persona_ids:
                    '''
                    Changed personas are a normal occurrence in this system. As long as
                    the qualtrics data points to the active persona, we don't care.
                    We check this elsewhere, not just in duplicates, but for all active links.
                    If we find an inactive duplicate persona in the Qualtrics panel, 
                    we leave it alone.
                    '''
                    app.logger.info("persona changed for user {0} from {1} to {2}, skipping duplicate, it is inactive.".format(curr_persona.user.id,q_persona.id,curr_persona.id))
            else:
                # There could be more than one duplicate.
                for recip_id in dup_persona_panel[curr_persona.id]:
                    if recip_id == curr_persona.qualtrics_panel_member_id:
                        continue
                    request_payload = {
                        'LibraryID':qid.library_string,
                        'PanelID':qid.panel_string,
                        'RecipientID':recip_id,
                        }

                    result = _api_call('removeRecipient',request_payload)
                    

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def update_from_qualtrics_to_persona_table():

    if ENV_TYPE != "Production":
        app.logger.exception("update_from_qualtrics_to_persona_table(): Not running on production, disabled. This is to prevent dev data from being injected into the production panel. To override, change this code.")
        return
      
    local_db_session = get_scoped_session()
    '''
    Please resolve dups before running this.
    Otherwise a survey invitation may not work for dup users.

    We use one universal panel and library, stored in one table.
    '''
    if get_all_panel_dups():
       app.logger.warning("Please resolve dups first. Terminating.")
       return

    qid = DBSession.query(QualtricsLibPanel).filter(QualtricsLibPanel.record_is_active==True).one()
    request_payload = {
        'LibraryID':qid.library_string,
        'PanelID':qid.panel_string
        }

    checked_personas = []
    result = _api_call('getPanel',request_payload)
    for r in result:
        q_persona = DBSession.query(IuserPersona).filter(IuserPersona.id==r['ExternalDataReference']).first()
        if not q_persona:
            continue
        checked_personas.append(q_persona.id)
        if q_persona.qualtrics_panel_member_id != r['RecipientID']:
            app.logger.info("Mismatch! user {0} persona {1} Our recipient id: {2}, in Qualtrics: {3}".format(
                q_persona.user_id,q_persona.id,
                q_persona.qualtrics_panel_member_id,r['RecipientID']))

            local_db_session.query(IuserPersona).filter(IuserPersona.id==int(r['ExternalDataReference'])).update(
                 {'qualtrics_panel_member_id':r['RecipientID']})
            local_db_session.commit()
            local_db_session.begin()

            app.logger.info("Updated panel member id from Qualtrics to our DB, user {0}".format(r['EmbeddedData']['userid']))

        # Look for mismatched survey links
        for invite in DBSession.query(QualtricsInvite).filter(
            QualtricsInvite.persona_id == q_persona.id).filter(
            QualtricsInvite.survey_status.in_((QUALTRICS_INVITED,QUALTRICS_INCOMPLETE))).all():
            if not re.search(r['RecipientID'],invite.survey_link):
                app.logger.info("Replacing survey link, it's incorrect for user {0} survey invite {1}".format(
                    q_persona.user.id,invite.id))
                gen_new_survey_link(local_db_session,
                    q_persona.user,invite.survey.survey_string,
                    q_persona.user,replace=True)


    '''
    Don't do this. Most unassigned persona are invalid.
    for persona in DBSession.query(IuserPersona).filter(IuserPersona.id.notin_(checked_personas)).all():
        # Make sure it matches the active person of it's current user.
        real_persona = get_persona_obj_for_user(persona.user.id,ignore_match_status=True)
        if real_persona and persona.id != real_persona.id:
            continue

        if persona.user.status not in (USER_STATUS_ACTIVE,
            USER_STATUS_APPLICATION_INCOMPLETE,
            USER_STATUS_SCREENING_INCOMPLETE):
            continue

        if persona.qualtrics_panel_member_id:
            app.logger.info("Found panel member id that isn't in qualtrics. persona id: {0} panel member id {1}".format(
                persona.id,persona.qualtrics_panel_member_id))

            local_db_session.query(IuserPersona).filter(IuserPersona.id==persona.id).update(
                 {'qualtrics_panel_member_id':None})
            db.session.commit()
            add_user_to_qualtrics(user=persona.user)
        else:
            app.logger.info("Missing panel member id, adding to Qualtrics. persona id: {0}".format(persona.id))
            add_user_to_qualtrics(user=persona.user)
    '''
    local_db_session.commit()

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def fix_active_links_for_changed_personas():

    '''
    Find all open survey links. If the persona of the link owner changed,
    change the survey link to match the current active persona.
    Unfortunately this forces them to retake the survey from scratch.
    Not much we can do about this.
    '''
    local_db_session = get_scoped_session()
    curr_persona = None
    for open_invitation in local_db_session.query(QualtricsInvite).filter(
        QualtricsInvite.survey_status.in_((
        QUALTRICS_INCOMPLETE,QUALTRICS_INVITED))).order_by(
        QualtricsInvite.user_id).all():

        # Did we not see this user's persona info yet? Records are sorted by user.
        if not curr_persona or (open_invitation.user_id != curr_persona.user_id):
            curr_persona = get_persona_obj_for_user(open_invitation.user_id,ignore_match_status=True)
            if not curr_persona: # Maybe inactive?
                continue

            panel_member_id = curr_persona.qualtrics_panel_member_id
            if curr_persona.qualtrics_panel_member_id in ('',None):
                result,panel_member_id = add_user_to_qualtrics(user=curr_persona.user)
                if not result:
                    app.logger.warning(
                        "Add user to qualtrics failed. Skipping, not crashing. User {0}".format(
                        curr_persona.user_id))
                    continue

                # Re-get, to sync session obj
                curr_persona = get_persona_obj_for_user(open_invitation.user_id,ignore_match_status=True)

        panel_member_id = curr_persona.qualtrics_panel_member_id

        # Is the link's persona not the active persona for this user?
        if open_invitation.persona_id != curr_persona.id:

            # If not, replace the panel id and persona id. They get a new, blank survey.
            old_link = open_invitation.survey_link
            dist_string,survey_string,mlrp,panel_string = open_invitation.survey_link.split('_')

            new_link = "{0}_{1}_{2}".format(dist_string,survey_string,panel_member_id)

            for survey in local_db_session.query(QualtricsSurvey).filter(
                QualtricsSurvey.survey_string=='SV_{0}'.format(survey_string)).all():

                # Check for already existing link. If so, delete old link, don't create this new one.
                if local_db_session.query(QualtricsInvite).filter(
                    QualtricsInvite.survey_link==new_link,
                    QualtricsInvite.user_id==open_invitation.user_id,
                    QualtricsInvite.persona_id==curr_persona.id).first():

                    print "Deleting invitation for persona id {0}, duplicate correct link exists for persona {1} ".format(
                        open_invitation.persona_id,curr_persona.id)

                    local_db_session.query(QualtricsInvite).filter(
                        QualtricsInvite.id==open_invitation.id).delete()

                else:
                    open_invitation.survey_link = new_link
                    open_invitation.survey_id = survey.id

                    print "Correcting persona id {0} live link from {1} to {2}".format(
                        curr_persona.id,old_link,open_invitation.survey_link)

                    open_invitation.persona_id = curr_persona.id

                local_db_session.commit()
                local_db_session.begin()

    local_db_session.commit()

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
if __name__ == '__main__':
    import pdb
    pdb.set_trace()
    #from qualtrics_3rd_party import manually_gen_survey_distribution_id
    #manually_gen_survey_distribution_id('SV_6ioEJxfxA2dREqx','BBBS Mentee Fall 2016 Survey')
    #manually_gen_survey_distribution_id('SV_2hjTHaHV2oJqBsp','BBBS Mentor Fall 2016 Survey')
    #manually_gen_survey_distribution_id('SV_5vUrLGK0nPEdyqF','iMentor Mentee Fall 2016 Survey')
    #manually_gen_survey_distribution_id('SV_6EDK6XqLxPYdAWx','iMentor Mentor Fall 2016 Survey')

    #fix_active_links_for_changed_personas()
    #auto_add_or_deactivate_surveys()
    '''
    resolve_dups()
    update_from_qualtrics_to_persona_table()
    '''
    #get_all_panel_dups()

    #update_response_statuses(survey_string='SV_brpRoygXmUxuPml')
    #update_from_qualtrics_to_persona_table()

    '''
    #_get_all_panel_members()
    qid = DBSession.query(QualtricsLibPanel).filter(QualtricsLibPanel.record_is_active==True).one()
    userlist = [x.user_id for x in DBSession.query(IuserPersona).filter(IuserPersona.qualtrics_panel_member_id==None).all()]

    #allusers = DBSession.query(IuserUser).filter(IuserUser.id.in_(userlist)).all()

    for user in DBSession.query(IuserUser).filter(IuserUser.id.in_(userlist)).all():
        if 'PURGE' in user.email:
            continue

        print "Doing user {0}".format(user.id)
        add_user_to_qualtrics(user=user,panel_id=qid.panel_string,
            lib_id=qid.library_string,update=False)
    
    #update_response_statuses(survey_string='SV_brpRoygXmUxuPml')
    '''

    '''
    user = DBSession.query(IuserUser).filter(IuserUser.id==145102).one()
    persona = get_persona_obj_for_user(user.id,ignore_match_status=True)
    invite = DBSession.query(QualtricsInvite).filter(
        and_(QualtricsInvite.persona_id==persona.id,
             QualtricsInvite.user_id==user.id,
             QualtricsInvite.survey_status.in_((QUALTRICS_INVITED,QUALTRICS_INCOMPLETE))
        ).order_by(QualtricsInvite.date_invited).first()
    x = _user_completed_survey(user,persona,invite)
    '''

    '''
    user = DBSession.query(IuserUser).filter(IuserUser.id==145408).one()
    x = add_user_to_qualtrics(user,user_id=None,panel_id=qid.panel_string,lib_id=qid.library_string,
        update=False, re_add=True)
    x = add_user_to_qualtrics(user,user_id=None,panel_id=qid.panel_string,lib_id=qid.library_string,update=True)

    x = replace_survey_distribution_id('SV_brpRoygXmUxuPml')
    link = gen_new_survey_link(user,'SV_brpRoygXmUxuPml',user,replace=True)
    '''

    '''
    print add_user_to_qualtrics(user)
    print _user_completed_survey(user,persona,user_survey)
    #print _get_imentor_survey_list()
    '''

