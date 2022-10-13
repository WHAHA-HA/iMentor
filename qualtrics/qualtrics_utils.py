# -*- coding: iso8859-15 -*-
import copy
from datetime import datetime
import httplib
import pdb
import traceback
import math
import pprint
import os,sys
import requests
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import (Base,metadata,
    ro_DBSession,DBSession,get_scoped_session)
from config.settings import (ENV_TYPE,LOGIN_DISABLED,
    DEFAULT_TEST_USER_ID,EMAIL_HOST_USER,QUALTRICS_URI,
    QUALTRICS_USER,QUALTRICS_TOKEN,QUALTRICS_API_SELECT,
    QUALTRICS_API_FORMAT,QUALTRICS_API_VERSION)

from flask import Response, json, jsonify, make_response, url_for, abort
from flask import  current_app, request, redirect, render_template
from flask.views import View, MethodView
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import desc
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

from qualtrics import qualtrics # app name
from legacy_models.mailer import MailerMessage
from legacy_models.iuser import (IuserUser,IuserPersona,IuserPersonaPartner,
    IuserUsertype,IuserAssignedusertype,ACTIVE_PERSONA_STATUS,USERTYPE_MAP,
    USER_STATUS_MAP,MATCH_CHOICES,USER_STATUS_INACTIVE_REJECTED,
    USER_STATUS_INTACTIVE_WITHDRAWN,USER_STATUS_INTACTIVE_DELETED,
    MENTEE,MENTOR,USER_STATUS_APPLICATION_INCOMPLETE,
    P_MATCH_STATUS_CLOSED)
from legacy_models.partners import PartnersPartner
from legacy_models.member import MemberSchool
from legacy_models.member import MemberMember
from college_checklist.models import CollegeChecklist
from new_platform.utils.roles import Role
from new_platform.utils.user_details import (get_persona_obj_for_user,
    get_partners_for_user,get_latest_mentor_for_mentee,
    get_latest_mentee_for_mentor,get_admin_for_user,get_details_for_user)
from qualtrics.models import (QualtricsSurvey,QualtricsInvite,QualtricsLibPanel,
    QUALTRICS_STATUS_MAP,QUALTRICS_NOT_INVITED,
    QUALTRICS_INVITED,QUALTRICS_INCOMPLETE,QUALTRICS_COMPLETE)

from qualtrics.qualtrics_3rd_party import (replace_survey_distribution_id,
    get_earliest_survey_link,add_user_to_qualtrics,gen_new_survey_link)

SORT_MAPPING = {
    'first_name':IuserUser.first_name,
    'last_name':IuserUser.last_name,
    'email':IuserUser.email,
    'survey_user_id':IuserPersona.qualtrics_panel_member_id,
    'user_status':IuserUser.status,
    'match_status':IuserPersona.match_status,
    'grade': MemberSchool.grade,
    'graduating_class':MemberSchool.graduating_class,
    'school':MemberSchool.school,
    'partner_id':PartnersPartner.id,
    'application_status':IuserUser.status,
    }

FILTER_MAPPING = {
    'first_name':IuserUser.first_name,
    'last_name':IuserUser.last_name,
    'email':IuserUser.email,
    'user_type':IuserAssignedusertype.usertype_id,
    'survey_status':QualtricsInvite.survey_status,
    'grade': MemberSchool.grade,
    'graduating_class':MemberSchool.graduating_class,
    'school':MemberSchool.school,
    'user_status':IuserUser.status,
    'match_status':IuserPersona.match_status,
    'partner_id':PartnersPartner.id,
    'application_status':IuserUser.status,
    }



