#!/bin/env python
# -*- coding: iso8859-15 -*-
import pdb
import pprint
import copy
import traceback
import os,sys
import csv
from datetime import datetime
from dateutil import tz
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'../..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import db,Base,metadata
from config.settings import (ENV_TYPE,LOGIN_DISABLED,
    DEFAULT_TEST_USER_ID)

from sqlalchemy.sql.expression import func, or_, not_, and_
from sqlalchemy.orm import sessionmaker 
from sqlalchemy.orm.exc import NoResultFound, MultipleResultsFound

from auth import app,lauth
from canvas import canvas
app.register_blueprint(canvas) # so templates can be found

from canvas.canvas_utils import (get_specific_canvas_set_for_user,
    fix_overlapping_canvas_sets,CANVAS_TYPE_LESSON)
from canvas.legacy_updates import update_legacy_dependencies_with_new_canvas_set

from legacy_models.iuser import IuserUser
from utils.roles import Role
from utils.user_details import get_partners_for_user

def parse_and_load_csv(csv_file):
  with open(csv_file, 'rU') as csvfile:
    # User_ID|Canvas_Set_ID|Curriculum_ID|Canvas_Start_Date_YYYYMMDD_HHMMSS|Canvas_End_Date_YYYYMMDD_HHMMSS|Curr_Start_Date_YYYYMMDD_HHMMSS|Curr_End_Date_YYYYMMDD_HHMMSS
    reader = csv.DictReader(csvfile, delimiter='|', quotechar="'")
    count = 0
    for row in reader:
        count += 1
        print "Row count: %s" % count
        user = IuserUser.query.filter(IuserUser.id==row['User_ID']).first()
        if not user:
            print "User {0} nonexistent, skipping.".format(row['User_ID'])
            continue

        role = Role(user.id)
        partner = None
        partners = get_partners_for_user(user,role)
        if partners:
            partner = partners[0]

        cset_start_date = datetime.strptime(row['Canvas_Start_Date_YYYYMMDD_HHMMSS'],'%Y%m%d_%H%M%S')
        cset_end_date = datetime.strptime(row['Canvas_End_Date_YYYYMMDD_HHMMSS'],'%Y%m%d_%H%M%S')

        # We're going to have to ignore the curriculum dates, and make them match
        # the canvas set dates exactly.
        #curr_start_date = datetime.strptime(row['Curr_Start_Date_YYYYMMDD_HHMMSS'],'%Y%m%d_%H%M%S')
        #curr_end_date = datetime.strptime(row['Curr_End_Date_YYYYMMDD_HHMMSS'],'%Y%m%d_%H%M%S')

        to_tz = tz.gettz(user.member.time_zone.name)

        cset_start_date = cset_start_date.replace(tzinfo=to_tz)
        cset_start_date = cset_start_date.astimezone(tz.gettz('UTC'))
        cset_start_date = cset_start_date.replace(tzinfo=None)

        cset_end_date = cset_end_date.replace(tzinfo=to_tz)
        cset_end_date = cset_end_date.astimezone(tz.gettz('UTC'))
        cset_end_date = cset_end_date.replace(tzinfo=None)

        errors,cset_start_date, cset_end_date = \
            fix_overlapping_canvas_sets(user,cset_start_date,cset_end_date)

        curr_start_date = cset_start_date
        curr_end_date = cset_end_date

        try:
            cscopy = get_specific_canvas_set_for_user(user,row['Curriculum_ID'],
                row['Canvas_Set_ID'],skip_other=False,curr_start_date=curr_start_date,
                curr_end_date=curr_end_date,cset_start_date=cset_start_date,
                cset_end_date=cset_end_date)

            update_legacy_dependencies_with_new_canvas_set(
                cscopy['canvas_set']['curriculum_id'],
                partner.id,cset_start_date,cset_end_date)

        except:
            print "Error occurred on user {0}, skipping: {1}".format(
                user.id,traceback.format_exc())


if __name__ == '__main__':
    parse_and_load_csv(sys.argv[1])
    #parse_and_load_csv('grade_10.csv')
