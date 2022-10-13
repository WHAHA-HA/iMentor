# -*- coding: iso8859-15 -*-
import os,sys
import re
import pdb
import pprint
import traceback
import psycopg2
from dateutil import tz
from datetime import datetime,timedelta
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
projdir2 = os.path.abspath(os.path.join(appdir,'../..'))
if projdir2 not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)
    sys.path.append(projdir2)

from config.project_globals import Base,metadata,DBSession,get_scoped_session

#Import 'app' object from auth as well
from auth import api, app

from flask import  current_app, request, redirect, render_template

import sqlalchemy
from sqlalchemy import (BigInteger, Boolean, Column, Date, DateTime, desc,
    Float, ForeignKey, Index, Integer, Numeric, SmallInteger,
    String, Table, Text, Time, text, DATE, func, UniqueConstraint)
from sqlalchemy.dialects.postgresql.base import INET, TSVECTOR
from sqlalchemy.sql.expression import func, or_, not_, and_
from sqlalchemy.orm import relationship
from legacy_models.member import MemberMember
from legacy_models.utils import UtilsTimezone
from legacy_models.partners import PartnersPartner,PartnersSession
from legacy_models.iuser import (IuserUser,IuserUsertype,IuserPersona,
    IuserPersonaPartner,IuserAssignedusertype,USERTYPE_MAP,ACTIVE_PERSONA_STATUS)
from new_platform.utils.user_details import (get_persona_obj_for_user,
    get_latest_mentee_user_for_mentor, get_latest_mentor_user_for_mentee,
    get_partners_for_user,get_users_for_partners,get_admin_obj_for_user)
from new_platform.utils.roles import Role
from new_platform.utils.user_details import user_timezone
from google_services.gdrive import create_gdoc_copy
from canvas.models import *
from canvas.canvas_scheduling import schedule_fix_lessons
from attendance.models import Attendance

# We prefer this display formats for dates and times, since they are succinct yet still descriptive.
DATETIME_DISPLAY_FORMAT = '%-m/%-d/%y %-I:%M %p'

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Change these!

