# -*- coding: iso8859-15 -*-

import os, sys
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)
import json
import csv
import requests
from requests.auth import HTTPBasicAuth
from config.settings import SALESFORCE_CONSUMER_KEY, SALESFORCE_USERNAME, SALESFORCE_PASSWORD, SALESFORCE_TOKEN, SALESFORCE_REDIRECTURI, SALESFORCE_BASE_URL 


consumer_key = SALESFORCE_CONSUMER_KEY
username = SALESFORCE_USERNAME
password = SALESFORCE_PASSWORD
token = SALESFORCE_TOKEN
callback_url = SALESFORCE_REDIRECTURI
base_url = SALESFORCE_BASE_URL

resource = "memtor_application"

#let's say our goal is to do ""SELECT match_status FROM iuser_persona WHERE id = 74623""

r = requests.get(base_url, auth = HTTPBasicAuth(username, password))









