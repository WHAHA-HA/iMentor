# -*- coding: iso8859-15 -*-
import os,sys
from httplib2 import Http
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import db

import googlemaps

from apiclient.discovery import build
from pydrive.auth import GoogleAuth
from oauth2client.service_account import ServiceAccountCredentials

from config.settings import (GDRIVE_AUTH_EMAIL,GDRIVE_AUTH_PKEY,
    GDRIVE_OBO_EMAIL,GDRIVE_AUTH_JSON,GOOGLE_API_KEY)

credentials = ServiceAccountCredentials.from_p12_keyfile(GDRIVE_AUTH_EMAIL, 
    GDRIVE_AUTH_PKEY, scopes=['https://www.googleapis.com/auth/drive'])

credentials = credentials.create_delegated(GDRIVE_OBO_EMAIL)

http = credentials.authorize(Http())

'''
from apiclient.discovery import build
x = build('drive', 'v2', http=http)
print x
'''

gauth = GoogleAuth()
gauth.credentials = credentials

# Sometimes we need direct access to the service.
gdrive_service = build('drive', 'v2', http=http)

