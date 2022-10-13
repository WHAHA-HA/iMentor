# -*- coding: iso8859-15 -*-
import os,sys
import pprint
import traceback
import re
import time
import mimetypes
import googlemaps
from httplib2 import Http
from datetime import datetime
from decimal import Decimal

appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.settings import GOOGLE_API_KEY,HOSTNAME
from config.project_globals import db,ENV_TYPE

from google_services import gauth, gdrive_service
from pydrive.drive import GoogleDrive
from googleapiclient.errors import HttpError

#Import 'app' object from auth as well
from auth import api, app

# Google maps API

gmaps=None

if 'iMentor' in HOSTNAME:
    # API key is only good for dev and prod IP ranges.
    gmaps = googlemaps.Client(key=GOOGLE_API_KEY)

# Comma-separated address, city, zipcode. State is not required.
def get_long_lat(address):
    if not gmaps:
        return None,None

    try:
        geocode_result = gmaps.geocode(address + ', USA')
        latitude = Decimal(geocode_result[0]['geometry']['location']['lat'])
        longitude = Decimal(geocode_result[0]['geometry']['location']['lng'])
    except:
        print("get_long_lat failed for this address:{0} with this error:{1}".format(
            address,traceback.format_exc()))
        return None,None

    return longitude,latitude
