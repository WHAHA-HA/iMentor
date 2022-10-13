# -*- coding: iso8859-15 -*-
import pdb
import pprint
import copy
import os,sys
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import (Base,metadata,
    DBSession,get_scoped_session)
from config.settings import ENV_TYPE, LOGIN_DISABLED

from flask import Response, json, jsonify, make_response, url_for, abort
from flask import  current_app, request, redirect, render_template
from flask.views import View, MethodView
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.sql.expression import func, or_, not_, and_
from sqlalchemy.orm import sessionmaker 
from sqlalchemy.orm.exc import NoResultFound, MultipleResultsFound

from flask_restful import Resource, Api, fields, marshal_with
#from flask_wtf import Form, RadioField

from auth import app
from legacy_models.utils import (UtilsState,UtilsCountry,
    UtilsCareer,UtilsOccupation)

from legacy_models.partners import PartnersPartner

from legacy_models.iuser import (IuserEmployer,IuserEmployerMember,
    IuserUser,
    IuserRacialgroup,IuserAcademicfield,IuserUserRacialgroup,
    ACTIVE_PERSONA_STATUS)
from legacy_models.member import MemberUserprogram, MemberSchool
from college_checklist.models import UtilsCollege

from apiforms.models import (FormCopy,SectionCopy,QuestionCopy,
    AnswerCopy,AnswerDependencyCopy,FormMemberSite,
    UserResponse,QUESTION_FREEFORM_TEXT,
    QUESTION_FREEFORM_CHAR,QUESTION_PHONE,QUESTION_ADDRESS,
    QUESTION_SINGLE_SELECT_TOGGLE,QUESTION_SINGLE_SELECT_RADIO,
    QUESTION_MULTI_SELECT,QUESTION_DROPDOWN,
    QUESTION_DROPDOWN_COUNTRIES,QUESTION_DROPDOWN_STATES,
    QUESTION_DROPDOWN_EMPLOYERS,QUESTION_DROPDOWN_COLLEGES,
    QUESTION_DROPDOWN_SCHOOLS,QUESTION_DATETIME,
    QUESTION_HEADING,QUESTION_INSTRUCTIONS,QUESTION_CAREER_OCCUPATION,
    QUESTION_CAREERS_ONLY,QUESTION_RACIAL_GROUP,
    QUESTION_ACADEMIC_FIELD,QUESTION_PARTNER_PROGRAM,
    QUESTION_MULTI_SELECT_NOPREF_TOGGLE,
    QUESTION_DROPDOWN_EMPLOYERS_TYPE2,
    QUESTON_TYPES,
    MENTOR_FORM,MENTEE_FORM,FORM_USER_TYPES,FORM_USER_TYPE_MAP,
    REVERSE_FORM_USER_TYPE_MAP,APPLICATION)

from new_platform.utils.user_status_type import create_persona_partner 
from new_platform.utils.authz import check_authz
from new_platform.utils.roles import Role


class UnrecognizedQuestionTypeException(Exception):
    pass

