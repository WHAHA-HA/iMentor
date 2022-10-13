# -*- coding: iso8859-15 -*-
import os,sys
import pprint
import logging
import datetime
import re
import csv
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'../..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import db,Base,metadata,DBSession,DOGPILE_CACHE_REGION
from legacy_models.iuser import IuserUser,MentorAttributes
from utils.roles import Role

USERHEAR = {
    'FF': 'Friend / Family',
    'SW': 'Surfing the Web',
    'VW': 'Volunteer Website',
    'VF': 'Volunteer Fair',
    'CWE': 'Co-worker / Employer',
    'NA': 'News Article',
    'O': 'Other'
    }


def gen_new_attribs():
    for user in IuserUser.query.all():
        print "Doing user {0}".format(user.id)
        if user.imentor_hear in USERHEAR:
            print "Replacing {0} with {1} for user {2}".format(
                user.imentor_hear,USERHEAR[user.imentor_hear],user.id)

            user.imentor_hear = USERHEAR[user.imentor_hear]
            db.session.commit()
        elif user.imentor_hear not in (None,''):
            print "Unknown Hear value for user id {0}: {1}".format(
                user.id,user.imentor_hear)

if  __name__ == '__main__':
    gen_new_attribs()
