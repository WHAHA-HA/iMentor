# -*- coding: iso8859-15 -*-
import pdb
import pprint
import copy
import os,sys
import pymongo
from datetime import datetime
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)
from config.project_globals import (get_scoped_session,
    db,Base,metadata,DBSession)
from config.settings import (ENV_TYPE,LOGIN_DISABLED,
    DEFAULT_TEST_USER_ID,MONGO_HOST,MONGO_PORT,
    MONGO_DBNAME_ES_PORTFOLIO,MONGO_ES_PORTFOLIO_ADDINDEX_COLLNAME,
    ESEARCH_INDEXED_APPS,CDN_PREFIX)
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
from portfolio import portfolio # app name
from legacy_models.iuser import IuserUser,USERTYPE_MAP
from new_platform.utils.roles import Role
from new_platform.utils.user_details import get_persona_for_user, get_persona_obj_for_user
from new_platform.utils.strip_html import strip_tags
from portfolio_utils import (get_scheduled_grades, get_scheduled_units,
    get_scheduled_lessons, get_reflection_response,
    get_reflection_card, get_supplemental_resources)
from models import (ReflectionUserResponse, ReflectionUserResponseHistory,
    ReflectionCard, ReflectionUserDetails,STARTED,COMPLETED,LAST_VIEWED)
from legacy_models.iuser import (BASIC_USER,
    MEMBER_ADMIN,REGIONAL_ADMIN,PARTNER_ADMIN,MENTOR,
    MENTEE,SUPER_ADMIN)
from utils.authz import check_authz

QUEUE_FIELD = ESEARCH_INDEXED_APPS['portfolio']['queue_field']

mongo_connection = pymongo.mongo_client.MongoClient(MONGO_HOST,MONGO_PORT)
database = pymongo.database.Database(mongo_connection,MONGO_DBNAME_ES_PORTFOLIO)
portfolio_coll = database[MONGO_ES_PORTFOLIO_ADDINDEX_COLLNAME]


BASE_URL = "/portfolio"

class ScheduledGrades(Resource):
    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    @login_required
    def post(self,user_id=None):
        from flask_login import current_user
    
        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        if user_id:
            current_user = check_authz(current_user,user_id,replace_user=True)
            if not current_user:
                abort(403)

        #print "POST args: %s" % pprint.pformat(request.json)
        post_args = request.get_json(force=True)

        results = get_scheduled_grades(current_user.id)
        outbound = []
        if results is not None:
            for r in results:
                outbound.append({
                    'curriculum_id':r[0],
                    'grade_description':r[1],
                    'grade_number':r[2],
                    'grade_id':r[3],
                    })

        return outbound

class ScheduledUnits(Resource):
    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    @login_required
    def post(self,user_id=None):
        from flask_login import current_user
    
        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        if user_id:
            current_user = check_authz(current_user,user_id,replace_user=True)
            if not current_user:
                abort(403)

        #print "POST args: %s" % pprint.pformat(request.json)
        post_args = request.get_json(force=True)

        results = get_scheduled_units(current_user.id, post_args['grade_id'])
        outbound = []
        if results is not None:
            for r in results:
                outbound.append({
                    'unit_description':r[0],
                    'grade_number':r[1],
                    'grade_id':r[2],
                    'unit_number':r[3],
                    'unit_id':r[4],
                    'featured_image':r[5],
                    'secondary_unit_description':r[6],
                    'current_flag':r[7],
                    'mentee_finished_flag':r[8],
                    'mentor_finished_flag':r[9],
                    'both_finished_flag':r[10],
                    'new_content_flag':r[11],
                    'unit_start':r[12].strftime("%-m/%-d/%y %-H:%M"),
                    'cscopy_id':r[13],
                    'mentor_first_name':r[14],
                    'mentee_first_name':r[15],
                    'mentor_user_id':r[16],
                    'mentee_user_id':r[17],
                    })

        # adjust UTC times to partner time zone.
        return outbound
        
class ScheduledLessons(Resource):
    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    @login_required
    def post(self,user_id=None):
        from flask_login import current_user
    
        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        if user_id:
            current_user = check_authz(current_user,user_id,replace_user=True)
            if not current_user:
                abort(403)

        #print "POST args: %s" % pprint.pformat(request.json)
        post_args = request.get_json(force=True)

        results = get_scheduled_lessons(current_user.id, post_args['grade_id'], post_args['unit_id'])
        outbound = []
        if results is not None:
            for r in results:
                outbound.append({
                    'curriculum_id':r[0],
                    'canvas_set_id':r[1],
                    'lesson_description':r[2],
                    'grade_number':r[3],
                    'grade_id':r[4],
                    'unit_number':r[5],
                    'unit_id':r[6],
                    'lesson_number':r[7],
                    'featured_image':r[8],
                    'secondary_lesson_description':r[9],
                    'current_lesson_flag':r[10],
                    'mentee_finished_flag':r[11],
                    'mentor_finished_flag':r[12],
                    'both_finished_flag':r[13],
                    'new_content_flag':r[14],
                    'scheduled_flag':r[15],
                    'lesson_type':r[16],
                    'unit_description':r[17],
                    'cscopy_id':r[18],
                    'mentor_first_name':r[19],
                    'mentee_first_name':r[20],
                    'mentor_user_id':r[21],
                    'mentee_user_id':r[22],
                    })

        # adjust UTC times to partner time zone.
        return outbound


