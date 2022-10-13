#!/usr/bin/env python
# -*- coding: iso8859-15 -*-
import copy
from datetime import datetime
import httplib
import pdb
import pprint
import os,sys
import pymongo
import traceback
import time
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import Base,metadata,DBSession
from config.settings import (MONGO_HOST,MONGO_PORT,
    MONGO_DBNAME_QUALTRICS,MONGO_QUALTRICS_ADDUPDATE_COLLNAME)

from auth import api, app, login_required

from qualtrics_utils import add_user_to_qualtrics

mongo_connection = pymongo.mongo_client.MongoClient(MONGO_HOST,MONGO_PORT)
database = pymongo.database.Database(mongo_connection,MONGO_DBNAME_QUALTRICS)
qualtrics_addup_coll = database[MONGO_QUALTRICS_ADDUPDATE_COLLNAME]

class QualtricsAddUpdateQueue(object):
    last_failed = None

    def pop(self):
        user_id = None
        user = qualtrics_addup_coll.find_one_and_delete({})
        try:
            # expecting: {'user_id': nnnn}
            if user:
               user_id = user['user_id']
               app.logger.info('Qualtrics queue pop: popped and updating user {0}'.format(user_id))
               result,q_response = add_user_to_qualtrics(
                   user_id=user_id, update=True) 

               # If no result and no qualtrics response, it's our error,
               # skip this user. Otherwise reprocess.
               if not result and q_response:
                   if user_id != self.last_failed:
                       self.last_failed = user_id
                       # Push dictionary back on the queue.
                       qualtrics_addup_coll.insert_one({'user_id':user_id})

                   else:  # Failed twice
                       msg = "queued qualtrics add: User {0} add/update failed twice in a row, skipping this user. Their panel ID probably doesn't match the one in Qualtrics. There's a cron to fix this. Result: {1}".format(
                       user_id,pprint.pformat(q_response))
                       app.logger.exception(msg)

            else: # empty queue
                time.sleep(30)
            
        except:
           # Push dictionary back on the queue.
           qualtrics_addup_coll.insert_one({'user_id':user_id})
           msg = "queued qualtrics add: Something went wrong: User {0} add/update failed. Sleeping for 30 seconds and then retrying. If this persists, see logs for more detail. Exception: {1}".format(
           user_id,traceback.format_exc())
           app.logger.exception(msg)
           time.sleep(30)

    def push(self,user_id):
       app.logger.info('Pushed user {0}'.format(user_id))
       return qualtrics_addup_coll.insert_one({'user_id':user_id})

    def count(self):
       return qualtrics_addup_coll.count()

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`

if __name__ == "__main__":
    qauq = QualtricsAddUpdateQueue()

    # Forever pop. It throttles itself, so no need to do it here.
    while True:
        qauq.pop()

