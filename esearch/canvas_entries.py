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
    MONGO_HOST,MONGO_PORT,MONGO_DBNAME_ES_CANVAS,
    MONGO_ES_CANVAS_ADDINDEX_COLLNAME,ESEARCH_INDEXED_APPS)


from canvas.models import WidgetContentUserResponse
from utils.user_details import get_partner_site_for_user

es = Elasticsearch([{'host':ESEARCH_HOST,'port':ESEARCH_PORT},])

INDEX = ESEARCH_INDEXED_APPS['canvas']['index']
DOC_TYPE = ESEARCH_INDEXED_APPS['canvas']['doc_type']
TEXT_FIELD = ESEARCH_INDEXED_APPS['canvas']['main_text_field']
QUEUE_FIELD = ESEARCH_INDEXED_APPS['canvas']['queue_field']

mongo_connection = pymongo.mongo_client.MongoClient(MONGO_HOST,MONGO_PORT)
database = pymongo.database.Database(mongo_connection,MONGO_DBNAME_ES_CANVAS)
canvas_coll = database[MONGO_ES_CANVAS_ADDINDEX_COLLNAME]

def del_canvas_index(obj_id):
    es.delete(index=INDEX,doc_type=DOC_TYPE,id=obj_id,ignore=[400, 404])

def add_canvas_index(obj):
    partner_site = get_partner_site_for_user(obj.user_id)
    if not partner_site:
        app.logger.warning("User {0} has no partner site, get_partner_site_for_user() returned None. Skipping Canvas WidgetContentUserResponse ID {1}".format(
            obj.user_id,obj.id))
        return

    partner_site_id = partner_site.latest_partner_id

    rdict = dict([(x,y) for x,y in obj.__dict__.items() if x not in ('_sa_instance_state','response_html')])
    rdict['widget_content_marker_user_copy_id'] = obj.widget_content_marker_user_copy.id
    rdict['widget_content_copy_id'] = obj.widget_content_marker_user_copy.widget_content_user_copy.id
    rdict['widget_copy_id'] = obj.widget_content_marker_user_copy.widget_content_user_copy.widget_user_copy.id
    rdict['canvas_app_user_copy'] = obj.widget_content_marker_user_copy.widget_content_user_copy.widget_user_copy.canvas_app_user_copy.id
    rdict['canvas_set_user_copy'] = obj.widget_content_marker_user_copy.widget_content_user_copy.widget_user_copy.canvas_app_user_copy.canvas_set_user_copy.id
    rdict['canvas_set_parent_id'] = obj.widget_content_marker_user_copy.widget_content_user_copy.widget_user_copy.canvas_app_user_copy.canvas_set_user_copy.parent_id
    rdict['curriculum_user_copy'] = obj.widget_content_marker_user_copy.widget_content_user_copy.widget_user_copy.canvas_app_user_copy.canvas_set_user_copy.curriculum_user_copy.id
    rdict['canvas_last_viewed'] = obj.widget_content_marker_user_copy.widget_content_user_copy.widget_user_copy.canvas_app_user_copy.canvas_set_user_copy.last_viewed
    rdict['canvas_admin_last_viewed'] = obj.widget_content_marker_user_copy.widget_content_user_copy.widget_user_copy.canvas_app_user_copy.canvas_set_user_copy.admin_last_viewed
    rdict['member_site_id'] = obj.user.member_id
    rdict['partner_site_id'] = partner_site_id
    rdict['date_indexed'] = int(time.time()) # seconds since the epoch
    print "Doing {0}".format(obj.id)

    es.update(index=INDEX,doc_type=DOC_TYPE,id=rdict['id'],body={'doc':rdict,
        'doc_as_upsert':True})


def one_time_add_all():
    for r in DBSession.query(
        WidgetContentUserResponse).filter(
        WidgetContentUserResponse.id>=2918498).order_by(
        WidgetContentUserResponse.id).all():
        add_canvas_index(r)

def pop_queue_add_del():
    '''
    Remove queued canvas response ids and actions, and index/delete them in elasticsearch.
    '''
    # FIFO queue pop
    response = canvas_coll.find_one_and_delete({})
    while response:
        print "Doing {0}".format(response[QUEUE_FIELD])
        try:
            if response['action'] == 'delete':
                es.delete(index="canvas",doc_type="response",id=response[QUEUE_FIELD],ignore=[400, 404])
            elif response['action'] == 'insert':
                obj = DBSession.query(WidgetContentUserResponse).filter(
                    WidgetContentUserResponse.id==response[QUEUE_FIELD]).first()
                # Canvas responses are replaced by news ones, and the id changes
                # each time. If this no longer exists in the database, skip it here.
                if obj:
                    add_canvas_index(obj)

            response = canvas_coll.find_one_and_delete({})
        except:
            canvas_coll.insert_one({'action':response['action'],QUEUE_FIELD:response[QUEUE_FIELD]})
            raise


if __name__ == "__main__":
    one_time_add_all()
    #pop_queue_add_del()
