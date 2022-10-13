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
#file_list = drive.ListFile()
#fl = file_list.GetList()

#fl = drive.ListFile({'q': "'root' in parents and trashed=false"}).GetList()
fl = drive.ListFile({'q': 'trashed=false and title=\'Curriculum: User Copies 2015-16 DEV_Glorias_Awesome_Beast_laptop\''}).GetList()

for file1 in fl:
  print 'title: %s, id: %s, parent id: %s, embed link: %s, alternate link: %s' % (
    file1['title'], file1['id'], file1['parents'][0]['id'] if file1['parents'] else [], 
    file1['embedLink'] if 'embedLink' in file1 else None,
    file1['alternateLink'] if 'alternateLink' in file1 else None)
  #print 'title: %s, id: %s, %s' % (file1['title'], file1['id'], pprint.pformat(file1.__dict__))
