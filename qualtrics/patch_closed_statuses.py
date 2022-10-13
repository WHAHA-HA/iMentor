#!/bin/env python
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
    QUALTRICS_INVITED,QUALTRICS_INCOMPLETE,QUALTRICS_COMPLETE,
    QUALTRICS_INCOMPLETE_CLOSED,QUALTRICS_INVITED_CLOSED)
from email_crash_report import send_crash_report

from qualtrics_3rd_party import _api_call,FailedQualtricsAPICall,add_user_to_qualtrics

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def update_past_closed_resps(survey_obj):
    local_db_session = get_scoped_session()

    command='getLegacyResponseData'
    request_payload = {'SurveyID':survey_obj.survey_string}

    cumulative_persona_ids = []

    # No in-progress records here.
    in_progress = True
    for i in range(0,2):
        if in_progress:
            request_payload['ResponsesInProgress'] = 1
        else:
            request_payload['ResponsesInProgress'] = 0

        pprint.pprint(request_payload)
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
                #import pdb;pdb.set_trace()
                record = result[key]
                if record['ExternalDataReference'] not in ('',None): # could be a survey preview
                    all_persona_ids.append(record['ExternalDataReference'])
                    cumulative_persona_ids.append(record['ExternalDataReference'])
        else:
            completed_personas = []
            incomplete_personas = []
            for key in result.keys():
                #import pdb;pdb.set_trace()
                record = result[key]
                if 'Finished' in record:
                    print "Finished: {0}, persona:{1}".format(record['Finished'],record['ExternalDataReference'])
                    if record['Finished'] in ('0','8'):
                        if record['ExternalDataReference'] not in ('',None): # could be a survey preview
                            completed_personas.append(record['ExternalDataReference'])
                            cumulative_persona_ids.append(record['ExternalDataReference'])
                    elif record['Finished'] in ('1',):
                        if record['ExternalDataReference'] not in ('',None): # could be a survey preview

                            incomplete_personas.append(record['ExternalDataReference'])
                            cumulative_persona_ids.append(record['ExternalDataReference'])

            if incomplete_personas:
                local_db_session.query(QualtricsInvite).filter(
                    QualtricsInvite.survey_id==survey_obj.id).filter(
                    QualtricsInvite.persona_id.in_(incomplete_personas)).update(
                    {'survey_status':QUALTRICS_INCOMPLETE_CLOSED},synchronize_session='fetch')
                local_db_session.commit()
                local_db_session.begin()

            if completed_personas:
                local_db_session.query(QualtricsInvite).filter(
                    QualtricsInvite.survey_id==survey_obj.id).filter(
                    QualtricsInvite.persona_id.in_(completed_personas)).update(
                    {'survey_status':QUALTRICS_COMPLETE},synchronize_session='fetch')
                local_db_session.commit()
                local_db_session.begin()

        in_progress = False

    # After both runs, this is done. We have a record of every user which started or completed.
    # Make sure all others who were invited are not marked as completed.
    if cumulative_persona_ids:
        #import pdb;pdb.set_trace()

        # Correct test users accidentally marked as complete due to filling out survey from dev.
        # Testers are supposed to remove these users from the Qualtrics survey status,
        # so they aren't picked up here as completed. The problem is, this is a race
        # condition if the same user id has a legit survey invite in prod.
        # Make it match what we see in Qualtrics, always.
        # Cumulative persona ids have been taken care of.
        local_db_session.query(QualtricsInvite).filter(
            QualtricsInvite.survey_id==survey_obj.id).filter(
            QualtricsInvite.persona_id.notin_(cumulative_persona_ids)).update(
            {'survey_status':QUALTRICS_INVITED_CLOSED},synchronize_session='fetch')
        local_db_session.commit()
        local_db_session.begin()

    local_db_session.commit()

def check_history_invited_vs_incomplete():
    for survey in QualtricsSurvey.query.filter(
        QualtricsSurvey.survey_is_active==False).all():
        print "Doing {0}".format(survey.id)
        update_past_closed_resps(survey_obj=survey)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
if __name__ == '__main__':
    check_history_invited_vs_incomplete()
