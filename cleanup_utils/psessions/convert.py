# -*- coding: iso8859-15 -*-
import os,sys
import pprint
import logging
import datetime
from dateutil import tz
import re
import csv
from sqlalchemy import and_
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'../..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import db,Base,metadata,DBSession,DOGPILE_CACHE_REGION
from legacy_models.iuser import (IuserPersonaPartner,IuserPersona,IuserUsertype,
    IuserAssignedusertype,IuserUser,ACTIVE_PERSONA_STATUS)
from legacy_models.member import MemberMember
from legacy_models.calendars import CalendarsEventtype
from legacy_models.curriculum import CurriculumPrompt
#from legacy_models.partners import PartnersSession
from temp_partners import TempPartnersSession

print "Did you change the time zone?"
import pdb
pdb.set_trace()

SERVER_TZ='America/New_York'

def do_residual():
    for p in DBSession.query(TempPartnersSession).filter(TempPartnersSession.new_start==None).all():
        new_start = p.start
        new_end_date = p.end_date
        DBSession.query(TempPartnersSession).filter(TempPartnersSession.id==p.id).update({
            'new_start':new_start.replace(tzinfo=None),
            'new_end_date':new_end_date.replace(tzinfo=None)})

        db.session.commit()

def convert():
    newdate_marker = datetime.datetime(2015,8,17,0,0,0).replace(tzinfo=tz.gettz('UTC')) 
    for p in DBSession.query(TempPartnersSession).all():
        new_start = p.start
        new_end_date = p.end_date
        print "Doing psession id {0}".format(p.id)
        if new_start.replace(tzinfo=tz.gettz(SERVER_TZ)).astimezone(tz.gettz('UTC')) < newdate_marker:
            DBSession.query(TempPartnersSession).filter(TempPartnersSession.id==p.id).update({
                'new_start':new_start.replace(tzinfo=tz.gettz(SERVER_TZ)).astimezone(tz.gettz('UTC')).replace(tzinfo=None),
                'new_end_date':new_end_date.replace(tzinfo=tz.gettz(SERVER_TZ)).astimezone(tz.gettz('UTC')).replace(tzinfo=None)})
        else:
            DBSession.query(TempPartnersSession).filter(TempPartnersSession.id==p.id).update({
                'new_start':new_start.replace(tzinfo=None),
                'new_end_date':new_end_date.replace(tzinfo=None)})

        db.session.commit()

def convert_before():
    import pdb
    pdb.set_trace()
    newdate_marker = datetime.datetime(2015,8,17,0,0,0).replace(tzinfo=tz.gettz(SERVER_TZ)) 
    for p in DBSession.query(TempPartnersSession).filter(start < newdate_marker).all():
        new_start = p.start
        new_end_date = p.end_date
        print "Doing psession id {0}".format(p.id)
        
        DBSession.query(TempPartnersSession).filter(TempPartnersSession.id==p.id).update({
            'new_start':new_start.replace(tzinfo=tz.gettz(SERVER_TZ)).astimezone(tz.gettz('UTC')).replace(tzinfo=None),
            'new_end_date':new_end_date.replace(tzinfo=tz.gettz(SERVER_TZ)).astimezone(tz.gettz('UTC')).replace(tzinfo=None)})

        db.session.commit()

def convert_after():
    import pdb
    pdb.set_trace()
    newdate_marker = datetime.datetime(2015,8,17,0,0,0).replace(tzinfo=tz.gettz(SERVER_TZ)) 
    for p in DBSession.query(TempPartnersSession).filter(start >= newdate_marker).all():
        new_start = p.start
        new_end_date = p.end_date
        print "Doing psession id {0}".format(p.id)

        DBSession.query(TempPartnersSession).filter(TempPartnersSession.id==p.id).update({
            'new_start':new_start.replace(tzinfo=None),
            'new_end_date':new_end_date.replace(tzinfo=None)})

        db.session.commit()

if __name__ == "__main__":
    import pdb
    pdb.set_trace()
    #db.session.execute('alter table partners_session drop column if exists new_start');
    #db.session.execute('alter table partners_session drop column if exists new_end_date');
    #db.session.execute('alter table partners_session add column new_start timestamp without time zone');
    #db.session.execute('alter table partners_session add column new_end_date timestamp without time zone');
    #db.session.commit()
    convert_before()
    #do_residual()
    #db.session.execute('alter table partners_session rename column end_date to old_end_date')
    #db.session.execute('alter table partners_session rename column new_end_date to end_date')
    #db.session.execute('alter table partners_session rename column start to old_start')
    #db.session.execute('alter table partners_session rename column new_start to start')
    #db.session.commit()
    