# Question type validation happens here.
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def eval_user_response(user_id,form_id,user_response,question_id,answer_id):
    '''
    This returns a tuple: error, jsonized response for storage, answer_id,
    asnwer_id from an external table.
    '''
    local_db_session = get_scoped_session()

    question = DBSession.query(QuestionCopy).filter(QuestionCopy.id==question_id).first()

    if question.question_type in (QUESTION_FREEFORM_TEXT, QUESTION_FREEFORM_CHAR, 
        QUESTION_HEADING,QUESTION_INSTRUCTIONS):
        if (not user_response) or (user_response.strip() in ('',None)):
            return [{'success': False, 'error':'Response is empty, rejecting'},
                None,None,None]
        return [None,user_response.strip() if user_response else None,
            answer_id,None]

    if question.question_type == QUESTION_PHONE: # phone
        if (not user_response) or (user_response.strip() in ('',None)):
            return [{'success': False, 'error':'Phone field is missing.'},
                None,None,None]
        if not user_response.strip().isdigit():
            return [{'success': False, 'error':'Phone field is incorrect.'},
                None,None,None]
        if len(user_response) > 10:
            return [{'success': False, 'error':'Phone field should only be 9 digits.'},
                None,None,None]
        return [None,user_response.strip(),answer_id,None]

    if question.question_type == QUESTION_ADDRESS:
        if 'address' not in user_response or user_response['address'].strip() in ('',None):
            return [{'success': False, 'error':'missing address field.'},
                None,None,None]
        if 'city' not in user_response or user_response['city'].strip() in ('',None):
            return [{'success': False, 'error':'missing city field.'},
                None,None,None]
        if 'state_id' not in user_response:
            return [{'success': False, 'error':'missing state_id field.'},
                None,None,None]
        if not DBSession.query(UtilsState).filter(UtilsState.id==user_response['state_id']).first():
            return [{'success': False, 'error':'state_id field is invalid.'},
                None,None,None]
        if 'zipcode' not in user_response:
            return [{'success': False, 'error':'missing ZIP code field.'},
                None,None,None]
        if not user_response['zipcode'].strip().isdigit():
            return [{'success': False, 'error':'ZIP code field is incorrect.'},
                None,None,None]

        user_response['address'] = user_response['address'].strip()
        user_response['city'] = user_response['city'].strip()
        user_response['zipcode'] = user_response['zipcode'].strip()
        return [None,json.dumps(user_response),None,None]

    if question.question_type in (QUESTION_SINGLE_SELECT_TOGGLE, 
        QUESTION_SINGLE_SELECT_RADIO, QUESTION_DROPDOWN):
        answer_match = DBSession.query(AnswerCopy).filter(and_(
            AnswerCopy.question_id == question_id,
            AnswerCopy.is_active == True,
            AnswerCopy.id == answer_id
            )).first()
        if not answer_match:
            return [{'success': False, 
                     'error':'answer id doesn\'t match potential answers for the question.'
                    },None,None,None]
        return [None,user_response.strip() if user_response else None,
            answer_id,None]

    if question.question_type == QUESTION_MULTI_SELECT:
        if 'answer_ids' not in user_response or user_response['answer_ids'] in ('',None,[]):
            return [{'success': False, 'error':'answer_ids field is missing/empty.'},
                None,None,None]

        for a_id in user_response['answer_ids']:
            if not isinstance(a_id,(int,long)):
                return [{'success': False, 'error':'answer_id list needs to be all integers.'},
                    None,None,None]
            if not DBSession.query(AnswerCopy).filter(and_(
                AnswerCopy.question_id == question_id,
                AnswerCopy.is_active == True,
                AnswerCopy.id == a_id
                )).first():

                return [{'success': False, 
                         'error':'answer id {0} doesn\'t match potential answers for the question.'.format(a_id),
                        },None,None,None]

        return [None,json.dumps(user_response),None,None]

    if question.question_type == QUESTION_MULTI_SELECT_NOPREF_TOGGLE:
        # If user chose no preference, there is no user response obj for 
        # this question. That condition was caught above. 
        if 'answer_ids' not in user_response:
            return [{'success': False, 'error':'answer_ids field is missing/empty.'},
                None,None,None]

        for a_id in user_response['answer_ids']:
            if not isinstance(a_id,(int,long)):
                return [{'success': False, 'error':'answer_id list needs to be all integers.'},
                    None,None,None]
            if not DBSession.query(AnswerCopy).filter(and_(
                AnswerCopy.question_id == question_id,
                AnswerCopy.is_active == True,
                AnswerCopy.id == a_id
                )).first():

                return [{'success': False, 
                         'error':'answer id {0} doesn\'t match potential answers for the question.'.format(a_id),
                        },None,None,None]

        return [None,json.dumps(user_response),None,None]

    if question.question_type == QUESTION_DROPDOWN_COUNTRIES:
        if not DBSession.query(UtilsCountry).filter(
            UtilsCountry.id == answer_id
            ).first():

            return [{'success': False, 
                     'error':'answer id {0} doesn\'t match potential answers for Country choices.'.format(answer_id),
                    },None,None,None]

         # Answer is an ID from an external table in this case. Swap them.
        return [None,user_response,None,answer_id]

    if question.question_type == QUESTION_DROPDOWN_STATES:
        if not DBSession.query(UtilsState).filter(
            UtilsState.id == answer_id
            ).first():

            return [{'success': False, 
                     'error':'answer id {0} doesn\'t match potential answers for State choices.'.format(answer_id),
                    },None,None,None]

         # Answer is an ID from an external table in this case. Swap them.
        return [None,user_response,None,answer_id]

    if question.question_type == QUESTION_DROPDOWN_EMPLOYERS:
        if answer_id:
            if not DBSession.query(IuserEmployer).filter(
                IuserEmployer.id == answer_id
                ).first():

                return [{'success': False, 
                     'error':'answer id {0} doesn\'t match potential answers for Employer choices.'.format(answer_id)
                    },None,None,None]

        elif user_response:
            answer = DBSession.query(IuserEmployer).filter(
                IuserEmployer.name == user_response.strip()
                ).first()

            if not answer:
                user = DBSession.query(IuserUser).filter(IuserUser.id==user_id).one()

                answer = IuserEmployer(name=user_response.strip())
                local_db_session.add(answer)
                local_db_session.flush()
                print "Added new Employer: {0} {1}".format(answer.id,answer.name)

                new_employer_member = IuserEmployerMember(
                  employer_id=answer.id,
                  member_id=user.member_id)

                local_db_session.add(new_employer_member)

                local_db_session.commit()

            answer_id = answer.id

        else:
            return [{'success': False, 
                'error':'Both user_response and answer_id are blank, rejecting.'
                },None,None,None]


        # Answer is an ID from an external table in this case. Swap them.
        return [None,user_response,None,answer_id]

    if question.question_type == QUESTION_DROPDOWN_EMPLOYERS_TYPE2:
        #{'employer1': {'answer_id':None,'answer': some string, or Not Listed},
        # 'employer2': {'answer_id':None,'answer': some string}}

        employer_lookup = None
        new_employer = None
        if user_response['employer1']['answer_id']:
            employer_lookup = user_response['employer1']['answer_id']

        elif user_response['employer1']['answer'] == 'Not Listed':
            if user_response['employer2']['answer_id']:
                employer_lookup = user_response['employer2']['answer_id']
            else:
                new_employer = user_response['employer2']['answer']

        else:
             new_employer = user_response['employer1']['answer']


        if employer_lookup:
            if not DBSession.query(IuserEmployer).filter(
                IuserEmployer.id == employer_lookup
                ).first():

                return [{'success': False, 
                     'error':'answer id {0} doesn\'t match potential answers for Employer choices.'.format(employer_lookup)
                    },None,None,None]

            answer_id = employer_lookup
            new_employer = user_response['employer1']['answer']

        elif new_employer:
            answer = DBSession.query(IuserEmployer).filter(
                IuserEmployer.name == new_employer.strip()
                ).first()

            if not answer:
                user = DBSession.query(IuserUser).filter(IuserUser.id==user_id).one()

                answer = IuserEmployer(name=new_employer.strip())
                local_db_session.add(answer)
                local_db_session.flush()
                print "Added new Employer: {0} {1}".format(answer.id,answer.name)

                new_employer_member = IuserEmployerMember(
                  employer_id=answer.id,
                  member_id=user.member_id)

                local_db_session.add(new_employer_member)

                local_db_session.commit()

            answer_id = answer.id

        else:
            return [{'success': False, 
                'error':'Both sets of answer and answer_id are blank, or did not make sense, rejecting.'
                },None,None,None]


        # Answer is an ID from an external table in this case. Swap them.
        return [None,new_employer,None,answer_id]


    if question.question_type == QUESTION_DROPDOWN_COLLEGES:
        if 'colleges' not in user_response or user_response in ('',None):
            return [{'success': False, 
                     'error': 'Missing "colleges" field in user_response. Expecting college id list.'
                    },None,None,None]

        for college in user_response['colleges']: #{'id':x,'name':yyyyy}
            if college['id'] == 0 and len(user_response['colleges']) == 1:
                break # This means not listed in the dropdown.

            if not DBSession.query(UtilsCollege).filter(
                UtilsCollege.id == college['id']
                ).first():
                return [{'success': False, 
                     'error':'college id {0} doesn\'t match potential College choices, or you have 0 plus some other selection.'.format(college['id']),
                    },None,None,None]

        return [None,json.dumps(user_response),None,None]

    if question.question_type == QUESTION_RACIAL_GROUP:
        if 'rgroups' not in user_response or user_response in ('',None):
            return [{'success': False, 
                     'error': 'Missing "rgroups" field in user_response. Expecting an rgroup list.'
                    },None,None,None]

        for rgroup in user_response['rgroups']:
            if not DBSession.query(IuserRacialgroup).filter(
                IuserRacialgroup.id == rgroup
                ).first():
                return [{'success': False, 
                     'error':'rgroup id {0} doesn\'t match potential rgroup choices, or you have 0 plus some other selection.'.format(rgroup),
                    },None,None,None]

        return [None,json.dumps(user_response),None,None]

    if question.question_type == QUESTION_ACADEMIC_FIELD:
        if 'afields' not in user_response or user_response in ('',None):
            return [{'success': False, 
                     'error': 'Missing "afields" field in user_response. Expecting an afields list.'
                    },None,None,None]

        for afield in user_response['afields']: #{'id':x,'name':yyyyy}
            if not DBSession.query(IuserAcademicfield).filter(
                IuserAcademicfield.id == afield
                ).first():
                return [{'success': False, 
                     'error':'afield id {0} doesn\'t match potential afield choices, or you have 0 plus some other selection.'.format(afield),
                    },None,None,None]

        return [None,json.dumps(user_response),None,None]

    if question.question_type == QUESTION_PARTNER_PROGRAM:
        if 'mprograms' not in user_response or user_response in ('',None):
            return [{'success': False, 
                     'error': 'Missing "mprograms" field in user_response. Expecting an mprograms list.'
                    },None,None,None]

        for mprogram in user_response['mprograms']: #[n,m,x,...]
            if not DBSession.query(MemberUserprogram).filter(
                MemberUserprogram.id == mprogram
                ).first():
                return [{'success': False, 
                     'error':'mprogram id {0} doesn\'t match potential mprogram choices, or you have 0 plus some other selection.'.format(mprogram),
                    },None,None,None]

        return [None,json.dumps(user_response),None,None]

    if question.question_type == QUESTION_DROPDOWN_SCHOOLS:
        # 'school' is an id.
        if 'school' not in user_response or user_response in ('',None):
            return [{'success': False, 
                     'error': 'Missing "school" field in user_response. Expecting both answer id and a user response.'
                    },None,None,None]

        if not DBSession.query(PartnersPartner).filter(
            PartnersPartner.id == answer_id
            ).first():

            return [{'success': False, 
                     'error':'answer id {0} doesn\'t match potential answers for School/Class choices.'.format(answer_id),
                    },None,None,None]

        # Now check if the user is new, and create persona and partner
        # records, sicne we have enough info.
        form_user_type = DBSession.query(FormCopy).filter(FormCopy.id==form_id).one().form_user_type
        create_persona_partner(user_id,answer_id,FORM_USER_TYPE_MAP,
            form_user_type)

        # Answer is an ID from an external table in this case. Swap them.
        # In this rare case, we have some additional data: 'school'
        return [None,json.dumps(user_response),None,answer_id]

    if question.question_type == QUESTION_DATETIME:
        if 'month' not in user_response or user_response['month'] in ('',None):
            return [{'success': False, 'error':'missing month field.'},
                None,None,None]
        if user_response['month'] < 1 or user_response['month'] > 12:
            return [{'success': False, 'error':'month field is invalid.'},
                None,None,None]

        if 'day' not in user_response or user_response['day'] in ('',None):
            return [{'success': False, 'error':'missing day field.'},
                None,None,None]
        if user_response['day'] < 1 or user_response['day'] > 31:
            return [{'success': False, 'error':'day field is invalid.'},
                None,None,None]

        if 'year' not in user_response or user_response['year'] in ('',None):
            return [{'success': False, 'error':'missing year field.'},
                None,None,None]
        if user_response['year'] < 1900 or user_response['year'] > 3000:
            return [{'success': False, 'error':'year field is invalid.'},
                None,None,None]

        return [None,json.dumps(user_response),None,None]

    if question.question_type == QUESTION_CAREER_OCCUPATION:
        # Missing validation: check if ids exist.
        if 'career_id' not in user_response or user_response['career_id'] in ('',None):
            return [{'success': False, 'error':'missing career_id field.'},
                None,None,None]
        # Missing validation: check if ids exist.
        if 'occupations' not in user_response or user_response['occupations'] in ('',None,[]):
            return [{'success': False, 'error':'missing/empty occupations list.'},
                None,None,None]

        if not DBSession.query(UtilsCareer).filter(
            UtilsCareer.id == user_response['career_id']).first():
            return [{'success': False, 'error':'career id does not match any known entry.'},
                None,None,None]

        for occ in user_response['occupations']:
            if not DBSession.query(UtilsOccupation).filter(
                UtilsOccupation.id == occ).first():
                return [{'success': False, 'error':'One or more occupations do not match any known entry.'},
                None,None,None]

        return [None,json.dumps(user_response),None,None]

    if question.question_type == QUESTION_CAREERS_ONLY:
        # Missing validation: check if ids exist.
        if 'career_ids' not in user_response or user_response['career_ids'] in ('',None):
            return [{'success': False, 'error':'missing career_ids field.'},
                None,None,None]

            for cid in user_response['career_ids']:
                if not DBSession.query(UtilsCareer).filter(
                    UtilsCareer.id == cid).first():
                    return [{'success': False, 'error':'One or more occupations do not match any known entry.'},
                    None,None,None]
        return [None,json.dumps(user_response),None,None]

    raise UnrecognizedQuestionTypeException("Unrecognized question type {0}".format(
        question.question_type)) 

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def toggle_user_question_visbility(local_db_session,
    form_id, question, user_response):
    '''
    Find questions dependent on this question id: answer and noanswer dependencies.
    '''
    dependent_qs = DBSession.query(QuestionCopy).filter(
        QuestionCopy.dependent_on_question_id==question.id).filter(
        QuestionCopy.is_active == True).order_by(QuestionCopy.ordinal,QuestionCopy.sub_ordinal
        ).all()

    '''
    We're not using this right now
    dependent_noanswer_qs = DBSession.query(QuestionCopy).filter(
        QuestionCopy.dependent_on_noanswer_question_id==question.id
        ).order_by(QuestionCopy.ordinal,QuestionCopy.sub_ordinal).all()
    '''

    for d in dependent_qs:
        #print "TOGGLE: dep question: %s, question: %s" % (d.id,question.id)

        # Loop through all answers. If OR used, at least one answer match makes 
        # the dependent question visible.
        # If AND, at least one non-match makes it not visible.
        for dependent_a in DBSession.query(AnswerDependencyCopy).filter(
            # question_id is the id of the dependent question, not the current question.
            # It's dependent on the answer of the current question.
            AnswerDependencyCopy.question_id==d.id).all():

            #print "TOGGLE: Debugging hide/show toggle. (1) Dependent Question:{0}, (2) User's Answer:{1}, (3) Dependent Answer:{2}".format(
            #    pprint.pformat(d.__dict__),pprint.pformat(user_response),
            #    pprint.pformat(dependent_a.__dict__))

            if dependent_a.dependent_on_answer_id_for_question_id and \
                user_response.answer_id not in (0,None) and \
                user_response.answer_id == dependent_a.dependent_on_answer_id_for_question_id:

                local_db_session.query(QuestionCopy).filter(
                    QuestionCopy.id==d.id).update({'is_visible':True})
                local_db_session.commit()
                local_db_session.begin()

                if dependent_a.and_or == 'OR':
                    break 

            elif dependent_a.dependent_on_answer_value_for_question_id and \
                user_response.user_response == \
                dependent_a.dependent_on_answer_value_for_question_id:

                local_db_session.query(QuestionCopy).filter(
                    QuestionCopy.id==d.id).update({'is_visible':True})
                local_db_session.commit()
                local_db_session.begin()

                if dependent_a.and_or == 'OR':
                    break 

            else:
                local_db_session.query(QuestionCopy).filter(
                    QuestionCopy.id==d.id).update({'is_visible':False})
                local_db_session.commit()
                local_db_session.begin()

                if dependent_a.and_or == 'AND':
                    break 

    '''
    Not using this right now. If it becomes useful, this loop must be rewritten.
    Is visible if question was not answered. Toggle is_visible off, since q was answered.
    for d in dependent_noanswer_qs:
        if d.is_visible == True:
            local_db_session.query(QuestionCopy).filter(
                QuestionCopy.id==d.id).update({'is_visible':False})
    local_db_session.commit()
    local_db_session.begin()
    '''

    section_ids = [x.id for x in local_db_session.query(SectionCopy).filter(
        SectionCopy.form_id==form_id).order_by(SectionCopy.ordinal).all()]

    not_visible = local_db_session.query(QuestionCopy).filter(
        QuestionCopy.section_id.in_(section_ids)).filter(
        and_(QuestionCopy.is_visible==False,QuestionCopy.is_active==True)
        ).order_by(QuestionCopy.ordinal,QuestionCopy.sub_ordinal).all()

    #print "TOGGLE: returning %s" % pprint.pformat([x.id for x in not_visible])

    hide_list = [x.id for x in not_visible]
    local_db_session.commit()
    local_db_session.begin()

    return hide_list

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# User Response Handling
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
class WrongDataException(Exception):
    pass


