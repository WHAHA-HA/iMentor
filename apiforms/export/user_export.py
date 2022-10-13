import os,sys
import re

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
    SectionCopy)
from HTMLParser import HTMLParser

rs = ResponseServices()
DATE_FORMAT = '%m/%d/%y'

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def export_intake_application(user_id, member_site_id):

    latest_persona_subq = user_details.get_latest_persona(filtered = False, user_id = None)
    latest_partner_site_subq = user_details.get_latest_partner_site()

    results = ro_DBSession.query(
        FormCopy.id.label('form_id'),
        IuserUser.id.label('user_id'),
        IuserUser.first_name.label('first_name'),
        IuserUser.last_name.label('last_name'),
        QuestionCopy.id.label('copy_question_id'),
        QuestionCopy.question_text.label('question_text')).\
        join(FormMemberSite, FormCopy.parent_id == FormMemberSite.form_id).\
        join(SectionCopy, FormCopy.id == SectionCopy.form_id).\
        join(QuestionCopy, SectionCopy.id == QuestionCopy.section_id).\
        join(UserResponse, QuestionCopy.id == UserResponse.question_id).\
        join(IuserUser, FormCopy.user_id == IuserUser.id).\
        join(MemberMember, IuserUser.member_id == MemberMember.id).\
        join(latest_persona_subq, IuserUser.id == latest_persona_subq.c.user_id).\
        join(IuserPersona, latest_persona_subq.c.latest_persona_id == IuserPersona.id).\
        join(IuserAssignedusertype, IuserPersona.assigned_usertype_id == IuserAssignedusertype.id).\
        join(IuserUsertype, IuserAssignedusertype.usertype_id == IuserUsertype.id).\
        outerjoin(latest_partner_site_subq, IuserPersona.id == latest_partner_site_subq.c.persona_id).\
        outerjoin(PartnersPartner, latest_partner_site_subq.c.latest_partner_id == PartnersPartner.id).\
        filter(FormMemberSite.member_site_id == member_site_id).\
   	    filter(FormCopy.user_id == user_id).\
   	    filter(QuestionCopy.is_active == True).\
   	    filter(~QuestionCopy.question_type.in_([15, 16])).\
   	    order_by(SectionCopy.parent_id.asc()).\
   	    order_by(QuestionCopy.ordinal.asc()).\
   	    order_by(QuestionCopy.sub_ordinal.asc()).\
        all()

    outer_list = []
    inner_list = []
    # In order to prevent a crash in the code below, we return nothing here, if there are no rows to export.
    if not results:
        inner_list.append('No data yet.')
        inner_list.append('')
        
        outer_list.append(tuple(inner_list))

    else:
        # We first add the static user information to the first tuple for A1 and B1 in the spreadsheet.
        inner_list.append(results[0].first_name.encode('utf-8','ignore') + ' ' + results[0].last_name.encode('utf-8','ignore'))
        inner_list.append('')
        
        outer_list.append(tuple(inner_list))
    
        for row in results:
            inner_list = []
            inner_list.append(strip_tags(row.question_text))
            consolidated_user_response = rs.answer_lookup(row.user_id, row.copy_question_id)
            # We convert empty lists to a string and filter NULL answers from the list, so that the join works and so that the export does not display "NaN" and other symbols for NULL values.
            if consolidated_user_response is None:
                consolidated_user_response = ''
            else:
                consolidated_user_response = filter(None, consolidated_user_response)
                # We use an ellipsis here to allow our CSV to use | as a delimiter.
                consolidated_user_response = '...'.join(consolidated_user_response)
            inner_list.append(consolidated_user_response)
            
            outer_list.append(tuple(inner_list))

    return outer_list

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
    export_intake_application(185197, 1)