# See the models file for modes.
def update_reflection_user_details(local_db_session,
    current_user,reflection_card_id,mode):

    time_now = datetime.utcnow()

    ref_detail = DBSession.query(ReflectionUserDetails).filter(
        ReflectionUserDetails.user_id==current_user.id).filter(
        ReflectionUserDetails.reflection_card_id==reflection_card_id).first()

    if not ref_detail:
        # Unmatched users could be doing this exercise.
        persona = get_persona_obj_for_user(current_user.id,ignore_match_status=False)
        if not persona:
            persona = get_persona_obj_for_user(current_user.id,ignore_match_status=True)

        ref_card = ReflectionCard.query.filter(ReflectionCard.id==reflection_card_id).one()

        ref_detail = ReflectionUserDetails(
            user_id=current_user.id,
            persona_id=persona.id,
            grade_id=ref_card.grade_id,
            unit_id=ref_card.unit_id,
            role=Role(current_user.id).role,
            reflection_card_id=ref_card.id,
            started = time_now,
            last_viewed = time_now)

        local_db_session.add(ref_detail)
        local_db_session.commit()
        local_db_session.begin()

        return ref_detail

    if not ref_detail.started:
        local_db_session.query(ReflectionUserDetails).filter(
            ReflectionUserDetails.user_id==current_user.id).filter(
            ReflectionUserDetails.id==reflection_card_id).update(
            {'started':time_now,'last_viewed':time_now})
        local_db_session.commit()
        local_db_session.begin()

    if mode == COMPLETED:

        # On 5/11/16, we deleted the majority of the legacy update code here,
        # since we released the new Safety Alerts feature and no longer needed to populate
        # legacy email tables and allow the legacy Keyword Alerts feature to scan those tables.
        # If you'd like to review the legacy update code, check commits to Git on 5/11/16.

        local_db_session.query(ReflectionUserDetails).filter(
            ReflectionUserDetails.user_id==current_user.id).filter(
            ReflectionUserDetails.reflection_card_id==reflection_card_id).update(
            {'completed':time_now,'last_viewed':time_now})
        local_db_session.commit()
        local_db_session.begin()
    else:
        local_db_session.query(ReflectionUserDetails).filter(
            ReflectionUserDetails.user_id==current_user.id).filter(
            ReflectionUserDetails.reflection_card_id==reflection_card_id).update(
            {'last_viewed':time_now})
        local_db_session.commit()
        local_db_session.begin()

    return ref_detail


class ReflectionResponseHTML(Resource):
    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    @login_required
    def post(self,user_id=None):
        from flask_login import current_user
        local_db_session = get_scoped_session()
    
        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        # Get role before current_user is replaced.
        # Current_user is replaced if OBO.
        role=Role(current_user.id)
        if user_id: # OBO
            current_user = check_authz(current_user,user_id,replace_user=True)
            if not current_user:
                abort(403)

        #print "POST args: %s" % pprint.pformat(request.json)
        post_args = request.get_json(force=True)

        result = get_reflection_response(current_user.id, post_args['grade_id'], post_args['unit_id'])
        if result is not None:
            if user_id:
                if role.is_this_the_admin_for_this_user(user_id):
                    local_db_session.query(ReflectionUserDetails).filter(
                        ReflectionUserDetails.user_id == current_user.id).filter(
                        ReflectionUserDetails.reflection_card_id == result[0]).update(
                        {'admin_last_viewed':datetime.utcnow()})
                     
            outbound = [{
                'reflection_card_id':result[0],
                'reflection_response_id':result[1],
                'party_reflection_html':result[2],
                'counterparty_reflection_html':result[3] if len(result) > 3 else None,
                }]

            local_db_session.commit()
            return outbound

        local_db_session.commit()
        return []
        
