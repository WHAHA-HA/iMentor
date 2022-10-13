# -*- coding: iso8859-15 -*-
import pdb
import pprint
import copy
import os,sys
import errno
import shutil
import random
import string
import re
from mimetypes import MimeTypes
from datetime import datetime
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import (Base,metadata,url_cache,
    DBSession,get_scoped_session)
from config.settings import (ENV_TYPE,LOGIN_DISABLED,
    DEFAULT_TEST_USER_ID,UPLOAD_FOLDER,LEGACY_UPLOAD_FOLDER,
    RELATIVE_LEGACY_UPLOAD_FOLDER,SERVER_RELATIVE_LEGACY_UPLOAD_FOLDER,
    MAX_URL_CACHE_SECONDS)

from werkzeug import secure_filename
from flask import Response, json, jsonify, make_response, url_for, abort, send_from_directory
from flask import  current_app, request, redirect, render_template
from flask.views import View, MethodView

from flask_login import (current_user,
                             login_user, logout_user, UserMixin,
                             confirm_login, fresh_login_required)
from flask_restful import Resource, Api, fields, marshal_with

#Import 'app' object from auth as well
from auth import api, app, login_required

from legacy_models.iuser import IuserUser
from utils.authz import check_authz
from utils.roles import Role
from utils.user_details import get_latest_mentee_for_mentor, get_latest_mentor_for_mentee
from models import (FileUploadUserBin,FileUploadAllowList,
    FileUploadLatestBinNum,MAX_BINS)

mime = MimeTypes()

# Notice that this is dynamic, based on project directory name!!!
if 'mobile' in projdir:
    BASE_URL = "/muser_content"
else:
    BASE_URL = "/user_content"


class UploadUnauth(Exception):
    pass

class DownloadUnauth(Exception):
    pass

class FileBinError(Exception):
    pass

