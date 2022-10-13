# -*- coding: iso8859-15 -*-
import pprint
import copy
import os,sys
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

import socket

CHAOS_KITTEN=False # Set this to True in local settings.

QUALTRICS_USER = 'will@imentor.org'
QUALTRICS_TOKEN = 'PF9V9IOkJUMJyHVXp26q0AwoJ5BAUZOIYo2if9eU'
QUALTRICS_URI ='https://imentor.qualtrics.com/WRAPI/ControlPanel/api.php'
# Can't use IP with SSL, sadly.
#QUALTRICS_URI ='https://104.118.250.50/WRAPI/ControlPanel/api.php'
QUALTRICS_API_SELECT = 'ControlPanel'
QUALTRICS_API_VERSION = '2.5'
QUALTRICS_API_FORMAT = 'JSON'

# ------------------------------------

# Override these in your local settings file if you wish.

# Generic email config
EMAIL_USE_TLS = True
#EMAIL_HOST = 'smtp.office365.com'
EMAIL_HOST = 'smtp.sendgrid.net'
EMAIL_HOST_USER = 'notifications@imentor.org'
#EMAIL_HOST_PASSWORD = 'iMentor@30'
EMAIL_HOST_PASSWORD = '3wsx7yhn5!#fB7&2'
EMAIL_PORT = 587
FROM_EMAIL = EMAIL_HOST_USER

MAX_SESSION_SECONDS = 3600 # This is an idle user session timeout.

# JWT token based login, with time element removed.
JWT_AUTH_URL_RULE = '/login/'
JWT_AUTH_USERNAME_KEY ='email'
JWT_AUTH_PASSWORD_KEY ='password'

# LOGGING AND ALERTING
# these addresses are emailed when an exception occurs!
ADMINS = ['technotifications@imentor.org']

# log file
LOG_FILENAME = '/var/log/uwsgi/new_platform.log'
MAX_BYTES = 500000
BACKUP_COUNT = 5

# SqlAlchemy caching defaults. Use file caching in your
# local settings file to override.
DOGPILE_CACHE_REGION='cache.dbqueries.'
DOGPILE_CACHE_CONFIG = {
    DOGPILE_CACHE_REGION + "backend":"dogpile.cache.pylibmc",
    DOGPILE_CACHE_REGION + "arguments.url":"127.0.0.1",
}

# Data Cache default settings
MAX_URL_CACHE_SECONDS = 60*60*24
URL_CACHE = {
    'CACHE_TYPE':'memcached',
    #'CACHE_TYPE':'filesystem',   # Not for servers.
    #'CACHE_DIR':'/tmp/URLCache', # Not for servers.
    'CACHE_KEY_PREFIX':'URLCache',
    'CACHE_MEMCACHED_SERVERS':('127.0.0.1',),
    'CACHE_DEFAULT_TIMEOUT':MAX_URL_CACHE_SECONDS
    }

# CROWDRISE API SETTINGS
CROWDRISE_API_KEY = "4495538a07c0738c96d1bad73025ad310b103931"
CROWDRISE_API_SECRET = "7f7d258b98c195cec4b54e234423010d6b3fc6ac"
CROWDRISE_API_BASE_URL = "https://www.crowdrise.com/api"

# Tableau report access and "ticket" (auth token) request info.
TABLEAU_SERVER_INTERNAL="https://10.12.21.20/"
TABLEAU_SERVER="https://tableau.imentor.org/"
TABLEAU_EMBED_URL=TABLEAU_SERVER + "javascripts/api/viz_v1.js" # ticket, workbook and view are set in template.
TABLEAU_STANDARD_URL=TABLEAU_SERVER + "trusted/{0}/views/{1}/{2}" # ticket, workbook, view.
TABLEAU_TICKET_REQUEST_URL=TABLEAU_SERVER_INTERNAL + "trusted"
TABLEAU_USERNAME="mbradley"

# Only used for a manual run of an update script, when necessary. 
PINGDOM_APP_KEY = "k1sijpqwos42vk67o97esfbcubduv8zo"
PINGDOM_AUTH_EMAIL = "ksweetman@imentor.org"
PINGDOM_AUTH_PWD = "iMentorPingdom1!"
PINGDOM_BASE_URL = "https://api.pingdom.com/api/2.0/"

# The day when sms event notifications should go out.
DEFAULT_DAYS_BEFORE_EVENT = 7

# College checklist defaults
MAX_COLLEGE_LIST_ENTRIES = 25 # number of records
MAX_COLLEGE_LIST_SIZE = 10    # number in dropdwon list

# KLUDGE: Turns off warning:
SQLALCHEMY_TRACK_MODIFICATIONS=True

# For Conversations Admin messages to all users:
SUPERUSER_ANNOUNCER_ID = 152132

# user content defaults
UPLOAD_FOLDER = '/mnt/shared/imentor/user_content'
LEGACY_UPLOAD_FOLDER = '/mnt/shared/imentor/imi/imentor/media/upload/iuser'
RELATIVE_LEGACY_UPLOAD_FOLDER='upload/iuser'

# This is constant, and has to be removed form the image path in the DB.
SERVER_RELATIVE_LEGACY_UPLOAD_FOLDER='upload/iuser'

# Elasticsearch settings for consistent index, doc type,
# and text field names, used like: 
# Also for consistent Mongo queue field names.
# http://10.12.21.103/index/doctype/123 for example.
ESEARCH_INDEXED_APPS = {
    'canvas': {
        'index':'canvas','doc_type':'response',
        'main_text_field':'response_text','queue_field':'resp_id'},
    'portfolio': {
        'index':'portfolio','doc_type':'reflection',
        'main_text_field':'reflection_text','queue_field':'refl_id'},
    'conversation': {
        'index':'conversation','doc_type':'message',
        'main_text_field':'data','queue_field':'msg_id'}
}

if 'HARDCODED_HOSTNAME' in os.environ:
    HOSTNAME=os.environ['HARDCODED_HOSTNAME']
    print "Loading local settings from a hard-coded env hostname: %s.py" % HOSTNAME
else:
    HOSTNAME = socket.gethostname( ).replace('.','_').replace('-','_')
    print "Loading local settings from %s.py" % HOSTNAME

hstr = "from config.settings.{0} import *".format(HOSTNAME)
exec(hstr)

