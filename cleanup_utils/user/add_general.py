# -*- coding: iso8859-15 -*-
import os,sys
import pprint
import logging
import traceback
import datetime
import re
import csv
from pytz import timezone
from sqlalchemy import and_
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'../..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import db,Base,metadata,DBSession,DOGPILE_CACHE_REGION
from legacy_models.iuser import IuserUser,MentorSiteList
from legacy_models.partners import PartnersAttributes,PartnersPartner
from legacy_models.member import MemberSchool,MemberMember
from utils.roles import Role
from apiforms.models import *


def add_general():
    for mm in MemberMember.query.all():
        print "Doing member {0}".format(mm.id)
        mattr = MemberSchool.query.filter(MemberSchool.school=='General'
            ).filter(MemberSchool.graduating_class==9999
            ).filter(MemberSchool.member_id==mm.id).first()

        if not mattr:
            mattr = MemberSchool(
                school='General',
                graduating_class=9999,
                member_id=mm.id
                )
            db.session.add(mattr)
            db.session.commit()
            db.session.refresh(mattr)

        for user in IuserUser.query.filter(IuserUser.member_id==mm.id).all():
            try:
                role = Role(user.id)
                if (role and not Role(user.id).is_mentor) or not role:
                    continue
                
                print "Checking for mentor site list for user {0} member id {1}".format(
                    user.id,mm.id)
                ms = MentorSiteList.query.filter(MentorSiteList.user_id==user.id).first()
                if not ms:
                    ms = MentorSiteList(
                        user_id = user.id,
                        member_school_id = mattr.id
                        )
                    db.session.add(ms)
                    db.session.commit()
                    db.session.refresh(ms)
                    print "Added mentor site list for user {0} member id {1}".format(
                        user.id,mm.id)
            except:
                print "User {0} {1} failed: {2}".format(user.id,user.email,traceback.format_exc())

    db.session.commit()

if  __name__ == '__main__':
    add_general()
