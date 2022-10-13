# -*- coding: iso8859-15 -*-
import os,sys
from datetime import datetime, date, timedelta
from dateutil import relativedelta
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import (db,Base,metadata,
    DBSession,get_scoped_session,DOGPILE_CACHE_REGION)
from config.caching_query import FromCache
from config.settings import (ENV_TYPE,LOGIN_DISABLED,
    DEFAULT_TEST_USER_ID,CDN_PREFIX)

from flask import Response, json, jsonify, make_response, url_for, abort
from flask import  current_app, request, redirect, render_template
from flask.views import View, MethodView
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.sql.expression import func, or_, not_, and_
from sqlalchemy.orm import sessionmaker 
from sqlalchemy.orm.exc import NoResultFound, MultipleResultsFound

from flask_login import (current_user,
                             login_user, logout_user, UserMixin,
                             confirm_login, fresh_login_required)
from flask_restful import Resource, Api, fields, marshal_with
#from flask_wtf import Form, RadioField

#Import 'app' object from auth as well
from auth import api, app, login_required

from tasks import tasks # app name

from legacy_models.iuser import IuserUser,USERTYPE_MAP,IuserPersona
from legacy_models.calendars import CalendarsEvent, CalendarsInvitation
from new_platform.utils.user_details import get_details_for_user

from sqlalchemy import (BigInteger, Boolean, Column, Date, DateTime,
    Float, ForeignKey, Index, Integer, Numeric, SmallInteger,
    String, Table, Text, Time, text, DATE, func, UniqueConstraint)


from tasks.models import (Rating, RatingPeriod, Announcement, AnnouncementAck, AnnouncementLocal,
    RecurringInfoUpdate, RecurringInfoUpdateAck, RecurringInfoUpdateLocal)
from tasks.tasks_utils import (get_user_credentials, 
    update_rsvp, ratings_update_obj, get_upcoming_events)

from utils.roles import Role
from utils.user_details import get_partners_for_user

BASE_URL = "/tasks"
DATE_FORMAT = '%Y/%m/%d'

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# TasksSurveys is handled by the qualtrics code on the back end. On the
# front end, it will be considered a Task.