# Sometimes you create a new unit, sometimes you reuse one.
#unit_id=5  
grade_id=4  # 12th grade
canvas_type=CANVAS_TYPE_OPENING_LESSON
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def make_pc_curriculum(local_db_session):

    unit = UnitInfo(
        unit_number=1,
        description="Reconnect (New)",
        featured_image="Reconnect (New)", # Not really an image for some reason.
        secondary_description="Are we college ready? What can we do to prepare?"
        )

    local_db_session.add(unit)
    local_db_session.flush()
    print "Added unit id {0}".format(unit.id)

    # Check the above variables such as canvas_type, unit_id, etc.

    cur = Curriculum(
        canvas_type=canvas_type,
        curriculum_number=1,
        start_datetime=datetime.utcnow(), # start date doesn't really matter. 
        end_datetime=datetime.utcnow(), # end date doesn't really matter. 
        grade_id=grade_id,
        unit_id=unit.id,
        description="Reconnect (New)",
        featured_image="//cdn.imentor.org/new_platform/static/canvas/images/12.1.1b_480.jpg"
        )

    local_db_session.add(cur)
    local_db_session.flush()
    print "Added cur id {0}".format(cur.id)

    # PC lesson:
    cset = CanvasSet(
        role=MEMBER_ADMIN,
        curriculum_id=cur.id,
        start_datetime=cur.start_datetime, # start date doesn't really matter. 
        end_datetime=cur.end_datetime, # end date doesn't really matter. 
        description="Reconnect (New)",
        )

    local_db_session.add(cset)
    local_db_session.flush()
    print "Added cset id {0}".format(cset.id)

    # Section (app) 1 of 4
    capp = CanvasApp(
        canvas_set_id=cset.id,
        ordinal=100,
        app_type=APP_TYPE_PRESENTATION,
        n_of_total=1,
        total=2,
        description="Lesson Overview"
        )

    local_db_session.add(capp)
    local_db_session.flush()
    print "Added capp id {0}".format(capp.id)

    # Card (widget) 1 of 3
    wid = Widget(
        canvas_app_id=capp.id,
        ordinal=100,
        )

    local_db_session.add(wid)
    local_db_session.flush()
    print "Added wid id {0}".format(wid.id)

    widcon = WidgetContent(
        widget_id=wid.id,
        content_type=WIDGET_CONTENT_HTML,
        ordinal=100,
        html= '''
<img style="float:right;" src="//cdn.imentor.org/new_platform/static/canvas/images/remember.png">
<p>In this lesson, mentees will set expectations and norms for the year, review the purpose of the program in 12th grade, and discuss the role their mentor will play in their college process. Mentees will also use this time to reconnect with their mentors and complete the pre-program survey.</p>

<p>In this lesson, mentees will:</p>
<ul style="list-style-type: circle">
<li>Review the goals of the program in 12th grade.</li>
<li>Set expectations and norms for the year.</li>
<li>Reconnect and share their summer experiences with their mentors.</li>
<li>Complete pre-program survey.</li>
</ul>
<p></p>
<p></p>
<b>
For the complete lesson, click
<a target="_blank" href="https://staff.imentor.org/help/reconnect-1211b">here</a>
.
</b>
            '''
        )
    local_db_session.add(widcon)
    local_db_session.flush()
    print "Added widcon id {0}".format(widcon.id)

    # 2 of 3
    wid = Widget(
        canvas_app_id=capp.id,
        ordinal=200,
        )

    local_db_session.add(wid)
    local_db_session.flush()
    print "Added wid id {0}".format(wid.id)

    # 1 of 2
    widcon = WidgetContent(
        widget_id=wid.id,
        content_type=WIDGET_CONTENT_HTML,
        ordinal=100,
        html= '''
<img src="//cdn.imentor.org/new_platform/static/canvas/images/check.png" style="float:right;" />
Play the following graduation song as mentees arrive to class. The recognizable graduation march starts one minute into the song.
            '''
        )

    local_db_session.add(widcon)
    local_db_session.flush()
    print "Added widcon id {0}".format(widcon.id)

    # 2 of 2
    widcon = WidgetContent(
        widget_id=wid.id,
        content_type=WIDGET_CONTENT_AUDIO,
        ordinal=200,
        url= '//cdn.imentor.org/new_platform/static/canvas/sound_files/ORIGINAL_GRADUATION_SONG.mp3'
        )

    local_db_session.add(widcon)
    local_db_session.flush()
    print "Added widcon id {0}".format(widcon.id)

    # 3 of 3
    wid = Widget(
        canvas_app_id=capp.id,
        ordinal=300,
        )

    local_db_session.add(wid)
    local_db_session.flush()
    print "Added wid id {0}".format(wid.id)

    # 1 of 2
    widcon = WidgetContent(
        widget_id=wid.id,
        content_type=WIDGET_CONTENT_HTML,
        ordinal=100,
        html='Display the following slideshow to facilitate the lesson.'
        )

    local_db_session.add(widcon)
    local_db_session.flush()
    print "Added widcon id {0}".format(widcon.id)

    # 2 of 2
    widcon = WidgetContent(
        widget_id=wid.id,
        content_type=WIDGET_CONTENT_GDOC,
        ordinal=200,
        url='https://docs.google.com/a/imentor.org/presentation/d/1O87DGGJjUUv6etyZuw50wbhn3xKVduxhzhEAvCaOSYU/embed'
        )

    local_db_session.add(widcon)
    local_db_session.flush()
    print "Added widcon id {0}".format(widcon.id)

    # 2 of 4
    capp = CanvasApp(
        canvas_set_id=cset.id,
        ordinal=200,
        app_type=APP_TYPE_PRESENTATION,
        n_of_total=2,
        total=2,
        description="Mentee Canvas Preview"
        )

    local_db_session.add(capp)
    local_db_session.flush()
    print "Added capp id {0}".format(capp.id)

    # 1 of 1
    wid = Widget(
        canvas_app_id=capp.id,
        ordinal=100,
        )

    local_db_session.add(wid)
    local_db_session.flush()
    print "Added wid id {0}".format(wid.id)

    # 1 of 1
    widcon = WidgetContent(
        widget_id=wid.id,
        content_type=WIDGET_CONTENT_HTML,
        ordinal=100,
        html='The following Canvas cards are what your class will see during this lesson.'
        )

    local_db_session.add(widcon)
    local_db_session.flush()
    print "Added widcon id {0}".format(widcon.id)

    # 3 of 4, but showing lesson, so show as 1 of 2
    capp = CanvasApp(
        canvas_set_id=cset.id,
        ordinal=300,
        app_type=APP_TYPE_PRESENTATION,
        n_of_total=1,
        total=2,
        description="Read the following quotes"
        )

    local_db_session.add(capp)
    local_db_session.flush()
    print "Added capp id {0}".format(capp.id)

    # 1 of 1
    wid = Widget(
        canvas_app_id=capp.id,
        ordinal=100,
        )

    local_db_session.add(wid)
    local_db_session.flush()
    print "Added wid id {0}".format(wid.id)

    # 1 of 2
    widcon = WidgetContent(
        widget_id=wid.id,
        content_type=WIDGET_CONTENT_IMAGE,
        ordinal=100,
        url='//cdn.imentor.org/new_platform/static/canvas/images/Graduation_Quotes.jpg'
        )

    local_db_session.add(widcon)
    local_db_session.flush()
    print "Added widcon id {0}".format(widcon.id)

    # 2 of 2
    widcon = WidgetContent(
        widget_id=wid.id,
        content_type=WIDGET_CONTENT_HTML,
        ordinal=100,
        html='''
Consider the following: 
<ul>
<li>What do you think each of the quotes mean?</li>
<li>How might you apply this quote to your senior year?</li>
</ul>
            '''
        )

    local_db_session.add(widcon)
    local_db_session.flush()
    print "Added widcon id {0}".format(widcon.id)

    # 4 of 4, but showing lesson, so show as 2 of 2
    capp = CanvasApp(
        canvas_set_id=cset.id,
        ordinal=400,
        app_type=APP_TYPE_PRESENTATION,
        n_of_total=2,
        total=2,
        description="Share with your mentor"
        )

    local_db_session.add(capp)
    local_db_session.flush()
    print "Added capp id {0}".format(capp.id)

    # 1 of 1
    wid = Widget(
        canvas_app_id=capp.id,
        ordinal=100,
        )

    local_db_session.add(wid)
    local_db_session.flush()
    print "Added wid id {0}".format(wid.id)

    # 1 of 1
    widcon = WidgetContent(
        widget_id=wid.id,
        content_type=WIDGET_CONTENT_HTML,
        ordinal=100,
        html='''
<ul>
<li>Share your summer highlights with your mentor.</li>
<li>Ask your mentor three questions about his or her summer.</li>
<li>Share what you are most looking forward to this year.</li>
</ul>
            '''
        )

    local_db_session.add(widcon)
    local_db_session.flush()
    print "Added widcon id {0}".format(widcon.id)

    # Not expecting a response in the PC copy.
    # This exists for presentation purposes.
    # no: Expecting a response, so mark this.
    widconrm = WidgetContentResponseMarker(
        widget_content_id=widcon.id,
        response_type=APP_TYPE_PRESENTATION # Why we always default to this is beyond me.
        )

    local_db_session.add(widconrm)
    local_db_session.flush()
    print "Added widconrm id {0} (PC copy, no response will be accepted here)".format(widconrm.id)

    # Return the curriculum id that was just created, so we can reuse it with ease.
    return {'curriculum_id':cur.id}
