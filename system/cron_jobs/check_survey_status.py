#!/usr/bin/env python
# -*- coding: iso8859-15 -*-
import copy
from datetime import datetime
import httplib
import json
import math
import pdb
import pprint
import requests
import traceback
import os,sys

from sqlalchemy.sql.expression import func, or_, not_, and_

appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'../..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import db,Base,metadata,DBSession
from config.settings import (ENV_TYPE,LOGIN_DISABLED,
    DEFAULT_TEST_USER_ID,EMAIL_HOST_USER,QUALTRICS_URI,
    QUALTRICS_USER,QUALTRICS_TOKEN,QUALTRICS_API_SELECT,
    QUALTRICS_API_FORMAT,QUALTRICS_API_VERSION)


#Import 'app' object from auth as well
from auth import api, app

from qualtrics.qualtrics_3rd_party import (update_response_statuses,
    auto_add_or_deactivate_surveys)
from qualtrics.models import QualtricsSurvey

# First pull in newly activated surveys, or close new deactivated ones.
auto_add_or_deactivate_surveys()

# Then update status values on activated surveys.
for survey in QualtricsSurvey.query.filter(
    QualtricsSurvey.survey_is_active==True).all():
    update_response_statuses(survey_obj=survey)

