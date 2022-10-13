# -*- coding: iso8859-15 -*-
import os,sys
import pprint
import traceback
import re
import time
import mimetypes
from httplib2 import Http
from datetime import datetime
from decimal import Decimal

appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.settings import GOOGLE_API_KEY,HOSTNAME
from config.project_globals import get_scoped_session,ENV_TYPE

#Import 'app' object from auth as well
from auth import api, app

from google_services.geocoding import get_long_lat
from legacy_models.member import MemberMember
from legacy_models.partners import PartnersPartner
from legacy_models.iuser import IuserUser


def one_time_load():

    local_db_session = get_scoped_session()

    '''
    for member in local_db_session.query(MemberMember).all():
        if not member.member_long:
            print "Doing member {0}".format(member.id)
            address = member.address + ',' + member.city + ',' + member.zip_code
            lng,lat = get_long_lat(address)
            if lng and lat:
                member.member_long = lng
                member.member_lat = lat
                local_db_session.commit()
                local_db_session.begin()
    '''
        
    for partner in local_db_session.query(PartnersPartner).all():
        if not partner.partner_long:
            print "Doing partner {0}".format(partner.id)
            address = partner.street_address + ',' + partner.city + ',' + partner.zip_code
            lng,lat = get_long_lat(address)
            if lng and lat:
                partner.partner_long = lng
                partner.partner_lat = lat
                local_db_session.commit()
                local_db_session.begin()
        
    for user in local_db_session.query(IuserUser).filter(IuserUser.status=='A').order_by('id').all():
        if not user.work_long:
            print "Doing user {0}".format(user.id)
            address = user.work_address + ',' + user.work_city + ',' + user.work_zip_code
            lng,lat = get_long_lat(address)
            if lng and lat:
                user.work_long = lng
                user.work_lat = lat
                local_db_session.commit()
                local_db_session.begin()
            address = user.address1 + ',' + user.city + ',' + user.zip_code
            lng,lat = get_long_lat(address)
            if lng and lat:
                user.home_long = lng
                user.home_lat = lat
                local_db_session.commit()
                local_db_session.begin()
        
        
    local_db_session.commit()

if __name__ == "__main__":
    one_time_load()
