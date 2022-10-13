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
from legacy_models.iuser import IuserUser,IuserOccupation,IuserCareer
from legacy_models.utils import UtilsOccupation
from legacy_models.calendars import CalendarsEventtype
from legacy_models.curriculum import CurriculumPrompt
from apiforms.models import *

#NOTE: First Run occupation_field_rename.sql! After running this script, run occupation_field_remove.sql
# Then remove the old_ fields from legacy_models/iuser.py

# Legacy_ID,Legacy_Name,Legacy_ID_Consolidaton,New_Name,New_ID

def replace_objs(old_id,new_id,new_name):
    print "Old:%s, New:%s" % (old_id,new_id)
    try:
        print "New id: %s" % UtilsOccupation.query.filter(UtilsOccupation.id==new_id).one().id
    except:
        print "Can't find new id %s, skipping." % new_id
        return

    try:
        print "Old id: %s" % IuserOccupation.query.filter(IuserOccupation.id==old_id).one().id
    except:
        print "Old id %s not found, maybe it was already remapped?" % old_id
        return

    iem_obj = IuserUser.query.filter(IuserUser.old_occupation_id==old_id)
    for iem in iem_obj.all():
        old_occupation_id = iem.old_occupation_id
        try:
            print "IuserUser: Replaced old id: {0} with new {1} in name {2}, record {3}".format(
                old_occupation_id,
                new_id,
                iem.old_occupation.name,
                iem.id
                )
        except:
            pass
    iem_obj.update({'occupation_id':new_id,'old_occupation_id':None})
    db.session.commit()

    # Then delete old records.
    print "IuserOccupation: Deleting old records with id {0}".format(
        old_id)
    IuserOccupation.query.filter(IuserOccupation.id==old_id).delete()
    db.session.commit()

    print "There are now %s IuserUser instances of the old id %s:" % (IuserUser.query.filter(IuserUser.old_occupation_id==old_id).count(),old_id)


for csvf in ('Occupation_Mapping.csv',):
  with open(csvf, 'rb') as csvfile:
    reader = csv.DictReader(csvfile, delimiter=',', quotechar='"')
    count = 0
    for row in reader:
        count += 1
        print "Row count: %s" % count
        if row['Legacy_ID'] and row['New_ID']:
            row['Legacy_ID'] = int(row['Legacy_ID'])
            row['New_ID'] = int(row['New_ID'])
            # There were few consolidations, so I did them in the sql file, not here.
            # ignore consolidation column.
            if row['New_ID'] != row['Legacy_ID'] and row['New_ID'] not in (0,None,''):

                replace_objs(old_id=row['Legacy_ID'],new_id=row['New_ID'],
                    new_name=row['New_Name'])

            # No name replacement.

        db.session.commit()

# general cleanup: remove spaces form front/back of occupation names.
for i in UtilsOccupation.query.all():
    old_name = i.name
    new_name = i.name.strip()
    if old_name != new_name:

        # Find records with dup names. Replace them.
        ie_obj = UtilsOccupation.query.filter(
            UtilsOccupation.id==i.id).update({
            'name':new_name})
 
        db.session.commit()
