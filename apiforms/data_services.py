# -*- coding: iso8859-15 -*-
import pdb
import re
import pprint
import copy
import os,sys
import itertools
import logging
from collections import OrderedDict

appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import (Base,metadata,
    url_cache,db,DBSession,get_scoped_session)
from config.project_globals import DOGPILE_CACHE_REGION
from config.caching_query import CachingQuery,FromCache

from config.settings import (ENV_TYPE, LOGIN_DISABLED, 
    MAX_URL_CACHE_SECONDS, DEFAULT_TEST_USER_ID,
    MAX_COLLEGE_LIST_SIZE)

from flask import Response, jsonify, make_response, url_for, abort
from flask import  current_app, request, redirect, render_template, url_for
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

from apiforms.models import *
from apiforms.export.user_export import export_intake_application
from apiforms.form_copy_functions import copy_form_cascade
from utils.authz import check_authz
from utils.user_details import get_persona_obj_for_user
from utils.roles import Role

from legacy_models.partners import PartnersPartner

from legacy_models.iuser import (IuserUser,IuserEmployer,IuserUsertype,
    IuserAssignedusertype,IuserRacialgroup,IuserAcademicfield,
    USER_STATUS_APPLICATION_INCOMPLETE,USERTYPE_MAP)

from legacy_models.utils import (UtilsState, UtilsCountry, 
    UtilsOccupation, UtilsCareer)
from legacy_models.member import MemberMember,MemberUserprogram
from college_checklist.models import UtilsCollege
from sqlalchemy.sql import select

logging.basicConfig()

DATA_URL = "/forms_data"

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# Data Services
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# This is dependent on current_user!
class FormLookup(Resource):
    '''
    Form lookup is special: it determines, based on the user selections, what
    type of user we're creating, if a new user is being created. 
    If form_user_type is set, we're adding a persona to a new user, based
    on their new assigned user type (mentor/mentee).
    Whether new or not, we're generating a new form for the user if
    one does not exist.

    Note: don't create forms on behalf of any other user. Only get them.
    '''
    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    @login_required
    def get(self,user_id=None,app_form=None):
        from flask_login import current_user
        local_db_session = get_scoped_session()

        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        current_user = check_authz(current_user,user_id)

        if not current_user:
            return abort(403)

        # Allow admins to see/change completed forms.
        if user_id:

            if app_form:
                the_form = DBSession.query(FormCopy).filter(FormCopy.user_id==current_user.id
                    ).filter(FormCopy.form_data_type==APPLICATION
                    ).order_by(FormCopy.id).first()
            else:
                the_form = DBSession.query(FormCopy).filter(FormCopy.user_id==current_user.id
                    ).order_by(FormCopy.id).first()

        else:
            the_form = DBSession.query(FormCopy).filter(FormCopy.user_id==current_user.id
                ).filter(FormCopy.form_was_completed==False
                ).order_by(FormCopy.id).first()


        if the_form:
            local_db_session.query(FormCopy).filter(
                FormCopy.id==the_form.id).update(
                {'last_touched_datetime':datetime.now()})

            local_db_session.commit()

            return the_form.id

        local_db_session.commit()

        # Don't create a new form on behalf of anyone else.
        if user_id:
            abort(403)

        # Find all other finished form parent ids, to generate new copy from master form.
        finished_form_parent_ids = [x.parent_id for x in DBSession.query(FormCopy).filter(
            FormCopy.user_id==current_user.id
            ).filter(FormCopy.form_was_completed==True,
            ).all()]
            
        role = Role(current_user.id)
        persona = get_persona_obj_for_user(
            current_user.id,ignore_match_status=True,ignore_active_status=True)

        if not persona:
            app.logger.exception("FormLookup: User {0} has no persona? Not crashing, just skipping.".format(
                current_user.id))

            return None

        # Admins may not have forms.
        if USERTYPE_MAP[role.role] not in REVERSE_FORM_USER_TYPE_MAP:
            return None

        form_user_type = REVERSE_FORM_USER_TYPE_MAP[USERTYPE_MAP[role.role]]


        # Figure out which master form to copy for this user,
        master_form_ids = [x.form_id for x in DBSession.query(FormMemberSite).filter(
            FormMemberSite.member_site_id == current_user.member_id).all()]

        if not master_form_ids:
            return None

        if form_user_type:
            # Forms may not have a user type, so 0 is acceptable.
            master_form = DBSession.query(Form).filter(
                Form.form_user_type.in_([form_user_type,0]),
                Form.id.in_(master_form_ids)
                )

        if finished_form_parent_ids:
            master_form = master_form.filter(and_(
                Form.id.notin_(finished_form_parent_ids),
                Form.id.in_(master_form_ids)
                ))

        # Don't generate an application form for people who have already filled one out.
        # If they didn't complete their form, they would have an unfinished form above.
        if current_user.status != USER_STATUS_APPLICATION_INCOMPLETE:
            master_form = master_form.filter(
                Form.form_data_type != APPLICATION)

        master_form = master_form.first()
                
        if not master_form:
            return None

        # Create copy from master, for this user.
        copy_form_cascade(
            form_id=master_form.id,
            user_id=current_user.id,
            persona_id=persona.id,
            member_site_id=current_user.member_id,
            role = role)

        unfinished_form = DBSession.query(FormCopy).filter(FormCopy.user_id==current_user.id
            ).filter(FormCopy.form_was_completed==False
            ).order_by(FormCopy.id).first()

        return unfinished_form.id

