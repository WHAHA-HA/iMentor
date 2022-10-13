import os,sys
import re
import pandas as pd
import datetime

appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'../..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import ro_DBSession,DOGPILE_CACHE_REGION
from config.caching_query import CachingQuery,FromCache
from sqlalchemy import (BigInteger, Boolean, Column, Date, DateTime, 
    Float, ForeignKey, Index, Integer, Numeric, SmallInteger, 
    String, Table, Text, Time, text, func, or_)
from sqlalchemy.dialects.postgresql.base import INET, TSVECTOR
from sqlalchemy.orm import relationship
from new_platform.utils import user_details
from apiforms.user_response_utils import ResponseServices
from legacy_models.iuser import (IuserUser, IuserPersona, IuserAssignedusertype,
    IuserUsertype, IuserPersonaPartner)
from legacy_models.partners import PartnersPartner
from legacy_models.member import MemberMember
from pandas import pivot_table
from apiforms.models import (FormCopy, FormMemberSite, QuestionCopy, UserResponse,
    Question, SectionCopy)
from HTMLParser import HTMLParser

rs = ResponseServices()
DATE_FORMAT = '%m/%d/%y'

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def export_intake_application(member_site_id, form_user_type, export_type):

    latest_persona_subq = user_details.get_latest_persona(filtered = False, user_id = None)
    latest_partner_site_subq = user_details.get_latest_partner_site()

    # The following block of notes refers to the database queries for each export type.
    # Not all users will have partner sites at the time of export, eg new mentors, so we use outerjoins there as well.
    # We filter by the member ID of the user, so that we exclude users from other member sites that use clones of the desired form.
    # We also filter by the member ID of the form, so that we export the correct number of answers per question.
    # The join of user ID between FormCopy and IuserUser ensures we export users who enter only their email and password, but answer no questions.
    # The outerjoin of UserResponse ensures we still see a row for the users who enter only their email and password, but answer no questions.

    # The export type of 0 is a reasonable amount of data that ensures exports are fairly quick,
    # but still useful for staff.
    if export_type == '0':
        lookback_date = datetime.datetime.utcnow().date() - datetime.timedelta(days = 90)
        
        results = ro_DBSession.query(
            FormCopy.id.label('form_id'),
            QuestionCopy.id.label('copy_question_id'),
            IuserUser.id.label('user_id'),
            IuserPersona.id.label('persona_id'),
            IuserPersona.match_id.label('match_id'),
            IuserUser.email.label('email'),
            MemberMember.name.label('member_site_name'),
            PartnersPartner.name.label('partner_site_name'),
            IuserUsertype.type.label('user_type'),
            IuserUser.status.label('user_status'),
            IuserPersona.match_status.label('match_status'),
            FormCopy.form_was_completed_datetime.label('completed_date'),
            QuestionCopy.question_text.label('master_question_text'),
            func.row_number().over(partition_by = IuserUser.id, order_by = [Question.section_id, Question.ordinal, Question.sub_ordinal]).label('question_number')).\
            join(FormMemberSite, FormCopy.parent_id == FormMemberSite.form_id).\
            join(SectionCopy, FormCopy.id == SectionCopy.form_id).\
            join(QuestionCopy, SectionCopy.id == QuestionCopy.section_id).\
            outerjoin(UserResponse, QuestionCopy.id == UserResponse.question_id).\
            join(IuserUser, FormCopy.user_id == IuserUser.id).\
            join(MemberMember, IuserUser.member_id == MemberMember.id).\
            join(latest_persona_subq, IuserUser.id == latest_persona_subq.c.user_id).\
            join(IuserPersona, latest_persona_subq.c.latest_persona_id == IuserPersona.id).\
            join(IuserAssignedusertype, IuserPersona.assigned_usertype_id == IuserAssignedusertype.id).\
            join(IuserUsertype, IuserAssignedusertype.usertype_id == IuserUsertype.id).\
            outerjoin(latest_partner_site_subq, IuserPersona.id == latest_partner_site_subq.c.persona_id).\
            outerjoin(PartnersPartner, latest_partner_site_subq.c.latest_partner_id == PartnersPartner.id).\
            join(Question, QuestionCopy.parent_id == Question.id).\
            filter(FormMemberSite.member_site_id == member_site_id).\
            filter(IuserUser.member_id == member_site_id).\
            filter(FormCopy.form_user_type == form_user_type).\
            filter(QuestionCopy.is_active == True).\
            filter(~QuestionCopy.question_type.in_([15, 16])).\
            filter(FormCopy.last_touched_datetime >= lookback_date).\
            order_by(Question.section_id.asc()).\
            order_by(Question.ordinal.asc()).\
            order_by(Question.sub_ordinal.asc()).\
            order_by(FormCopy.last_touched_datetime.asc()).\
            all()
            
    # The export type of 1 is recent data only that ensures exports are very quick,
    # but still relevant to the work of our staff.
    if export_type == '1':
        lookback_date = datetime.datetime.utcnow().date() - datetime.timedelta(days = 10)
        
        results = ro_DBSession.query(
            FormCopy.id.label('form_id'),
            QuestionCopy.id.label('copy_question_id'),
            IuserUser.id.label('user_id'),
            IuserPersona.id.label('persona_id'),
            IuserPersona.match_id.label('match_id'),
            IuserUser.email.label('email'),
            MemberMember.name.label('member_site_name'),
            PartnersPartner.name.label('partner_site_name'),
            IuserUsertype.type.label('user_type'),
            IuserUser.status.label('user_status'),
            IuserPersona.match_status.label('match_status'),
            FormCopy.form_was_completed_datetime.label('completed_date'),
            QuestionCopy.question_text.label('master_question_text'),
            func.row_number().over(partition_by = IuserUser.id, order_by = [Question.section_id, Question.ordinal, Question.sub_ordinal]).label('question_number')).\
            join(FormMemberSite, FormCopy.parent_id == FormMemberSite.form_id).\
            join(SectionCopy, FormCopy.id == SectionCopy.form_id).\
            join(QuestionCopy, SectionCopy.id == QuestionCopy.section_id).\
            outerjoin(UserResponse, QuestionCopy.id == UserResponse.question_id).\
            join(IuserUser, FormCopy.user_id == IuserUser.id).\
            join(MemberMember, IuserUser.member_id == MemberMember.id).\
            join(latest_persona_subq, IuserUser.id == latest_persona_subq.c.user_id).\
            join(IuserPersona, latest_persona_subq.c.latest_persona_id == IuserPersona.id).\
            join(IuserAssignedusertype, IuserPersona.assigned_usertype_id == IuserAssignedusertype.id).\
            join(IuserUsertype, IuserAssignedusertype.usertype_id == IuserUsertype.id).\
            outerjoin(latest_partner_site_subq, IuserPersona.id == latest_partner_site_subq.c.persona_id).\
            outerjoin(PartnersPartner, latest_partner_site_subq.c.latest_partner_id == PartnersPartner.id).\
            join(Question, QuestionCopy.parent_id == Question.id).\
            filter(FormMemberSite.member_site_id == member_site_id).\
            filter(IuserUser.member_id == member_site_id).\
            filter(FormCopy.form_user_type == form_user_type).\
            filter(QuestionCopy.is_active == True).\
            filter(~QuestionCopy.question_type.in_([15, 16])).\
            filter(FormCopy.last_touched_datetime >= lookback_date).\
            order_by(Question.section_id.asc()).\
            order_by(Question.ordinal.asc()).\
            order_by(Question.sub_ordinal.asc()).\
            order_by(FormCopy.last_touched_datetime.asc()).\
            all()

    # The export type of 2 is optimized for Salesforce, which also prefers recent data
    # and a column order based on the time those columns were created in the database.
    # We prefer columns in the order they were created for Salesforce exports,
    # which keeps the column order stable and ensures mapping to Salesforce columns is intact.
    elif export_type == '2':
        lookback_date = datetime.datetime.utcnow().date() - datetime.timedelta(days = 7)

        results = ro_DBSession.query(
            FormCopy.id.label('form_id'),
            QuestionCopy.id.label('copy_question_id'),
            IuserUser.id.label('user_id'),
            IuserPersona.id.label('persona_id'),
            IuserPersona.match_id.label('match_id'),
            IuserUser.email.label('email'),
            MemberMember.name.label('member_site_name'),
            PartnersPartner.name.label('partner_site_name'),
            IuserUsertype.type.label('user_type'),
            IuserUser.status.label('user_status'),
            IuserPersona.match_status.label('match_status'),
            FormCopy.form_was_completed_datetime.label('completed_date'),
            QuestionCopy.question_text.label('master_question_text'),
            QuestionCopy.parent_id.label('question_number')).\
            join(FormMemberSite, FormCopy.parent_id == FormMemberSite.form_id).\
            join(SectionCopy, FormCopy.id == SectionCopy.form_id).\
            join(QuestionCopy, SectionCopy.id == QuestionCopy.section_id).\
            outerjoin(UserResponse, QuestionCopy.id == UserResponse.question_id).\
            join(IuserUser, FormCopy.user_id == IuserUser.id).\
            join(MemberMember, IuserUser.member_id == MemberMember.id).\
            join(latest_persona_subq, IuserUser.id == latest_persona_subq.c.user_id).\
            join(IuserPersona, latest_persona_subq.c.latest_persona_id == IuserPersona.id).\
            join(IuserAssignedusertype, IuserPersona.assigned_usertype_id == IuserAssignedusertype.id).\
            join(IuserUsertype, IuserAssignedusertype.usertype_id == IuserUsertype.id).\
            outerjoin(latest_partner_site_subq, IuserPersona.id == latest_partner_site_subq.c.persona_id).\
            outerjoin(PartnersPartner, latest_partner_site_subq.c.latest_partner_id == PartnersPartner.id).\
            filter(FormMemberSite.member_site_id == member_site_id).\
            filter(IuserUser.member_id == member_site_id).\
            filter(FormCopy.form_user_type == form_user_type).\
            filter(QuestionCopy.is_active == True).\
            filter(~QuestionCopy.question_type.in_([15, 16])).\
            filter(FormCopy.last_touched_datetime >= lookback_date).\
            order_by(QuestionCopy.parent_id.asc()).\
            order_by(FormCopy.last_touched_datetime.asc()).\
            all()

    # The export of type 3 is optimized for Salesforce and focuses on mentors with a match status of "RS" for rescreening.
    # iMentor relies on this export to upload the application data to the new persona record in Salesforce.
    elif export_type == '3':
        results = ro_DBSession.query(
            FormCopy.id.label('form_id'),
            QuestionCopy.id.label('copy_question_id'),
            IuserUser.id.label('user_id'),
            IuserPersona.id.label('persona_id'),
            IuserPersona.match_id.label('match_id'),
            IuserUser.email.label('email'),
            MemberMember.name.label('member_site_name'),
            PartnersPartner.name.label('partner_site_name'),
            IuserUsertype.type.label('user_type'),
            IuserUser.status.label('user_status'),
            IuserPersona.match_status.label('match_status'),
            FormCopy.form_was_completed_datetime.label('completed_date'),
            QuestionCopy.question_text.label('master_question_text'),
            QuestionCopy.parent_id.label('question_number')).\
            join(FormMemberSite, FormCopy.parent_id == FormMemberSite.form_id).\
            join(SectionCopy, FormCopy.id == SectionCopy.form_id).\
            join(QuestionCopy, SectionCopy.id == QuestionCopy.section_id).\
            outerjoin(UserResponse, QuestionCopy.id == UserResponse.question_id).\
            join(IuserUser, FormCopy.user_id == IuserUser.id).\
            join(MemberMember, IuserUser.member_id == MemberMember.id).\
            join(latest_persona_subq, IuserUser.id == latest_persona_subq.c.user_id).\
            join(IuserPersona, latest_persona_subq.c.latest_persona_id == IuserPersona.id).\
            join(IuserAssignedusertype, IuserPersona.assigned_usertype_id == IuserAssignedusertype.id).\
            join(IuserUsertype, IuserAssignedusertype.usertype_id == IuserUsertype.id).\
            outerjoin(latest_partner_site_subq, IuserPersona.id == latest_partner_site_subq.c.persona_id).\
            outerjoin(PartnersPartner, latest_partner_site_subq.c.latest_partner_id == PartnersPartner.id).\
            filter(FormMemberSite.member_site_id == member_site_id).\
            filter(IuserUser.member_id == member_site_id).\
            filter(FormCopy.form_user_type == form_user_type).\
            filter(QuestionCopy.is_active == True).\
            filter(~QuestionCopy.question_type.in_([15, 16])).\
            filter(IuserPersona.match_status == 'RS').\
            order_by(QuestionCopy.parent_id.asc()).\
            order_by(FormCopy.last_touched_datetime.asc()).\
            all()

    # In order to prevent a crash in the code below, we return nothing here, if there are no rows to export.
    if not results:
        return

    scrubbed_results = dict(user_id = [],\
        persona_id = [],\
        match_id = [],\
        email = [],\
        member_site_name = [],\
        partner_site_name = [],\
        user_type = [],\
        user_status = [],\
        match_status = [],\
        completed_date = [],\
        distinct_master_question = [],\
        consolidated_user_response = [])
    for row in results:
        scrubbed_results['user_id'].append(row.user_id)
        scrubbed_results['persona_id'].append(row.persona_id)
        
        # The next few conditionals ensure the export succeeds, even if some data is NULL, eg a match or completed date, both of which may not be available at the time of export, as in the case of new mentors or incomplete applications.
        # Explictly setting NULL values to '' ensures they appear as blanks in Excel, not as 'None'.
        if row.match_id is None:
            scrubbed_results['match_id'].append('')
        else:
            scrubbed_results['match_id'].append(row.match_id)

        scrubbed_results['email'].append(row.email)
        scrubbed_results['member_site_name'].append(row.member_site_name.encode('utf-8','ignore'))

        if row.partner_site_name is None:
            scrubbed_results['partner_site_name'].append('')
        else:
            scrubbed_results['partner_site_name'].append(row.partner_site_name.encode('utf-8','ignore'))

        scrubbed_results['user_type'].append(row.user_type)
        scrubbed_results['user_status'].append(row.user_status)
        scrubbed_results['match_status'].append(row.match_status)

        if row.completed_date is None:
            completed_date = 'Incomplete'
        else:
            completed_date = row.completed_date.strftime(DATE_FORMAT)
        scrubbed_results['completed_date'].append(completed_date)

        # We add a padded question number to ensure the columns retain ascending order after the pivot below.
        mqid = str(row.question_number).zfill(10)
        scrubbed_results['distinct_master_question'].append('%s_' % mqid + row.master_question_text)

        consolidated_user_response = rs.answer_lookup(row.user_id, row.copy_question_id)
        # We convert empty lists to a string and filter NULL answers from the list, so that the join works and so that the export does not display "NaN" and other symbols for NULL values.
        if consolidated_user_response is None:
            consolidated_user_response = ''
        else:
            consolidated_user_response = filter(None, consolidated_user_response)
            consolidated_user_response = ' | '.join(consolidated_user_response)
        scrubbed_results['consolidated_user_response'].append(consolidated_user_response)

    df = pd.DataFrame(scrubbed_results)
    # The aggfunc here is necessary for the pivot, even though we always should have one row of responses per question.
    pivoted_results = pivot_table(\
        df,\
        index = ['user_id',\
            'persona_id',\
            'match_id',\
            'email',\
            'member_site_name',\
            'partner_site_name',\
            'user_type',\
            'user_status',\
            'match_status',\
            'completed_date'],\
        columns = 'distinct_master_question',\
        values = 'consolidated_user_response',\
        aggfunc = lambda x: ' | '.join(x),\
        fill_value = '')
    indexless_results = pivoted_results.reset_index()

    final_columns = []
    for column in indexless_results.columns:
        # We remove the numeric prefixes from column headers that kept them in order during the pivot.
        column = re.sub('^[0-9]+_', '', str(column))
        column = strip_tags(column)
        final_columns.extend([column])
    
    # Yield keeps data flowing from the back end to the front end and therefore prevents a time-out with large exports and prevent high memory consumption on the server.
    yield final_columns
    for final_value in indexless_results.values.tolist():
        yield final_value

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class MLStripper(HTMLParser):
    def __init__(self):
        self.reset()
        self.fed = []
    def handle_data(self, d):
        self.fed.append(d)
    def get_data(self):
        return ' '.join(self.fed)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def strip_tags(html):
    s = MLStripper()
    s.feed(html)
    return s.get_data()

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
if __name__=="__main__":
    export_intake_application(1, 1, '1')
