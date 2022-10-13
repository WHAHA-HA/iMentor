# -*- coding: iso8859-15 -*-
import os,sys
import json
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)
import time, datetime
#from flask_cors import CORS, cross_origin
from flask_sqlalchemy import SQLAlchemy
from flask import Flask, redirect, g, got_request_exception
from flask_restful import Api
from flask import Response, jsonify, make_response
from flask_cache import Cache as URLCache
from flask.json import JSONEncoder

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, scoped_session
from sqlalchemy.ext.declarative import declarative_base

from dogpile.cache import make_region

from config.settings import (ENV_TYPE,DOGPILE_CACHE_CONFIG,
    DOGPILE_CACHE_REGION,URL_CACHE,HOSTNAME,SQLALCHEMY_POOL_SIZE)

from config.crash_logger import log_handler, crash_mailer
from config.custom_routes import load_regex_converter
from config.settings import DEBUG,DEFAULT_TEST_USER_ID,LOGIN_DISABLED
from config.settings import (DIGEST_AUTH_REALM,
    DIGEST_AUTH_USER,DIGEST_AUTH_PASSWORD,GDRIVE_AUTH_EMAIL,GDRIVE_AUTH_PKEY,
    GDRIVE_AUTH_JSON,GDRIVE_OBO_EMAIL,SQLALCHEMY_DATABASE_URI,SQLALCHEMY_DB_RO_URI,
    SQLALCHEMY_TRACK_MODIFICATIONS)
from config.settings import QUALTRICS_URI

from digest_auth import FlaskRealmDigestDB

# Turn off warning in cron jobs
import warnings
from flask.exthook import ExtDeprecationWarning
warnings.simplefilter('ignore', ExtDeprecationWarning)

# Static assets, not uploaded user content.
STATIC_PATH = os.path.abspath(os.path.join(appdir,"../static"))
app = Flask(__name__,static_url_path='/new_platform/static', static_folder=STATIC_PATH)
app._static_folder = STATIC_PATH

app.config.from_object('config.settings')
app.url_map.strict_slashes=True

#cors = CORS(app, resources={r"/new_platform/static/*": {"origins": "cdn.imentor.org"}})
#app.config['CORS_HEADERS'] = 'Content-Type'

# Query caching: use file for local tests, memcache for servers.
# See settings for config.
query_region = make_region().configure_from_config(DOGPILE_CACHE_CONFIG,DOGPILE_CACHE_REGION)

# Set up URL memoize caching
url_cache = URLCache(app,config=URL_CACHE)
url_cache.init_app(app) 

# Both global and local sessions are used. Local sessions are read-write.
engine = create_engine(SQLALCHEMY_DATABASE_URI,
    pool_size=SQLALCHEMY_POOL_SIZE, isolation_level="AUTOCOMMIT")
DBSession = scoped_session(sessionmaker(autocommit=True,autoflush=True,bind=engine))

def get_scoped_session():
    session = scoped_session(sessionmaker(autocommit=True,autoflush=True,bind=engine))
    session.begin()
    return session

ro_engine = create_engine(SQLALCHEMY_DB_RO_URI,
    pool_size=SQLALCHEMY_POOL_SIZE, isolation_level="AUTOCOMMIT")
ro_DBSession = scoped_session(sessionmaker(autocommit=True,autoflush=True,bind=ro_engine))

db = SQLAlchemy(app)
db.init_app(app)

Base = declarative_base()
metadata = Base.metadata

api = Api(app)

load_regex_converter(app)

# Add the user upon every restart: the DB is memory resident.
DigestAuthDB = FlaskRealmDigestDB(DIGEST_AUTH_REALM)
DigestAuthDB.add_user(DIGEST_AUTH_USER,DIGEST_AUTH_PASSWORD)

# Be sure to properly set your ENV_TYPE in config/settings/*.py
print "Your environment type is: {0}".format(ENV_TYPE)
print "Generated Google docs will be stored under this person's GDRIVE: {0}".format(GDRIVE_OBO_EMAIL)

@app.errorhandler(500)
def do500(e):
    return render_template("global_templates/500.html"), 500

@app.errorhandler(404)
def do404(e):
    return render_template("global_templates/404.html"), 404

@app.errorhandler(403)
def do403(e):
    return render_template("global_templates/403.html"), 403

class CustomJSONEncoder(JSONEncoder):
    def default(self, o):
        if isinstance(o, datetime.datetime) or isinstance(o,datetime.date):
            return o.isoformat()

        return JSONEncoder.default(self, o)

# This is only in effect when you call jsonify()
app.json_encoder = CustomJSONEncoder


if ENV_TYPE == "Production":
    app.debug = False
    crash_mailer(app,ENV_TYPE,HOSTNAME)
    log_handler(app)

    # We derive domain, unless we need it in crontab.
    # Don't use this unless you have to.
    DOMAIN = 'imentor.org'
else:
    #app.debug = True

    # Let's test crash reporting in dev, but not on individual machines.
    if DEBUG == False:
        app.debug = False
        crash_mailer(app,ENV_TYPE,HOSTNAME)
    else:
        app.debug = True

    log_handler(app)

    '''
    # CORS headers in every JSON response when testing.
    @api.representation('application/json')
    def output_json(data, code, headers={}):
        #print "Calling CORS response header function..."
        resp = make_response(json.dumps(data), code)
        headers['Access-Control-Allow-Origin'] = '*'
        headers['Access-Control-Allow-Credentials'] = 'true'
        headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE, OPTIONS'
        headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'

        resp.headers.extend(headers)
        return resp
    '''

    # We derive domain, unless we need it in crontab.
    # Don't use this unless you have to.
    if ENV_TYPE == 'Dev_Running_Prod_DB_Copy':
        DOMAIN = 'imentortest.org'
    else:
        DOMAIN = 'imentordev.org'