class ReflectionCardHTML(Resource):
    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    @login_required
    def post(self,user_id=None):
        from flask_login import current_user
        local_db_session = get_scoped_session()
    
        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        if user_id:
            current_user = check_authz(current_user,user_id,replace_user=True)
            if not current_user:
                abort(403)

        #print "POST args: %s" % pprint.pformat(request.json)
        post_args = request.get_json(force=True)

        result = get_reflection_card(post_args['grade_id'], post_args['unit_id'])

        if result is not None:
            if not user_id: # Don't do this for admins
                update_reflection_user_details(local_db_session,
                    current_user,result[0],LAST_VIEWED)

            outbound = [{
                'reflection_card_id':result[0],
                'mentor_card_html':result[1],
                'mentee_card_html':result[2],
                'grade_number':result[3],
                'grade_id':result[4],
                'unit_number':result[5],
                'unit_id':result[6],
                }]

            return outbound
        return []

class FinishReflectionResponse(Resource):
    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    @login_required
    def post(self,user_id=None):
        from flask_login import current_user
        local_db_session = get_scoped_session()

        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        if user_id:
            current_user = check_authz(current_user,user_id,replace_user=True)
            if not current_user:
                abort(403)

        #print "POST args: %s" % pprint.pformat(request.json)
        post_args = request.get_json(force=True)

        result = get_reflection_card(post_args['grade_id'], post_args['unit_id'])
        update_reflection_user_details(local_db_session,
            current_user,result[0],COMPLETED)
  
        local_db_session.commit()
        return {'success':True}

class ReflectionResponse(Resource):
    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    @login_required
    def post(self,user_id=None):
        from flask_login import current_user
        local_db_session = get_scoped_session()

        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        if user_id:
            current_user = check_authz(current_user,user_id,replace_user=True)
            if not current_user:
                abort(403)

        post_args = request.get_json(force=True)
        print "Post Args: {0}".format(post_args)

        result = get_reflection_card(post_args['grade_id'], post_args['unit_id'])
        details = update_reflection_user_details(local_db_session,
            current_user,post_args['reflection_card_id'],LAST_VIEWED)

        '''
        If id exists, replace a user response.
        if 'reflection_response_id' in post_args and post_args['reflection_response_id'] not in (None,0):
            local_db_session.query(ReflectionUserResponse).filter(
                ReflectionUserResponse.id==post_args['reflection_response_id']).filter(
                ReflectionUserResponse.user_id==current_user.id).delete()

            local_db_session.commit()
            local_db_session.begin()

        else:
            # Find and notify of possible duplicate.
        '''
        # Get more than one in case of dups.
        response_objs = local_db_session.query(
            ReflectionUserResponse.id.label('reflection_response_id')).\
            join(ReflectionUserDetails, ReflectionUserResponse.reflection_user_details_id == ReflectionUserDetails.id).\
            filter(ReflectionUserResponse.user_id == current_user.id).\
            filter(ReflectionUserDetails.grade_id == post_args['grade_id']).\
            filter(ReflectionUserDetails.unit_id == post_args['unit_id']).\
            all()

        if response_objs:
            #msg = "Found a Reflection response in Portfolio which should have arrived with an ID, but did not. This is a front end bug. Not crashing, just noting. We compensated for the error on the back end, no duplicate happened, and all is well. User: {0}, POST args: {1}".format(current_user.id,pprint.pformat(post_args))
            #app.logger.warning(msg)

            for r in response_objs:
                local_db_session.query(ReflectionUserResponse).filter(
                    ReflectionUserResponse.id==r.reflection_response_id).filter(
                    ReflectionUserResponse.user_id==current_user.id).delete()

                # Remove from elasticsearch queue, if it was added.
                portfolio_coll.insert_one({'action':'delete',QUEUE_FIELD:r.reflection_response_id})

            local_db_session.commit()
            local_db_session.begin()

        # Record history of all POSTS.
        response_history = ReflectionUserResponseHistory(
            user_id = current_user.id,
            reflection_user_details_id = details.id,
            reflection_html = post_args['message'],
            reflection_text = strip_tags(post_args['message']),
            words = post_args['words'],
            chars = post_args['chars'],
            added_datetime = datetime.utcnow()
            )
        local_db_session.add(response_history)

        new_response = ReflectionUserResponse(
            user_id = current_user.id,
            reflection_user_details_id = details.id,
            reflection_html = post_args['message'],
            reflection_text = strip_tags(post_args['message']),
            words = post_args['words'],
            chars = post_args['chars']
            )
        local_db_session.add(new_response)
        local_db_session.commit()
        portfolio_coll.insert_one({'action':'insert',QUEUE_FIELD:new_response.id})

        return {'success':True, 'id':new_response.id}

class SupplementalResources(Resource):
    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    @login_required
    def post(self,user_id=None):
        from flask_login import current_user
    
        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        if user_id:
            current_user = check_authz(current_user,user_id,replace_user=True)
            if not current_user:
                abort(403)

        results = get_supplemental_resources(current_user.id)
        outbound = []
        if results is not None:
            for r in results:
                outbound.append({
                    'resource_link':r[0],
                    'resource_description':r[1],
                    'resource_type':r[2],
                    })

        return outbound

