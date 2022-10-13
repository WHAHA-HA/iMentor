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

from config.project_globals import (Base,metadata,get_scoped_session,
    DBSession)
from config.settings import (ENV_TYPE,LOGIN_DISABLED,
    DEFAULT_TEST_USER_ID,MONGO_HOST,MONGO_PORT,
    MONGO_DBNAME_ES_CANVAS,MONGO_ES_CANVAS_ADDINDEX_COLLNAME,
    ESEARCH_INDEXED_APPS,SUPERUSER_ANNOUNCER_ID)

from flask import Response, json, jsonify, make_response, url_for, abort
from flask import  current_app, request, redirect, render_template
from flask.views import View, MethodView
from sqlalchemy import (BigInteger, Boolean, Column, Date, DateTime, desc,
    Float, ForeignKey, Index, Integer, Numeric, SmallInteger,
    String, Table, Text, Time, text, DATE, func, UniqueConstraint)
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

from canvas import canvas # app name

from legacy_models.iuser import IuserUser,USERTYPE_MAP
from models import (WidgetContentResponseMarkerCopy,
    WidgetContentUserResponse,WidgetContentUserResponseHistory,
    CanvasSetCopy,CanvasSet,WIDGET_CRESPONSE_HTML,
    WIDGET_CRESPONSE_FILE_UPLOAD)

from canvas.canvas_utils import get_most_recent_canvas_set_for_user,get_specific_canvas_set_for_user
from canvas.legacy_updates import update_legacy_dependencies_upon_finish
from new_platform.utils.user_details import get_persona_obj_for_user
from new_platform.utils.strip_html import strip_tags

from canvas.canvas_objs import BASE_URL
from utils.authz import check_authz
from utils.roles import Role

QUEUE_FIELD = ESEARCH_INDEXED_APPS['canvas']['queue_field']

mongo_connection = pymongo.mongo_client.MongoClient(MONGO_HOST,MONGO_PORT)
database = pymongo.database.Database(mongo_connection,MONGO_DBNAME_ES_CANVAS)
canvas_coll = database[MONGO_ES_CANVAS_ADDINDEX_COLLNAME]

def close_and_update_legacy_tables(current_user,canvas_set_id,local_db_session,obo_user_id):

    update_legacy = False
    cset = local_db_session.query(CanvasSetCopy).filter(
        CanvasSetCopy.user_id==current_user.id).filter(
        CanvasSetCopy.id==canvas_set_id).one()

    utcnow = datetime.utcnow()

    # Don't update legacy twice.
    if not cset.user_completed:
        local_db_session.query(CanvasSetCopy).filter(
            CanvasSetCopy.user_id==current_user.id).filter(
            CanvasSetCopy.id==canvas_set_id).update(
            {'user_first_completed':utcnow,'obo_user_posted':obo_user_id})

        update_legacy = True

    # Update this every time user clicks Finished.
    local_db_session.query(CanvasSetCopy).filter(
        CanvasSetCopy.user_id==current_user.id).filter(
        CanvasSetCopy.id==canvas_set_id).update(
        {'user_completed':utcnow,'obo_user_posted':obo_user_id})

    local_db_session.commit()
    local_db_session.begin()

    if update_legacy:
        update_legacy_dependencies_upon_finish(
            local_db_session,current_user,canvas_set_id)


