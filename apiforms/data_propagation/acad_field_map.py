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
from legacy_models.iuser import IuserUser,IuserAcademicfield,IuserUserAcademicField
from apiforms.models import *

for csvf in ('./Academic-Field_Mapping.csv',):
  with open(csvf, 'rb') as csvfile:
    # Legacy_ID,Legacy_Name,Legacy_ID_Consolidaton,New_Name,New_IDs
    reader = csv.DictReader(csvfile, delimiter=',', quotechar='"')
    count = 0
    for row in reader:
        count += 1
        print "Row count: %s" % count
        legacy_id = int(row['Legacy_ID'])
        new_id = int(row['Legacy_ID_Consolidaton']) if row['Legacy_ID_Consolidaton'] not in (None,'') else None
        if row['Legacy_ID_Consolidaton']:
            fix = IuserUserAcademicField.query.filter(
                IuserUserAcademicField.academicfield_id==legacy_id
                )
            fixall = fix.all()
            for f in fixall:
                '''
                if f.academicfield_id != legacy_id:
                    import pdb
                    pdb.set_trace()
                    from sqlalchemy.dialects import postgresql
                    print str(fix.statement.compile(dialect=postgresql.dialect()))
                    print "What the hell!!??! skipping. {0} {1} {2}, for afield {3}".format(
                        f.id,f.user_id,f.academicfield_id,legacy_id)
                    continue
                '''

                print "Fixing {0} {1} {2}, for afield {3}".format(f.id,f.user_id,f.academicfield_id,legacy_id)
                # if record with new id already exists, delete old. Otherwise relace old.
                if IuserUserAcademicField.query.filter(
                    IuserUserAcademicField.academicfield_id==new_id
                    ).filter(IuserUserAcademicField.user_id==f.user_id
                    ).first():

                    IuserUserAcademicField.query.filter(
                        IuserUserAcademicField.academicfield_id==legacy_id
                        ).filter(IuserUserAcademicField.user_id==f.user_id
                        ).delete()
                else:
                    IuserUserAcademicField.query.filter(
                        IuserUserAcademicField.academicfield_id==legacy_id
                        ).filter(IuserUserAcademicField.user_id==f.user_id
                        ).update({'academicfield_id':new_id})

            db.session.commit()

            af = IuserAcademicfield.query.filter(
                IuserAcademicfield.id==legacy_id
                ).first()

            if af:
                print "Deleting {0}".format(pprint.pformat(af.__dict__))
                IuserAcademicfield.query.filter(
                    IuserAcademicfield.id==legacy_id
                    ).delete()
                db.session.commit()

        if row['New_Name']:
            new_name = row['New_Name'].strip()
            print "Updating name from {0} to {1}".format(row['Legacy_Name'],new_name)
            IuserAcademicfield.query.filter(
                IuserAcademicfield.id==legacy_id
                ).update({'name':new_name})

            db.session.commit()

