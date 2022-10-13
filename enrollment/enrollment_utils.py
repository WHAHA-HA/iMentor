# -*- coding: iso8859-15 -*-
import pdb
import pprint
import copy
import os,sys
import math
from datetime import datetime
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import db,Base,metadata,ro_DBSession,DBSession
from config.settings import (ENV_TYPE,LOGIN_DISABLED,
    DEFAULT_TEST_USER_ID)

from flask import Response, json, jsonify, make_response, url_for, abort
from sqlalchemy import desc
from sqlalchemy.sql.expression import func, or_, not_, and_
from sqlalchemy.orm import sessionmaker 
from sqlalchemy.orm.exc import NoResultFound, MultipleResultsFound

#from flask_wtf import Form, RadioField

#Import 'app' object from auth as well
from auth import api, app

from legacy_models.partners import PartnersPartner
from legacy_models.iuser import (USERTYPE_MAP,ACTIVE_PERSONA_STATUS,
    GENDER_CHOICES,MATCH_CHOICES,USER_STATUS_MAP,USER_STATUS_APPLICATION_INCOMPLETE,
    P_MATCH_STATUS_READY,P_MATCH_STATUS_MATCHED,
    IuserPersonaPartner,IuserPersona,IuserUsertype,IuserAssignedusertype,IuserUser)
from qualtrics.models import (QualtricsInvite,QUALTRICS_STATUS_MAP,
    QUALTRICS_COMPLETE,QUALTRICS_NOT_INVITED)

from new_platform.utils.roles import Role
from new_platform.utils import user_details
from enrollment.models import (MenteeReadinessSchool,SCHOOL_ATTENDANCE_VALUES,
    PROGRAM_READINESS_VALUES,SCHOOL_ATTENDANCE_YES,PROGRAM_READINESS_YES)

SORT_MAPPING = {
    'first_name':IuserUser.first_name,
    'last_name':IuserUser.last_name,
    'gender':IuserUser.gender,
    'application_status':IuserUser.status,
    'attendance': MenteeReadinessSchool.school_attendance,
    'program_readiness': MenteeReadinessSchool.program_readiness,
    'parental_consent':IuserUser.mentee_consent_form,
    'user_status':IuserUser.status,
    'match_status':IuserPersona.match_status,
    'partner_id':PartnersPartner.id,
    }

FILTER_MAPPING = {
    'first_name':IuserUser.first_name,
    'last_name':IuserUser.last_name,
    'gender':IuserUser.gender,
    'application_status':IuserUser.status,
    'attendance': MenteeReadinessSchool.school_attendance,
    'program_readiness': MenteeReadinessSchool.program_readiness,
    'parental_consent':IuserUser.mentee_consent_form,
    'user_status':IuserUser.status,
    'match_status':IuserPersona.match_status,
    'partner_id':PartnersPartner.id,
    }