def specific_lesson(orig_user_id,current_user,user_id,lesson_id=None,skip_other=False,
    use_this_cscopy_id=None,admin_role=None):

    local_db_session = get_scoped_session()
    matched_user = Role(current_user.id).get_matching_mentor_mentee()

    if lesson_id:
        # Canvas sets should be pre-generated before calling this. It will generate new ones
        # but without your date specifications.
        cset = DBSession.query(CanvasSet).filter(CanvasSet.id==lesson_id).one()
    else:
        cset_copy = DBSession.query(CanvasSetCopy).filter(CanvasSetCopy.id==use_this_cscopy_id).one()
        cset = DBSession.query(CanvasSet).filter(CanvasSet.id==cset_copy.parent_id).one()

    results = get_specific_canvas_set_for_user(local_db_session,
        current_user,matched_user,cset.curriculum_id,lesson_id,skip_other=skip_other,
        use_this_cscopy_id=use_this_cscopy_id)

    # If canvas set cop was not returned, this is a failed condition.
    # 'success' status appearing below would be set to false, and failed.
    if 'success' not in results:

        if user_id: # If in obo mode (on-behalf-of)
            if admin_role.is_this_the_admin_for_this_user(user_id):
                local_db_session.query(CanvasSetCopy).filter(
                    CanvasSetCopy.user_id==current_user.id).filter(
                    CanvasSetCopy.id==results['canvas_set']['id']).update(
                    {'admin_last_viewed':datetime.utcnow()})
                local_db_session.commit()
                local_db_session.begin()

        else: # Standard user
            if results['canvas_set']['user_started'] in (None,''):
                local_db_session.query(CanvasSetCopy).filter(
                    CanvasSetCopy.id==results['canvas_set']['id']).update(
                    {'user_started':datetime.utcnow()})
                local_db_session.commit()
                local_db_session.begin()

            # If the canvas set copy has no response markers, mark the lesson as "finished",
            # since the user viewed it. 
            auto_finish = True
            for a in results['canvas_set']['apps']:
                if not auto_finish:
                    break

                for w in a['widgets']:
                    if not auto_finish:
                        break

                    for c in w['content']:
                        if c['response_markers']:
                            #print "Found response marker, not auto-finishing: {0}".format(
                            #    pprint.pformat(c))
                            auto_finish = False
                            break

            if auto_finish:
                #print "Found no response marker, auto-finishing..."
                close_and_update_legacy_tables(current_user,results['canvas_set']['id'],
                local_db_session,orig_user_id)

            local_db_session.query(CanvasSetCopy).filter(
                CanvasSetCopy.user_id==current_user.id).filter(
                CanvasSetCopy.id==results['canvas_set']['id']).update(
                    {'last_viewed':datetime.utcnow()})

    local_db_session.commit()
    return results


class LessonCopyByID(Resource):
    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    @login_required
    def get(self,lesson_copy_id,user_id=None):
        from flask_login import current_user
        local_db_session = get_scoped_session()

        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        orig_user_id = None
        admin_role = None
        if user_id:
            # Get role before current_user is replaced.
            # Current_user is replaced if OBO.
            admin_role = Role(current_user.id)

            orig_user_id = current_user.id
            current_user = check_authz(current_user,user_id,replace_user=True)
            if not current_user:
                abort(403)

        return specific_lesson(orig_user_id,current_user,user_id,None,skip_other=False,
            use_this_cscopy_id=lesson_copy_id,admin_role=admin_role)


class SpecificPresentation(Resource):
    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    @login_required
    def get(self,lesson_id,user_id=None):
        from flask_login import current_user

        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        orig_user_id = None
        admin_role = None
        if user_id:
            # Get role before current_user is replaced.
            # Current_user is replaced if OBO.
            admin_role = Role(current_user.id)

            orig_user_id = current_user.id
            current_user = check_authz(current_user,user_id,replace_user=True)
            if not current_user:
                abort(403)

        return specific_lesson(orig_user_id,current_user,user_id,lesson_id,skip_other=False,
            use_this_cscopy_id=None,admin_role=admin_role)


