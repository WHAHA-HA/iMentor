#!/bin/env python
# -*- coding: iso8859-15 -*-
import os,sys
import re
import pdb
import pprint
import traceback
from dateutil import tz
from datetime import datetime,timedelta
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'../..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import db,Base,metadata,DBSession

#Import 'app' object from auth as well
from auth import api, app

from flask import  current_app, request, redirect, render_template

from sqlalchemy import (BigInteger, Boolean, Column, Date, DateTime, desc,
    Float, ForeignKey, Index, Integer, Numeric, SmallInteger,
    String, Table, Text, Time, text, DATE, func, UniqueConstraint)
from sqlalchemy.dialects.postgresql.base import INET, TSVECTOR
from sqlalchemy.sql.expression import func, or_, not_, and_
from sqlalchemy.orm import relationship
from legacy_models.member import MemberMember
from legacy_models.partners import PartnersPartner,PartnersSession
from legacy_models.iuser import (IuserUser,IuserUsertype,IuserPersona,
    IuserPersonaPartner,IuserAssignedusertype,USERTYPE_MAP,ACTIVE_PERSONA_STATUS)
from new_platform.utils.user_details import (get_persona_obj_for_user,
    get_latest_mentee_user_for_mentor, get_latest_mentor_user_for_mentee,
    get_partners_for_user,get_users_for_partners,get_admin_obj_for_user)
from new_platform.utils.roles import Role
from google_services.gdrive import create_gdoc_copy
from canvas.models import *


def gen_new_gdoc_copy(user_id,doc_id):

    user = IuserUser.query.filter(IuserUser.id==user_id).one()
    role = Role(user.id)

    mentor = None
    mentee = None
    other_user = None
    other_user_content = None
    if role.is_mentor:
        mentee = get_latest_mentee_user_for_mentor(user.id)
        '''
        if mentee:
           print "Mentor {0} matched mentee: {1}".format(user.id,mentee.id)
        else:
           print "Mentor {0} has no mentee match".format(user.id)
        '''
        other_user = mentee
        mentor = user

    elif role.is_mentee:
        mentor = get_latest_mentor_user_for_mentee(user.id)
        '''
        if mentor:
           print "Mentee {0} matched mentor: {1}".format(user.id,mentor.id)
        else:
           print "Mentee {0} has no mentor match".format(user.id)
        '''
        other_user = mentor
        mentee = user

    if other_user:
        other_user_content = WidgetContentCopy.query.filter(
            WidgetContentCopy.orig_doc_id==doc_id
            ).filter(WidgetContentCopy.user_id==other_user.id).first()

    current_user_content = WidgetContentCopy.query.filter(
        WidgetContentCopy.orig_doc_id==doc_id
        ).filter(WidgetContentCopy.user_id==user.id).first()

    if not current_user_content:
        # Did the match already generate a new copy? 
        # If so we want to collaborate.
        if other_user_content:
            print "Found copy for matching user {0}, reuse this for user {1}, document {2}".format(other_user.id,user.id,pprint.pformat(other_user_content.__dict__))

        else:
            # Neither user or other have a copy yet. Make one.
            # Created GDocs under the Mentee's user ID, if we have one.
            gdoc_user_id = user.id if not mentee else mentee.id
            new_doc = create_gdoc_copy(gdoc_user_id,doc_id)
            if other_user:
                print "Created new doc for user {0} original doc id {1} new doc id {2}. It is recommended to be used for the matching user as well: {3}".format(user.id,doc_id,new_doc['id'],other_user.id)
            else:
                print "Created new doc for user {0} original doc id {1} new doc id {2}".format(user.id,doc_id,new_doc['id'])

    else:
        if other_user:
            print "Found doc id copy {0} for this user {1}, not generating a new one. It is recommended that it be reused for the matching user as well: {2}".format(pprint.pformat(current_user_content.__dict__),user.id,other_user.id)
        if other_user:
            print "Found doc id copy {0} for this user {1}, not generating a new one.".format(pprint.pformat(current_user_content.__dict__),user.id)


if __name__ == "__main__":
    user_id=sys.argv[1]
    gdoc_id=sys.argv[2]
    gen_new_gdoc_copy(user_id,gdoc_id)
