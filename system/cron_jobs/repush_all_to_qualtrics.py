#!/usr/bin/env python
# -*- coding: iso8859-15 -*-
import copy
from datetime import datetime
import traceback
import httplib
import json
import math
import pdb
import pprint
import requests
import traceback
import time
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

from legacy_models.iuser import USER_STATUS_ACTIVE,IuserUser

#Import 'app' object from auth as well
from auth import api, app

from qualtrics.qualtrics_queue import QualtricsAddUpdateQueue

QAUQ = QualtricsAddUpdateQueue()

'''
Push users on to the Qualtrics update queue that runs continuously.
'''
def repush_all():
    userlist = [x.id for x in DBSession.query(IuserUser).filter(
        IuserUser.status==USER_STATUS_ACTIVE).order_by(IuserUser.id).all()]

    for u in userlist:
        QAUQ.push(u)

if __name__ == '__main__':
    repush_all()