class Presentation(Resource):
    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    @login_required
    def get(self,user_id=None):
        from flask_login import current_user
        local_db_session = get_scoped_session()

        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        orig_user_id = None
        if user_id:
            orig_user_id = current_user.id
            current_user = check_authz(current_user,user_id,replace_user=True)
            if not current_user:
                abort(403)

        role = Role(current_user.id)
        other_user = role.get_matching_mentor_mentee()

        results = get_most_recent_canvas_set_for_user(local_db_session,current_user,
            other_user,None)

        if 'success' not in results:
            if results['canvas_set']['user_started'] in (None,''):
                local_db_session.query(CanvasSetCopy).filter(
                    CanvasSetCopy.id==results['canvas_set']['id']).update(
                    {'user_started':datetime.utcnow()})
                local_db_session.commit()
                local_db_session.begin()

            # If the canvas set copy has no response markers, mark the lesson as "finished",
            # since the user viewed it. 
            auto_finish = True
            for a in results['canvas_set']['apps']:
                if not auto_finish:
                    break

                for w in a['widgets']:
                    if not auto_finish:
                        break
    
                    for c in w['content']:
                        if c['response_markers']:
                            #print "Found response marker, not auto-finishing: {0}".format(
                            #    pprint.pformat(c))
                            auto_finish = False
                            break

            if auto_finish:
                #print "Found no response marker, auto-finishing..."
                close_and_update_legacy_tables(current_user,results['canvas_set']['id'],
                    local_db_session,orig_user_id)

            local_db_session.query(CanvasSetCopy).filter(
                CanvasSetCopy.user_id==current_user.id).filter(
                CanvasSetCopy.id==results['canvas_set']['id']).update(
                    {'last_viewed':datetime.utcnow()})

        local_db_session.commit()
        return results


    @login_required
    def post(self,user_id=None):
        '''
        NOTE: We are making a huge assumption of one response per marker right now.
        This makes it easy to remove dups upon a replacement response.
        If this assumption changes, we may have increased dup issues, and this code will
        have to change accordingly to handle > 1 response per marker. 
        '''
        from flask_login import current_user
        local_db_session = get_scoped_session()

        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        orig_user_id = None
        if user_id:
            orig_user_id = current_user.id

            current_user = check_authz(current_user,user_id,replace_user=True)
            if not current_user:
                abort(403)

        """
        {"canvas_set_id":1,"app_type":2,"canvas_app_id":1,"widget_id":1,"widget_content_id":2,
         "response_marker_id":1,"ordinal":100,"response":{"html":"<p>test 123</p>
         <p>asndfmasdfasdf<br>    </p>","text":"","words":0,"chars" :0}}
        """
        post_args = request.get_json(force=True)
        #print "Post Args: {0}".format(post_args)
        post_args = post_args['message']

        try:
            marker = DBSession.query(WidgetContentResponseMarkerCopy).filter(
                WidgetContentResponseMarkerCopy.user_id==current_user.id).filter(
                WidgetContentResponseMarkerCopy.widget_content_id==post_args['widget_content_id']).filter(
                WidgetContentResponseMarkerCopy.id==post_args['response_marker_id']).one()
        except NoResultFound:
            # There's a session issue if this fails. Not sure how it happens, but
            # it means a user is posting as another user. Log them out.
            app.logger.exception("User {0} was trying to post a canvas response to a canvas that is not theirs: {1}. This is most likely not a hack, it is a bug of some kind. We logged them out. If they log in again, things will most likely be fine.".format(
                current_user.id,pprint.pformat(post_args)))
            return {'success':False, 'error': 'Session issue, log user out'}
        
        original_response_id = 0;

        # Replace current response with new one. This assumes only 
        # one response per widget per user.
        response_objs = local_db_session.query(WidgetContentUserResponse).filter(
            WidgetContentUserResponse.marker_id==marker.id).filter(
            WidgetContentUserResponse.user_id==current_user.id).all()
        if response_objs:
            #msg = "Found a response in canvas which should have arrived with an ID, but did not. This is a front end bug. Not crashing, just noting. We compensated for the error on the back end, no duplicate happened, and all is well. User: {0}, POST args: {1}".format(current_user.id,pprint.pformat(post_args))
            #app.logger.warning(msg)

            # Check for and remove all possible dups.
            local_db_session.query(WidgetContentUserResponse).filter(
                WidgetContentUserResponse.marker_id==marker.id).filter(
                WidgetContentUserResponse.user_id==current_user.id).delete()

            local_db_session.commit()
            local_db_session.begin()

        matched_user = Role(current_user.id).get_matching_mentor_mentee()

        if marker.response_type == WIDGET_CRESPONSE_FILE_UPLOAD:

            new_resp = WidgetContentUserResponse(
               user_id = current_user.id,
               matched_user_id = matched_user.id if matched_user else None,
               persona_id = get_persona_obj_for_user(current_user.id,
                   ignore_match_status=True).id,
               matched_persona_id = get_persona_obj_for_user(matched_user.id,
                   ignore_match_status=True).id if matched_user else None,
               marker_id = marker.id,
               response_url = post_args['response']['url'],
               obo_user_posted = orig_user_id,
               )
    
            local_db_session.add(new_resp)
    
            local_db_session.commit()
            local_db_session.begin()


        elif marker.response_type == WIDGET_CRESPONSE_HTML:

            # NO: This creates confusion on the front end.
            '''
            # If html was deleted, nothing new to add.
            # Add conditional here to check different response types for
            # blank/null in the future.
            if post_args['response']['html'] in (None,''):
                return {'success':True, 'id':0}
            '''

            new_resp = WidgetContentUserResponse(
               user_id = current_user.id,
               matched_user_id = matched_user.id if matched_user else None,
               persona_id = get_persona_obj_for_user(current_user.id,
                   ignore_match_status=True).id,
               matched_persona_id = get_persona_obj_for_user(matched_user.id,
                   ignore_match_status=True).id if matched_user else None,
               marker_id = marker.id,
               response_html = post_args['response']['html'],
               response_text = strip_tags(post_args['response']['html']),
               words = post_args['response']['words'],
               chars = post_args['response']['chars'],
               obo_user_posted = orig_user_id,
               )

            local_db_session.add(new_resp)

            local_db_session.commit()
            local_db_session.begin()

            # remove old and add new to queue for elasticsearch 
            for old_resp in response_objs:
                canvas_coll.insert_one({'action':'delete',QUEUE_FIELD:old_resp.id})

            canvas_coll.insert_one({'action':'insert',QUEUE_FIELD:new_resp.id})

        else: # unrecognized type
            local_db_session.commit()
            raise Exception("Can't yet handle response types other than HTML or File Upload. This is easy to fix.")

        # Record history of all POSTS.
        wcurh = WidgetContentUserResponseHistory(
           user_id = current_user.id,
           matched_user_id = matched_user.id if matched_user else None,
           persona_id = get_persona_obj_for_user(current_user.id,
               ignore_match_status=True).id,
           matched_persona_id = get_persona_obj_for_user(matched_user.id,
               ignore_match_status=True).id if matched_user else None,
           marker_id = marker.id,
           response_html = post_args['response']['html'] if 'html' in post_args['response'] else None,
           response_text = strip_tags(post_args['response']['html']) if 'html' in post_args['response'] else None,
           response_url = post_args['response']['url'] if 'url' in post_args['response'] else None,
           words = post_args['response']['words'] if 'words' in post_args['response'] else None,
           chars = post_args['response']['chars'] if 'chars' in post_args['response'] else None,
           added_datetime = datetime.utcnow(),
           original_response_id = original_response_id,
           obo_user_posted = orig_user_id,
           new_response_id = new_resp.id
        )
        local_db_session.add(wcurh)
        local_db_session.commit()

        return {'success':True, 'id':new_resp.id}