def _get_mentees_for_partners(post_args,page_size,page):
    result = ro_DBSession.query(IuserPersonaPartner,IuserPersona,IuserUsertype,IuserAssignedusertype,IuserUser,MenteeReadinessSchool,PartnersPartner).\
      join(IuserPersona,IuserPersonaPartner.persona_id==IuserPersona.id).\
      join(PartnersPartner,IuserPersonaPartner.partner_id==PartnersPartner.id).\
      join(IuserAssignedusertype,IuserAssignedusertype.id==IuserPersona.assigned_usertype_id).\
      join(IuserUsertype,IuserUsertype.id==IuserAssignedusertype.usertype_id).\
      join(IuserUser,IuserUser.id==IuserPersona.user_id).\
      outerjoin(MenteeReadinessSchool,MenteeReadinessSchool.user_id==IuserUser.id).\
      filter(IuserUsertype.id == 5).\
      filter(IuserPersona.status == ACTIVE_PERSONA_STATUS).\
      filter(PartnersPartner.is_alumni == False).\
      filter(IuserPersonaPartner.partner_id.in_(post_args['partner_ids']))

    #from sqlalchemy.dialects import postgresql
    #print "Mentees query{0}".format(str(result.statement.compile(dialect=postgresql.dialect())))

    if 'search_string' in post_args and post_args['search_string'] not in (None,''):
        result = result.filter(or_(
            FILTER_MAPPING['first_name'].ilike('%'+post_args['search_string']+'%'),
            FILTER_MAPPING['last_name'].ilike('%'+post_args['search_string']+'%')
            ))

    # {'filter_fields':{'gender':['N','M'],'program_readiness':[1],...}}
    if 'filter_fields' in post_args:
        for field,value in post_args['filter_fields'].items():
            if not value:
                continue
            if field == 'application_status':
                if len(value) == 1 and value[0] == True:
                    result = result.filter(FILTER_MAPPING[field]!=USER_STATUS_APPLICATION_INCOMPLETE)
                elif len(value) == 1 and value[0] == False:
                    result = result.filter(FILTER_MAPPING[field]==USER_STATUS_APPLICATION_INCOMPLETE)
            else:
                # Value is an array
                result = result.filter(FILTER_MAPPING[field].in_(value))

    # {'sort_fields':{'last_name':'asc'/'desc','first_name':'asc'/'desc'}}
    if 'sort_fields' in post_args:
        for field,direction in post_args['sort_fields'].items():
            if direction == 'desc':
                result = result.order_by(desc(SORT_MAPPING[field]))
            elif direction == 'asc':
                result = result.order_by(SORT_MAPPING[field])
            else:
                continue
    else:
        result = result.order_by(IuserUser.last_name)

    if 'csv_download' in post_args and post_args['csv_download'] == True:
        return result.all()

    total = result.count()
    total_pages = int(math.ceil(float(total)/float(page_size)))

    outbound = {'total':total,'total_pages':total_pages,
        'current_page':page,'page_size':page_size,'data':[]}

    outbound['enrollment_totals'] = {
        'total_male_records':0,
        'total_female_records':0,
        'total_app_status_complete':0,
        'total_app_status_complete_male':0,
        'total_app_status_complete_female':0,
        'total_school_attendance_yes':0,
        'total_school_attendance_yes_male':0,
        'total_school_attendance_yes_female':0,
        'total_program_readiness_yes':0,
        'total_program_readiness_yes_male':0,
        'total_program_readiness_yes_female':0,
        'total_parental_consent_yes':0,
        'total_parental_consent_yes_male':0,
        'total_parental_consent_yes_female':0,
        'total_ready_to_be_matched':0,
        'total_ready_to_be_matched_male':0,
        'total_ready_to_be_matched_female':0,
        'total_not_ready_to_be_matched':0,
        'total_not_ready_to_be_matched_male':0,
        'total_not_ready_to_be_matched_female':0,
        'total_matched':0,
        'total_matched_male':0,
        'total_matched_female':0,
        }

    for r in result.all():
        if r[4].gender == 'M':
            outbound['enrollment_totals']['total_male_records'] += 1
            if r[4].status != USER_STATUS_APPLICATION_INCOMPLETE:
                outbound['enrollment_totals']['total_app_status_complete_male'] += 1
            if r[5] and r[5].school_attendance == SCHOOL_ATTENDANCE_YES:
                outbound['enrollment_totals']['total_school_attendance_yes_male'] += 1
            if r[5] and r[5].program_readiness == PROGRAM_READINESS_YES:
                outbound['enrollment_totals']['total_program_readiness_yes_male'] += 1
            if r[4].mentee_consent_form:
                outbound['enrollment_totals']['total_parental_consent_yes_male'] += 1

            if r[1].match_status == P_MATCH_STATUS_READY:
                outbound['enrollment_totals']['total_ready_to_be_matched_male'] += 1
            elif r[1].match_status == P_MATCH_STATUS_MATCHED:
                outbound['enrollment_totals']['total_matched_male'] += 1
            else:
                outbound['enrollment_totals']['total_not_ready_to_be_matched_male'] += 1


        else:
            outbound['enrollment_totals']['total_female_records'] += 1
            if r[4].status != USER_STATUS_APPLICATION_INCOMPLETE:
                outbound['enrollment_totals']['total_app_status_complete_female'] += 1
            if r[5] and r[5].school_attendance == SCHOOL_ATTENDANCE_YES:
                outbound['enrollment_totals']['total_school_attendance_yes_female'] += 1
            if r[5] and r[5].program_readiness == PROGRAM_READINESS_YES:
                outbound['enrollment_totals']['total_program_readiness_yes_female'] += 1
            if r[4].mentee_consent_form:
                outbound['enrollment_totals']['total_parental_consent_yes_female'] += 1

            if r[1].match_status == P_MATCH_STATUS_READY:
                outbound['enrollment_totals']['total_ready_to_be_matched_female'] += 1
            elif r[1].match_status == P_MATCH_STATUS_MATCHED:
                outbound['enrollment_totals']['total_matched_female'] += 1
            else:
                outbound['enrollment_totals']['total_not_ready_to_be_matched_female'] += 1


        if r[4].status != USER_STATUS_APPLICATION_INCOMPLETE:
            outbound['enrollment_totals']['total_app_status_complete'] += 1

        if r[5] and r[5].school_attendance == SCHOOL_ATTENDANCE_YES:
            outbound['enrollment_totals']['total_school_attendance_yes'] += 1

        if r[5] and r[5].program_readiness == PROGRAM_READINESS_YES:
            outbound['enrollment_totals']['total_program_readiness_yes'] += 1

        if r[4].mentee_consent_form:
            outbound['enrollment_totals']['total_parental_consent_yes'] += 1

        if r[1].match_status == P_MATCH_STATUS_READY:
            outbound['enrollment_totals']['total_ready_to_be_matched'] += 1
        elif r[1].match_status == P_MATCH_STATUS_MATCHED:
            outbound['enrollment_totals']['total_matched'] += 1
        else:
            outbound['enrollment_totals']['total_not_ready_to_be_matched'] += 1


    outbound['enrollment_percents'] = {
        'ready_to_be_matched':int(math.ceil((float(outbound['enrollment_totals']['total_ready_to_be_matched']) / float(total)) * 100)) \
            if total else 0,

        'not_ready_to_be_matched':int(math.ceil((float(outbound['enrollment_totals']['total_not_ready_to_be_matched']) / float(total)) * 100)) \
            if total else 0,

        'matched':int(math.ceil((float(outbound['enrollment_totals']['total_matched']) / float(total)) * 100)) \
            if total else 0,

        'app_complete_out_of_total':int(math.ceil((float(outbound['enrollment_totals']['total_app_status_complete']) / float(total)) * 100)) \
            if total else 0,

        'male_app_complete_out_of_total_male':int(math.ceil((float(outbound['enrollment_totals']['total_app_status_complete_male']) / float(outbound['enrollment_totals']['total_male_records'])) * 100)) \
            if outbound['enrollment_totals']['total_male_records'] else 0,

        'female_app_complete_out_of_total_female':int(math.ceil((float(outbound['enrollment_totals']['total_app_status_complete_female']) / float(outbound['enrollment_totals']['total_female_records'])) * 100)) \
            if outbound['enrollment_totals']['total_female_records'] else 0,

        'attendance_yes_out_of_total':int(math.ceil((float(outbound['enrollment_totals']['total_school_attendance_yes']) / float(total)) * 100)) \
            if total else 0,

        'male_attendance_yes_out_of_total_male':int(math.ceil((float(outbound['enrollment_totals']['total_school_attendance_yes_male']) / float(outbound['enrollment_totals']['total_male_records'])) * 100)) \
            if outbound['enrollment_totals']['total_male_records'] else 0,

        'female_attendance_yes_out_of_total_female':int(math.ceil((float(outbound['enrollment_totals']['total_school_attendance_yes_female']) / float(outbound['enrollment_totals']['total_female_records'])) * 100)) \
            if outbound['enrollment_totals']['total_female_records'] else 0,

        'readiness_yes_out_of_total':int(math.ceil((float(outbound['enrollment_totals']['total_program_readiness_yes']) / float(total)) * 100)) \
            if total else 0,

        'male_readiness_yes_out_of_total_male':int(math.ceil((float(outbound['enrollment_totals']['total_program_readiness_yes_male']) / float(outbound['enrollment_totals']['total_male_records'])) * 100)) \
            if outbound['enrollment_totals']['total_male_records'] else 0,

        'female_readiness_yes_out_of_total_female':int(math.ceil((float(outbound['enrollment_totals']['total_program_readiness_yes_female']) / float(outbound['enrollment_totals']['total_female_records'])) * 100)) \
            if outbound['enrollment_totals']['total_female_records'] else 0,

        'parental_consent_yes_out_of_total':int(math.ceil((float(outbound['enrollment_totals']['total_parental_consent_yes']) / float(total)) * 100)) \
            if total else 0,

        'male_parental_consent_yes_out_of_total_male':int(math.ceil((float(outbound['enrollment_totals']['total_parental_consent_yes_male']) / float(outbound['enrollment_totals']['total_male_records'])) * 100)) \
            if outbound['enrollment_totals']['total_male_records'] else 0,

        'female_parental_consent_yes_out_of_total_female':int(math.ceil((float(outbound['enrollment_totals']['total_parental_consent_yes_female']) / float(outbound['enrollment_totals']['total_female_records'])) * 100)) \
            if outbound['enrollment_totals']['total_female_records'] else 0,

        'ready_to_be_matched_out_of_total':int(math.ceil((float(outbound['enrollment_totals']['total_ready_to_be_matched']) / float(total)) * 100)) \
            if total else 0,

        'male_ready_to_be_matched_out_of_total_male':int(math.ceil((float(outbound['enrollment_totals']['total_ready_to_be_matched_male']) / float(outbound['enrollment_totals']['total_male_records'])) * 100)) \
            if outbound['enrollment_totals']['total_male_records'] else 0,

        'female_ready_to_be_matched_out_of_total_female':int(math.ceil((float(outbound['enrollment_totals']['total_ready_to_be_matched_female']) / float(outbound['enrollment_totals']['total_female_records'])) * 100)) \
            if outbound['enrollment_totals']['total_female_records'] else 0,

        'not_ready_to_be_matched_out_of_total':int(math.ceil((float(outbound['enrollment_totals']['total_not_ready_to_be_matched']) / float(total)) * 100)) \
            if total else 0,

        'male_not_ready_to_be_matched_out_of_total_male':int(math.ceil((float(outbound['enrollment_totals']['total_not_ready_to_be_matched_male']) / float(outbound['enrollment_totals']['total_male_records'])) * 100)) \
            if outbound['enrollment_totals']['total_male_records'] else 0,

        'female_not_ready_to_be_matched_out_of_total_female':int(math.ceil((float(outbound['enrollment_totals']['total_not_ready_to_be_matched_female']) / float(outbound['enrollment_totals']['total_female_records'])) * 100)) \
            if outbound['enrollment_totals']['total_female_records'] else 0,

        'matched_out_of_total':int(math.ceil((float(outbound['enrollment_totals']['total_matched']) / float(total)) * 100)) \
            if total else 0,

        'male_matched_out_of_total_male':int(math.ceil((float(outbound['enrollment_totals']['total_matched_male']) / float(outbound['enrollment_totals']['total_male_records'])) * 100)) \
            if outbound['enrollment_totals']['total_male_records'] else 0,

        'female_matched_out_of_total_female':int(math.ceil((float(outbound['enrollment_totals']['total_matched_female']) / float(outbound['enrollment_totals']['total_female_records'])) * 100)) \
            if outbound['enrollment_totals']['total_female_records'] else 0,

        }


    result = result.limit(page_size).offset(page_size * (page-1)).all()

    for r in result:
        outbound['data'].append({
            'user_id':r[4].id,
            'first_name':r[4].first_name,
            'last_name':r[4].last_name,
            'gender':r[4].gender,
            'application_status':True if r[4].status != USER_STATUS_APPLICATION_INCOMPLETE else False,
            'attendance': r[5].school_attendance if r[5] else None,
            'program_readiness': r[5].program_readiness if r[5] else None,
            'parental_consent':'Yes' if r[4].mentee_consent_form else 'No',
            'user_status':r[4].status,
            'match_status':r[1].match_status,
            'partner_name':r[6].name,
            'partner_id':r[6].id,
            'persona_id':r[1].id
            })

    return outbound

