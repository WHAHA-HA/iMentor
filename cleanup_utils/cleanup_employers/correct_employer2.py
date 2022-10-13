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
from legacy_models.iuser import IuserEmployer,IuserEmployerMember,IuserUser
from apiforms.models import *

#Member_Site_ID|Employer_ID|Employer_Name|New_Employer_ID|New_Employer_Name
mapped_names = {}

def replace_objs(old_id,new_id,new_name):
    # First do iuser_employer_member.
    # Make sure old and new ids exists.
    print "Old:%s, New:%s" % (old_id,new_id)
    try:
        print "New id: %s" % IuserEmployer.query.filter(IuserEmployer.id==new_id).one().id
    except:
        print "Can't find new id %s, skipping." % new_id
        return

    try:
        print "Old id: %s" % IuserEmployer.query.filter(IuserEmployer.id==old_id).one().id
    except:
        print "Old id %s not found, maybe it was already remapped?" % old_id
        return

    iem_obj = IuserEmployerMember.query.filter(IuserEmployerMember.employer_id==old_id)
    for iem in iem_obj.all():
        old_employer_id = iem.employer_id
        try:
            print "IuserEmployerMember: Replaced old id: {0} with new {1} in name {2}, record {3}".format(
                old_employer_id,
                new_id,
                iem.employer.name,
                iem.id
                )
        except:
            pass
    iem_obj.update({'employer_id':new_id})
    db.session.commit()

    # Then do iuser_user.
    iem_obj = IuserUser.query.filter(IuserUser.employer_id==old_id)
    for iem in iem_obj.all():
        old_employer_id = iem.employer_id
        print "IuserUser: Replaced old id: {0} with new {1} in name {2}, record {3}".format(
            old_employer_id,
            new_id,
            iem.employer.name,
            iem.id
            )
    iem_obj.update({'employer_id':new_id})
    db.session.commit()

    # Then do application responses.
    q_ids = [x.id for x in QuestionCopy.query.filter(
        QuestionCopy.question_text.like('Employer%')).all()]

    iem_obj = UserResponse.query.filter(
        UserResponse.question_id.in_(q_ids)).filter(
        UserResponse.selected_id==old_id)

    for iem in iem_obj.all():
        old_employer_id = iem.selected_id
        print "UserResponse: Replaced old id: {0} with new {1} in name {2}, record {3}".format(
            old_employer_id,
            new_id,
            iem.user_response,
            iem.id
            )
    iem_obj.update({'selected_id':new_id,'user_response':new_name},
        synchronize_session='fetch')

    db.session.commit()

    # Then delete old records.
    print "IuserEmployer: Deleting old records with id {0}".format(
        old_id)
    IuserEmployer.query.filter(IuserEmployer.id==old_id).delete()
    db.session.commit()

    print "There are now %s IuserEmployer instances of the old id %s:" % (IuserEmployer.query.filter(IuserEmployer.id==old_id).count(),old_id)
    print "There are now %s IuserUser instances of the old id %s:" % (IuserUser.query.filter(IuserUser.employer_id==old_id).count(),old_id)
    print "There are now %s UserResponse instances of the old id %s:" % (UserResponse.query.filter(UserResponse.question_id.in_(q_ids)).filter(
        UserResponse.selected_id==old_id).count(),old_id)


#for csvf in ('./Employer_Cleanup.csv','./EmployerCleanup2.csv'):
for csvf in ('./05202015_employer_updates.txt',):
  with open(csvf, 'rb') as csvfile:
    reader = csv.DictReader(csvfile, delimiter='|', quotechar=',')
    count = 0
    for row in reader:
        count += 1
        print "Row count: %s" % count
        if row['New_Employer_ID']:
            row['Employer_ID'] = int(row['Employer_ID'])
            row['New_Employer_ID'] = int(row['New_Employer_ID'])
            row['New_Employer_Name'] = row['New_Employer_Name'].strip()

            '''
            # already mapped
            if row['Employer_ID'] in mapped_names:
                continue

            if row['Employer_ID'] in mapped_names.values():
                for k,v in mapped_names.items():
                    if v == row['Employer_ID']:
                        break
                print "Error: this id {0} has been mapped already from {1} to {2}, skipping this row:{3}".format(
                    row['Employer_ID'],k,v,pprint.pformat(row))
                continue
            '''

            if row['New_Employer_ID'] != row['Employer_ID'] and row['New_Employer_ID'] not in (0,None,''):

                replace_objs(old_id=row['Employer_ID'],new_id=row['New_Employer_ID'],
                    new_name=row['New_Employer_Name'])

                mapped_names[row['Employer_ID']] = row['New_Employer_ID']

            if row['New_Employer_Name'] not in ('',None,0):
                print "Replacing name: %s %s, first getting rid of dups." % (row['New_Employer_ID'],row['New_Employer_Name'])
                # Finally, replace name.
                # Replace any dup names, so foreign key doesn't complain.
                # These records will be deleted anyway. 
                ie_obj = IuserEmployer.query.filter(
                    IuserEmployer.name==row['New_Employer_Name']).filter(
                    IuserEmployer.id!=row['New_Employer_ID'])

                for ie in ie_obj.all():
                    replace_objs(old_id=ie.id,new_id=row['New_Employer_ID'],
                        new_name=row['New_Employer_Name'])

                    mapped_names[ie.id] = row['New_Employer_ID']
                

                ie_obj = IuserEmployer.query.filter(IuserEmployer.id==row['New_Employer_ID'])
                try:
                    ie = ie_obj.one()
                    #old_name = ie.name
                    ie_obj.update({'name':row['New_Employer_Name']})

                except:
                    db.session.rollback()
                    print "WHERE DID THIS RECORD GO? %s %s" % (row['New_Employer_ID'],row['New_Employer_Name'])
                    '''
                    ie_obj = IuserEmployer(id=row['New_Employer_ID'],name=row['New_Employer_Name'])
                    db.session.add(ie_obj)
                    db.session.commit()
                    '''
                    continue

                try:
                    print "Replaced name {1} in id {2}".format(
                        IuserEmployer.query.filter(IuserEmployer.id==row['New_Employer_ID']).one().name,
                        row['New_Employer_ID']
                        )
                except:
                    pass

        db.session.commit()

# general cleanup: remove spaces form front/back of employer names.
for i in IuserEmployer.query.all():
    old_name = i.name
    new_name = i.name.strip()
    if old_name != new_name:

        # Find records with dup names. Replace them.
        ie_obj = IuserEmployer.query.filter(
            IuserEmployer.name==new_name).filter(
            IuserEmployer.id!=i.id)

        for ie in ie_obj.all():
            print "Removing dups for stripped name: %s" % pprint.pformat(i.__dict__)
            replace_objs(old_id=ie.id,new_id=i.id,new_name=new_name)
        else:
            IuserEmployer.query.filter(IuserEmployer.id==i.id).update({'name':new_name})
            print "Stripped whitespace from %s" % pprint.pformat(i.__dict__)
            db.session.commit()
