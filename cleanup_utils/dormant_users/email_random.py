import pdb
import os,sys
import pprint
import csv
import string
import random
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'../..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import db,Base,metadata

from sqlalchemy import (BigInteger, Boolean, Column, Date, DateTime,
    Float, ForeignKey, Index, Integer, Numeric, SmallInteger,
    String, Table, Text, Time, text, DATE, func)
from sqlalchemy.dialects.postgresql.base import INET, TSVECTOR
from sqlalchemy.sql.expression import func, or_, not_, and_
from sqlalchemy.orm import relationship
from legacy_models.iuser import (IuserUser,IuserPersona,
    IuserPersonaPartner,PartnersPartner,MemberMember,
    IuserAssignedusertype,IuserUsertype,get_details_for_user)

def id_generator(size=6, chars=string.ascii_uppercase + string.digits):
    return ''.join(random.choice(chars) for _ in range(size))

with open('./email_randomization.csv', 'rb') as csvfile:
    reader = csv.DictReader(csvfile, delimiter=',', quotechar='"')
    count = 0
    for row in reader:
        count += 1
        print "Row count: %s" % count

        userobj = IuserUser.query.filter(
            IuserUser.id == row['ID']).filter(
            IuserUser.email == row['EMAIL'])

        user = userobj.first()
        if not user:
            print "User not found, skipping: {0}:{1}".format(
                row['ID'],row['EMAIL'])
            continue

        print "Found user {0} {1}".format(user.id,user.email)
        userobj.update({'email':'PURGE_USER_{0}'.format(id_generator(10))})
        result = db.session.commit()

        user = IuserUser.query.filter(
            IuserUser.id == row['ID']).one()
        print "Changed {0} email to: {1}".format(user.id,user.email)



