# -*- coding: iso8859-15 -*-
import os,sys
import pprint
import logging
import hashlib
import uuid
from functools import wraps
from flask import request,abort
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'../..'))
projdir2 = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)
    sys.path.append(projdir2)
from config.project_globals import (db,Base,metadata,
    DBSession,DOGPILE_CACHE_REGION)
from config.caching_query import CachingQuery,FromCache
from sqlalchemy import (BigInteger, Boolean, Column, Date, DateTime,
    Float, ForeignKey, Index, Integer, Numeric, SmallInteger,
    String, Table, Text, Time, text, func, or_)
from new_platform.audit import (audit_trail,DATA_REMOVE,DATA_ADD,
    DATA_NOCHG,APPLICATION_DATA)
from sqlalchemy.sql.expression import func, or_, not_, and_
from sqlalchemy.orm import sessionmaker, aliased
from sqlalchemy.orm.exc import NoResultFound, MultipleResultsFound
from legacy_models.partners import PartnersPartner
from legacy_models.curriculum import CurriculumPrompt
from legacy_models.calendars import CalendarsEventtype
from legacy_models.member import MemberMember,MemberSchool
from legacy_models.iuser import (IuserAssignedusertype,
    IuserUser,IuserUUID,IuserToken,
    ACTIVE_PERSONA_STATUS,P_MATCH_STATUS_MATCHED,IuserMatchhistory,
    USER_STATUS_ACTIVE,USER_STATUS_APPLICATION_INCOMPLETE,
    USER_STATUS_SCREENING_INCOMPLETE)

from utils.user_details import get_persona_obj_for_user

def get_hexdigest( algorithm, salt, raw_password):
    """
    Returns a string of the hexdigest of the given plaintext password and salt
    using the given algorithm ('md5', 'sha1' or 'crypt').
    """
    raw_password, salt = raw_password.decode(encoding='utf-8'), salt.decode(encoding='utf-8')
    if algorithm != 'sha1':
        raise ValueError("Got unknown password algorithm type in password.")
    return hashlib.sha1(salt + raw_password).hexdigest()

def check_password(password,raw_password):
    """
    Returns a boolean of whether the raw_password was correct. Handles
    encryption formats behind the scenes.
    """
    algo, salt, hsh = password.split('$')
    return hsh == get_hexdigest(algo, salt, raw_password)


class UUIDHandler(object):

    def gen_uuid(self):
        self.uuid = uuid.uuid4()

    def store_format(self):
        return self.uuid.hex

    def load(self,uhex):
        self.uuid = uuid.UUID(hex=uhex)
        return self.uuid


def set_api_key(user_id,reset=False):
    user_uuid = IuserUUID.query.filter(
        user_id == user_id).first()

    if not user_uuid:
        new_uuid = UUIDHandler()
        new_uuid.gen_uuid()

        user_uuid = IuserUUID(
            user_id = user_id,
            uuid = new_uuid.store_format())

        db.session.add(user_uuid)
        db.session.commit()

    elif reset or user_uuid.uuid in (None,''):
        new_uuid = UUIDHandler()
        new_uuid.gen_uuid()

        IuserUUID.query.filter(
            user_id == user_id).update(
            {'uuid':new_uuid.store_format()})

        db.session.commit()

def get_token(user_id):
    token = IuserToken.query.filter(IuserToken.user_id==user_id).filter(IuserToken.is_active==True).first()
    if not token:
        new_uuid = UUIDHandler()
        new_uuid.gen_uuid()
        token = IuserToken(user_id=user_id,is_active=True,
            session_token=new_uuid.store_format())
        db.session.add(token)
        db.session.commit()
    return token.session_token
        

def check_token(user_id,token):
    curr_token = get_token(user_id)
    return curr_token == token

def deactivate_token(user_id):
    token = IuserToken.query.filter(IuserToken.user_id==user_id).filter(IuserToken.is_active==True).first()
    if token:
        DBSession.query(IuserToken).filter(
            IuserToken.id==token.id).filter(
            IuserToken.user_id==user_id).update(
            {'is_active':False})
        db.session.commit()

def authenticate(email,password):
    user = IuserUser.query.filter(IuserUser.email==email).first()
    if not user:
        return False,None
    if check_password(user.password,password):
        if get_persona_obj_for_user(user.id,ignore_match_status=True) and \
            user.status in (USER_STATUS_ACTIVE,
            USER_STATUS_APPLICATION_INCOMPLETE,
            USER_STATUS_SCREENING_INCOMPLETE):
            return user,get_token(user.id)

def valid_token():
    api_key = request.headers.get('Authorization',None)
    if api_key:
        api_key = api_key.replace('ApiKey ','')
        email,auth_token = api_key.split(':')
        user = IuserUser.query.filter(IuserUser.email==email).first()
        if user:
            if check_token(user.id,auth_token):
                return user
    return False
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Decorator
def login_token_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if valid_token() not in (False,None):
            return f(*args, **kwargs)
        abort(401)
    return decorated_function
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def token_login(email,password):
    user,token = authenticate(email,password)
    if not user or not token:
        abort(401)
    return user,token
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

if __name__ == "__main__":
    import pdb
    pdb.set_trace()
    user = IuserUser.query.filter(IuserUser.email=='aagg@comcast.net').one()
    set_api_key(user.id,reset=False)
    our_uuid = IuserUUID.query.filter(IuserUUID.user_id==user.id).one().uuid
    print int( UUIDHandler().load(our_uuid) )

    print authenticate("aagg@comcast.net","nnnnnnnnnnnnnnnnnn")