# user_id is only set if admin is uploading on behalf of someone else.
@app.route('{0}/'.format(BASE_URL), methods=['POST'])
@app.route('{0}/<int:user_id>/'.format(BASE_URL), methods=['POST'])
@login_required
def upload_file(user_id=None,profile_image=None):
    from flask_login import current_user
    base64encoded = False
    if LOGIN_DISABLED:
        current_user = DBSession.query(IuserUser).filter(
            IuserUser.id==DEFAULT_TEST_USER_ID).one()

    allow_list = tuple(x.file_extension for x in DBSession.query(FileUploadAllowList).all())

    if request.method == 'POST':
        if user_id:
            orig_email = current_user.email
            current_user = check_authz(current_user,user_id)
            if not current_user:
                raise UploadUnauth("User {0} is not authorized to do file upload on behalf of this user: {1}.".format(orig_email,user_id))

        # Form POST or json POST
        if hasattr(request,'files') and 'file' in request.files:
            lfile = request.files['file']
            filename = secure_filename(os.path.basename(lfile.filename))
        else:
            base64encoded = True
            lfile = request.json['data']
            if 'uri' in lfile:
                
                lfile = lfile['uri']
                lindex = lfile.find(',/') # strip off excess chars
                lfile = lfile[lindex+1:].decode('base64')
                #print lfile
            filename = request.json['filename']
            filename = secure_filename(os.path.basename(filename))


        if not filename.lower().endswith(allow_list):
            raise UploadUnauth("File type not allowed: {0}, user {1}.".format(filename,current_user.email))

        if profile_image and not filename.lower().endswith(('jpg','jpeg','tiff','png','gif')):
            raise UploadUnauth("File type not allowed for profile pictures. Must be jpg,jpeg,tiff,png,gif: {0}, user {1}.".format(filename,current_user.email))

        local_db_session = get_scoped_session()

        # File path = UPLOAD_FOLDER + '/B' + zero-padded bin number + '/' + user id
        # Bin number is hidden from the outside world. It's primary use is to 
        # avoid the max inode limit for too many dirs in a directory. But it also
        # adds a nice layer of obscurity.
        user_bin = local_db_session.query(FileUploadUserBin).filter(
            FileUploadUserBin.user_id==current_user.id).first()

        if not user_bin:
            latest_bin = local_db_session.query(FileUploadLatestBinNum)
            if latest_bin.count() > 1:
                raise FileBinError("There's more than one record in FileUploadLatestBinNum, crashing!")

            latest_bin_num = latest_bin.one().latest_bin_num

            # Zero padded str
            lbs = 'B{0:0>' + '{0}'.format(len(str(MAX_BINS))) + '}'
            latest_bin_str = lbs.format(latest_bin_num)

            # Bump this record. There is only one.
            # There is a slim chance of a race condition, but this isn't harmful.
            # It's just a directory name in this case.
            if latest_bin_num >= MAX_BINS:
                local_db_session.query(FileUploadLatestBinNum).update({
                    'latest_bin_num': 1})
            else:
                local_db_session.query(FileUploadLatestBinNum).update({
                    'latest_bin_num': latest_bin_num + 1})

            local_db_session.commit()
            local_db_session.begin()

            user_bin = FileUploadUserBin(
                user_id = current_user.id,
                bin_name = latest_bin_str
                )

            local_db_session.add(user_bin)
            local_db_session.commit()
            local_db_session.begin()
                
        try:
            os.makedirs(UPLOAD_FOLDER + '/' + user_bin.bin_name + '/' + str(current_user.id))
        except OSError, e:
            # Don't care if folder already exists. Reuse it.
            if e.errno != errno.EEXIST:
                raise e
            pass

        if base64encoded:
            newfile=open(os.path.join(UPLOAD_FOLDER + '/' + user_bin.bin_name + '/' + str(current_user.id), filename),'wb')
            newfile.write(lfile)
            newfile.close()
        else:
            lfile.save(os.path.join(UPLOAD_FOLDER + '/' + user_bin.bin_name + '/' + str(current_user.id), filename))

        '''
        If user updated their profile image, copy it to the legacy profile pic area,
        update the DB.
        Make sure the destination file name is unique, since all user files go in one directory
        in legacy. Yech.
        '''
        if profile_image:
            file_ext = filename.split('.')
            new_name = file_ext[0] + '_' + ''.join(random.choice(string.ascii_lowercase + string.digits) for _ in range(10)) + '.' + file_ext[1]
            shutil.copyfile(
                os.path.join(UPLOAD_FOLDER + '/' + user_bin.bin_name + '/' + str(current_user.id), filename),
                os.path.join(LEGACY_UPLOAD_FOLDER + '/' + new_name)
                )
            #print LEGACY_UPLOAD_FOLDER + '/' + new_name

            local_db_session.query(IuserUser).filter(IuserUser.id==current_user.id).update(
                {'photo':SERVER_RELATIVE_LEGACY_UPLOAD_FOLDER + '/' + new_name})

        # Don't reveal bin to the outside world. GET happens below.
        url = '{0}/{1}/{2}'.format(BASE_URL,current_user.id,filename)

        local_db_session.commit()

        return jsonify({'url': url})


@app.route('{0}/profile_image/'.format(BASE_URL), methods=['POST'])
@app.route('{0}/profile_image/<int:user_id>/'.format(BASE_URL), methods=['POST'])
@login_required
def upload_profile_file(user_id=None):
    return upload_file(user_id=user_id,profile_image=True)