class ResponseServices(object):

    def unravel_user_response(self,response,question_id):
        question = DBSession.query(QuestionCopy).filter(
            QuestionCopy.id==question_id).first()

        if question.question_type in (QUESTION_ADDRESS, 
            QUESTION_MULTI_SELECT, QUESTION_DROPDOWN_SCHOOLS, QUESTION_DATETIME, 
            QUESTION_CAREER_OCCUPATION, QUESTION_CAREERS_ONLY, 
            QUESTION_DROPDOWN_COLLEGES,QUESTION_RACIAL_GROUP,
            QUESTION_ACADEMIC_FIELD,QUESTION_PARTNER_PROGRAM,
            QUESTION_MULTI_SELECT_NOPREF_TOGGLE):
            try:
                response['user_response'] = json.loads(response['user_response'])
            except TypeError:
                raise WrongDataException("User response id {0} is supposed to be a json string, but is not: {1}. Unravel failed, crashing!".format(
                    response['id'],response['user_response']))

            return response

        return response

    def answer_lookup(self,user_id,question_id,return_struct=False):

        question = DBSession.query(QuestionCopy).filter(
            QuestionCopy.id==question_id).filter(
            #QuestionCopy.is_active==True).filter(
            QuestionCopy.user_id==user_id).first()

        if not question:
            if return_struct:
                return [],{},[]
            return []

        user_response = DBSession.query(UserResponse).filter(
            UserResponse.question_id==question_id).filter(
            UserResponse.user_id==user_id).first()

        if not user_response:
            if return_struct:
                return [],{},[]
            return []

        # Detach from session so local changes can happen
        # without pushing changes to the DB.
        DBSession.expunge(user_response)

        if question.question_type in (
            QUESTION_FREEFORM_TEXT, QUESTION_FREEFORM_CHAR, 
            QUESTION_HEADING,QUESTION_INSTRUCTIONS,
            QUESTION_PHONE):
            if return_struct:
                return [user_response.user_response],user_response,[]
            return [user_response.user_response]

        if question.question_type == QUESTION_ADDRESS:
            try:
                user_response.user_response = json.loads(user_response.user_response)
            except TypeError:
                raise WrongDataException("User response id {0} is supposed to be a json string of multi-select address values, but is not: {1}. Crashing!".format(
                    user_response.id,user_response.user_response))

            state_abbr = DBSession.query(UtilsState).filter(
                UtilsState.id==user_response.user_response['state_id']).first().abbr

            if return_struct:
                return [user_response.user_response['address'],
                user_response.user_response['city'],state_abbr,
                user_response.user_response['zipcode'] ], user_response, []

            return [user_response.user_response['address'],
            user_response.user_response['city'],state_abbr,
            user_response.user_response['zipcode'] ]

        if question.question_type in (QUESTION_SINGLE_SELECT_TOGGLE, 
            QUESTION_SINGLE_SELECT_RADIO, QUESTION_DROPDOWN):
            answer_match = DBSession.query(AnswerCopy).filter(and_(
                AnswerCopy.question_id == question.id,
                #AnswerCopy.is_active == True,
                AnswerCopy.id == user_response.answer_id
                )).first()
            if not answer_match:
                raise WrongDataException("Missing answer record, or incorrect answer id for question id {0}, answer id: {1}, user_response: {2}".format(
                    question.id,user_response.answer_id,
                    pprint.pformat(user_response.__dict__)))

            if return_struct:
                return [answer_match.answer_text],user_response,[answer_match]
            return [answer_match.answer_text]

        if question.question_type == QUESTION_MULTI_SELECT_NOPREF_TOGGLE:
            outbound = []
            answers = []
            try:
                user_response.user_response = json.loads(user_response.user_response)
            except TypeError:
                raise WrongDataException("User response id {0} is supposed to be a json string of multi-select values, but is not: {1}. Crashing!".format(
                    user_response.id,user_response.user_response))

            for a_id in user_response.user_response['answer_ids']:
                answer = DBSession.query(AnswerCopy).filter(and_(
                    AnswerCopy.question_id == question.id,
                    #AnswerCopy.is_active == True,
                    AnswerCopy.id == a_id
                    )).first()
                outbound.append(answer.answer_text)
                answers.append(answer)
            if return_struct:
                return outbound,user_response,answers
            return outbound

        if question.question_type == QUESTION_MULTI_SELECT:
            outbound = []
            answers = []
            try:
                user_response.user_response = json.loads(user_response.user_response)
            except TypeError:
                raise WrongDataException("User response id {0} is supposed to be a json string of multi-select values, but is not: {1}. Crashing!".format(
                    user_response.id,user_response.user_response))

            for a_id in user_response.user_response['answer_ids']:
                answer = DBSession.query(AnswerCopy).filter(and_(
                    AnswerCopy.question_id == question.id,
                    #AnswerCopy.is_active == True,
                    AnswerCopy.id == a_id
                    )).first()
                outbound.append(answer.answer_text)
                answers.append(answer)
            if return_struct:
                return outbound,user_response,answers
            return outbound

        if question.question_type == QUESTION_PARTNER_PROGRAM:
            outbound = []
            mprograms = []
            try:
                user_response.user_response = json.loads(user_response.user_response)
            except TypeError:
                raise WrongDataException("User response id {0} is supposed to be a json string of multi-select mprogram values, but is not: {1}. Crashing!".format(
                    user_response.id,user_response.user_response))

            for program_id in user_response.user_response['mprograms']:
                mprogram = DBSession.query(MemberUserprogram).filter(
                    MemberUserprogram.id == program_id
                    ).first()
                outbound.append(mprogram.name)
                mprograms.append(mprogram)
            if return_struct:
                return outbound,user_response,mprograms
            return outbound

        if question.question_type == QUESTION_RACIAL_GROUP:
            outbound = []
            rgroups = []
            try:
                user_response.user_response = json.loads(user_response.user_response)
            except TypeError:
                raise WrongDataException("User response id {0} is supposed to be a json string of multi-select rgroup values, but is not: {1}. Crashing!".format(
                    user_response.id,user_response.user_response))

            for group_id in user_response.user_response['rgroups']:
                rgroup = DBSession.query(IuserRacialgroup).filter(
                    IuserRacialgroup.id == group_id
                    ).first()
                outbound.append(rgroup.group)
                rgroups.append(rgroup)
            if return_struct:
                return outbound,user_response,rgroups
            return outbound

        if question.question_type == QUESTION_ACADEMIC_FIELD:
            outbound = []
            afields = []
            try:
                user_response.user_response = json.loads(user_response.user_response)
            except TypeError:
                raise WrongDataException("User response id {0} is supposed to be a json string of multi-select afield values, but is not: {1}. Crashing!".format(
                    user_response.id,user_response.user_response))

            for afield_id in user_response.user_response['afields']:
                afield = DBSession.query(IuserAcademicfield).filter(
                    IuserAcademicfield.id == afield_id
                    ).first()
                outbound.append(afield.name)
                afields.append(afield)
            if return_struct:
                return outbound,user_response,afields
            return outbound

        if question.question_type == QUESTION_DROPDOWN_COUNTRIES:
            country = DBSession.query(UtilsCountry).filter(
                UtilsCountry.id == user_response.selected_id
                ).first()
            if return_struct:
                return [country.name],user_response,[country]
            return [country.name]

        if question.question_type == QUESTION_DROPDOWN_STATES:
            state = DBSession.query(UtilsState).filter(
                UtilsState.id == user_response.selected_id
                ).first()
            if return_struct:
                return [state.abbr],user_response,[state]
            return [state.abbr]

        if question.question_type in (QUESTION_DROPDOWN_EMPLOYERS,
            QUESTION_DROPDOWN_EMPLOYERS_TYPE2):
            # User could either select, or type a new one.
            if user_response.selected_id:
                employer = DBSession.query(IuserEmployer).filter(
                    IuserEmployer.id == user_response.selected_id
                    ).first()
                if return_struct:
                    return [employer.name],user_response,[employer]
                return [employer.name]
            else:
                if return_struct:
                    return [user_response.user_response],user_response,[]
                return [user_response.user_response]

        if question.question_type == QUESTION_DROPDOWN_COLLEGES:
            outbound = []
            colleges = []
            #'colleges': {'id':x,'name':yyyyy}

            try:
                user_response.user_response = json.loads(user_response.user_response)
            except TypeError:
                raise WrongDataException("User response id {0} is supposed to be a json string of multi-select college values, but is not: {1}. Crashing!".format(
                    user_response.id,user_response.user_response))

            for college in user_response.user_response['colleges']:
                if college['id'] == 0:
                    outbound.append('Not Listed')
                    break

                college = DBSession.query(UtilsCollege).filter(
                    UtilsCollege.id == college['id']
                    ).first()
                outbound.append(college.name)
                colleges.append(college)

            if return_struct:
                return outbound,user_response,colleges
            return outbound

        if question.question_type == QUESTION_DROPDOWN_SCHOOLS:
            # School is really partner program
            school = DBSession.query(PartnersPartner).filter(
                PartnersPartner.id == user_response.selected_id
                ).first()

            if not school:
                raise WrongDataException("User response id {0} is supposed to have a partner id selected as a school program, but does not: {1}. Crashing!".format(
                    user_response.id,user_response.user_response))
    
            if return_struct:
                return [school.name],user_response,[school]
            return [school.name]

        if question.question_type == QUESTION_DATETIME:
            try:
                user_response.user_response = json.loads(user_response.user_response)
            except TypeError:
                raise WrongDataException("User response id {0} is supposed to be a json string of multi-select datetime values, but is not: {1}. Crashing!".format(
                    user_response.id,user_response.user_response))

            if return_struct:
                return ["%s/%s/%s" % (user_response.user_response['month'],
                    user_response.user_response['day'],
                    user_response.user_response['year'])],user_response,[]
            return ["%s/%s/%s" % (user_response.user_response['month'],
                user_response.user_response['day'],user_response.user_response['year'])]

        if question.question_type == QUESTION_CAREER_OCCUPATION:
            try:
                user_response.user_response = json.loads(user_response.user_response)
            except TypeError:
                raise WrongDataException("User response id {0} is supposed to be a json string of multi-select career/occ values, but is not: {1}. Crashing!".format(
                    user_response.id,user_response.user_response))

            career = DBSession.query(UtilsCareer).filter(
                UtilsCareer.id == user_response.user_response['career_id']).first()
            occlist = []
            occupations = []
            for occ in user_response.user_response['occupations']:
                occupation = DBSession.query(UtilsOccupation).filter(
                    UtilsOccupation.id == occ).first()
                occlist.append(occupation.name)
                occupations.append(occupation)
            if return_struct:
                return [career.name] + occlist,user_response,occupations
            return [career.name] + occlist

        if question.question_type == QUESTION_CAREERS_ONLY:
            clist = []
            careers = []
            try:
                user_response.user_response = json.loads(user_response.user_response)
            except TypeError:
                raise WrongDataException("User response id {0} is supposed to be a json string of multi-select career values, but is not: {1}. Crashing!".format(
                    user_response.id,user_response.user_response))

            for cid in user_response.user_response['career_ids']:
                career = DBSession.query(UtilsCareer).filter(
                    UtilsCareer.id == cid).first()
                clist.append(career.name)
                careers.append(career)
            if return_struct:
                return clist,user_response,careers
            return clist

        raise UnrecognizedQuestionTypeException("Unrecognized question type {0}".format(
            question.question_type)) 

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# User Response Retrieval and Validation
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

