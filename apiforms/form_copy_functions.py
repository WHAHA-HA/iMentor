# -*- coding: iso8859-15 -*-
import pdb
import os,sys
import pprint
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import (Base,metadata,
    DBSession,get_scoped_session)


from sqlalchemy import (BigInteger, Boolean, Column, Date, DateTime,
    Float, ForeignKey, Index, Integer, Numeric, SmallInteger,
    String, Table, Text, Time, text, DATE, func)
from sqlalchemy.dialects.postgresql.base import INET, TSVECTOR
from sqlalchemy.sql.expression import func, or_, not_, and_
from sqlalchemy.orm import relationship
from legacy_models.iuser import (IuserUser,MemberMember,
    IuserAssignedusertype,IuserUsertype)
from new_platform.utils import user_details

from apiforms.models import *
from new_platform.utils.roles import Role

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# Functions to copy Master Q & A records to Copy.
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
class UserNotMemberException(Exception):
    pass

class UserCantAnswerException(Exception):
    pass


def copy_question_for_user(local_db_session, question_id, user_id, 
    persona_id, member_site_id, new_section_id, new_q_copies):
    '''
    Make sure the user belongs to one of the member sites that should see
    this question.
    '''
    orig = DBSession.query(Question).filter(Question.id == question_id).one().__dict__
    orig['parent_id'] = orig['id']
    #print "Copying orig question %d" % orig['id']
    del orig['id']
    del orig['_sa_instance_state']
    del orig['copied_from_id']
    orig['user_id'] = user_id
    orig['persona_id'] = persona_id
    orig['section_id'] = new_section_id

    if orig['dependent_on_question_id']:
        '''
        Find the copy we are dependent on, not the original.
        Be sure questions are copied in ID order, so dependencies exist ahead of time.
        Look for question copy that belongs to this user, whose parent ID is this one.

        Note: Don't look in DB, since duplicates are allowed. Look in new list.
        There should only be one question copy for a parent question in each form.
        '''
        orig['dependent_on_question_id'] = new_q_copies[ orig['dependent_on_question_id'] ].id

    elif orig['dependent_on_noanswer_question_id']:
        '''
        Same here:
        '''
        orig['dependent_on_noanswer_question_id'] = new_q_copies[ orig['dependent_on_noanswer_question_id'] ].id


    '''
    Member site id is a bit redundant, since it should match the user's member site id.
    It saves us a lookup if we store it here. 
    Users can have more than one persona, although we often default to the most recent one.
    '''
    orig['member_site_id'] = member_site_id
    new_obj = QuestionCopy(**orig)
    local_db_session.add(new_obj)
    local_db_session.commit()
    local_db_session.begin()

    #print "Saving new question id %d, parent id: %s" % (new_obj.id,new_obj.parent_id)
    new_q_copies[new_obj.parent_id] = new_obj

    return new_obj.id


def copy_answer_dependencies(local_db_session, user_id, question_id, 
    new_question_id, new_a_copies):

    for r in DBSession.query(AnswerDependency).filter(AnswerDependency.question_id == question_id
        ).order_by(AnswerDependency.id).all():

        record = r.__dict__
        record['parent_id'] = record['id']
        del record['id']
        del record['_sa_instance_state']
        record['question_id'] = new_question_id

        '''
        1: Take the dependent_on_answer_id_for_question_id field. 
        2: Search for an answer in new answer copies we've already created 
           (not the DB, due to dups being allowed).
        3: Use this answer copy id to fill this dependent_on_answer_id_for_question_id value.
        '''
        record['dependent_on_answer_id_for_question_id'] = new_a_copies[ record['dependent_on_answer_id_for_question_id'] ].id

        newac = AnswerDependencyCopy(**record)
        local_db_session.add(newac)

    local_db_session.commit()
    local_db_session.begin()


def copy_answer_for_user(local_db_session, answer_id, user_id, 
    persona_id, member_site_id, new_question_id, new_a_copies):

    orig = DBSession.query(Answer).filter(Answer.id == answer_id).one().__dict__
    orig['parent_id'] = orig['id']
    del orig['id']
    del orig['_sa_instance_state']
    del orig['copied_from_id']
    orig['user_id'] = user_id
    orig['persona_id'] = persona_id
    orig['question_id'] = new_question_id
    '''
    Member site id is a bit redundant, since it should match the user's member site id.
    It saves us a lookup if we store it here. 
    Users can have more than one persona, although we often default to the most recent one.
    '''
    orig['member_site_id'] = member_site_id
    new_obj = AnswerCopy(**orig)
    local_db_session.add(new_obj)
    local_db_session.commit()
    local_db_session.begin()
    
    #print "Saving new answer id %d, parent id: %d" % (new_obj.id,new_obj.parent_id)
    new_a_copies[ new_obj.parent_id ] = new_obj
    return new_obj.id


