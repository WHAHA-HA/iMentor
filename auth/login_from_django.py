#!/usr/bin/env python
# -*- coding: iso8859-15 -*-
import pprint
import copy
import os,sys
import base64,pickle
from datetime import datetime
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

# Log into Django. test Flask login. Log out.
from flask import request
from flask_login import current_user

# Copied from Flask, modified to decode the Django session ID into a user id.

from flask_login import LoginManager,_signals,_get_user
from flask import (_request_ctx_stack, abort, current_app, flash, redirect,
                   request, session, url_for, has_request_context)

from legacy_models.django import DjangoSession
from legacy_models.auth import AuthUser
from legacy_models.iuser import IuserUser

from config.settings import DEFAULT_TEST_USER_ID, LOGIN_DISABLED

#: Sent when the user is loaded from the cookie. In addition to the app (which
#: is the sender), it is passed `user`, which is the user being reloaded.
user_loaded_from_cookie = _signals.signal('loaded-from-cookie')


def decode_cookie(cookie):
    '''
    Decoding session cookie from Django.
    Needed to add login disabled check for render_template(), 
    which doesn't check this flag, sadly.
    '''
    if LOGIN_DISABLED and DEFAULT_TEST_USER_ID:
        return DEFAULT_TEST_USER_ID

    session = DjangoSession.query.filter(
        DjangoSession.session_key==cookie).filter(
        DjangoSession.expire_date > datetime.now()).first()

    if not session:
        return

    session_data = session.session_data
    encoded_data = base64.decodestring(session_data)
    hash, pickled = encoded_data.split(':', 1)

    cookie_user = pickle.loads(pickled).get('_auth_user_id')
    print "Got cookie, returning {0}".format(cookie_user)
    return cookie_user


class LocalLoginManager(LoginManager):

    '''
    This was not customized. It was overridden here to call a local
    decode_cookie function.
    See auth/__init__ for the user load function.
    '''
    def _load_from_cookie(self, cookie):
        if self.token_callback:
            user = self.token_callback(cookie)
            if user is not None:
                session['user_id'] = getattr(user, self.id_attribute)()
                session['_fresh'] = False
                _request_ctx_stack.top.user = user
            else:
                self.reload_user()
        else:
            user_id = decode_cookie(cookie)
            if user_id is not None:
                session['user_id'] = user_id
                session['_fresh'] = False

            self.reload_user()

        if _request_ctx_stack.top.user is not None:
            app = current_app._get_current_object()
            user_loaded_from_cookie.send(app, user=_get_user())

'''
User for websockets.
'''
def verify_session_id(sessionid):
    # returns user id or None
    return decode_cookie(sessionid)