class UserRetrievalServices(object):

    response_services = ResponseServices()

    def _get_form(self, form_id, user_id, stringify_datetimes = True):
        try:
            form = DBSession.query(FormCopy).filter(FormCopy.id==form_id
                ).filter(FormCopy.user_id==user_id).one().__dict__
            '''
            Stringify by default for outbound messages.
            '''
            if stringify_datetimes:
                form['form_was_completed_datetime'] = str(form['form_was_completed_datetime'])\
                    if form['form_was_completed_datetime'] else None

                form['last_touched_datetime'] = str(form['last_touched_datetime'])\
                    if form['last_touched_datetime'] else None

                form['started_datetime'] = str(form['started_datetime'])\
                    if form['started_datetime'] else None

        except NoResultFound, e:
            return None

        del form['_sa_instance_state']
        return form

    def _get_all_sections_for_form(self, form_id, section_id):
        sections_list = []
        if section_id and form_id:
            section_query = DBSession.query(SectionCopy).filter(and_(
              SectionCopy.id==section_id, SectionCopy.form_id==form_id
              )).order_by(SectionCopy.ordinal).all()
        elif form_id:
            section_query = DBSession.query(SectionCopy).filter(
                SectionCopy.form_id==form_id).order_by(
                SectionCopy.ordinal).all()

        for section in section_query:
            section = section.__dict__
            del section['_sa_instance_state']
            sections_list.append(section)
        return sections_list

    def _get_all_questions_for_section(self, section_id, question_id):
        questions_list = []
        if question_id and section_id:
            question_query = DBSession.query(QuestionCopy).filter(and_(
                QuestionCopy.id==question_id,
                QuestionCopy.is_active==True,
                QuestionCopy.section_id==section_id
                )).order_by(QuestionCopy.ordinal,QuestionCopy.sub_ordinal).all()

        elif section_id:
            question_query = DBSession.query(QuestionCopy).filter(and_(
                QuestionCopy.is_active==True,
                QuestionCopy.section_id==section_id
                )).order_by(QuestionCopy.ordinal,QuestionCopy.sub_ordinal).all()

        # questions is a list of questions query objs
        else:
            return {}

        for question in question_query:
            question = question.__dict__
            del question['_sa_instance_state']
            questions_list.append(question)
        return questions_list

    def _get_all_answers_for_question(self, question_id, answer_id):
        answers_list = []
        if answer_id and question_id:
            answer_query = DBSession.query(AnswerCopy).filter(and_( 
                AnswerCopy.id==answer_id, 
                AnswerCopy.is_active == True,
                AnswerCopy.question_id==question_id
                )).order_by(AnswerCopy.ordinal).all()
        elif question_id:
            answer_query = DBSession.query(AnswerCopy).filter(and_(
                AnswerCopy.is_active == True,
                AnswerCopy.question_id==question_id
                )).order_by(AnswerCopy.ordinal).all()
        for answer in answer_query:
            answer = answer.__dict__
            del answer['_sa_instance_state']
            if answer['answer_datetime']:
                answer['answer_datetime'] = str(answer['answer_datetime'])
            answers_list.append(answer)
        return answers_list

    def _get_user_response_for_question(self, question_id, user_id):
        user_response =  DBSession.query(UserResponse).filter(
            and_(
                UserResponse.question_id == question_id,
                UserResponse.user_id == user_id
                )
            ).first()
        if user_response:
            # Detach from session so local changes can happen
            # without pushing changes to the DB.
            DBSession.expunge(user_response)
            response = user_response.__dict__
            del response['_sa_instance_state']
            return self.response_services.unravel_user_response(
                response,question_id)

        return {}

    def _assemble_nested_dict(self, user_id, nested_dict, form_id, section_id=None, \
        question_id=None, answer_id=None):
        nested_dict['form']['sections'] = self._get_all_sections_for_form(form_id, section_id)
        if not nested_dict['form']['sections']:
            abort(404)

        for section in nested_dict['form']['sections']:  # get question
            if section_id == None:
                section['questions'] = self._get_all_questions_for_section(
                    section_id=section['id'], question_id=None)
            else:
                section['questions'] = self._get_all_questions_for_section(section_id, question_id)

        for section in nested_dict['form']['sections']:
            for question in section['questions']:
                if question_id == None:
                    question['answers'] = self._get_all_answers_for_question(
                        question_id=question['id'],
                        answer_id=None)
                else:
                    question['answers'] = self._get_all_answers_for_question(
                        question_id,
                        answer_id)

                question['user_response'] = self._get_user_response_for_question(question['id'],user_id)

        return nested_dict


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def check_form_authz(current_user,user_id,form_id,replace_user=True):
    form_copy = DBSession.query(FormCopy).filter(FormCopy.id==form_id).one()

    if user_id:
        on_behalf_of_user = DBSession.query(IuserUser).filter(IuserUser.id==user_id).one()

        if form_copy.user_id != user_id:
            app.logger.warning("User {0} tried to get to form {1} on behalf of user {2}, but the form doesn't belong to user {2}, Kicking them out.".format(
               current_user.email,form_id,on_behalf_of_user.id
               ))
            return None,None

        current_user_info = Role(user_id=current_user.id)
        if not current_user_info.is_some_admin_for_site_id(on_behalf_of_user.member_id):
            app.logger.warning("User {0} tried to get to form {1} but they either aren't an admin, or don't belong to site id {2}. Kicking them out.".format(
               current_user.email,form_id,on_behalf_of_user.member_id
               ))
            return None,None

        # If they passed the test, make the "on behalf of" user the current user.
        if replace_user:
            current_user = on_behalf_of_user

    elif form_copy.user_id != current_user.id:
        app.logger.warning("User {0} tried to get to their own form {1} but this isn't their form. Kicking them out.".format(
           current_user.email,form_id
           ))
        return None,None
 
    return current_user,form_copy

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def check_all_required_fields(form,user):
    sections = DBSession.query(SectionCopy).filter(
        SectionCopy.user_id==user.id).filter(
        SectionCopy.form_id==form.id).order_by('ordinal').all()
    section_ids = [x.id for x in sections]
    #for x in sections:
    #    print "Section:{0}{1}".format(x.id,x.description)

    questions = DBSession.query(QuestionCopy).filter(
        QuestionCopy.section_id.in_(section_ids)).filter(
        QuestionCopy.question_type.notin_((QUESTION_HEADING,
            QUESTION_INSTRUCTIONS))).order_by('ordinal','sub_ordinal').all()

    question_ids = [x.id for x in questions if x.is_active and x.is_required and x.is_visible]
    #for x in questions:
    #    print "Question:{0}{1}".format(x.id,x.question_text)

    user_responses = DBSession.query(UserResponse).filter(
        UserResponse.question_id.in_(question_ids)).filter(
        UserResponse.user_id==user.id).all()
    user_response_qids = [x.question_id for x in user_responses]

    diff = set(question_ids).difference(user_response_qids)
    if diff:
        missing_answers = [q for q in questions if q.id in diff]
        app.logger.exception("User {0} id {1} completed their form, but they may be missing answers. These questions were required and visible, but are missing answers: {2}".format(
            user.email,user.id,pprint.pformat([(x.id,x.question_text) for x in missing_answers])))

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Get on behalf of another user, if permissions allow.
def get_obo_application_form(current_user,user_id):
    if check_authz(current_user,user_id,replace_user=False):
        form = DBSession.query(FormCopy).filter(
            FormCopy.user_id==user_id).filter(
            FormCopy.form_data_type==APPLICATION).first()
        return form
    return None

