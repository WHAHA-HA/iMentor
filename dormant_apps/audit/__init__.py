# -*- coding: iso8859-15 -*-
import os,sys
import pprint
import pymongo
from datetime import datetime
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.settings import (ENV_TYPE,LOGIN_DISABLED,
    DEFAULT_TEST_USER_ID,MONGO_HOST,MONGO_PORT,
    MONGO_DBNAME_AUDIT_TRAIL,MONGO_AUDIT_TRAIL_COLLNAME)

from legacy_models.iuser import IuserUser

mongo_connection = pymongo.mongo_client.MongoClient(MONGO_HOST,MONGO_PORT)
database = pymongo.database.Database(mongo_connection,MONGO_DBNAME_AUDIT_TRAIL)
audit_coll = database[MONGO_AUDIT_TRAIL_COLLNAME]

DATA_REMOVE=1
DATA_ADD   =2
DATA_NOCHG =3
DATA_ERROR =4
ACTIONS = [DATA_REMOVE,DATA_ADD,DATA_NOCHG,DATA_ERROR]

APPLICATION_DATA=1
FORM_DATA       =2
DATA_SOURCES = [APPLICATION_DATA,FORM_DATA]

class BadAuditDataError(Exception):
    pass

def audit_trail(
    by_user_id,for_user_id,action,data_source,table,message,additional_data=None
    ):

    #if ENV_TYPE != "Production":
    #    return

    if action not in ACTIONS:
        raise BadAuditDataError("Unrecognized action {0}".format(action))
    
    if data_source not in DATA_SOURCES:
        raise BadAuditDataError("Unrecognized data source {0}".format(data_source))

    audit_coll.insert({
        'datestamp':datetime.utcnow(),'by_user':by_user_id,
        'for_user':for_user_id,'action':action,'data_source':data_source,
        'table':table,'message':message,'addtl':additional_data
        })

    audit_coll.create_index([("datestamp", pymongo.ASCENDING),
                             ("table", pymongo.ASCENDING)],
                             background=True)
