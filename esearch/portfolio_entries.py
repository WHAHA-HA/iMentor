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
    MONGO_HOST,MONGO_PORT,MONGO_DBNAME_ES_PORTFOLIO,
    MONGO_ES_PORTFOLIO_ADDINDEX_COLLNAME,ESEARCH_INDEXED_APPS)

from portfolio.models import ReflectionUserResponse
from utils.user_details import get_partner_site_for_user
from utils.strip_html import strip_tags

es = Elasticsearch([{'host':ESEARCH_HOST,'port':ESEARCH_PORT},])

INDEX = ESEARCH_INDEXED_APPS['portfolio']['index']
DOC_TYPE = ESEARCH_INDEXED_APPS['portfolio']['doc_type']
TEXT_FIELD = ESEARCH_INDEXED_APPS['portfolio']['main_text_field']
QUEUE_FIELD = ESEARCH_INDEXED_APPS['portfolio']['queue_field']

mongo_connection = pymongo.mongo_client.MongoClient(MONGO_HOST,MONGO_PORT)
database = pymongo.database.Database(mongo_connection,MONGO_DBNAME_ES_PORTFOLIO)
portfolio_coll = database[MONGO_ES_PORTFOLIO_ADDINDEX_COLLNAME]


def del_portfolio_index(obj_id):
    es.delete(index=INDEX,doc_type=DOC_TYPE,id=obj_id,ignore=[400, 404])

def add_portfolio_index(obj):
    partner_site = get_partner_site_for_user(obj.user_id)
    if not partner_site:
        app.logger.warning("User {0} has no partner site, get_partner_site_for_user() returned None. Skipping ReflectionUserResponse ID {1}".format(
            obj.user_id,obj.id))
        return

    partner_site_id = None
    if partner_site:
        partner_site_id = partner_site.latest_partner_id

    rdict = dict([(x,y) for x,y in obj.__dict__.items() if x not in ('_sa_instance_state','reflection_html')])
    rdict['mentor_card_text'] = strip_tags(obj.reflection_user_details.reflection_card.mentor_card_html)
    rdict['mentee_card_text'] = strip_tags(obj.reflection_user_details.reflection_card.mentee_card_html)
    rdict['reflection_card_id'] = obj.reflection_user_details.reflection_card_id
    rdict['persona_id'] = obj.reflection_user_details.persona_id
    rdict['grade_id'] = obj.reflection_user_details.grade_id
    rdict['unit_id'] = obj.reflection_user_details.unit_id
    rdict['member_site_id'] = obj.user.member_id
    rdict['partner_site_id'] = partner_site_id
    rdict['date_indexed'] = int(time.time()) # seconds since the epoch
    print "Doing {0}".format(obj.id)

    es.update(index=INDEX,doc_type=DOC_TYPE,id=rdict['id'],body={'doc':rdict,
        'doc_as_upsert':True})


def one_time_add_all():
    for r in DBSession.query(
        ReflectionUserResponse).order_by(
        ReflectionUserResponse.id).all():
        add_portfolio_index(r)

def pop_queue_add_del():
    '''
    Remove queued portfolio reflection ids and actions, and index/delete them in elasticsearch.
    '''
    # FIFO queue pop
    reflection = portfolio_coll.find_one_and_delete({})
    while reflection:
        print "Doing {0}".format(reflection[QUEUE_FIELD])
        try:
            if reflection['action'] == 'delete':
                es.delete(index=INDEX,doc_type=DOC_TYPE,id=reflection[QUEUE_FIELD],ignore=[400, 404])
            elif reflection['action'] == 'insert':
                obj = DBSession.query(ReflectionUserResponse).filter(
                    ReflectionUserResponse.id==reflection[QUEUE_FIELD]).first()
                # Portfolio reflection are replaced by news ones, and the id changes
                # each time. If this no longer exists in the database, skip it here.
                if obj:
                    add_portfolio_index(obj)

            reflection = portfolio_coll.find_one_and_delete({})
        except:
            portfolio_coll.insert_one({'action':reflection['action'],QUEUE_FIELD:reflection[QUEUE_FIELD]})
            raise


if __name__ == "__main__":
    one_time_add_all()
    #pop_queue_add_del()
