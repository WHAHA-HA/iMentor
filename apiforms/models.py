# -*- coding: iso8859-15 -*-
'''
 forms_form:: 
  forms for member sites: forms_form_member_site, who can edit: forms_form_role
          \
      forms_section:: 
       sections of forms. 
            \ 
        forms_section_question::
         questions in sections. 
              \ 
          forms_section_answer:: 
           potential answers for questions. site & role


 forms_form_copy:: 
  users' form, one user and member site. who can edit: forms_form_role_copy
          \
      forms_section_copy:: 
       users' section, one member site.
            \ 
        forms_section_question_copy :: 
         users' question, one member site.
              \ 
          forms_section_answer_copy :: 
           users' potential answers, one member site. 


 Answers have a foreign key to questions, questions to sections, 
 and sections to forms.

 User responses contain user-provided answers. Answers contain 
 potential answers,if there are any, for the corresponding question.
'''

import pdb
import os,sys
import pprint
from datetime import datetime
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
projdir2 = os.path.abspath(os.path.join(appdir,'../..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)
    sys.path.append(projdir2)

from config.project_globals import db,Base,metadata

from sqlalchemy import (BigInteger, Boolean, Column, Date, DateTime,
    Float, ForeignKey, Index, Integer, Numeric, SmallInteger,
    String, Table, Text, Time, text, DATE, func, UniqueConstraint)
from sqlalchemy.dialects.postgresql.base import INET, TSVECTOR
from sqlalchemy.sql.expression import func, or_, not_, and_
from sqlalchemy.orm import relationship
from legacy_models.iuser import (IuserUser,IuserPersona,
    IuserPersonaPartner,PartnersPartner,MemberMember,
    IuserAssignedusertype,IuserUsertype)

from new_platform.utils.roles import Role

# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
# Constants
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
QUESTION_FREEFORM_TEXT = 1
QUESTION_FREEFORM_CHAR = 2
QUESTION_PHONE = 3
QUESTION_ADDRESS = 4  # Four part question, including state dropdown.
QUESTION_SINGLE_SELECT_TOGGLE = 5 # Boolean: yes/no, t/f
QUESTION_SINGLE_SELECT_RADIO = 6 # One selection out of >= 3
QUESTION_MULTI_SELECT = 7 # Behaves like multi checkboxes but can be any shape/style
QUESTION_DROPDOWN = 8
QUESTION_DROPDOWN_COUNTRIES = 9 # endpoint for country list is /forms_data/countries/
QUESTION_DROPDOWN_STATES = 10 # US states: /forms_data/states/
QUESTION_DROPDOWN_EMPLOYERS = 11  # /forms_data/employers/str/
QUESTION_DROPDOWN_COLLEGES = 12  # /forms_data/colleges/str/
QUESTION_DROPDOWN_SCHOOLS = 13  # /forms_data/schools/, with participating classes nested in each school
QUESTION_DATETIME = 14
QUESTION_HEADING = 15 # Heading stored in question_text, no answers or user response.
QUESTION_INSTRUCTIONS = 16 # Instructions stored in question_text, no answers or user response.
QUESTION_CAREER_OCCUPATION = 17 # Two part question: occupations appear after career selection.
QUESTION_CAREERS_ONLY = 18 # Careers only, multi-select.
QUESTION_RACIAL_GROUP = 19 # Multi-select, /forms_data/rgroup/
QUESTION_ACADEMIC_FIELD = 20 # Multi-select, /forms_data/afield/
QUESTION_PARTNER_PROGRAM = 21 # Multi-select, /forms_data/mprograms/
QUESTION_MULTI_SELECT_NOPREF_TOGGLE = 22 # Multi-select with a "no-preference" toggle. LAST answer is always assumed to be the "no preference" selection.
QUESTION_DROPDOWN_EMPLOYERS_TYPE2 = 23  # Second employer field is required if first is set to "Not Listed"

QUESTON_TYPES = [
    QUESTION_FREEFORM_TEXT,QUESTION_FREEFORM_CHAR,QUESTION_PHONE,
    QUESTION_ADDRESS,QUESTION_SINGLE_SELECT_TOGGLE,QUESTION_SINGLE_SELECT_RADIO,
    QUESTION_MULTI_SELECT,QUESTION_DROPDOWN,QUESTION_DROPDOWN_COUNTRIES, 
    QUESTION_DROPDOWN_STATES, QUESTION_DROPDOWN_EMPLOYERS,
    QUESTION_DROPDOWN_COLLEGES,QUESTION_DROPDOWN_SCHOOLS,
    QUESTION_DATETIME, QUESTION_HEADING, QUESTION_INSTRUCTIONS,
    QUESTION_CAREER_OCCUPATION, QUESTION_CAREERS_ONLY,
    QUESTION_MULTI_SELECT_NOPREF_TOGGLE,
    QUESTION_DROPDOWN_EMPLOYERS_TYPE2
    ]

# These are for form_user_type
MENTOR_FORM = 1
MENTEE_FORM = 2
FORM_USER_TYPES = [
    MENTOR_FORM,MENTEE_FORM
    ]
FORM_USER_TYPE_MAP = {
    MENTOR_FORM:'Mentor',
    MENTEE_FORM:'Mentee',
    }

REVERSE_FORM_USER_TYPE_MAP = {
    'Mentor':MENTOR_FORM,
    'Mentee':MENTEE_FORM,
    }

# These are for form_data_type and section_data_type
APPLICATION = 1

# These are status values for queued forms ready to have notifications
# be sent by the legacy code.
NOTIFY_APPLICATION_COMPLETE = 1

# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
# The following store questions, answers sections and form blocks.
# They do not store responses.
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

class Form(Base, db.Model):
    __tablename__ = 'forms_form'

    id = Column(Integer, primary_key=True, nullable=False)
    is_active = Column(Boolean, nullable=False, default=True)
    form_user_type = Column(Integer, nullable=False, default=0)
    form_data_type = Column(Integer, nullable=False, default=0)
    copied_from_id = Column(Integer, nullable=True, default=0)
    description = Column(Text, nullable=False)


class FormMemberSite(Base, db.Model):
    __tablename__ = 'forms_form_member_site'

    '''
    A many-to-many mapping of forms to member sites.
    '''
    id = Column(Integer, primary_key=True, nullable=False)
    member_site_id = Column(Integer, ForeignKey('member_member.id'), nullable=False, default=0)
    form_id = Column(Integer, ForeignKey('forms_form.id'), nullable=False, default=0)
    form = relationship(Form, foreign_keys=[form_id])


class FormRoleCanModify(Base, db.Model):
    __tablename__ = 'forms_form_role_can_modify'

    '''
    A many-to-many mapping of forms to roles that are allowed to modify it.
    '''
    id = Column(Integer, primary_key=True, nullable=False)
    form_id = Column(Integer, ForeignKey('forms_form.id'), nullable=False, default=0)

    '''
    Only useful if is_immutable = False
    '''
    role_id_can_modify = Column(Integer, ForeignKey('iuser_usertype.id'), nullable=False, default=0)


class FormRoleCanAnswer(Base, db.Model):
    __tablename__ = 'forms_form_role_can_answer'

    '''
    A many-to-many mapping of forms to roles that are allowed to answer it.
    '''
    id = Column(Integer, primary_key=True, nullable=False)
    form_id = Column(Integer, ForeignKey('forms_form.id'), nullable=False, default=0)

    '''
    Which roles can fill out this form: checked during copy.
    '''
    role_id_can_answer = Column(Integer, ForeignKey('iuser_usertype.id'), nullable=False, default=0)


# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

class Section(Base, db.Model):
    __tablename__ = 'forms_section'

    id = Column(Integer, primary_key=True, nullable=False)
    ordinal = Column(Integer, nullable=False, default=0)
    is_active = Column(Boolean, nullable=False, default=True)
    copied_from_id = Column(Integer, nullable=True, default=0)
    description = Column(Text, nullable=False)
    #section_data_type = Column(Integer, nullable=False, default=0)  # for now
    form_id = Column(Integer, ForeignKey('forms_form.id'), nullable=False, default=0) 
    form = relationship(Form, foreign_keys=[form_id])


# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


class Question(Base, db.Model):
    __tablename__ = 'forms_section_question'

    id = Column(Integer, primary_key=True, nullable=False)
    '''
    copied_from_id is for member sites copying master questions
    and customizing them specifically for their site. 
    '''
    copied_from_id = Column(Integer, nullable=True, default=0)
    is_active = Column(Boolean, nullable=False, default=True)
    weighted_val = Column(Integer, nullable=False, default=0) 
    is_required = Column(Boolean, nullable=False, default=False)
    is_visible = Column(Boolean, nullable=False, default=True)
    is_immutable = Column(Boolean, nullable=False, default=False)

    '''
    If dependent_on_question_id is set, we look in answer_dependency for one or more records.
    '''
    dependent_on_question_id = Column(Integer, ForeignKey('forms_section_question.id', deferrable=True, initially=u'DEFERRED'), nullable=True) 
    dependent_on_noanswer_question_id = Column(Integer, ForeignKey('forms_section_question.id', deferrable=True, initially=u'DEFERRED'), nullable=True)

    '''
    Skip to another question: 
    (1) once this is answered, or (2) Once the answer matches some value. 
    Overrides 'dependent' fields above.
    '''
    if_answered_goto_question = Column(Integer, ForeignKey('forms_section_question.id'), nullable=True) 
    answer_matches_goto_question = Column(Text, nullable=True)

    section_id = Column(Integer, ForeignKey('forms_section.id'), nullable=False, default=0) # changed
    section = relationship(Section)

    '''
    ordinal and sub_ordinal work as follows:
    Address question will consist of two question records: freeform text, and dropdown state.
    This could be question ordinal 5 and subordial 1 and 2, so that the front end knows 
    they are connected. Behind the scenes they are two questions.
    '''
    ordinal = Column(Integer, nullable=False, default=0)
    sub_ordinal = Column(Integer, nullable=False, default=0)

    question_type = Column(Integer, nullable=False, default=0) # See QUESTION_TYPES, above.

    question_text = Column(Text, nullable=False, default="NULL")


class AnswerDependency(Base, db.Model):
    __tablename__ = 'forms_answer_dependency'

    id = Column(Integer, primary_key=True, nullable=False)
    '''
    This is the id of the question which is dependent on these answers. 
    We already know the dependent_on_question_id value so don't repeat it here.
    '''
    question_id = Column(Integer, ForeignKey('forms_section_question.id'), nullable=True) 
    and_or = Column(Text, nullable=False, default="OR")
    '''
    Only one of these should be set in each record.
    '''
    dependent_on_answer_id_for_question_id = Column(Integer, ForeignKey('forms_section_answer.id'), nullable=True)
    dependent_on_answer_value_for_question_id = Column(Text, nullable=True)  # Convert based on question type. 

# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

class Answer(Base, db.Model):
    __tablename__ = 'forms_section_answer'

    id = Column(Integer, primary_key=True, nullable=False)
    copied_from_id = Column(Integer, nullable=True, default=0)
    is_active = Column(Boolean, nullable=False, default=True)
    ordinal = Column(Integer, nullable=False, default=0)
    question_id = Column(Integer, ForeignKey('forms_section_question.id'), nullable=False, default=0) 
    question = relationship(Question)
    is_immutable = Column(Boolean, nullable=False, default=False)

    # Only one of the following is set.
    answer_text = Column(Text, nullable=True, default=None)
    answer_char = Column(String(500), nullable=True, default=None) #Acts like VARCHAR, length=max
    answer_bool = Column(Boolean, nullable=True, default=None)
    answer_int = Column(Integer, nullable=True, default=None)
    answer_datetime = Column(DateTime, nullable=True, default=None)

    is_from_query = Column(Boolean, nullable=False, default=False)  # t/f to verify if answer is queried in code


# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#  Copy models appear below. Every user has an independent copy.
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
class FormCopy(Base, db.Model):
    __tablename__ = 'forms_form_copy'

    id = Column(Integer, primary_key=True, nullable=False)
    form_user_type = Column(Integer, nullable=False, default=0)
    form_data_type = Column(Integer, nullable=False, default=0)
    is_active = Column(Boolean, nullable=False, default=True)
    parent_id = Column(Integer, ForeignKey('forms_form.id'), nullable=True, default=None) 
    user_id = Column(Integer, ForeignKey(IuserUser.id), nullable=False, default=0)
    persona_id = Column(Integer, ForeignKey(IuserPersona.id), nullable=False, default=0)
    member_site_id = Column(Integer, ForeignKey('member_member.id'), nullable=False, default=0) 
    description = Column(Text, nullable=False)
    started_datetime = Column(DateTime, nullable=False, default=datetime.now)
    last_touched_datetime = Column(DateTime, nullable=False, default=datetime.now)
    form_was_completed = Column(Boolean, nullable=False, default=False)
    form_was_completed_datetime = Column(DateTime, nullable=True, default=None)


class FormRoleCopy(Base, db.Model):
    __tablename__ = 'forms_form_role_can_modify_copy'

    '''
    A many-to-many mapping of user form to roles that are allowed to modify it.
    '''
    id = Column(Integer, primary_key=True, nullable=False)
    form_id = Column(Integer, ForeignKey('forms_form_copy.id'), nullable=False, default=0) 

    '''
    Only useful if is_immutable = False
    '''
    role_id_can_modify = Column(Integer, ForeignKey('iuser_usertype.id'), nullable=False, default=0) 

# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

class SectionCopy(Base, db.Model):
    __tablename__ = 'forms_section_copy'

    id = Column(Integer, primary_key=True, nullable=False)
    ordinal = Column(Integer, nullable=False, default=0)
    is_active = Column(Boolean, nullable=False, default=True)
    user_id = Column(Integer, ForeignKey(IuserUser.id), nullable=False, default=0)
    persona_id = Column(Integer, ForeignKey(IuserPersona.id), nullable=False, default=0)
    parent_id = Column(Integer, ForeignKey('forms_section.id'), nullable=True, default=None) 
    member_site_id = Column(Integer, ForeignKey('member_member.id'), nullable=False, default=0) 
    #section_data_type = Column(Integer, nullable=False, default=0)  # for now
    form_id = Column(Integer, ForeignKey('forms_form_copy.id'), nullable=False, default=0) 
    form = relationship(FormCopy)
    description = Column(Text, nullable=False)


# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


class QuestionCopy(Base, db.Model):
    __tablename__ = 'forms_section_question_copy'

    id = Column(Integer, primary_key=True, nullable=False)
    is_active = Column(Boolean, nullable=False, default=True)
    user_id = Column(Integer, ForeignKey(IuserUser.id), nullable=False, default=0)
    persona_id = Column(Integer, ForeignKey(IuserPersona.id), nullable=False, default=0)
    parent_id = Column(Integer, ForeignKey('forms_section_question.id'), nullable=True, default=None) 
    member_site_id = Column(Integer, ForeignKey('member_member.id'), nullable=False, default=0) 
    weighted_val = Column(Integer, nullable=False, default=0) 
    is_required = Column(Boolean, nullable=False, default=False)
    is_visible = Column(Boolean, nullable=False, default=True)
    is_immutable = Column(Boolean, nullable=False, default=False)

    '''
    If dependent_on_question_id is set, we look in answer_dependency for one or more records.
    '''
    dependent_on_question_id = Column(Integer, ForeignKey('forms_section_question_copy.id', deferrable=True, initially=u'DEFERRED'), nullable=True) 
    dependent_on_noanswer_question_id = Column(Integer, ForeignKey('forms_section_question_copy.id', deferrable=True, initially=u'DEFERRED'), nullable=True) 

    '''
    Skip to another question: 
    (1) once this is answered, or (2) Once the answer matches some value. 
    Overrides 'dependent' fields above.
    '''
    if_answered_goto_question = Column(Integer, ForeignKey('forms_section_question_copy.id'), nullable=True) 
    answer_matches_goto_question = Column(Text, nullable=True) 

    section_id = Column(Integer, ForeignKey('forms_section_copy.id'), nullable=False, default=0) 
    section = relationship(SectionCopy,foreign_keys=[section_id])

    '''
    ordinal and sub_ordinal work as follows:
    Address question will consist of two question records: freeform text, and dropdown state.
    This could be question ordinal 5 and subordial 1 and 2, so that the front end knows 
    they are connected. Benhind the scenes they are two questions.
    '''
    ordinal = Column(Integer, nullable=False, default=0)
    sub_ordinal = Column(Integer, nullable=False, default=0)

    question_type = Column(Integer, nullable=False, default=0) # See QUESTION_TYPES, above.

    question_text = Column(Text, nullable=False, default="NULL") 


# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


class AnswerCopy(Base, db.Model):
    __tablename__ = 'forms_section_answer_copy'

    '''
    This is a potential answer, something that is available 
    to the user as a potential answer. This is not the users'
    selected answer (user response).
    '''
    id = Column(Integer, primary_key=True, nullable=False)
    is_active = Column(Boolean, nullable=False, default=True)
    ordinal = Column(Integer, nullable=False, default=0)
    question_id = Column(Integer, ForeignKey('forms_section_question_copy.id'), nullable=False, default=0) 
    question = relationship(QuestionCopy,foreign_keys=[question_id])
    is_immutable = Column(Boolean, nullable=False, default=False)
    user_id = Column(Integer, ForeignKey(IuserUser.id), nullable=False, default=0)
    user = relationship(IuserUser,foreign_keys=[user_id])
    persona_id = Column(Integer, ForeignKey(IuserPersona.id), nullable=False, default=0)
    persona = relationship(IuserPersona,foreign_keys=[persona_id])
    parent_id = Column(Integer, ForeignKey('forms_section_answer.id'), nullable=True, default=None) 
    member_site_id = Column(Integer, ForeignKey('member_member.id'), nullable=False, default=0) 

    # Only one of the following is set.
    answer_text = Column(Text, nullable=True, default=None)
    answer_char = Column(String(500), nullable=True, default=None) #Acts like VARCHAR, length=max
    answer_bool = Column(Boolean, nullable=True, default=None)
    answer_int = Column(Integer, nullable=True, default=None)
    answer_datetime = Column(DateTime, nullable=True, default=None)

    is_from_query = Column(Boolean, nullable=False, default=False)  # t/f to verify if answer is queried in code


class AnswerDependencyCopy(Base, db.Model):
    __tablename__ = 'forms_answer_dependency_copy'

    id = Column(Integer, primary_key=True, nullable=False)
    parent_id = Column(Integer, ForeignKey('forms_answer_dependency.id'), nullable=True, default=None) 
    
    '''
    This is the id of the question which is dependent on these answers. 
    We already know the dependent_on_question_id value so don't repeat it here.
    '''
    question_id = Column(Integer, ForeignKey('forms_section_question_copy.id'), nullable=True) 
    and_or = Column(Text, nullable=False, default="OR") 
    '''
    Only one of these should be set in each record.
    '''
    dependent_on_answer_id_for_question_id = Column(Integer, ForeignKey('forms_section_answer_copy.id'), nullable=True)
    dependent_on_answer_value_for_question_id = Column(Text, nullable=True)  # Convert based on question type. 


# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# Response models appear below
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
class UserResponse(Base, db.Model):
    ''' holds the single/multiple choice answer responses for the user. '''
    __tablename__='forms_section_user_response'

    id = Column(Integer, primary_key=True, nullable=False)
    user_id = Column(Integer, ForeignKey(IuserUser.id), nullable=False, default=0)
    question_id = Column(Integer, ForeignKey('forms_section_question_copy.id'), nullable=False, default=0) 
    question = relationship(QuestionCopy,foreign_keys=[question_id])
    answer_id = Column(Integer, ForeignKey('forms_section_answer_copy.id'), nullable=True, default=None)
    answer = relationship(AnswerCopy,foreign_keys=[answer_id])
    # will contain the id of any dropdown from a table other than the answer table.
    selected_id = Column(Integer, nullable=True, default=None)  
    '''
    This is for user's freeform text response, if they did not 
    have potential answers in the answer_id, above. 

    For complex questions such as school/class, career/occupation, this will
    contain the JSON-encoded answers.
    '''
    user_response = Column(Text, nullable=True)
    __table_args__ = (UniqueConstraint('user_id', 'question_id'),)

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# Models for user response parsing and tracking parse status
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# for the id_str_both parse options below.
PARSE_ID = 1
PARSE_STR = 2
PARSE_BOTH = 3

# for the parse status.
NOT_PARSED = 1
COMPLETED = 2
ERROR = 3

# Respone Parse Types:
# Insert into table A if no fields match. Update table B with new/match.
# Match field is empty: Update table A field X with mapped value (int or string): >= 1 table, >= 1 column.

# Respone Parse Rules are intended for reuse.

class UserResponseParseRule(Base, db.Model):
    __tablename__='forms_user_response_parse_rule'

    id = Column(Integer, primary_key=True, nullable=False)
    match_create_table_fields_json = Column(String(1000), nullable=True, default=None)
    update_tables_fields_json = Column(String(1000), nullable=False, default='')
    where_tables_fields_json = Column(String(1000), nullable=False, default='')
    overwrite_values = Column(Boolean, nullable=False, default=True)
    # This may or may not be specific to question type. This is more of a visual aid.
    for_question_type = Column(Integer, nullable=True, default=None)
    optional_name = Column(String(100), nullable=True, default=None)

class UserResponseParseMap(Base, db.Model):
    __tablename__='forms_user_response_parse_map'

    id = Column(Integer, primary_key=True, nullable=False)
    master_question_id = Column(Integer, ForeignKey(Question.id), nullable=False, default=0)
    parse_rule = Column(Integer, ForeignKey(UserResponseParseRule.id), nullable=False, default=0)


# There will be one record per error.
# Upon success, there should only be one record.
class UserResponseParseStatus(Base, db.Model):
    __tablename__='forms_user_response_parse_status'

    id = Column(Integer, primary_key=True, nullable=False)
    form_copy_id = Column(Integer, ForeignKey(FormCopy.id), nullable=False, default=0)
    user_response_id_if_error = Column(Integer, nullable=True, default=None)
    status = Column(Integer, nullable=False, default=0)
    error_str = Column(String(1000), nullable=True, default=None)
    last_parse_datetime = Column(DateTime, nullable=True, default=None)

