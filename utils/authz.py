# -*- coding: iso8859-15 -*-
import os,sys
import pprint
import logging
import datetime
import pymongo
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'../..'))
projdir2 = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)
    sys.path.append(projdir2)
from config.settings import (MONGO_HOST,MONGO_PORT,
    MONGO_DBNAME_LOGS,MONGO_GENERIC_LOGQUEUE_COLLNAME)
from config.project_globals import (Base,metadata,
    DBSession,DOGPILE_CACHE_REGION,get_scoped_session)
from config.caching_query import CachingQuery,FromCache
from sqlalchemy import (BigInteger, Boolean, Column, Date, DateTime,
    Float, ForeignKey, Index, Integer, Numeric, SmallInteger,
    String, Table, Text, Time, text, func, or_)
from sqlalchemy.sql.expression import func, or_, not_, and_
from sqlalchemy.orm import sessionmaker
from sqlalchemy.orm.exc import NoResultFound, MultipleResultsFound

#Import 'app' object from auth as well
from auth import api, app

from legacy_models.iuser import IuserUser
from legacy_models.log import CONTENT_TYPE_USER
from new_platform.utils.roles import Role
from new_platform.utils.user_details import get_persona_obj_for_user

mongo_connection = pymongo.mongo_client.MongoClient(MONGO_HOST,MONGO_PORT)
database = pymongo.database.Database(mongo_connection,MONGO_DBNAME_LOGS)
generic_logq_coll = database[MONGO_GENERIC_LOGQUEUE_COLLNAME]

from legacy_models.iuser import (BASIC_USER,
    MEMBER_ADMIN,E_MEMBER_ADMIN,REGIONAL_ADMIN,PARTNER_ADMIN,MENTOR,
    MENTEE,SUPER_ADMIN)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def can_user_access_messaging(user_id=None,email=None):
    if Role(user_id,email).role == SUPER_ADMIN:
        return True

    persona = get_persona_obj_for_user(user_id=user_id,email=email,get_all_active=False,
        ignore_match_status=True,ignore_active_status=True)
    if persona.memberprofile_edit_messaging:
        return True
    return False

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def check_authz(current_user,user_id,replace_user=True,must_be_users_admin=False,log_error=True):

    '''
    Check if a user is allowed to act on behalf of another user in two ways:
    (1) Check if current user is some form of admin for the user_id's member site.
    (2) Also check if the current user is specifically that user's admin,
    if the corresponding flag is set.
    '''
    if user_id:
        on_behalf_of_user = DBSession.query(IuserUser).filter(IuserUser.id==user_id).one()

        role = Role(user_id=current_user.id)

        if not role.is_some_admin_for_site_id(on_behalf_of_user.member_id):

            if log_error:
                msg = "User {0} tried to get to data on behalf of user {1}, but they either aren't an admin, or don't belong to site id {2}. We kicked them out.".format(
                    current_user.email,user_id,on_behalf_of_user.member_id
                    )

                # For Django user reporting. This should either go away or be improved.
                log_data = {'content_type':{'id':CONTENT_TYPE_USER},
                    'object_id':current_user.id,
                    'message':msg,
                    'category':'on_behalf_of',
                    'datetime':datetime.datetime.now()
                }
                new_id = generic_logq_coll.insert_one(log_data)

                app.logger.exception(msg)

            return None

        if must_be_users_admin:

            if not role.is_this_the_admin_for_this_user(user_id):
                if log_error:
                    msg = "User {0} tried to get to data on behalf of user {1}, but they aren't that user's admin, and must_be_users_admin is set to True: {2}. We kicked them out.".format(
                        current_user.email,user_id,on_behalf_of_user.member_id
                        )

                    # For Django user reporting. This should either go away or be improved.
                    log_data = {'content_type':{'id':CONTENT_TYPE_USER},
                        'object_id':current_user.id,
                        'message':msg,
                        'category':'on_behalf_of',
                        'datetime':datetime.datetime.now()
                    }
                    new_id = generic_logq_coll.insert_one(log_data)

                    app.logger.exception(msg)

                return None

        msg = "Admin {0} is acting on behalf of user {1} for member site {2}, passed all tests, we let them through. The must_be_users_admin flag was {3}. The admin is an admin at the user's member site".format(
            current_user.email,user_id,on_behalf_of_user.member_id,must_be_users_admin
            )

        # For Django user reporting. This should either go away or be improved.
        log_data = {'content_type':{'id':CONTENT_TYPE_USER},
            'object_id':current_user.id,
            'message':msg,
            'category':'on_behalf_of',
            'datetime':datetime.datetime.now()
        }
        new_id = generic_logq_coll.insert_one(log_data)

        # If they passed the test, make the "on behalf of" user the current user,
        # if the corresponding flag is set.
        if replace_user:
            current_user = on_behalf_of_user

    return current_user


