# -*- coding: iso8859-15 -*-
import pdb
import pprint
import copy
import os,sys
import time
import pymongo
from datetime import datetime,timedelta
from elasticsearch import Elasticsearch

appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from auth import app
from config.project_globals import (Base,metadata,
    DBSession,get_scoped_session)
from config.settings import (ENV_TYPE,LOGIN_DISABLED,
    DEFAULT_TEST_USER_ID,ESEARCH_HOST,ESEARCH_PORT,
    MONGO_HOST,MONGO_PORT,MONGO_DBNAME_ES_CONVERSATION,
    MONGO_ES_CONVERSATION_ADDINDEX_COLLNAME,ESEARCH_INDEXED_APPS,
    SUPERUSER_ANNOUNCER_ID)

from conversations.models import Conversation
from utils.user_details import get_partner_site_for_user
from utils.strip_html import strip_tags

es = Elasticsearch([{'host':ESEARCH_HOST,'port':ESEARCH_PORT},])

INDEX = ESEARCH_INDEXED_APPS['conversation']['index']
DOC_TYPE = ESEARCH_INDEXED_APPS['conversation']['doc_type']
TEXT_FIELD = ESEARCH_INDEXED_APPS['conversation']['main_text_field']
QUEUE_FIELD = ESEARCH_INDEXED_APPS['conversation']['queue_field']

mongo_connection = pymongo.mongo_client.MongoClient(MONGO_HOST,MONGO_PORT)
database = pymongo.database.Database(mongo_connection,MONGO_DBNAME_ES_CONVERSATION)
conversation_coll = database[MONGO_ES_CONVERSATION_ADDINDEX_COLLNAME]


def del_conversation_index(obj_id):
    es.delete(index=INDEX,doc_type=DOC_TYPE,id=obj_id,ignore=[400, 404])

def add_conversation_index(obj):
    print "Doing {0}".format(obj.id)

    partner_site = get_partner_site_for_user(obj.user_id)
    # Superusers have no partners. Generall announcements appear in convs from a superuser.
    if not partner_site:
        if obj.user_id != SUPERUSER_ANNOUNCER_ID:
            app.logger.warning("User {0} has no partner site, get_partner_site_for_user() returned None. Skipping Conversation ID {1}".format(
                obj.user_id,obj.id))
        else:
            print "Skipping admin"
        return

    partner_site_id = partner_site.latest_partner_id

    rdict = dict([(x,y) for x,y in obj.__dict__.items() if x not in ('_sa_instance_state')])
    rdict['data'] = strip_tags(obj.data)
    rdict['member_site_id'] = obj.user.member_id
    rdict['partner_site_id'] = partner_site_id
    rdict['date_indexed'] = int(time.time()) # seconds since the epoch
    print "Doing {0}".format(obj.id)

    es.update(index=INDEX,doc_type=DOC_TYPE,id=rdict['id'],body={'doc':rdict,
        'doc_as_upsert':True})


def one_time_add_all():
    for r in DBSession.query(
        Conversation).order_by(
        Conversation.id).all():
        add_conversation_index(r)

def pop_queue_add_del():
    '''
    Remove queued conversation message ids and actions, and index/delete them in elasticsearch.
    '''
    # FIFO queue pop
    message = conversation_coll.find_one_and_delete({})
    while message:
        print "Doing {0}".format(message[QUEUE_FIELD])
        try:
            if message['action'] == 'insert':
                obj = DBSession.query(Conversation).filter(
                    Conversation.id==message[QUEUE_FIELD]).first()
                # Portfolio message are replaced by news ones, and the id changes
                # each time. If this no longer exists in the database, skip it here.
                if obj:
                    add_conversation_index(obj)

            else:
                raise Exception("No deletes in conversation. what is this? {0}".format(
                    message['action']))

            message = conversation_coll.find_one_and_delete({})
        except:
            conversation_coll.insert_one({'action':message['action'],QUEUE_FIELD:message[QUEUE_FIELD]})
            raise


if __name__ == "__main__":
    one_time_add_all()
    #pop_queue_add_del()