def get_survey_user_list(post_args,page_size,page):

    if not post_args['partner_ids'] and not post_args['survey_id']:
         print "Empty partner_ids and/or survey_id, rejecting."
         return []

    peek_survey = ro_DBSession.query(QualtricsSurvey).filter(QualtricsSurvey.id==post_args['survey_id']).first()

    result = ro_DBSession.query(IuserPersonaPartner,IuserPersona,IuserUsertype,IuserAssignedusertype,IuserUser,MemberSchool,QualtricsInvite,PartnersPartner).\
      join(IuserPersona,IuserPersonaPartner.persona_id==IuserPersona.id).\
      join(PartnersPartner,IuserPersonaPartner.partner_id==PartnersPartner.id).\
      join(IuserAssignedusertype,IuserAssignedusertype.id==IuserPersona.assigned_usertype_id).\
      join(IuserUsertype,and_(IuserUsertype.id==IuserAssignedusertype.usertype_id,
          IuserUsertype.id==peek_survey.user_type)).\
      join(IuserUser,IuserUser.id==IuserPersona.user_id).\
      outerjoin(QualtricsInvite,and_(
          QualtricsInvite.persona_id==IuserPersona.id,
          QualtricsInvite.survey_id==post_args['survey_id'])).\
      outerjoin(MemberSchool,MemberSchool.id==PartnersPartner.graduating_class_id).\
      filter(IuserPersona.status == ACTIVE_PERSONA_STATUS).\
      filter(IuserPersona.match_status != P_MATCH_STATUS_CLOSED).\
      filter(PartnersPartner.is_alumni == False).\
      filter(IuserPersonaPartner.partner_id.in_(post_args['partner_ids']))


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
            if field == 'survey_status' and QUALTRICS_NOT_INVITED in value:
                new_value = [x for x in value if x != QUALTRICS_NOT_INVITED]
                if new_value:
                    result = result.filter(or_(
                        FILTER_MAPPING[field].in_(new_value),
                        FILTER_MAPPING[field]==None))
                else:
                    result = result.filter(FILTER_MAPPING[field]==None)
            elif field == 'application_status':
                if (True in value) and (False in value):
                    continue
                if True in value:
                    result = result.filter(FILTER_MAPPING[field]!=USER_STATUS_APPLICATION_INCOMPLETE)
                else:
                    result = result.filter(FILTER_MAPPING[field]==USER_STATUS_APPLICATION_INCOMPLETE)
            else:
            # Value is an array
                result = result.filter(FILTER_MAPPING[field].in_(value))

    # {'sort_fields':{'last_name':'asc'/'desc','first_name':'asc'/'desc'}}
    if 'sort_fields' in post_args:
        print "Sort fields: {0}".format(pprint.pformat(post_args['sort_fields']))
        for field,direction in post_args['sort_fields'].items():
            if direction == 'desc':
                result = result.order_by(desc(SORT_MAPPING[field]))
            elif direction == 'asc':
                result = result.order_by(SORT_MAPPING[field])
            else:
                continue # no sort

    if 'csv_download' in post_args and post_args['csv_download'] == True:
        return result.all()

    total = result.count()
    total_pages = int(math.ceil(float(total)/float(page_size)))

    result_obj = result
    result = result_obj.all()
    
    outbound = {'total':total,'total_pages':total_pages,
        'current_page':page,'page_size':page_size,'data':[]}

    outbound['survey_totals'] = {
        'total_invited':0,
        'total_incomplete':0,
        'total_completed':0,
        'total_not_invited':0
        }

    for r in result:
        if r[6]:
            if r[6].survey_status == QUALTRICS_INCOMPLETE:
                outbound['survey_totals']['total_incomplete'] += 1
            elif r[6].survey_status == QUALTRICS_INVITED:
                outbound['survey_totals']['total_invited'] += 1
            elif r[6].survey_status == QUALTRICS_COMPLETE:
                outbound['survey_totals']['total_completed'] += 1
        else:
            outbound['survey_totals']['total_not_invited'] += 1

    outbound['survey_percents'] = {
        'Invited':int(math.ceil((float(outbound['survey_totals']['total_invited']) / float(total)) * 100)) if total else 0,
        'Not Invited':int(math.ceil((float(outbound['survey_totals']['total_not_invited']) / float(total)) * 100)) if total else 0,
        'Completed':int(math.ceil((float(outbound['survey_totals']['total_completed']) / float(total)) * 100)) if total else 0,
        'Incomplete':int(math.ceil((float(outbound['survey_totals']['total_incomplete']) / float(total)) * 100)) if total else 0,
        }

    result = result_obj.limit(page_size).offset(page_size * (page-1)).all()

    for r in result:
        outbound['data'].append({
            'user_id':r[4].id,
            'first_name':r[4].first_name,
            'last_name':r[4].last_name,
            'email':r[4].email,
            'user_type':r[3].usertype_id,
            'application_status':True if r[4].status != USER_STATUS_APPLICATION_INCOMPLETE else False,
            'survey_id': r[6].survey_id if r[6] else None,
            'survey_description': r[6].survey.description if r[6] else None,
            'survey_status': r[6].survey_status if r[6] else QUALTRICS_NOT_INVITED,
            'grade':r[5].grade if r[5] else None,
            'graduating_class':r[5].graduating_class if r[5] else None,
            'school':r[5].school if r[5] else None,
            'user_status':r[4].status,
            'match_status':r[1].match_status,
            'partner_name':r[7].name,
            'survey_user_id':r[1].qualtrics_panel_member_id,
            'partner_id':r[7].id
            })

    return outbound