class Finished(Resource):
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

        orig_user_id = None
        if user_id:
            orig_user_id = current_user.id
            current_user = check_authz(current_user,user_id,replace_user=True)
            if not current_user:
                abort(403)

        post_args = request.get_json(force=True)
        #print "Post Args: {0}".format(post_args)

        close_and_update_legacy_tables(current_user,post_args['canvas_set_id'],
            local_db_session,orig_user_id)

        local_db_session.commit()


api.add_resource(Presentation, '{0}/presentation/'.format(BASE_URL),
    endpoint='canvas_data_get_post')

api.add_resource(Presentation, '{0}/presentation/<int:user_id>/'.format(BASE_URL),
    endpoint='canvas_data_get_post_obo')

api.add_resource(Finished, '{0}/finished/'.format(BASE_URL),
    endpoint='canvas_finished')

api.add_resource(Finished, '{0}/finished/<int:user_id>/'.format(BASE_URL),
    endpoint='canvas_finished_obo')

api.add_resource(SpecificPresentation, '{0}/lesson/<int:lesson_id>/presentation/'.format(BASE_URL),
    endpoint='canvas_specific')

api.add_resource(SpecificPresentation, '{0}/lesson/<int:lesson_id>/presentation/<int:user_id>/'.format(BASE_URL),
    endpoint='canvas_specific_obo_user')

api.add_resource(LessonCopyByID, '{0}/lessoncopy/<int:lesson_copy_id>/presentation/'.format(BASE_URL),
    endpoint='lesson_copy_by_curr_copy_id')

api.add_resource(LessonCopyByID, '{0}/lessoncopy/<int:lesson_copy_id>/presentation/<int:user_id>/'.format(BASE_URL),
    endpoint='lesson_copy_by_curr_copy_id_obo')


