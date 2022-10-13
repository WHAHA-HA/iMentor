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

from qualtrics import qualtrics # app name
from legacy_models.mailer import MailerMessage
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
    QUALTRICS_INVITED,QUALTRICS_INCOMPLETE,QUALTRICS_COMPLETE,
    QUALTRICS_INCOMPLETE_CLOSED,QUALTRICS_INVITED_CLOSED)
from email_crash_report import send_crash_report

breaks_email = set('!@#$%^&*()\\/"\'_-+=|')

class FailedQualtricsAPICall(Exception):
    pass

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def munge_email(email):
    # Munge perfectly legit email addresses which are rejected by Qualtrics.
    # They refuse to fix the bug, and completely ignore the RFC.
    if any((c in breaks_email) for c in email):
        return "KLUDGED.{0}@QUALTRICSISBROKEN.org".format(
            ''.join(random.SystemRandom().choice(string.ascii_uppercase + string.digits) for _ in range(10))
            )
    return email

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def _api_call(request_command, data={}):
    # External call to Qualtrics API
    headers = {'Content-Type': 'application/json','Accept': 'application/json'}

    data['API_SELECT']=QUALTRICS_API_SELECT
    data['Version']=QUALTRICS_API_VERSION
    data['Format']=QUALTRICS_API_FORMAT
    data['User']=QUALTRICS_USER
    data['Token']=QUALTRICS_TOKEN

    data['Request']=request_command

    resp = requests.post(QUALTRICS_URI, headers=headers, json=data)
    #app.logger.info("Status code:" , resp.status_code)
    #app.logger.info("Response:" , pprint.pformat(resp.__dict__))
    if resp.text not in (None,''):
        try:
            return json.loads(resp.text)
        except:
            app.logger.warning("Qualtrics API call failed. This happens so frequently that it's been reduced to a warning, so as not to crash our platform code. The call: {0}, the response: {1}".format(
            pprint.pformat(data),pprint.pformat(resp.__dict__)))

            #send_crash_report(resp.status_code,QUALTRICS_URI,resp.__dict__)

    if resp.status_code != 200:
        #send_crash_report(resp.status_code,QUALTRICS_URI,resp.__dict__)
        resp.raise_for_status()

    return resp.text


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def _get_imentor_survey_list():
    result = _api_call('getSurveys')
    if result['Meta']['Status'] == 'Success':
        return result['Result']['Surveys']
    else:
        raise FailedQualtricsAPICall('getSurveys call failed, crashing: {0}'.format(
            pprint.pformat(result)))


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def _get_imentor_panel_list(lib_id):
    # We're only using one panel ID system-wide, so this is obsolete.
    request_payload = {
        'LibraryID':lib_id
        }

    result = _api_call('getPanels',request_payload)
    if result['Meta']['Status'] == 'Success':
        return result['Result']
    else:
        raise FailedQualtricsAPICall('getPanels call failed, crashing: {0}'.format(
            pprint.pformat(result)))

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def _gen_survey_distribution_id(survey_id,panel_id,survey_desc,lib_id):
    request_payload = {
        'SurveyID':survey_id,
        'Description':survey_desc,
        'PanelLibraryID':lib_id,
        'PanelID':panel_id
        }

    result = _api_call('createDistribution',request_payload)
    if result['Meta']['Status'] == 'Success':
        return result['Result']['EmailDistributionID'][4:] # remove EMD_
    else:
        raise FailedQualtricsAPICall('createDistribution call failed, crashing: {0}'.format(
            pprint.pformat(result)))


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def auto_add_or_deactivate_surveys():

    local_db_session = get_scoped_session()
    '''
    This queries Qualtrics for surveys which haven't yet been added to our qualtrics_survey
    table, and meet these criteria:
    1: start date is required
    2: survey status must be 'active'
    3: The word "Mentor" or "Mentee" must be in the survey title (name) somewhere. 
       Uppper/lower case doesn't matter. 

    This will also mark surveys as inactive in our system if it finds inactive surveys.

    We use one universal panel and library, stored in one table.
    '''
    panel_lib_id = DBSession.query(QualtricsLibPanel).filter(QualtricsLibPanel.record_is_active==True).one()

    for survey in _get_imentor_survey_list():
        survey_record = DBSession.query(QualtricsSurvey).filter(QualtricsSurvey.survey_string==survey['SurveyID']).first()
        if survey_record:
            if survey['SurveyStatus']!='Active' and survey_record.survey_is_active==True:
                # Mark survey inactive. Mark all outstanding invitations incomplete.
                local_db_session.query(QualtricsSurvey).filter(QualtricsSurvey.id==survey_record.id).update(
                    {'survey_is_active':False})

                local_db_session.query(QualtricsInvite).filter(
                    QualtricsInvite.survey_id==survey_record.id).filter(
                    QualtricsInvite.survey_status==QUALTRICS_INVITED).update(
                        {'survey_status':QUALTRICS_INVITED_CLOSED})

                local_db_session.query(QualtricsInvite).filter(
                    QualtricsInvite.survey_id==survey_record.id).filter(
                    QualtricsInvite.survey_status==QUALTRICS_INCOMPLETE).update(
                        {'survey_status':QUALTRICS_INCOMPLETE_CLOSED})

            local_db_session.commit()
            local_db_session.begin()

        else: # new survey

            if ENV_TYPE == "Production":
                # Start date and active flag requred to activate a survey.
                # Also the word "Mentor" or "Mentee" is required in the survey name.
                if (survey['SurveyStatus'] == 'Active') and (survey['SurveyStartDate'][0] != '0'):
                    start_date = datetime.strptime(survey['SurveyStartDate'], "%Y-%m-%d %H:%M:%S").date()
                    end_date = datetime.strptime(survey['SurveyExpirationDate'], "%Y-%m-%d %H:%M:%S").date() \
                        if survey['SurveyExpirationDate'][0] != '0' else None

                    distrib_str = _gen_survey_distribution_id(
                        survey['SurveyID'],
                        panel_lib_id.panel_string,
                        survey['SurveyName'],
                        panel_lib_id.library_string)

                    # Avoid finding cases of the word "iMentor" in the name.
                    user_type = MENTEE if 'mentee' in survey['SurveyName'].lower() else MENTOR 
    
                    new_record = QualtricsSurvey(
                        description = survey['SurveyName'],
                        member_id = None, # all member sites by default. This can change.
                            library_string = panel_lib_id.library_string,
                        panel_string = panel_lib_id.panel_string,
                        distribution_string = distrib_str,
                        survey_string = survey['SurveyID'],
                        user_type = user_type,
                        start_date = start_date,
                        end_date = end_date,
                        survey_is_active = True
                        )
                    app.logger.info("new record: {0}".format(pprint.pformat(new_record.__dict__)))

                    local_db_session.add(new_record)

                local_db_session.commit()
                local_db_session.begin()

            else: # Not production
                # Don't require a start date for testing.
                # This allows surveys to be tested but not visible
                # in production just yet.
                # Surveys still need the Qualtrics Active flag to be turned off
                # to be closed.

                if (survey['SurveyStatus'] == 'Active'):
                    if  (survey['SurveyStartDate'][0] == '0'):
                        start_date = datetime.today()
                        end_date = (datetime.now() + timedelta(days=5)).date()
                    else:
                        start_date = datetime.strptime(survey['SurveyStartDate'], "%Y-%m-%d %H:%M:%S").date()
                        end_date = datetime.strptime(survey['SurveyExpirationDate'], "%Y-%m-%d %H:%M:%S").date() \
                            if survey['SurveyExpirationDate'][0] != '0' else None

                    distrib_str = _gen_survey_distribution_id(
                        survey['SurveyID'],
                        panel_lib_id.panel_string,
                        survey['SurveyName'],
                        panel_lib_id.library_string)
    
                    # Avoid finding cases of the word "iMentor" in the name.
                    user_type = MENTEE if 'mentee' in survey['SurveyName'].lower() else MENTOR 

                    new_record = QualtricsSurvey(
                        description = survey['SurveyName'],
                        member_id = None, # all member sites by default. This can change.
                        library_string = panel_lib_id.library_string,
                        panel_string = panel_lib_id.panel_string,
                        distribution_string = distrib_str,
                        survey_string = survey['SurveyID'],
                        user_type = user_type,
                        start_date = start_date,
                        end_date = end_date,
                        survey_is_active = True
                        )
                    app.logger.info("new record: {0}".format(pprint.pformat(new_record.__dict__)))
                    local_db_session.add(new_record)

                local_db_session.commit()
                local_db_session.begin()

    local_db_session.commit()

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def replace_survey_distribution_id(survey_string):
    '''
    This will come in handy if the invites need to be re-isssued for some reason,
    and you need to start over re: inviting users to an existing survey. 
    '''

    local_db_session = get_scoped_session()
    panel_lib_id = DBSession.query(QualtricsLibPanel).filter(QualtricsLibPanel.record_is_active==True).one()

    survey = DBSession.query(QualtricsSurvey).filter(QualtricsSurvey.survey_string==survey_string).one()
    old_dist_str = survey.distribution_string

    distrib_str = _gen_survey_distribution_id(
        survey.survey_string, panel_lib_id.panel_string, survey.description,
        panel_lib_id.library_string)

    local_db_session.query(QualtricsSurvey).filter(
        QualtricsSurvey.id==survey.id).update(
        {'distribution_string':distrib_str})

    local_db_session.commit()

    app.logger.warning("replace_survey_distribution_id(): replaced survey string from {0} to {1}".format(
        old_dist_str,distrib_str))


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def _user_completed_survey(local_db_session,user,persona,survey_invite):
    if not persona.qualtrics_panel_member_id:
        return False

    command='getRecipient'
    request_payload = {
        'RecipientID':persona.qualtrics_panel_member_id,
        'LibraryID':survey_invite.survey.library_string,
        }
    result = _api_call(command, request_payload)

    if not result or not result['Meta'] or not (result['Meta']['Status'] == 'Success'):
        #app.logger.exception('getRecipient call failed, crashing: {0}'.format(
        #    pprint.pformat(result)))
        return False

    # This may be null:
    if 'Result' not in result or 'Recipient' not in result['Result'] or \
        'RecipientResponseHistory' not in result['Result']['Recipient']:
        return False

    if result['Result']['Recipient']['RecipientResponseHistory']:
        for response in result['Result']['Recipient']['RecipientResponseHistory']:
            if 'SurveyID' in response:
                if response['SurveyID'] == survey_invite.survey.survey_string:
                    if response['FinishedSurvey'] == True:
                        local_db_session.query(QualtricsInvite).filter(
                            QualtricsInvite.id==survey_invite.id).update(
                            {'survey_status':QUALTRICS_COMPLETE})
                        local_db_session.commit()
                        local_db_session.begin()
                        app.logger.info("User {0} finished survey {1}".format(
                            user.id,survey_invite.survey.survey_string))
                        return True

    app.logger.info("User {0} did not finish survey {1}".format(
        user.id,survey_invite.survey.survey_string))
    return False

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def update_response_statuses(survey_string=None,survey_obj=None):
    local_db_session = get_scoped_session()

    command='getLegacyResponseData'
    if survey_string:
        request_payload = {'SurveyID':survey_string}
    else:
        request_payload = {'SurveyID':survey_obj.survey_string}

    cumulative_persona_ids = []

    if survey_string:
        surveys = DBSession.query(QualtricsSurvey).filter(
            QualtricsSurvey.survey_string==survey_string).all()
    else:
        surveys = [survey_obj]

    # Run this twice. Once for finished and once for in progress.
    in_progress = True
    for i in range(0,2):
        if in_progress:
            request_payload['ResponsesInProgress'] = 1
        else:
            request_payload['ResponsesInProgress'] = 0

        result = _api_call(command, request_payload)

        all_persona_ids = []
        if 'Meta' in result and 'Status' in result['Meta'] and result['Meta']['Status']=='Error':
            msg = "update_response_statuses(): survey query returned this error, skipping: {0}".format(
                pprint.pformat(result))
            app.logger.exception(msg)
            continue

        if not result:
            in_progress = False
            continue

        if in_progress:
            for key in result.keys():
                record = result[key]
                if record['ExternalDataReference'] not in ('',None): # could be a survey preview
                    all_persona_ids.append(record['ExternalDataReference'])
                    cumulative_persona_ids.append(record['ExternalDataReference'])
        else:
            for key in result.keys():
                record = result[key]
                if 'Finished' in record:
                    # Ignore: and data['Status'] in ["0","8"]:
                    if record['Finished'] not in ('0','8'):
                        if record['ExternalDataReference'] not in ('',None): # could be a survey preview
                            all_persona_ids.append(record['ExternalDataReference'])
                            cumulative_persona_ids.append(record['ExternalDataReference'])

        qid = DBSession.query(QualtricsLibPanel).filter(QualtricsLibPanel.record_is_active==True).one()

        for survey in surveys:
            if survey.panel_string != qid.panel_string:
                app.logger.exception("update_response_statuses(): the panel ID in your survey doesn't match the live panel ID in the qualtrics lib panel table. I hope this is OK! If you replace it, be sure to generate a new distribution ID for the survey. See the replace_survey_distribution_id() function. Survey: {0}, lib_panel table: {1}".format(survey.distribution_string,qid.distribution_string))
        
            if all_persona_ids:
                if in_progress:
                    local_db_session.query(QualtricsInvite).filter(
                        QualtricsInvite.survey_id==survey.id).filter(
                        QualtricsInvite.persona_id.in_(all_persona_ids)).update(
                        {'survey_status':QUALTRICS_INCOMPLETE},synchronize_session='fetch')
                    local_db_session.commit()
                    local_db_session.begin()

                else:
                    # Mark ones as complete.
                    local_db_session.query(QualtricsInvite).filter(
                        QualtricsInvite.survey_id==survey.id).filter(
                        QualtricsInvite.persona_id.in_(all_persona_ids)).update(
                        {'survey_status':QUALTRICS_COMPLETE},synchronize_session='fetch')
                    local_db_session.commit()
                    local_db_session.begin()

        in_progress = False

    # After both runs, this is done. We have a record of every user which started or completed.
    # Make sure all others who were invited are not marked as completed.
    if cumulative_persona_ids:
        for survey in surveys:
            # Correct test users accidentally marked as complete due to filling out survey from dev.
            # Testers are supposed to remove these users from the Qualtrics survey status,
            # so they aren't picked up here as completed. The problem is, this is a race
            # condition if the same user id has a legit survey invite in prod.
            # Make it match what we see in Qualtrics, always.
            # Cumulative persona ids have been taken care of.
            local_db_session.query(QualtricsInvite).filter(
                QualtricsInvite.survey_id==survey.id).filter(
                QualtricsInvite.survey_status==QUALTRICS_COMPLETE).filter(
                QualtricsInvite.persona_id.notin_(cumulative_persona_ids)).update(
                {'survey_status':QUALTRICS_INVITED},synchronize_session='fetch')
            local_db_session.commit()
            local_db_session.begin()

    local_db_session.commit()


    '''
    app.logger.info("update_response_statuses(): update personas {0} for survey {1} to completed.".format(
        pprint.pformat(all_persona_ids),survey.survey_string))
    '''

       
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_earliest_survey_link(user=None,persona=None,user_id=None,get_name=False):
    local_db_session = get_scoped_session()

    if not user:
        user = DBSession.query(IuserUser).filter(IuserUser.id==user_id).one()
        persona = get_persona_obj_for_user(user.id,ignore_match_status=True)
        if not persona:
            if get_name:
                return None,None
            return None

    # Gets earliest not-completed survey link for user.
    user_survey_invite = DBSession.query(QualtricsInvite).filter(
        and_(QualtricsInvite.persona_id==persona.id,
             QualtricsInvite.user_id==user.id,
             QualtricsInvite.survey_status.in_((QUALTRICS_INVITED,QUALTRICS_INCOMPLETE)))
        ).order_by(QualtricsInvite.date_invited).first()

    if not user_survey_invite:
        if get_name:
            return None,None
        return None

    finished = False
    try:
        finished = _user_completed_survey(local_db_session,
            user,persona,user_survey_invite)
    except:
        app.logger.exception("get_earliest_survey_link(): _user_completed_survey() call failed on the Qualtrics side. User {0} Persona {1} was sent the survey link from our database, and was not affected. Not crashing, just logging:{2}".format(user.id,persona.id,traceback.format_exc()))

    local_db_session.commit()

    if finished:
        if get_name:
            return None,None
        return None

    if get_name:
        survey = DBSession.query(QualtricsSurvey).filter(
            QualtricsSurvey.id==user_survey_invite.survey_id).one()

        return survey.description,'https://new.qualtrics.com/SE/?Q_DL=' + user_survey_invite.survey_link
        
    return 'https://new.qualtrics.com/SE/?Q_DL=' + user_survey_invite.survey_link


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def add_user_to_qualtrics(user=None,user_id=None,panel_id=None,lib_id=None,
    update=False, re_add=False):
    '''
    This makes a qualtrics call to either:
    (1) add a user to our default panel, creating a new panel ID for a user, or
    (2) update user info in our default panel.
    A panel ID is attached to their persona, and can be regenerated at any time.
    '''
    if ENV_TYPE != "Production":
        app.logger.info("add_user_to_qualtrics(): Not running on production, disabled. This is to prevent dev data from being injected into the production panel. To override, change this code.")
        return False,None
      
    local_db_session = get_scoped_session()

    if user_id:
        user = DBSession.query(IuserUser).filter(IuserUser.id==user_id).one()

    persona = get_persona_obj_for_user(user.id,ignore_match_status=True)

    if not persona:
        app.logger.warning("add_user_to_qualtrics(): User id {0} has no persona, skipping.".format(user.id))
        return False,None

    if persona.qualtrics_panel_member_id not in (None,'') and update == False and re_add == False:
        return True, persona.qualtrics_panel_member_id
    if persona.qualtrics_panel_member_id in (None,'') and (update == True or re_add == True):
        update = False
        re_add = False

    role = Role(user.id)
    partners = get_partners_for_user(user,role)
    partner = None
    if len(partners)==1:
        # Individuals only have one partner site, if any.
        # Admins have several, so don't use it in that case.
        partner = partners[0]

    mentee = get_latest_mentee_user_for_mentor(user.id) if role.is_mentor else None
    mentor = get_latest_mentor_user_for_mentee(user.id) if role.is_mentee else None

    mentor_fn = mentor.first_name if mentor else None
    mentee_fn = mentee.first_name if mentee else None

    match_start_date = None

    if role.is_mentee:
        match_start_date = get_latest_mentor_for_mentee(user.id)
    elif role.is_mentor:
        match_start_date = get_latest_mentee_for_mentor(user.id)

    if match_start_date:
        match_start_date = match_start_date.match_start_date

    pc = get_admin_for_user(user.id)
    colleges = [x.college.name for x in DBSession.query(CollegeChecklist).filter(
        CollegeChecklist.user_id==user.id).all()]
    
    request_payload = {
        'Email':munge_email(user.email),
        'FirstName':user.first_name,
        'LastName':user.last_name,
        'ExternalDataRef':str(persona.id)
        }

    qid = DBSession.query(QualtricsLibPanel).filter(QualtricsLibPanel.record_is_active==True).one()

    request_payload['PanelID']=qid.panel_string
    request_payload['LibraryID']=qid.library_string

    request_payload['ED'] = {}

    request_payload['ED']['firstname'] = user.first_name
    request_payload['ED']['lastname'] = user.last_name
    request_payload['ED']['email'] = user.email
    request_payload['ED']['gender'] = user.gender
    request_payload['ED']['userid'] = user.id
    request_payload['ED']['memberid'] = user.member_id
    request_payload['ED']['matchstatus'] = persona.match_status
    request_payload['ED']['match_start_date'] = str(match_start_date) if \
        match_start_date else None
    request_payload['ED']['status'] = user.status
    request_payload['ED']['school'] = partner.graduating_class.school if partner and partner.graduating_class else None
    request_payload['ED']['graduationyear'] = partner.graduating_class.graduating_class if partner and partner.graduating_class else None
    request_payload['ED']['partnername'] = partner.name if partner else None
    request_payload['ED']['programtype'] = partner.program_name if partner else None
    request_payload['ED']['personaid'] = persona.id
    request_payload['ED']['mentee_firstname'] = mentee_fn
    request_payload['ED']['mentor_firstname'] = mentor_fn
    request_payload['ED']['pc_firstname'] = pc[6] if pc else None
    request_payload['ED']['pc_lastname'] = pc[7] if pc else None
    request_payload['ED']['OOP'] = 'True' if user.meet_out_of_program else 'False'
    request_payload['ED']['colleges'] = colleges

    # Check for add vs. update. Command varies slightly.
    command = 'addRecipient'

    if persona.qualtrics_panel_member_id not in (None,''):
        if update:
            request_payload['RecipientID']=persona.qualtrics_panel_member_id
            command = 'updateRecipient'
        else:
            # Remove them first, so no dups happen.
            remove_command='removeRecipient'
            remove_payload = {
                'RecipientID': persona.qualtrics_panel_member_id,
                'PanelID': qid.panel_string,
                'LibraryID': qid.library_string
                }

            response = _api_call(remove_command, remove_payload)
            app.logger.info("Remove response: {0}".format(pprint.pformat(response)))

    response = _api_call(command, request_payload)

    if response['Meta']['Status'] == 'Success':
        if update == True:
            return True,persona.qualtrics_panel_member_id

        if response['Result']['RecipientID'] in ('',None):
            app.logger.exception("Qualtrics is returning empty user panel IDs upon add. Skipping user {0}, no crash: {1}".format(
                user.id,pprint.pformat(response)))
            return False,None

        persona.qualtrics_panel_member_id = response['Result']['RecipientID']

        local_db_session.query(IuserPersona).filter(IuserPersona.id==persona.id).update(
            {'qualtrics_panel_member_id':response['Result']['RecipientID']})
        local_db_session.commit()

        app.logger.info("Added/replaced user {0} in qualtrics panel {1}, library {2} their personal panel ID is {3}".format(
            user.id,request_payload['PanelID'],request_payload['LibraryID'],
            persona.qualtrics_panel_member_id))
        return True,persona.qualtrics_panel_member_id

    msg = "add_user_to_qualtrics(): User {0} persona {1} partner {2} role {3} had no Qualtrics panel ID. Tried to generate/update one, but failed. Skipping. Here's the failed result for {5}: {4}, user email: {6}".format(
        user.id,persona.id,partner.name if partner else None,role.role,pprint.pformat(response),command,user.email)
    # Warning, not an exception, so we don't get flooded with email errors.
    app.logger.warning(msg)

    local_db_session.commit()
    return False,response


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def gen_new_survey_link(local_db_session,user,survey_string,
    admin,replace=False):

    role = Role(user.id)
    persona = get_persona_obj_for_user(user.id,ignore_match_status=True)
    if not persona:
        return None

    panel_member_id = persona.qualtrics_panel_member_id

    if persona.qualtrics_panel_member_id in (None,''):
        result,panel_member_id = add_user_to_qualtrics(user)

        if not result:
            return None

    survey = DBSession.query(QualtricsSurvey).filter(
        QualtricsSurvey.survey_string == survey_string).filter(
        QualtricsSurvey.user_type == role.role).filter(
        or_(QualtricsSurvey.member_id == user.member_id,
            QualtricsSurvey.member_id == None)).first()

    if not survey:
        #app.logger.warning("gen_new_survey_link(): User {0} role {1} can't be invited to survey {2}, role or member id does not match.".format(
        #    user.id,role.role,survey_string))
        return None

    qid = DBSession.query(QualtricsLibPanel).filter(QualtricsLibPanel.record_is_active==True).one()

    if survey.panel_string != qid.panel_string:
        msg = "gen_new_survey_link(): the panel ID in your survey doesn't match the live panel ID in the qualtrics lib panel table. Not going to invite users. If you replace it, be sure to generate a new distribution ID for the survey. See the replace_survey_distribution_id() function. Survey: {0}, lib_panel table: {1}".format(survey.distribution_string,qid.distribution_string)
        raise Exception(msg)
        
    link = '{0}_{1}_{2}'.format(
        survey.distribution_string,
        survey.survey_string.replace('SV_', ''),
        panel_member_id
        )

    # Allow user to see same survey if their persona has changed (re-matched, moved, etc.)
    # This is done by replacing either the survey distribution ID or the user panel ID,
    # then regenerating a new link.
    invite = DBSession.query(QualtricsInvite).filter(
        QualtricsInvite.user_id==user.id).filter(
        QualtricsInvite.persona_id==persona.id).filter(
        QualtricsInvite.survey_id==survey.id).first()

    if invite:
        if replace == False:
            app.logger.info('gen_new_survey_link(): User {0} role {1} persona {2} already invited to survey {3}, skipping.'.format(
                user.id,role.role,persona.id,survey_string))

            # Already invited, see if it's been completed.
            try:
                _user_completed_survey(local_db_session,user,persona,invite)
            except:
                # Qualtrics will fail at this periodically, sadly.
                pass

            local_db_session.commit()
            local_db_session.begin()
            return None

        if link == invite.survey_link:
            app.logger.info("No need to udpate this link: it already matches. Invite ID: {0}, User: {1}, link {2} invite.survey_link: {3}".format(
                invite.user_id,invite.id,link,invite.survey_link))
            
            return 'https://new.qualtrics.com/SE/?Q_DL=' + link

        local_db_session.query(QualtricsInvite).filter(
            QualtricsInvite.id==invite.id).update(
            {'survey_link':link})

        local_db_session.commit()
        local_db_session.begin()

        return 'https://new.qualtrics.com/SE/?Q_DL=' + link
    
    # Add a new invitation record.
    invite = QualtricsInvite(
        user_id = user.id,
        persona_id = persona.id,
        invited_by_user_id = admin.id,
        survey_id = survey.id,
        survey_status = QUALTRICS_INVITED,
        survey_link = link
        )
    local_db_session.add(invite)
    local_db_session.commit()
    local_db_session.begin()

    return 'https://new.qualtrics.com/SE/?Q_DL=' + link


def manually_gen_survey_distribution_id(survey_id,survey_desc):
    panel_lib_id = DBSession.query(QualtricsLibPanel).filter(QualtricsLibPanel.record_is_active==True).one()
    distrib_str = _gen_survey_distribution_id(
        survey_id,
        panel_lib_id.panel_string,
        survey_desc,
        panel_lib_id.library_string)
    print distrib_str
    return distrib_str