def copy_section_for_user(local_db_session, section_id, user_id, 
    persona_id, member_site_id, new_form_id):

    orig = DBSession.query(Section).filter(Section.id == section_id).one().__dict__
    orig['parent_id'] = orig['id']
    del orig['id']
    del orig['_sa_instance_state']
    del orig['copied_from_id']
    orig['form_id'] = new_form_id
    orig['user_id'] = user_id
    orig['persona_id'] = persona_id
    '''
    Member site id is a bit redundant, since it should match the user's member site id.
    It saves us a lookup if we store it here. 
    Users can have more than one persona, although we often default to the most recent one.
    '''
    orig['member_site_id'] = member_site_id
    new_obj = SectionCopy(**orig)
    local_db_session.add(new_obj)
    
    local_db_session.commit()
    local_db_session.begin()
    return new_obj.id


def copy_form_for_user(local_db_session,
    form_id, user_id, persona_id, member_site_id,
    role = None):
    '''
    Make sure the user belongs to one of the member sites that should see
    this form.
    '''
    # Member could also come from user.member_id, but we need this for other info.
    user_info = DBSession.query(IuserUser).filter(IuserUser.id == user_id).one()

    if not role:
        role = Role(user_id)

    if not DBSession.query(FormMemberSite).filter(
        FormMemberSite.form_id == form_id).filter(
        FormMemberSite.member_site_id == user_info.member_id).first():
        raise UserNotMemberException("User {0} \n not in the member site list of {1} \n for form {2}, \n not copying.".format(
            pprint.pformat([x.__dict__ for x in user_info]),
            pprint.pformat([x.__dict__ for x in DBSession.query(FormMemberSite).filter(
                FormMemberSite.form_id == form_id).all()]),
            pprint.pformat(DBSession.query(Form).filter(Form.id == form_id).one().__dict__)
            )
        )

    '''
    Make sure user has a role matching someone who can see this form.
    '''
    if not DBSession.query(FormRoleCanAnswer).filter(
        FormRoleCanAnswer.role_id_can_answer == role.role).filter(
        FormRoleCanAnswer.form_id == form_id).first():

        raise UserCantAnswerException("User {0} \n not in the 'can answer' role list of {1} \n for form {2}, \n not copying.".format(
            pprint.pformat([x.__dict__ for x in user_info]),
            pprint.pformat([x.__dict__ for x in DBSession.query(FormRoleCanAnswer).filter(
                FormRoleCanAnswer.form_id == form_id).all()]),
            pprint.pformat(DBSession.query(Form).filter(Form.id == form_id).one().__dict__)
            )
        )


    orig = DBSession.query(Form).filter(Form.id == form_id).one().__dict__
    orig['parent_id'] = orig['id']
    del orig['id']
    del orig['_sa_instance_state']
    del orig['copied_from_id']
    orig['user_id'] = user_id
    orig['persona_id'] = persona_id
    '''
    Member site id is a bit redundant, since it should match the user's member site id.
    It saves us a lookup if we store it here. 
    Users can have more than one persona, although we often default to the most recent one.
    '''
    orig['member_site_id'] = member_site_id
    new_obj = FormCopy(**orig)
    local_db_session.add(new_obj)
    local_db_session.flush()

    for r in DBSession.query(FormRoleCanModify).filter(FormRoleCanModify.form_id == form_id).all():
        record = r.__dict__
        del record['id']
        del record['_sa_instance_state']
        record['form_id'] = new_obj.id
        local_db_session.add(FormRoleCopy(**record))

    local_db_session.commit()
    local_db_session.begin()
    return new_obj.id


def copy_section_cascade(local_db_session, section_id, user_id, 
    persona_id, member_site_id, new_form_id):

    new_section_id = copy_section_for_user(local_db_session, section_id, 
    user_id, persona_id, member_site_id, new_form_id)

    question_copies = {}
    answer_copies = {}
    for r in DBSession.query(Question).filter(Question.section_id == section_id).order_by(Question.id):
        master_question_id = r.id
        new_question_id = copy_question_for_user(local_db_session,
            r.id, user_id, persona_id, member_site_id, new_section_id, question_copies)

        for a in DBSession.query(Answer).filter(Answer.question_id == master_question_id):
            copy_answer_for_user(local_db_session, a.id, user_id, 
            persona_id, member_site_id, new_question_id, answer_copies)
        
        copy_answer_dependencies(local_db_session, user_id, 
            master_question_id, new_question_id, answer_copies)

def copy_form_cascade(form_id, user_id, persona_id, member_site_id, role = None):
    local_db_session = get_scoped_session()

    new_form_id = copy_form_for_user(local_db_session,
        form_id, user_id, persona_id, member_site_id, role)

    for f in DBSession.query(Section).filter(Section.form_id == form_id):
        copy_section_cascade(local_db_session, f.id, user_id, persona_id, 
        member_site_id, new_form_id)

    local_db_session.commit()
