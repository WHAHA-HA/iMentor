# -*- coding: iso8859-15 -*-
import os,sys
import time
import pdb
import pprint
import copy
import pylibmc
import uuid
from urllib import unquote_plus
from functools import wraps
from flask import request,abort,session,jsonify,redirect
from flask_jwt import JWT, JWTError, jwt_required, current_identity
from flask_jwt import _default_request_handler as jwt_default_request_handler
from collections import OrderedDict
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'../..'))
projdir2 = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)
    sys.path.append(projdir2)
from config.project_globals import (get_scoped_session,Base,metadata,
    DBSession,DOGPILE_CACHE_REGION)
from config.settings import (MAX_SESSION_SECONDS,SECRET_KEY
    JWT_AUTH_URL_RULE,JWT_AUTH_USERNAME_KEY,
    JWT_AUTH_PASSWORD_KEY)

from config.caching_query import CachingQuery,FromCache
from sqlalchemy import (BigInteger, Boolean, Column, Date, DateTime,
    Float, ForeignKey, Index, Integer, Numeric, SmallInteger,
    String, Table, Text, Time, text, func, or_)
from sqlalchemy.sql.expression import func, or_, not_, and_
from sqlalchemy.orm import sessionmaker, aliased
from sqlalchemy.orm.exc import NoResultFound, MultipleResultsFound

from auth import app
from legacy_models.iuser import IuserUser
from auth.models import LiveSession

'''
Login is done by JWT. Endpoint is /auth/. Functions below intercept the login
at various points.
Session key is tracked in the DB to prevent reuse.
Mobile tokens are handled differently, since they don't expire. See the Mobile project
for details.
'''

# For JWT support
def identity(data_dict):
    user_id = int(data_dict['identity'].split(':')[1])
    local_db_session = get_scoped_session()
    live_session = local_db_session.query(LiveSession).filter(
        LiveSession.session_id==data_dict['identity']).filter(
        LiveSession.user_id==user_id).first()
    if not live_session:
        local_db_session.commit()
        abort(403)
        #redirect('/')

    # Check idle time. if they're idle too long, log them out.
    if (time.time() - live_session.user.last_accessed_seconds) > MAX_SESSION_SECONDS or \
        not live_session.user.is_active:

        local_db_session.query(LiveSession).filter(
            LiveSession.user_id==user_id).delete()
        local_db_session.commit()

        abort(403)
        #redirect('/')

    local_db_session.query(IuserUser).filter(IuserUser.id==user_id).update({
        'last_accessed_seconds':time.time()})
    local_db_session.commit()
        
    result = DBSession.query(IuserUser).filter(IuserUser.id==user_id).one()
    if not result:
        abort(403)
        #redirect('/')

    return result


def authenticate(username,password):
    local_db_session = get_scoped_session()

    if len(username) > 200 or len(password) > 200:
        return None

    if '@' in username:
        user = local_db_session.query(IuserUser).filter(IuserUser.email==username).filter(
            IuserUser.is_active==True).first()
    else:
        user = local_db_session.query(IuserUser).filter(IuserUser.username==username).filter(
            IuserUser.is_active==True).first()
    if not user:
        local_db_session.commit()
        return None

    if not check_password(user.encrypted_password,password):
        local_db_session.commit()
        return None

    local_db_session.query(IuserUser).filter(IuserUser.id==user.id).update({
        'last_accessed_seconds':time.time()})

    local_db_session.commit()
        
    return DBSession.query(IuserUser).filter(IuserUser.id==user.id).one()