# Admin rules/matching rules apply if requesting another user's files.
# Note that user_id is part of the path when requesting files.
@app.route('{0}/<path:relpath>'.format(BASE_URL), methods=['GET','DELETE'])
@login_required
def download_file(relpath,base64=False,profile_pic=False,user_id=None):
    from flask_login import current_user
    if LOGIN_DISABLED:
        current_user = DBSession.query(IuserUser).filter(
            IuserUser.id==DEFAULT_TEST_USER_ID).one()

    obo_user_id = None
    if relpath: # This is null if we're getting profile pics.
        obo_user_id = relpath.split('/')[0]
        if obo_user_id.isdigit():
            obo_user_id = int(obo_user_id)
        else:
            obo_user_id = current_user.id
    elif user_id:
        obo_user_id = user_id

    local_db_session = get_scoped_session()

    # Matching mentor/mentee, admin, or self must match to get to user files.
    # We only look in the user's bin for the specified pic. So for OBO,
    # we must become that user.
    if obo_user_id and obo_user_id != current_user.id:
        holduser = current_user

        user_role = Role(current_user.id)
        if not user_role.is_matching_mentor_mentee(obo_user_id):
            current_user = check_authz(current_user,obo_user_id,log_error=False)
            if not current_user:
                # Only for download: mentee/mentor is allowed to download images uploaded by their admin(s).
                if Role(obo_user_id).is_some_admin_for_site_id(holduser.member.id):
                    current_user = local_db_session.query(IuserUser).filter(IuserUser.id==obo_user_id).first()
                    if not current_user:
                        local_db_session.commit()
                        raise DownloadUnauth("User {0} is not authorized to get files uploaded by this user: {1}.".format(holduser.id,obo_user_id))
        else:
            # Become that user, to get the proper bin id.
            current_user = user_role.get_matching_mentor_mentee()
            if not current_user:
                # Only for download: mentee/mentor is allowed to download images uploaded by their admin(s).
                if Role(obo_user_id).is_some_admin_for_site_id(holduser.member.id):
                    current_user = local_db_session.query(IuserUser).filter(IuserUser.id==obo_user_id).first()
                    if not current_user:
                        local_db_session.commit()
                        raise DownloadUnauth("User {0} is not authorized to get files uploaded by this user: {1}.".format(holduser.id,obo_user_id))

    if profile_pic:
        pic = current_user.photo
        #print pic
        relpic = re.sub(SERVER_RELATIVE_LEGACY_UPLOAD_FOLDER + '/','',pic)
        #print relpic
        pic = LEGACY_UPLOAD_FOLDER + '/' + relpic
        #print pic

    else:
        user_bin = local_db_session.query(FileUploadUserBin).filter(
            FileUploadUserBin.user_id==current_user.id).first()

        if not user_bin:
            local_db_session.commit()
            abort(404) # Not found

    # Add the user's bin name, which is not visible to the outside world.
    if request.method == 'GET':
        local_db_session.commit()
        if base64:
            if profile_pic:
                f = open(pic, 'rb')
            else:
                f = open(UPLOAD_FOLDER + '/' + user_bin.bin_name + '/' + relpath, 'rb')

            encoded = f.read().encode('base64')
            f.close()
            return jsonify({'file':encoded,'file_name':relpath})
        else:
            if profile_pic:
                return send_from_directory(LEGACY_UPLOAD_FOLDER,relpic)
            else:
                return send_from_directory(UPLOAD_FOLDER + '/' + user_bin.bin_name,relpath)

    elif request.method == 'DELETE':
        local_db_session.commit()
        if profile_pic:
            abort(403) # Not allowed to delete profile pics.

        return os.remove(UPLOAD_FOLDER + '/' + user_bin.bin_name + '/' + relpath)


# Admin rules/matching rules apply if requesting another user's files.
# Note that user_id is part of the path when requesting files.
@app.route('{0}/base64/<path:relpath>/'.format(BASE_URL), methods=['GET','DELETE'])
def base64_download_file(relpath):
    return download_file(relpath,base64=True)

# Admin rules/matching rules apply if requesting another user's files.
# Note that user_id is part of the path when requesting files.
@app.route('{0}/base64/profile_pic/'.format(BASE_URL), methods=['GET'])
def base64_download_profile_pic():
    return download_file(relpath=None,base64=True,profile_pic=True)

