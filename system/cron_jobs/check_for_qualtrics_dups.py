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

from qualtrics.qualtrics_maintenance import (resolve_dups,
    update_from_qualtrics_to_persona_table,fix_active_links_for_changed_personas)

from qualtrics.models import QualtricsSurvey

# Fix duplicates and associated links.
# Not yet sure how dup adds even happen.
# Then fix active links where the person has changed: replace link panel id and persona id.
resolve_dups()
update_from_qualtrics_to_persona_table()
fix_active_links_for_changed_personas()
