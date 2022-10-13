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

def seq_add():
    local_db_session = get_scoped_session()
    user_seq = 0
    last_c = None
    for c in DBSession.query(Conversation).order_by(Conversation.recipient_user_id,Conversation.received_by_server).all():
        if last_c:
            local_db_session.query(Conversation).filter(
                Conversation.id == last_c.id).update({
                'sequence' : user_seq})
            local_db_session.commit()
            local_db_session.begin()

        if last_c and c.recipient_user_id != last_c.recipient_user_id:
            user_seq = 1

        else:
            user_seq += 1

        print "Doing {0}, seq {1} user {2}".format(c.id,user_seq,c.recipient_user_id)
        last_c = c

    local_db_session.commit()
        
if __name__ == "__main__":
    import pdb;pdb.set_trace()
    seq_add()
