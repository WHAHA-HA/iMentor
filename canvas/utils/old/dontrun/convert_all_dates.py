# -*- coding: iso8859-15 -*-
import os,sys
import re
import pdb
import pprint
import traceback
from dateutil import tz
from datetime import datetime
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'../..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import db,Base,metadata

#Import 'app' object from auth as well
from auth import api, app

from flask import  current_app, request, redirect, render_template

from sqlalchemy import (BigInteger, Boolean, Column, Date, DateTime,
    Float, ForeignKey, Index, Integer, Numeric, SmallInteger,
    String, Table, Text, Time, text, DATE, func, UniqueConstraint)
from sqlalchemy.dialects.postgresql.base import INET, TSVECTOR
from sqlalchemy.sql.expression import func, or_, not_, and_
from sqlalchemy.orm import relationship
from legacy_models.member import MemberMember
from legacy_models.iuser import IuserUser,IuserPersona,USERTYPE_MAP
from new_platform.utils.user_details import (get_persona_obj_for_user,
    get_latest_mentee_user_for_mentor, get_latest_mentor_user_for_mentee,
    get_partners_for_user)
from new_platform.utils.roles import Role
from google_services.gdrive import create_gdoc_copy
from canvas.models import *

def convert_all_dates():

     # All dates are in EST. Convert to UTC, save without time zone.
    from_tz = tz.gettz('US/Eastern')
    to_tz = tz.gettz('UTC')

    for i in CanvasSetCopy.query.all():
        new_startdt = i.start_datetime.replace(tzinfo=from_tz)
        new_startdt = new_startdt.astimezone(to_tz)
        new_startdt = new_startdt.replace(tzinfo=None)

        new_enddt = i.end_datetime.replace(tzinfo=from_tz)
        new_enddt = new_enddt.astimezone(to_tz)
        new_enddt = new_enddt.replace(tzinfo=None)

        new_ustarted = None
        if i.user_started:
            new_ustarted = i.user_started.replace(tzinfo=from_tz)
            new_ustarted = new_ustarted.astimezone(to_tz)
            new_ustarted = new_ustarted.replace(tzinfo=None)

        new_ucompleted = None
        if i.user_completed:
            new_ucompleted = i.user_completed.replace(tzinfo=from_tz)
            new_ucompleted = new_ucompleted.astimezone(to_tz)
            new_ucompleted = new_ucompleted.replace(tzinfo=None)

        CanvasSetCopy.query.filter(CanvasSetCopy.id==i.id).update(
            {'start_datetime': new_startdt, 'end_datetime': new_enddt,
             'user_started': new_ustarted, 'user_completed': new_ucompleted})

    for i in CurriculumCopy.query.all():
        new_startdt = i.start_datetime.replace(tzinfo=from_tz)
        new_startdt = new_startdt.astimezone(to_tz)
        new_startdt = new_startdt.replace(tzinfo=None)

        new_enddt = i.end_datetime.replace(tzinfo=from_tz)
        new_enddt = new_enddt.astimezone(to_tz)
        new_enddt = new_enddt.replace(tzinfo=None)

        CurriculumCopy.query.filter(CurriculumCopy.id==i.id).update(
            {'start_datetime': new_startdt, 'end_datetime': new_enddt})

    local_db_session.commit()


if __name__ == "__main__":
    convert_all_dates()
