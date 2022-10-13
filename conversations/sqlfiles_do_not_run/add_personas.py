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
from conversations.models import Conversation

def conv_update():
    local_db_session = get_scoped_session()
    for c in local_db_session.query(Conversation).all():
        print "Doing {0}".format(c.id)
        local_db_session.query(Conversation).filter(Conversation.id==c.id).update(
            {'persona_id':get_persona_obj_for_user(c.user_id,ignore_match_status=True).id,
             'recipient_persona_id':get_persona_obj_for_user(c.recipient_user_id,ignore_match_status=True).id})

    local_db_session.commit()
        
if __name__ == "__main__":
    conv_update()
