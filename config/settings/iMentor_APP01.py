#!/usr/bin/env python
# -*- coding: utf-8 -*-

#app.config['SECRET_KEY'] ='A0Zr98j/3yX R~XHH!jmN]LWX/,?RT'
import os
basedir = os.path.abspath(os.path.dirname(__file__))

CDN_PREFIX='//cdn.imentor.org'

DB_NAME="imentor_production"
DB_USER="imentor"
DB_PASSWD="7yh8uj9ik0ol"
DB_HOST="10.12.21.16"
DB_PORT=5432

# Read-only DB replica: DEV does not have one.
# In PROD, only the server is different.
RO_DB_NAME=DB_NAME
RO_DB_USER=DB_USER
RO_DB_PASSWD=DB_PASSWD
RO_DB_HOST='10.12.21.17'
RO_DB_PORT=DB_PORT

FLASK_HOST='127.0.0.1'
FLASK_PORT=8000
FLASK_CHAT_WEBSOCKET_PORT=8001

ESEARCH_HOST = "10.12.21.14"
ESEARCH_PORT = 9200

SQLALCHEMY_DATABASE_URI = 'postgresql+psycopg2://{0}:{1}@{2}:{3}/{4}'.format(DB_USER,DB_PASSWD,DB_HOST,DB_PORT,DB_NAME)
SQLALCHEMY_DB_RO_URI = 'postgresql+psycopg2://{0}:{1}@{2}:{3}/{4}'.format(RO_DB_USER,RO_DB_PASSWD,RO_DB_HOST,RO_DB_PORT,RO_DB_NAME)

print "HEY!!! You are connecting to: %s" % SQLALCHEMY_DATABASE_URI

MONGO_HOST="10.12.21.15"
MONGO_PORT=27017
MONGO_DBNAME_MATCHING="MATCHING"
MONGO_MSGQUEUE_COLLNAME="matching_message_queue"
MONGO_MATCHRESULTS_COLLNAME="matching_results"
MONGO_DBNAME_LOGS="LOGS"
MONGO_GENERIC_LOGQUEUE_COLLNAME="generic_log_queue"
MONGO_DBNAME_FORMS="FORMS"
MONGO_POP_FROM_FORM_COLLNAME="pop_from_form"
MONGO_FORM_NOTIFY_COLLNAME="form_notify_ready"
MONGO_DBNAME_AUDIT_TRAIL="AUDIT_TRAIL"
MONGO_AUDIT_TRAIL_COLLNAME="audit_objs"
MONGO_DBNAME_QUALTRICS="QUALTRICS_QUEUES"
MONGO_QUALTRICS_ADDUPDATE_COLLNAME="qualtrics_addupddate_users"
MONGO_DBNAME_ES_CANVAS="ELASTIC_QUEUE_CANVAS"
MONGO_ES_CANVAS_ADDINDEX_COLLNAME="elastic_queue_canvas_addindex"
MONGO_DBNAME_ES_PORTFOLIO="ELASTIC_QUEUE_PORTFOLIO"
MONGO_ES_PORTFOLIO_ADDINDEX_COLLNAME="elastic_queue_portfolio_addindex"
MONGO_DBNAME_ES_CONVERSATION="ELASTIC_QUEUE_CONVERSATION"
MONGO_ES_CONVERSATION_ADDINDEX_COLLNAME="elastic_queue_conversation_addindex"
MONGO_DBNAME_DEBUG="DEBUG_DATA"
MONGO_FORMS_DEBUG_COLLNAME="forms_debug_data"


TWILIO_ACCOUNT_SID = 'ACe7d7edbddba628434f30d3482e0632a8'
TWILIO_AUTH_TOKEN = '22031f2638457492c9fced32f2ba79b3'
TWILIO_PHONE_NUMBER = '65029'

SQLALCHEMY_ECHO = False
SQLALCHEMY_POOL_SIZE = 20
SECRET_KEY = 'A0Zt98j/3yi R~XHH!jmN]LWX/,?RT'
PASS_KEY = 'A0Zt98j/3yiR~XHH!jmN]LWX'
DEBUG = False
PAGE_LIMIT = 100
BASE_SITENAME = "nyc.imentor.org"
BASE_URL = "https://" + BASE_SITENAME + "/"

ENV_TYPE="Production"

DOGPILE_CACHE_REGION='cache.dbqueries.'
DOGPILE_CACHE_CONFIG = {
    DOGPILE_CACHE_REGION + "backend":"dogpile.cache.pylibmc",
    DOGPILE_CACHE_REGION + "arguments.url":"10.12.21.15",
}

# Data Cache settings (matched on URL)
MAX_URL_CACHE_SECONDS = 60*60*24
URL_CACHE = {
    'CACHE_TYPE':'memcached',
    #'CACHE_TYPE':'filesystem',   # Not for servers.
    #'CACHE_DIR':'/tmp/URLCache', # Not for servers.
    'CACHE_KEY_PREFIX':'URLCache',
    'CACHE_MEMCACHED_SERVERS':('10.12.21.15',),
    'CACHE_DEFAULT_TIMEOUT':MAX_URL_CACHE_SECONDS
    }

# College checklist defaults
MAX_COLLEGE_LIST_ENTRIES = 25 # number of records
MAX_COLLEGE_LIST_SIZE = 10    # number in dropdwon list

REMEMBER_COOKIE_NAME = 'sessionid'
UPLOAD_FOLDER = '/mnt/shared/imentor/user_content'
LEGACY_UPLOAD_FOLDER = '/mnt/shared/imentor/imi/imentor/media/upload/iuser'
RELATIVE_LEGACY_UPLOAD_FOLDER='upload/iuser'

DIGEST_AUTH_REALM='prod_imentor'
DIGEST_AUTH_USER='imentor'
DIGEST_AUTH_PASSWORD='2qa3ws4ed5rf6tg7yh'

GDRIVE_OBO_EMAIL='jclayton@imentor.org'
GDRIVE_AUTH_EMAIL='792097238448-d6l3hvnppuc0do9fjvn2mqf6so9pbj1r@developer.gserviceaccount.com'
GDRIVE_AUTH_PKEY= os.path.abspath(os.path.join(basedir,'google_creds_prod_priv.p12'))
GDRIVE_AUTH_JSON= os.path.abspath(os.path.join(basedir,'google_creds_prod_priv.json'))
GOOGLE_API_KEY='AIzaSyDkKMaZpgdyy6FfA-qZM-lCdMfWBygKdJw'

# For mobile
APN_USE_SANDBOX=False
APN_CERT_FILE=os.path.abspath(os.path.join(basedir,'../../mobile_notifications/prod_push.pem'))
FCM_API_KEY='AIzaSyDtsEls2-MzDKwWKe7_qKSUtc58ZeuUERo'


LOGIN_DISABLED=False
DEFAULT_TEST_USER_ID=None
#LOGIN_DISABLED=True
#DEFAULT_TEST_USER_ID=1215

