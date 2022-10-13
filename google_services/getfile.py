#!/bin/env python
# -*- coding: iso8859-15 -*-
import os,sys
import pprint
from httplib2 import Http
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import db,GDRIVE_AUTH_JSON

from google_services import gauth
from pydrive.drive import GoogleDrive

drive = GoogleDrive(gauth)

drive.auth.settings['save_credentials']=True
drive.auth.settings['client_config_file']=GDRIVE_AUTH_JSON
file_list = drive.ListFile()
fl = file_list.GetList()

pprint.pprint([x for x in fl if x['id'] == sys.argv[1]][0])