# Don't require login for this!
class URLMemberLookup(Resource):
    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    def post(self):
        return self.get()

    def get(self):
        rmatch = re.match('https?\:\/\/([A-Za-z0-9_-]+)\.',request.url_root)
        #print "rmatch: %s" % request.url_root
        if not rmatch:
            abort(403)

        prefix = rmatch.group(1)

        member = DBSession.query(MemberMember).filter(
            MemberMember.url_name==prefix
            ).first()

        if member:
            return member.name

        abort(403)


class CountryService(Resource):
    """ web services (GET) for countries """
    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    country_field = {
        'id': fields.Integer,
        'order': fields.Integer,
        'name': fields.String,
        'abbr': fields.String
    }

    @login_required
    @url_cache.memoize(MAX_URL_CACHE_SECONDS,make_name=lambda x:"countries")
    @marshal_with(country_field)
    def get(self):
        from flask_login import current_user
        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        countries = DBSession.query(UtilsCountry).order_by('name').all()
        return countries 


class StateService(Resource):
    """ web services (GET) for states in the USA"""
    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    state_field = {
        'id': fields.Integer,
        'order': fields.Integer,
        'name': fields.String,
        'abbr': fields.String
    }

    @login_required
    @url_cache.memoize(MAX_URL_CACHE_SECONDS,make_name=lambda x:"states")
    @marshal_with(state_field)
    def get(self):
        from flask_login import current_user
        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        usa_states = DBSession.query(UtilsState).filter(
            UtilsState.abbr != '--').order_by('name').all()

        db.session.commit()
        return usa_states


class AcademicFieldService(Resource):
    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    academic_field = {
        'id': fields.Integer,
        'name': fields.String
    }

    @login_required
    @url_cache.memoize(MAX_URL_CACHE_SECONDS,make_name=lambda x:"acad_field")
    @marshal_with(academic_field)
    def get(self):
        from flask_login import current_user
        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        db.session.commit()
        return DBSession.query(IuserAcademicfield).order_by('name').all()

class RacialGroupService(Resource):
    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    racial_group_field = {
        'id': fields.Integer,
        'ordinal': fields.Integer,
        'group': fields.String
    }

    @login_required
    @url_cache.memoize(MAX_URL_CACHE_SECONDS,make_name=lambda x:"racial_group")
    @marshal_with(racial_group_field)
    def get(self):
        from flask_login import current_user
        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        db.session.commit()
        return DBSession.query(IuserRacialgroup).order_by('ordinal').all()

