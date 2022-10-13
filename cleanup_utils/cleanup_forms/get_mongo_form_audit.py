# -*- coding: iso8859-15 -*-
import pdb
import pprint
import copy
import os,sys
import json
import pymongo
from datetime import datetime,timedelta
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'../..'))
nprojdir = os.path.abspath(os.path.join(appdir,'../../..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)
    sys.path.append(nprojdir)

from config.project_globals import DBSession,Base,metadata,get_scoped_session

from config.settings import (ENV_TYPE,LOGIN_DISABLED,
    DEFAULT_TEST_USER_ID,MONGO_HOST,MONGO_PORT,
    MONGO_DBNAME_DEBUG,MONGO_FORMS_DEBUG_COLLNAME)

mongo_connection = pymongo.mongo_client.MongoClient(MONGO_HOST,MONGO_PORT)
database = pymongo.database.Database(mongo_connection,MONGO_DBNAME_DEBUG)
forms_debug_coll = database[MONGO_FORMS_DEBUG_COLLNAME]

def get_audit_records():
    for i in forms_debug_coll.find({'logger.data.login_user_id':190698}):
        print i

if __name__ == "__main__":
    get_audit_records()
