#!/usr/bin/env python
# -*- coding: iso8859-15 -*-
import pdb
import pprint
import copy
import traceback
import os,sys
import pymongo
from datetime import datetime,timedelta
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import (Base,metadata,
    get_scoped_session,DBSession)

from sqlalchemy import or_
from legacy_models.iuser import IuserUser
from form_proc_and_notify import FormDataProcessing
from apiforms.models import FormCopy

if __name__ == "__main__":
    import pdb
    pdb.set_trace()
    local_db_session = get_scoped_session()
    blank_named_users = local_db_session.query(IuserUser).filter(
        or_(IuserUser.first_name == None,
            IuserUser.first_name == "")
        ).filter(IuserUser.status=='SI'
        ).all()
    for blank in blank_named_users:
        form = local_db_session.query(FormCopy).filter(
            FormCopy.user_id == blank.id).first()
        if form:
            FormDataProcessing().preprocess_fields(local_db_session,form)
    local_db_session.commit()