class EmployerService(Resource):
    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    employer_field = {
        'id': fields.Integer,
        'name': fields.String
    }

    @login_required
    @marshal_with(employer_field)
    def get(self,partial_str):
        from flask_login import current_user
        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        employers = DBSession.query(IuserEmployer).filter(
            IuserEmployer.name.ilike('%' + partial_str + '%')
            ).order_by('name').all()

        db.session.commit()
        return employers


class CollegeService(Resource):
    """ web services (GET) for Colleges"""
    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    college_field = {
      'id': fields.Integer,
      'name': fields.String
    }

    @marshal_with(college_field)
    def get(self,partial_str):
        colleges = DBSession.query(UtilsCollege).filter(or_(
            UtilsCollege.name.ilike('%' + partial_str + '%'),
            UtilsCollege.alias.ilike('%' + partial_str + '%')
            )).order_by('name').limit(MAX_COLLEGE_LIST_SIZE).all()

        db.session.commit()
        return colleges


class CareerService(Resource):
    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    @login_required
    @url_cache.memoize(MAX_URL_CACHE_SECONDS,make_name=lambda x:"careers")
    def get(self):
        from flask_login import current_user
        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        careers = [x.__dict__ for x in DBSession.query(UtilsCareer).order_by('name').all()]
        for c in careers:
            del c['_sa_instance_state']

            c['occupations'] = [x.__dict__ for x in DBSession.query(UtilsOccupation).filter(UtilsOccupation.career_id==c['id']).order_by('name').all()]

            for o in c['occupations']:
                del o['_sa_instance_state']

        db.session.commit()
        return careers

class CareerOnlyService(Resource):
    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    @login_required
    @url_cache.memoize(MAX_URL_CACHE_SECONDS,make_name=lambda x:"careers_only")
    def get(self):
        from flask_login import current_user
        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        careers = [x.__dict__ for x in DBSession.query(UtilsCareer).order_by('name').all()]
        for c in careers:
            del c['_sa_instance_state']

        db.session.commit()
        return careers

# This is dependent on current_user!
class MemberProgramService(Resource):

    member_program = {
      'id': fields.Integer,
      'name': fields.String,
      'abbr': fields.String
    }

    # We can't yet filter these on partner, since the new mentor did not yet
    # get assigned to a partner. So show all programs for a member site.
    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    @login_required
    @marshal_with(member_program)
    def get(self,user_id=None):
        from flask_login import current_user
        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        current_user = check_authz(current_user,user_id)

        if not current_user:
            return abort(403)

        db.session.commit()
        return DBSession.query(MemberUserprogram).filter(
            MemberUserprogram.member_id==current_user.member_id
            ).filter(MemberUserprogram.hidden==False
            ).order_by('name').all()


# This is dependent on current_user!
class SchoolService(Resource):
    """ web services (GET) for schools with its nested program_name """
    if ENV_TYPE != "Production":
        def options(self):
            resp = Response('', status=200, mimetype='application/json')
            return resp

    @login_required
    def get(self,user_id=None):

        from flask_login import current_user
        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        current_user = check_authz(current_user,user_id)

        if not current_user:
            return abort(403)

        nowdate = datetime.now()

        # Don't show school years that have passed.
        if (nowdate.month ==6 and nowdate.day==30) or nowdate.month >= 7:
           showyear = nowdate.year + 1
        else:
           showyear = nowdate.year

        unordered = {}
        outbound = OrderedDict()

        for partner in DBSession.query(PartnersPartner).filter(
            PartnersPartner.member_id == current_user.member_id).filter(
            PartnersPartner.is_alumni==False).filter(
            PartnersPartner.status_id==1).order_by('name').all():
            if partner.graduating_class and partner.graduating_class.graduating_class >= showyear:
                if partner.graduating_class.school not in unordered:
                    unordered[partner.graduating_class.school] = [{'id':partner.id,'class':partner.name}]
                else:
                    unordered[partner.graduating_class.school].append({'id':partner.id,'class':partner.name})

        for k in sorted(unordered.keys()):
            outbound[k] = unordered[k]

        db.session.commit()
        return outbound