class TasksRatings(Resource):

    from flask_login import current_user
    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    resp_get_json = {        
        'rating':  fields.Integer,
        'name' : fields.String,
        'show':fields.Boolean
        #'id' : fields.Integer,
        }

    resp_post_json = {
        'success':  fields.Boolean,
        'error':fields.String
        }



    @login_required
    @marshal_with(resp_post_json)
    def post(self,some_variables=None):
        from flask_login import current_user
        local_db_session = get_scoped_session()

        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        details=get_user_credentials(current_user)
        if not details:
            print("User {0} has no peer".format(current_user.email))
            return  {'success': False, 'error':'No peer to rate'}

        today=datetime.utcnow()           

        if not details.rated_before:
            if(today.date()<details.startdate):
                print("The ratings record is empty and time not yet ripe for rating"+"today : "+str(today)+" startdate : "+str(details.startdate))
                return  {'success': False, 'error':'time not yet ripe for rating'}  
        else:            
            if(today.date()<details.last_rated.date()):
                return  {'success': False, 'error':'current date is behind last rated date!!!!'}  

            date_delta = relativedelta.relativedelta(today,details.last_rated)
            if details.frequency_month >= 1 and date_delta.months < 1:
                return  {'success': False, 'error':'time not yet ripe for rating'}                    

            # These are mostly used for testing
            elif details.frequency_day >= 1 and date_delta.days < 1:
                return  {'success': False, 'error':'time not yet ripe for rating'}                    
            elif details.frequency_hour >= 1 and date_delta.hours < 1:
                return  {'success': False, 'error':'time not yet ripe for rating'}                    
            elif details.frequency_minute >= 1 and date_delta.minutes < 1:
                return  {'success': False, 'error':'time not yet ripe for rating'}                    

        rat=(request.json)['rating']        
        print(rat)        

        if(details.iam_mentee==False):
            rating_record=Rating(mentor_persona_id=details.mentor_persona_id,mentee_persona_id=details.mentee_persona_id,mentee_rating=rat,mentee_rated_on=datetime.utcnow(),mentor_user_id=details.mentor_user_id,mentee_user_id=details.mentee_user_id)      
        else:
            rating_record=Rating(mentor_persona_id=details.mentor_persona_id,mentee_persona_id=details.mentee_persona_id,mentor_rating=rat,mentor_rated_on=datetime.utcnow(),mentor_user_id=details.mentor_user_id,mentee_user_id=details.mentee_user_id)      

        #currently new record being created every time mentor/mentee rated. Each row contains either rating for mentor or for mentee
        local_db_session.add(rating_record)
        local_db_session.commit()

        return {'success': True,'error': None}

    @login_required
    @marshal_with(resp_get_json)
    def get(self,some_variables=None):
        from flask_login import current_user
        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        no_pop_up={'rating' : 0, 'show' : False, 'name' : ''}
        # We default the rating to 999, so that we can indicate to the front end that
        # no previous rating exists and that we should hide certain HTML elements.
        pop_up={'rating' : '999', 'show' : True, 'name' : '', id: 0}
                

        details=get_user_credentials(current_user)
        if not details:
            return  no_pop_up

        today=datetime.utcnow()           

        no_pop_up['id']=details.peer_name        
        pop_up['name']=details.peer_name        
        
        if(details.iam_mentee == True):
            pop_up['id']=details.mentor_user_id        
        else:
            pop_up['id']=details.mentee_user_id        

        if not details.rated_before:            
            if(today.date()<details.startdate):
                print("The ratings record is empty and time not yet ripe for rating"+"today : "+str(today)+" startdate : "+str(details.startdate))
                return no_pop_up
        else:
            if(today.date()<details.last_rated.date()):
                print ('error : current date is behind last rated date!!!!')     
                #Should we abort with 404 or with some other message to convey the situation?
                return no_pop_up   

            pop_up['rating']=details.last_rating   

            pop_up['show']=False

            date_delta = relativedelta.relativedelta(today,details.last_rated)
            if details.frequency_month >= 1 and date_delta.months < 1:
                return  {'success': False, 'error':'time not yet ripe for rating'}                    

            # These are mostly used for testing
            elif details.frequency_day >= 1 and date_delta.days < 1:
                return  {'success': False, 'error':'time not yet ripe for rating'}                    
            elif details.frequency_hour >= 1 and date_delta.hours < 1:
                return  {'success': False, 'error':'time not yet ripe for rating'}                    
            elif details.frequency_minute >= 1 and date_delta.minutes < 1:
                return  {'success': False, 'error':'time not yet ripe for rating'}                    

            pop_up['show']=True

        return pop_up

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class TasksEvents(Resource):

    from flask_login import current_user

    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp


    @login_required
    def post(self,some_variables=None):
        from flask_login import current_user
        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()        

        #print "POST args: %s" % pprint.pformat(request.json)
        post_args = request.get_json(force=True)

        results = get_upcoming_events(current_user.id)
        outbound = []
        if results is not None:
            for r in results:
                outbound.append({
                    'party_first_name':r[0],
                    'party_rsvp':r[1],
                    'counterparty_first_name':r[2],
                    'counterparty_rsvp':r[3],
                    'rsvp_id':r[4],
                    'event_id':r[5],
                    'event_name':r[6],
                    'event_date':r[7].strftime("%-m/%-d/%y"),
                    'event_time':r[8].strftime("%-I:%M %p") if r[8] else '',
                    'event_address':r[9],
                    })

        return outbound

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class TasksAnnouncements(Resource):

    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    @login_required
    def get(self):
        # Gets all announcements for current user.
        from flask_login import current_user

        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        role = Role(current_user.id)
        partner_ids = [x.id for x in get_partners_for_user(current_user,role)]

        # A cron job marks announcements as inactive based on their end date.
        # We retrieve only the most recent announcement here to prevent a deluge of announcements,
        # as well as UI complications, for our users.
        latest_announcement = DBSession.query(
            Announcement.id.label('id'),
            Announcement.announcement_description.label('announcement_description'),
            Announcement.announcement_html.label('announcement_html')).\
            options(FromCache(DOGPILE_CACHE_REGION)).\
            outerjoin(AnnouncementLocal, Announcement.id == AnnouncementLocal.announcement_id).\
            outerjoin(AnnouncementAck, and_(Announcement.id == AnnouncementAck.announcement_id, current_user.id == AnnouncementAck.user_id)).\
            filter(Announcement.is_active == True).\
            filter(or_(AnnouncementLocal.member_id == current_user.member_id, AnnouncementLocal.partner_id.in_(partner_ids))).\
            filter(AnnouncementLocal.role_id == role.role).\
            filter(AnnouncementAck.user_id == None).\
            order_by(Announcement.start_date.desc()).\
            first()

        outbound = {}
        if latest_announcement:
            outbound = \
                {
                'id':latest_announcement.id,
                'announcement_description':latest_announcement.announcement_description,
                'announcement_html':latest_announcement.announcement_html,
                }

        return outbound

    @login_required
    def post(self):
        # Records the fact that they saw it.
        from flask_login import current_user
        local_db_session = get_scoped_session()

        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        post_args = request.get_json(force=True)

        # If mentors and mentees see the announcement acknowledgement task, it means they
        # haven't acknowledged it already, so no further checks for acknowledgement records is necessary.
        ack = AnnouncementAck(
            user_id = current_user.id,
            announcement_id = post_args['announcement_id'])

        local_db_session.add(ack)

        local_db_session.commit()
        return {'success':True}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class TasksRSVP(Resource):
    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    @login_required
    def post(self):
        from flask_login import current_user
        local_db_session = get_scoped_session()

        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        #print "POST args: %s" % pprint.pformat(request.json)
        post_args = request.get_json(force=True)

        update_rsvp(local_db_session,current_user, post_args['rsvp_id'], post_args['rsvp_selection'])
  
        local_db_session.commit()
        return {'success':True}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class InfoUpdate(Resource):

    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    @login_required
    def get(self):
        # Gets all information update tasks for current user.
        from flask_login import current_user

        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        role = Role(current_user.id)
        partner_ids = [x.id for x in get_partners_for_user(current_user,role)]

        # We retrieve only the most recent information update task here to prevent a deluge of tasks,
        # as well as UI complications, for our users.
        # We also order by the information update acknowledgement to retrieve only the latest acknowledgement record.
        latest_info_update_task = DBSession.query(
            RecurringInfoUpdate.id.label('info_update_id'),
            RecurringInfoUpdate.interval_days.label('interval_days'),
            RecurringInfoUpdateAck.user_acked_date.label('confirmation_date')).\
            options(FromCache(DOGPILE_CACHE_REGION)).\
            outerjoin(RecurringInfoUpdateLocal, RecurringInfoUpdate.id == RecurringInfoUpdateLocal.recurring_info_update_id).\
            outerjoin(RecurringInfoUpdateAck, and_(RecurringInfoUpdate.id == RecurringInfoUpdateAck.recurring_info_update_id, current_user.id == RecurringInfoUpdateAck.user_id)).\
            filter(RecurringInfoUpdate.is_active == True).\
            filter(or_(RecurringInfoUpdateLocal.member_id == current_user.member_id, RecurringInfoUpdateLocal.partner_id.in_(partner_ids))).\
            filter(RecurringInfoUpdateLocal.role_id == role.role).\
            order_by(RecurringInfoUpdate.id.desc()).\
            order_by(RecurringInfoUpdateAck.id.desc()).\
            first()

        outbound = {}
        if latest_info_update_task:
            # We display the update task only if the user hasn't confirm it yet or hasn't confirm it within given interval.
            if not latest_info_update_task.confirmation_date or latest_info_update_task.confirmation_date < datetime.utcnow() - timedelta(days = latest_info_update_task.interval_days):
                # We return different fields for mentors (4) or mentees (5).
                if role.role == 4:
                    user_details = DBSession.query(
                        IuserUser.cell_phone.label('cell_phone'),
                        IuserUser.email.label('email')).\
                        options(FromCache(DOGPILE_CACHE_REGION)).\
                        filter(IuserUser.id == current_user.id).\
                        one()
                        
                    outbound = \
                        {
                        'info_update_id':latest_info_update_task.info_update_id,
                        'cell_phone':user_details.cell_phone,
                        'email':user_details.email,
                        'date_of_birth':'NA',
                        }
                elif role.role == 5:
                    user_details = DBSession.query(
                        IuserUser.cell_phone.label('cell_phone'),
                        IuserUser.email.label('email'),
                        IuserUser.date_of_birth.label('date_of_birth')).\
                        options(FromCache(DOGPILE_CACHE_REGION)).\
                        filter(IuserUser.id == current_user.id).\
                        one()
    
                    outbound = \
                        {
                        'info_update_id':latest_info_update_task.info_update_id,
                        'cell_phone':user_details.cell_phone,
                        'email':user_details.email,
                        'date_of_birth':user_details.date_of_birth.strftime(DATE_FORMAT) if \
                            type(user_details.date_of_birth) == datetime else  \
                            user_details.date_of_birth,
                        }

        return outbound

    @login_required
    def post(self):
        # Records the fact that users updated their information.
        from flask_login import current_user
        local_db_session = get_scoped_session()

        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        post_args = request.get_json(force=True)

        # We first confirm whether this email exists already for another user.
        existing_email = DBSession.query(
            IuserUser.id.label('user_id'),
            IuserUser.email.label('email')).\
            options(FromCache(DOGPILE_CACHE_REGION)).\
            filter(IuserUser.id != current_user.id).\
            filter(IuserUser.email == post_args['email']).\
            order_by(IuserUser.id.desc()).\
            first()
        
        if existing_email:
            return {'success':False, 'existing_email':True}
        else:
            # If mentors and mentees see the information update task, it means they can update their information
            # and insert a record here.
            ack = RecurringInfoUpdateAck(
                user_id = current_user.id,
                recurring_info_update_id = post_args['info_update_id'])
            
            local_db_session.add(ack)
    
            role = Role(current_user.id)
            if role.role == 4:
                local_db_session.query(IuserUser).\
                    filter(IuserUser.id == current_user.id).\
                    update({'cell_phone': post_args['cell_phone'], 'email': post_args['email']})
            elif role.role == 5:
                local_db_session.query(IuserUser).\
                    filter(IuserUser.id == current_user.id).\
                    update({'cell_phone': post_args['cell_phone'], 'email': post_args['email'],
                        'date_of_birth': post_args['date_of_birth']})
    
            local_db_session.commit()
    
            return {'success':True, 'existing_email':False}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@app.route(BASE_URL + "/")
