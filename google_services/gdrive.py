# -*- coding: iso8859-15 -*-
import os,sys
import pprint
import traceback
import re
import time
import mimetypes
from httplib2 import Http
from datetime import datetime
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.settings import GDRIVE_AUTH_JSON
from config.project_globals import ENV_TYPE

from google_services import gauth, gdrive_service
from pydrive.drive import GoogleDrive
from googleapiclient.errors import HttpError

#Import 'app' object from auth as well
from auth import api, app

# These directory (folder) are here because they should never change. 
MCCOPY_PATTERN='Curriculum: User Copies {0}-{1} {2}'
MCGRADE_PATTERN='Grade {0} Copies'
MCUNIT_PATTERN='Unit {0} Copies'
MCLESSON_PATTERN='Lesson {0} Copies'

class TooManyMatchesException(Exception):
    pass

class InvalidPatternException(Exception):
    pass

class NotFoundException(Exception):
    pass

class GoogleDriveObj(object):

    def __init__(self):
        self.drive = GoogleDrive(gauth)
        self.drive.auth.settings['save_credentials']=True
        self.drive.auth.settings['client_config_file']=GDRIVE_AUTH_JSON

    def get_file_or_dir(self,name,parent=None,reuse_list=None):
        # If no parent is passed, all folders will be searched.
        if reuse_list:
            curr_list = reuse_list
        else:
            start_time = datetime.now()
            curr_list = self.drive.ListFile({'q': "trashed=false"}).GetList()

            tdelta = datetime.now() - start_time
            print "GDRIVE: File list took {0} seconds".format(tdelta.seconds)

        if parent:
            orig = [x for x in curr_list
                if x['title'] == name and parent['id'] == x['parents'][0]['id']]
        else:
            orig = [x for x in curr_list if x['title'] == name]

        if len(orig) > 1:
            raise TooManyMatchesException("get_file_or_dir(): Too many matches for GDrive file copy of file or dir {0}, skipping.".format(name))

        if reuse_list:
            return orig[0] if orig else None,reuse_list
        else:
            return orig[0] if orig else None,curr_list


    def download(self,filename,parent,reuse_list=None):
        # This uses the dowload link mime type to figure out the local file extension.
        orig_file,x = self.get_file_or_dir(filename,parent,reuse_list)
        file_ext = orig_file['exportLinks'].keys()[0].split('/')[1]
        local_orig_file = self.drive.CreateFile({'id': orig_file['id']})
        local_orig_file.GetContentFile('tmp_%s.%s' % (orig_file['title'],file_ext),mimetype=orig_file['exportLinks'].keys()[0])


    def newdir(self,dirname,parent={'id':'root'},reuse_list=None):
        # Make sure root dir names are absolute: no dups anywhere.
        # ('root' is not the actual parent id for root files, so it won't match).
        if parent['id'] == 'root':
            new_folder,whole_list = self.get_file_or_dir(dirname,parent=None,reuse_list=reuse_list)
        else:
            new_folder,whole_list = self.get_file_or_dir(dirname,parent,reuse_list)

        if new_folder:
            print "GDRIVE: Found folder {0} {1}".format(new_folder['id'],new_folder['title'])

        else:
            start_time = datetime.now()

            new_folder = self.drive.CreateFile({'title': dirname})
            new_folder['parents'] = [parent]
            new_folder['mimeType'] = "application/vnd.google-apps.folder"
            new_folder.Upload()
            gdrive_service.permissions().insert(
                fileId=new_folder['id'], body={'type':'anyone','withLink':True,'role':'writer'}).execute()

            tdelta = datetime.now() - start_time
            print "GDRIVE: Created new folder {0} {1}, command took this many seconds: {2}".format(new_folder['id'],new_folder['title'],tdelta.seconds)

        return new_folder,whole_list


    def copy_file(self,orig_file,yyyy,yy,grade,unit,lesson,dir_id,for_user_id):

        title_text = orig_file['title'].split(str(yyyy))[0]

        new_title = title_text + ' {0}-{1} Grade {2} Unit {3} Lesson {4} User ID {5} {6}'.format(
            yyyy,yy,str(grade).zfill(2),str(unit).zfill(2),
            str(lesson).zfill(2),for_user_id,datetime.now())

        start_time = datetime.now()
        # File name must contain this pattern: Mentor Poster 2015-16 Grade 11 Unit 1 Lesson 1
        new_file_dict = gdrive_service.files().copy(fileId=orig_file['id'], 
            body={'parents':[{'id':dir_id}],'title': new_title}).execute()

        tdelta = datetime.now() - start_time
        print "GDRIVE: Copied {0} to {1} for user {2}, command took this many seconds:{3}".format(
            orig_file['title'],new_title,for_user_id,tdelta.seconds)

        start_time = datetime.now()

        result = gdrive_service.permissions().insert(
            fileId=new_file_dict['id'], body={'type':'anyone','withLink':True,'role':'writer'}).execute()

        tdelta = datetime.now() - start_time
        print "GDRIVE: Changed permissions of {0} to editable by anyone with link. Command took this many seconds: {1}".format(new_title,tdelta.seconds)


        return new_file_dict