@app.route('{0}/export/<int:user_id>/'.format(DATA_URL),methods=['GET'])
@login_required
def export_application(user_id):
    if request.method == 'GET':
        from flask_login import current_user
        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        current_user = check_authz(current_user,user_id)
        if not current_user:
            return abort(403)

        results = export_intake_application(current_user.id, current_user.member_id)
        if results:
            def generate():
                yield '"sep=|"\n'
                for r in results:
                    yield '{0}|{1}\n'.format(
                        r[0].encode('utf-8','ignore') if type(r[0]) in (str,unicode) else r[0],
                        r[1].encode('utf-8','ignore') if type(r[1]) in (str,unicode) else r[1]
                        )

            # The file name below is a placeholder, since we set it again in forms.js later.
            resp = Response(generate())
            resp.mimetype='text/csv'
            resp.headers['Content-Disposition'] = 'attachment;filename=application_export.csv'
            resp.headers['Cache-Control'] = 'must-revalidate, post-check=0, pre-check=0'
            
            return resp
        else:
            return {'success':False,'error':'No data.'}

@app.route(DATA_URL + '/export_intake_application/<member_id>/<formusertype>/<recentflag>/')
def intake_app_export(member_id,formusertype,recentflag):
    from flask_login import current_user

    if LOGIN_DISABLED:
        current_user = DBSession.query(IuserUser).filter(
            IuserUser.id==DEFAULT_TEST_USER_ID).one()

    if (not current_user.member and memebr_id == 1) or (current_user.member.id == member_id):
        return export_intake_application(member_id, formusertype, recentflag)


# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# ======= Endpoints
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
api.add_resource(FormLookup, '{0}/form_lookup/'.format(DATA_URL), endpoint='form_lookup')
api.add_resource(FormLookup, '{0}/form_lookup/<int:user_id>/'.format(DATA_URL), endpoint='form_lookup_obo_user')
api.add_resource(FormLookup, '{0}/form_lookup/<int:user_id>/app_form/'.format(DATA_URL), endpoint='app_form_lookup_obo_user')
api.add_resource(URLMemberLookup, '{0}/url_name/'.format(DATA_URL), endpoint='url_data')
api.add_resource(CountryService, '{0}/countries/'.format(DATA_URL), endpoint='country_data')
api.add_resource(StateService, '{0}/states/'.format(DATA_URL), endpoint='state_data')
api.add_resource(EmployerService, '{0}/employers/<string:partial_str>/'.format(DATA_URL), endpoint='employer_data')
api.add_resource(CollegeService, '{0}/colleges/<string:partial_str>/'.format(DATA_URL), endpoint='college_data')
api.add_resource(SchoolService, '{0}/schools/'.format(DATA_URL), endpoint='school_data')
api.add_resource(SchoolService, '{0}/schools/<int:user_id>/'.format(DATA_URL), endpoint='school_data_obo_user')
api.add_resource(CareerService, '{0}/careers/'.format(DATA_URL), endpoint='career_data')
api.add_resource(CareerOnlyService, '{0}/careers_only/'.format(DATA_URL), endpoint='career_only_data')
api.add_resource(RacialGroupService, '{0}/rgroups/'.format(DATA_URL), endpoint='racial_group_data')
api.add_resource(AcademicFieldService, '{0}/afields/'.format(DATA_URL), endpoint='academic_field_data')
api.add_resource(MemberProgramService, '{0}/mprograms/'.format(DATA_URL), endpoint='member_program_data')
api.add_resource(MemberProgramService, '{0}/mprograms/<int:user_id>/'.format(DATA_URL), endpoint='member_program_data_obo_user')
