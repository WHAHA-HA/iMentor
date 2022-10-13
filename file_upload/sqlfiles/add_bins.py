# -*- coding: iso8859-15 -*-
import os,sys
import re
import pdb
import errno
import pprint
import shutil
import traceback
from datetime import datetime
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'../..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import db,Base,metadata,get_scoped_session

#Import 'app' object from auth as well
from auth import api, app

from flask import  current_app, request, redirect, render_template

from sqlalchemy import (BigInteger, Boolean, Column, Date, DateTime,
    Float, ForeignKey, Index, Integer, Numeric, SmallInteger,
    String, Table, Text, Time, text, DATE, func, UniqueConstraint)
from sqlalchemy.dialects.postgresql.base import INET, TSVECTOR
from sqlalchemy.sql.expression import func, or_, not_, and_
from sqlalchemy.orm import relationship

from legacy_models.iuser import IuserUser

from config.settings import UPLOAD_FOLDER

from file_upload.models import (MAX_BINS, FileUploadAllowList,
    FileUploadUserBin,FileUploadLatestBinNum)

def one_time_add():

    local_db_session = get_scoped_session()
    latest_bin = local_db_session.query(FileUploadLatestBinNum).one()

    for i in os.listdir(UPLOAD_FOLDER):
        lpath = os.path.join(UPLOAD_FOLDER, i)
        if os.path.isdir(lpath):
            lbs = 'B{0:0>' + '{0}'.format(len(str(MAX_BINS))) + '}'
            latest_bin_str = lbs.format(latest_bin.latest_bin_num)

            # Bump this record. There is only one.
            # Don't use modulo here. We don't want 0.
            if latest_bin.latest_bin_num >= MAX_BINS:
                latest_bin.latest_bin_num = 1
            else:
                latest_bin.latest_bin_num += 1
            local_db_session.commit()
            local_db_session.begin()

            user_bin = FileUploadUserBin(
                user_id = int(i),
                bin_name = latest_bin_str
                )

            local_db_session.add(user_bin)
            local_db_session.commit()
            local_db_session.begin()

            newdir = os.path.join(UPLOAD_FOLDER,latest_bin_str)
            try:
                os.mkdir(newdir)
            except OSError, e:
                 # Don't care if folder already exists. Overwrite existing files.
                 if e.errno != errno.EEXIST:
                     raise e
                 pass

            shutil.move(lpath,newdir)
    
    local_db_session.commit()
            
if __name__ == "__main__":
    one_time_add()