@app.route(BASE_URL + "/")
def portfolio_home():
    from flask_login import current_user

    if LOGIN_DISABLED:
        current_user = DBSession.query(IuserUser).filter(
            IuserUser.id==DEFAULT_TEST_USER_ID).one()

    if hasattr(current_user,'id'):
        return render_template("portfolio/index.html",CDN_URL=CDN_PREFIX)

    return redirect("/")

@app.route(BASE_URL + "/debug/")
def portfolio_home_debug():
    from flask_login import current_user

    if LOGIN_DISABLED:
        current_user = DBSession.query(IuserUser).filter(
            IuserUser.id==DEFAULT_TEST_USER_ID).one()

    if hasattr(current_user,'id'):
        return render_template("portfolio/index.debug.html",CDN_URL=CDN_PREFIX)

    return redirect("/")

@app.route(BASE_URL + "/<user_id>/")
def portfolio_home_obo(user_id):
    from flask_login import current_user

    if LOGIN_DISABLED:
        current_user = DBSession.query(IuserUser).filter(
            IuserUser.id==DEFAULT_TEST_USER_ID).one()

    if hasattr(current_user,'id'):
        current_user = check_authz(current_user,user_id,replace_user=True)
        if not current_user:
            abort(403)

        return render_template("portfolio/index.html",
            user_id_from_flask=current_user.id,CDN_URL=CDN_PREFIX)

    return redirect("/")

@app.route(BASE_URL + "/debug/<user_id>/")
def portfolio_home_obo_debug(user_id):
    from flask_login import current_user

    if LOGIN_DISABLED:
        current_user = DBSession.query(IuserUser).filter(
            IuserUser.id==DEFAULT_TEST_USER_ID).one()

    if hasattr(current_user,'id'):
        current_user = check_authz(current_user,user_id,replace_user=True)
        if not current_user:
            abort(403)

        return render_template("portfolio/index.debug.html",
            user_id_from_flask=current_user.id,CDN_URL=CDN_PREFIX)

    return redirect("/")

# Use response endpoint
api.add_resource(ScheduledUnits, '{0}/scheduled_units/'.format(BASE_URL),
    endpoint='portfolio_scheduled_units')
api.add_resource(ScheduledLessons, '{0}/scheduled_lessons/'.format(BASE_URL),
    endpoint='portfolio_scheduled_lessons')
api.add_resource(ScheduledGrades, '{0}/scheduled_grades/'.format(BASE_URL),
    endpoint='portfolio_scheduled_grades')
api.add_resource(ReflectionResponseHTML, '{0}/reflection_response_html/'.format(BASE_URL),
    endpoint='portfolio_reflection_response_html')
api.add_resource(ReflectionCardHTML, '{0}/reflection_card_html/'.format(BASE_URL),
    endpoint='portfolio_reflection_card_html')

api.add_resource(ScheduledUnits, '{0}/scheduled_units/<int:user_id>/'.format(BASE_URL),
    endpoint='portfolio_scheduled_units_obo')
api.add_resource(ScheduledLessons, '{0}/scheduled_lessons/<int:user_id>/'.format(BASE_URL),
    endpoint='portfolio_scheduled_lessons_obo')
api.add_resource(ScheduledGrades, '{0}/scheduled_grades/<int:user_id>/'.format(BASE_URL),
    endpoint='portfolio_scheduled_grades_obo')
api.add_resource(ReflectionResponseHTML, '{0}/reflection_response_html/<int:user_id>/'.format(BASE_URL),
    endpoint='portfolio_reflection_response_html_obo')
api.add_resource(ReflectionCardHTML, '{0}/reflection_card_html/<int:user_id>/'.format(BASE_URL),
    endpoint='portfolio_reflection_card_html_obo')

api.add_resource(ReflectionResponse, '{0}/reflection_response/'.format(BASE_URL),
    endpoint='portfolio_reflection_response')
api.add_resource(ReflectionResponse, '{0}/reflection_response/<int:user_id>/'.format(BASE_URL),
    endpoint='portfolio_reflection_response_obo')

api.add_resource(FinishReflectionResponse, '{0}/finish_reflection_response/'.format(BASE_URL),
    endpoint='portfolio_finish_reflection_response')

api.add_resource(FinishReflectionResponse, '{0}/finish_reflection_response/<int:user_id>/'.format(BASE_URL),
    endpoint='portfolio_finish_reflection_response_obo')

api.add_resource(SupplementalResources, '{0}/supplemental_resources/'.format(BASE_URL),
    endpoint='portfolio_supplemental_resources')
api.add_resource(SupplementalResources, '{0}/supplemental_resources/<int:user_id>/'.format(BASE_URL),
    endpoint='portfolio_supplemental_resources_obo')
