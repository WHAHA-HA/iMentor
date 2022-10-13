# -*- coding: iso8859-15 -*-
import pdb
import pprint
import copy
import os,sys
import pymongo
from dateutil import tz
from datetime import datetime
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'../..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import get_scoped_session,Base,metadata,DBSession
from utils.user_details import get_persona_obj_for_user

#Import 'app' object from auth as well
from auth import api, app, login_required

from legacy_models.iuser import IuserUser,IuserPersona
from sms_notifications.models import SMSInvalidResponse

def change_invalid_table():
    local_db_session = get_scoped_session()
    for c in DBSession.query(SMSInvalidResponse).all():
        print c.id
        c.user_id = c.message.recipient_id
        c.from_phone = c.message.from_phone

    local_db_session.commit()
        
if __name__ == "__main__":
    import pdb;pdb.set_trace()
    change_invalid_table()