def create_default_dirs():
    # Do this upon startup, so user function call isn't doing this.
    year = datetime.now().year - 1
    last_digits = (year % 1000) + 1

    gdo = GoogleDriveObj()

    for i in range(1,4):
        new_folder1,x = gdo.newdir(MCCOPY_PATTERN.format(year,last_digits,ENV_TYPE))
        year += 1
        last_digits += 1
        for grade in [9,10,11,12]:
            new_folder2,x = gdo.newdir(MCGRADE_PATTERN.format(str(grade).zfill(2)),parent={'id':new_folder1['id']})
            for unit in range(1,21):
                new_folder3,x = gdo.newdir(MCUNIT_PATTERN.format(str(unit).zfill(2)),parent={'id':new_folder2['id']})
                for lesson in range(1,21):
                    new_folder4,x = gdo.newdir(MCLESSON_PATTERN.format(str(lesson).zfill(2)),parent={'id':new_folder3['id']})

def create_gdoc_copy(for_user_id,doc_id):

    def retry_fn(for_user_id,doc_id):
        gdo = GoogleDriveObj()
    
        # Find original file metadata by ID.
        doc_meta = gdrive_service.files().get(fileId=doc_id).execute()
    
        if not doc_meta:
            raise NotFoundException("Document can't be found by ID {0}, skipping.".format(doc_list))
    
        pattern = re.search('(\d{4})-(\d{2}) Grade (\d+) Unit (\d+) Lesson (\d+)',doc_meta['title'])
        if not pattern or pattern.groups() == 0:
            raise InvalidPatternException("The file name and ID we tried to copy: {0}, {1}  doesn't match the required pattern of something like this: 2014-15 Grade N Unit M Lesson R . Crashing for user ID {2}!".format(
                doc_meta['title'],doc_id,for_user_id))
    
        yyyy = pattern.group(1)
        yy = pattern.group(2)
        grade = pattern.group(3)
        unit = pattern.group(4)
        lesson = pattern.group(5)
    
        # Quicker search if we only query dirs.
    
        # Make sure folders exist. The should pre-exist.
        root_folder = MCCOPY_PATTERN.format(yyyy,yy,ENV_TYPE)
        dir1 = gdo.drive.ListFile({'q': "trashed=false and title='{0}'".format(root_folder)}).GetList()
        if not dir1:
            dir1,list1 = gdo.newdir(root_folder,parent={'id':'root'})
        else:
           dir1 = dir1[0]
    
        folder2 = MCGRADE_PATTERN.format(str(grade).zfill(2))
        dir2 = gdo.drive.ListFile({'q': "trashed=false and title='{0}'".format(folder2)}).GetList()
        if not dir2:
            dir2,list2 = gdo.newdir(folder2,parent={'id':dir1['id']})
        else:
           dir2 = dir2[0]
    
        folder3 = MCUNIT_PATTERN.format(str(unit).zfill(2))
        dir3 = gdo.drive.ListFile({'q': "trashed=false and title='{0}'".format(folder3)}).GetList()
        if not dir3:
            dir3,list3 = gdo.newdir(folder3,parent={'id':dir2['id']})
        else:
           dir3 = dir3[0]
    
    
        folder4 = MCLESSON_PATTERN.format(str(lesson).zfill(2))
        dir4 = gdo.drive.ListFile({'q': "trashed=false and title='{0}'".format(folder4)}).GetList()
        if not dir4:
            dir4,list4 = gdo.newdir(folder4,parent={'id':dir3['id']})
        else:
           dir4 = dir4[0]
                
        new_file = gdo.copy_file(doc_meta,yyyy,yy,grade,unit,lesson,dir4['id'],for_user_id)
        return new_file
    
    counter = 10
    while counter > 0:
        try:
            return retry_fn(for_user_id,doc_id)
        except HttpError, err:
            if err.resp.status in [403, 500, 503]:
                app.logger.warning("create_gdoc_copy(): Hit a network failure when trying to create doc id {0} for user id {1}. Sleeping, then retrying: {2}".format(
                    doc_id,for_user_id,traceback.format_exc()))
                time.sleep(5)
                counter -= 1
            else:
                raise

    app.logger.exception("create_gdoc_copy(): Hit a network failure 10 times when trying to create doc id {0} for user id {1}. Giving up! {2}".format(
        doc_id,for_user_id,traceback.format_exc()))
    
if __name__ == "__main__":
    # Run this manuallly before using these directories, to avoid a race condition.
    import pdb
    pdb.set_trace()
    create_default_dirs()