def tasks_home():
    # This serves the purpose of serving the tasks page to logged in users.
    # That's all this does.
    from flask_login import current_user

    if LOGIN_DISABLED:
        current_user = DBSession.query(IuserUser).filter(
            IuserUser.id==DEFAULT_TEST_USER_ID).one()

    if hasattr(current_user,'id'):
        return render_template("tasks/tasks.html",CDN_URL=CDN_PREFIX)

    return redirect("/")

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Use response endpoint
'''
# Handled in Qualtrics and displayed by tasks. Not handled here.
api.add_resource(TasksEvents, '{0}/surveys/'.format(BASE_URL),
    endpoint='tasks_surveys')
'''

api.add_resource(TasksRatings, '{0}/ratings/'.format(BASE_URL),
    endpoint='tasks_ratings')
api.add_resource(TasksEvents, '{0}/events/'.format(BASE_URL),
    endpoint='tasks_events')
api.add_resource(TasksAnnouncements, '{0}/announcements/'.format(BASE_URL),
    endpoint='tasks_announcements')
api.add_resource(TasksRSVP, '{0}/rsvp/'.format(BASE_URL),
    endpoint='tasks_rsvp')
api.add_resource(InfoUpdate, '{0}/info_update/'.format(BASE_URL),
    endpoint='tasks_recurring_info_update')
    
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
if __name__=="__main__":
    
    role = Role(151865)

    latest_info_update_task = DBSession.query(
        RecurringInfoUpdate.id.label('info_update_id'),
        RecurringInfoUpdateAck.user_acked_date.label('confirmation_date')).\
        outerjoin(RecurringInfoUpdateLocal, RecurringInfoUpdate.id == RecurringInfoUpdateLocal.recurring_info_update_id).\
        outerjoin(RecurringInfoUpdateAck, and_(RecurringInfoUpdate.id == RecurringInfoUpdateAck.recurring_info_update_id, 151937 == RecurringInfoUpdateAck.user_id)).\
        options(FromCache(DOGPILE_CACHE_REGION)).\
        filter(RecurringInfoUpdate.is_active == True).\
        filter(or_(RecurringInfoUpdateLocal.member_id == 197, RecurringInfoUpdateLocal.partner_id.in_([1817,]))).\
        filter(RecurringInfoUpdateLocal.role_id == role.role).\
        order_by(RecurringInfoUpdate.id.desc()).\
        first()

    outbound = {}
    if latest_info_update_task:
        if not latest_info_update_task.confirmation_date or latest_info_update_task.confirmation_date < datetime.utcnow() - timedelta(days = 180):
            # We return different fields for mentors (4) or mentees (5).
            if role.role == 4:
                user_details = DBSession.query(
                    IuserUser.cell_phone.label('cell_phone'),
                    IuserUser.email.label('email')).\
                    options(FromCache(DOGPILE_CACHE_REGION)).\
                    filter(IuserUser.id == 151937).\
                    one()
                    
                outbound = \
                    {
                    'info_update_id':latest_info_update_task.info_update_id,
                    'cell_phone':user_details.cell_phone,
                    'email':user_details.email,
                    'date_of_birth':'NA',
                    }
            elif role.role == 5:
                user_details = DBSession.query(
                    IuserUser.cell_phone.label('cell_phone'),
                    IuserUser.email.label('email'),
                    IuserUser.date_of_birth.label('date_of_birth')).\
                    options(FromCache(DOGPILE_CACHE_REGION)).\
                    filter(IuserUser.id == 151937).\
                    one()
    
                outbound = \
                    {
                    'info_update_id':latest_info_update_task.info_update_id,
                    'cell_phone':user_details.cell_phone,
                    'email':user_details.email,
                    'date_of_birth':user_details.date_of_birth.strftime(DATE_FORMAT),
                    }

    print latest_info_update_task.confirmation_date
    print datetime.utcnow() - timedelta(days = 180)
    print outbound
    
    '''
    local_db_session = get_scoped_session()
    
    if role.role == 4:
        print 'here'
        local_db_session.query(IuserUser).\
            filter(IuserUser.id == 151937).\
            update({'cell_phone': '8565065611', 'email': 'mentor_showcase@imentor.org'})
    elif role.role == 5:
        local_db_session.query(IuserUser).\
            filter(IuserUser.id == current_user.id).\
            update({'cell_phone': post_args['cell_phone'], 'email': post_args['email'],
                'date_of_birth': post_args['date_of_birth']})
                
    local_db_session.commit()
    '''