def _our_jwt_payload_handler(identity):
    # We do our own idle timeout.
    #iat = datetime.utcnow()
    #exp = iat + current_app.config.get('JWT_EXPIRATION_DELTA')
    #nbf = iat + current_app.config.get('JWT_NOT_BEFORE_DELTA')
    rand1 = str(uuid.uuid4())
    rand2 = str(uuid.uuid4())
    user_id = getattr(identity, 'id') or identity['id']
    session_id = rand1 + ':' + str(user_id) + ':' + rand2

    '''
    Duplicate login will simply stomp on the first session,
    making it immeidately invalid.
    '''
    local_db_session = get_scoped_session()
    existing = local_db_session.query(LiveSession).filter(
        LiveSession.user_id==user_id).first()
    if existing:
        if (time.time() - existing.user.last_accessed_seconds) <= MAX_SESSION_SECONDS:
            app.logger.exception("Not a crash, just an alert: user {0} tried to log in more than once. We kicked them out of their second session.".format(existing.user.id))

        local_db_session.query(LiveSession).filter(
            LiveSession.user_id==user_id).update({
            'session_id':session_id})
    else:
        lsession = LiveSession(
            user_id=user_id,
            session_id=session_id)
        local_db_session.add(lsession)

    local_db_session.commit()

    return {'identity': session_id}


def _our_request_handler():
    # Read from token, then cookie.
    result = jwt_default_request_handler()
    if result:
        app.logger.warning("Not a warning, token came from header:{0}".format(result))
        return result
    
    # Expecting "JWT some_token" in a cookie named "token"
    # Return token only.
    # Note that cookies are only used when we have to do so: when loading new pages,
    # to keep certain functional sections separate from others.
    result = request.cookies.get('token',None)
    if result:
        sresult = unquote_plus(result).split()
        if len(sresult) != 2:
            return None
        if sresult[0] != 'JWT':
            return None
        app.logger.warning("Not a warning, token came from cookie:{0}".format(sresult[1]))
        return sresult[1]

def _our_jwt_error_handler(error):
    error.status_code = error.status_code if error.status_code != 401 else 403
    app.logger.warning(error.description + " HEADER:{0}\n{1}".format(pprint.pformat(request.headers.__dict__),pprint.pformat(request.json)))
    return jsonify(OrderedDict([
        ('status_code', error.status_code),
        ('error', error.error),
        ('description', error.description),
    ])), error.status_code, error.headers

def _our_auth_request_handler():
    data = request.get_json()
    username = data.get(JWT_AUTH_USERNAME_KEY, None)
    password = data.get(JWT_AUTH_PASSWORD_KEY, None)
    criterion = [username, password, len(data) == 2]

    if not all(criterion):
        raise JWTError('Bad Request', 'Invalid credentials')

    identity = _jwt.authentication_callback(username, password)

    if identity:
        access_token = _jwt.jwt_encode_callback(identity)
        return _jwt.auth_response_callback(access_token, identity)
    else:
        raise JWTError('Bad Request', 'Invalid credentials')



# Register JWT
jwt = JWT(app, authenticate, identity)
jwt.request_callback = _our_request_handler
jwt.jwt_payload_callback = _our_jwt_payload_handler
jwt.jwt_error_callback = _our_jwt_error_handler
jwt.auth_request_callback = _our_auth_request_handler

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Password related
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def set_password(password):
    return generate_password_hash(password)

def check_password(pw_hash, password):
    return check_password_hash(pw_hash, password)

def logout(user):
    local_db_session = get_scoped_session()
    local_db_session.query(LiveSession).filter(
        LiveSession.user_id==user.id).delete()
    local_db_session.commit()

def new_user(username,password,role,active=False):
    if len(username) > 200 or len(password) > 200:
        return None

    creds = json.loads(request.body)

    email=None
    if '@' in username:
        email = copy.deepcopy(username)
        username = None

    if email:
        user = DBSession.query(IuserUser).filter(IuserUser.email==email).first()
        if user:
            return user

    if username:
        user = DBSession.query(IuserUser).filter(IuserUser.username==username).first()
        if user:
            return user

    local_db_session = get_scoped_session()
    user = IuserUser(
        email = email,
        username = username,
        encrypted_password = set_password(password),
        role_id=role,
        is_active=active
        )
    local_db_session.add(user)
    local_db_session.commit()

    user_type = creds['user_type'] # 'Mentor' or 'Mentee'
    if user_type not in ('Mentor','Mentee'):
        response = {'success':False,'error':'Admin? Really? Nice try.'}
        return HttpResponse(json.dumps(response), content_type="application/json")

    DBSession.query(IuserUser).filter(IuserUser.id==user.id).one()