def get_related_answer(user,search_text):
    q = DBSession.query(QuestionCopy).filter(
        QuestionCopy.user_id==user.id).filter(
        QuestionCopy.question_text.ilike('%{0}%'.format(search_text))).first()

    if q and q.section.form.form_data_type == APPLICATION:
       a = ResponseServices().answer_lookup(user.id,q.id)
       return q.id, q.question_text, a

    return None,None

def get_all_match_qas_for_legacy(user,skip_qids=None):

    class LegacyResp(object):
        def __init__(self,qtext,atexts):
            self.text_smarttag = qtext
            self.answer = atexts

    outbound = []

    rs = ResponseServices()
    form = DBSession.query(FormCopy).filter(
        FormCopy.form_data_type==APPLICATION).filter( 
        FormCopy.user_id==user.id).first()

    if form:
        sections = DBSession.query(SectionCopy).filter(
            SectionCopy.user_id==user.id).filter(
            SectionCopy.form_id==form.id).order_by('ordinal').all()
        use_section = sections[2] # matching section.

        for q in DBSession.query(QuestionCopy).filter(
            QuestionCopy.section_id==use_section.id).filter(
            QuestionCopy.question_type.notin_((QUESTION_HEADING,
                QUESTION_INSTRUCTIONS))).filter(
            QuestionCopy.user_id==user.id).order_by('ordinal','sub_ordinal').all():

            if skip_qids and q.id in skip_qids:
                continue

            outbound.append( LegacyResp( q.question_text,
                rs.answer_lookup(user.id,q.id) ) )

    return outbound