def send_invite_email(local_db_session,user,link,description):

    if not user or not link:
        return

    user_role = Role(user.id)

    member_details = DBSession.query(
        MemberMember.name.label('member_name'),
        MemberMember.url_name.label('member_url')).\
        filter(MemberMember.id==user.member_id).first()

    if user.member_id in [1, 244, 248]:
        team_name = 'The iMentor Team'
    else:
        team_name = 'The mentor 2.0 Team'

    if user_role.is_mentee:
        personalized_body = '''Hi from {0}!

Please take a moment to complete the {1}. The information we collect using this survey helps us measure the effectiveness of our program, and we greatly value our mentees' feedback as we learn how we can improve. The survey will only take 15-20 minutes of your time to complete.

Click here to access your survey: {2}

Thanks,

{3}
            '''.format(member_details[0],description,link, team_name)
    else:
        personalized_body = '''Hi from {0}!

Please take a moment to complete the {1}. The information we collect using this survey helps us measure the effectiveness of our program, and we greatly value our mentors' feedback as we learn how we can improve. The survey will only take 5-10 minutes of your time to complete.

Click here to access your survey: {2}

Thanks,

{3}
            '''.format(member_details[0],description,link, team_name)

    message = MailerMessage(
        to_address=user.email,
        from_address=EMAIL_HOST_USER,
        subject='Please take this survey from %s!' % member_details[0],
        message_body=personalized_body,
        priority='2',
        content_subtype=''
        )

    local_db_session.add(message)
    local_db_session.commit()
    local_db_session.begin()



def lookup_emails(post_args,admin):
    if 'external_email' in post_args:
        return [x.email for x in IuserUser.query.filter(
            IuserUser.id.in_(post_args['external_email']['user_ids'])).all()]


def check_survey_status(survey_id,user_ids,admin):
    survey = QualtricsSurvey.query.filter(QualtricsSurvey.id==survey_id).one()
    # Return a list of user ids for users who completed the survey.

    invited = [x.user_id for x in QualtricsInvite.query.filter(QualtricsInvite.survey_id==survey.id).filter(
        QualtricsInvite.survey_status==QUALTRICS_INVITED).all() if x.user_id in user_ids]

    completed = [x.user_id for x in QualtricsInvite.query.filter(QualtricsInvite.survey_id==survey.id).filter(
        QualtricsInvite.survey_status==QUALTRICS_COMPLETE).all() if x.user_id in user_ids]

    return {'completed':completed,'invited':invited}


def delete_invitations(post_args,admin):
    if 'uninvite' not in post_args or 'survey_id' not in post_args:
        return

    local_db_session = get_scoped_session()

    if post_args['uninvite']['user_ids']:
        for user_id in post_args['uninvite']['user_ids']:
            local_db_session.query(QualtricsInvite).filter(
                QualtricsInvite.survey_id==post_args['survey_id']).filter(
                QualtricsInvite.user_id.in_(post_args['uninvite']['user_ids'])
                ).delete(synchronize_session=False)

    else: # by partner
        user_ids = [x.persona.user.id for x in IuserPersonaPartner.query.filter(
            IuserPersonaPartner.partner_id.in_(post_args['partner_ids'])).all()]

        local_db_session.query(QualtricsInvite).filter(
            QualtricsInvite.survey_id==post_args['survey_id']).filter(
            QualtricsInvite.user_id.in_(user_ids)).delete(synchronize_session=False)
            
    local_db_session.commit()


def invite_users(post_args,admin):
    if 'invite' not in post_args or 'survey_id' not in post_args:
        return
    if not post_args['partner_ids'] and not post_args['invite']['user_ids']:
        return

    local_db_session = get_scoped_session()

    survey = QualtricsSurvey.query.filter(QualtricsSurvey.id==post_args['survey_id']).one()
    if post_args['invite']['user_ids']:
        for user_id in post_args['invite']['user_ids']:
            user = IuserUser.query.filter(IuserUser.id==user_id).one()
            link = gen_new_survey_link(local_db_session,
                user,survey.survey_string,admin)
            if link:
                send_invite_email(local_db_session,user,link,survey.description)
    else:
        for pp in IuserPersonaPartner.query.filter(
            IuserPersonaPartner.partner_id.in_(post_args['partner_ids'])).all():
            if pp.persona.user.status not in (USER_STATUS_INACTIVE_REJECTED,
                USER_STATUS_INTACTIVE_WITHDRAWN,USER_STATUS_INTACTIVE_DELETED):
                link = gen_new_survey_link(local_db_session,
                    pp.persona.user,survey.survey_string,admin)
                if link:
                    send_invite_email(local_db_session,pp.persona.user,
                        link,survey.description)
            

    local_db_session.commit()

