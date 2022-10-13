# -*- coding: iso8859-15 -*-
import os,sys
import pprint
import logging
import datetime
from dateutil import tz
from decimal import Decimal

appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'../..'))
projdir2 = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)
    sys.path.append(projdir2)
from config.project_globals import (db,Base,metadata,
    DBSession,DOGPILE_CACHE_REGION)
from config.caching_query import CachingQuery,FromCache
from sqlalchemy import (BigInteger, Boolean, Column, Date, DateTime, 
    Float, ForeignKey, Index, Integer, Numeric, SmallInteger, 
    String, Table, Text, Time, text, func, or_, cast)
from sqlalchemy.sql.expression import func, or_, not_, and_
from sqlalchemy.orm import sessionmaker, aliased
from canvas.models import (Curriculum, GradeInfo, UnitInfo, CanvasSet, 
    WidgetContentUserResponse, WidgetContentResponseMarkerCopy, WidgetContentCopy, 
    WidgetCopy, CanvasAppCopy, CanvasSetCopy, CurriculumCopy, WidgetContentMarkerReferenceCopy,
    PartnersSessionCurriculum)
from portfolio.models import ReflectionUserResponse, ReflectionCard, ReflectionUserDetails
from conversations.models import Conversation
from utils.user_details import (get_details_for_user, get_latest_mentor_for_mentee,
    get_latest_mentee_for_mentor, user_timezone)
from legacy_models.partners import PartnersPartner, PartnersSession
from legacy_models.iuser import (IuserUser, IuserPersona, IuserPersonaPartner, 
    USER_STATUS_ACTIVE,USER_STATUS_APPLICATION_INCOMPLETE,USER_STATUS_SCREENING_INCOMPLETE,
    ACTIVE_PERSONA_STATUS,P_MATCH_STATUS_CLOSED,
    IuserAssignedusertype, IuserUsertype)

from legacy_models.member import MemberMember
from legacy_models.utils import UtilsTimezone

# We prefer this display formats for dates and times, since they are succinct yet still descriptive.
DATETIME_DISPLAY_FORMAT = '%-m/%-d/%y %-I:%M %p'
DATE_DISPLAY_FORMAT = '%-m/%-d/%y'
CONV_DATE_FORMAT = '%d%m%Y'

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_class_roster(partner_id):

    IuserPersona2 = aliased(IuserPersona)
    IuserUser2 = aliased(IuserUser)

    # We obtain data from the perspective of all mentees receiving iMentor services.
    class_mentees = DBSession.query(
        IuserUser.id.label('mentee_user_id'),
        IuserPersona.id.label('mentee_persona_id'),
        IuserUser.first_name.label('mentee_first_name'),
        IuserUser.last_name.label('mentee_last_name'),
        IuserPersonaPartner.partner_id.label('partner_id'),
        IuserUser.email.label('mentee_email'),
        IuserUser2.email.label('staff_email')).\
        options(FromCache(DOGPILE_CACHE_REGION)).\
        join(IuserPersona, IuserUser.id == IuserPersona.user_id).\
        join(IuserPersonaPartner, IuserPersona.id == IuserPersonaPartner.persona_id).\
        join(IuserAssignedusertype, IuserPersona.assigned_usertype_id == IuserAssignedusertype.id).\
        join(IuserUsertype, IuserAssignedusertype.usertype_id == IuserUsertype.id).\
        join(PartnersPartner, IuserPersonaPartner.partner_id == PartnersPartner.id).\
        join(IuserPersona2, PartnersPartner.member_contact_id == IuserPersona2.id).\
        join(IuserUser2, IuserPersona2.user_id == IuserUser2.id).\
        filter(IuserUsertype.id == 5).\
        filter(IuserPersona.status == ACTIVE_PERSONA_STATUS).\
        filter(IuserPersona.match_status != 'C').\
        filter(IuserUser.status.in_(['A', 'SI'])).\
        filter(IuserPersonaPartner.partner_id == partner_id).\
        order_by(IuserPersona.match_status.asc()).\
        order_by(IuserUser.first_name.asc()).\
        order_by(IuserUser.last_name.asc()).\
        all()

    outer_list = []
    for mentee in class_mentees:
        inner_list = []
        
        inner_list.append(mentee.mentee_first_name)
        inner_list.append(mentee.mentee_last_name)
        inner_list.append(mentee.mentee_user_id)
        inner_list.append(mentee.mentee_persona_id)
        
        mentee_profile_link = '/iuser/backend_profile/' + str(mentee.mentee_persona_id) + '/'
        inner_list.append(mentee_profile_link)
        
        inner_list.append(mentee.mentee_email)
        
        # We obtain the current lesson ID for mentors and mentees, so that text message reminders are easy.
        current_curriculum = get_lesson(partner_id, 'current', mentee.mentee_user_id)
        if current_curriculum[0] != 'NA':
            current_lesson = DBSession.query(
                CanvasSet.id.label('lesson_id')).\
                options(FromCache(DOGPILE_CACHE_REGION)).\
                filter(CanvasSet.curriculum_id == current_curriculum[0]).\
                filter(CanvasSet.role == 5).\
                first()
    
            # It's possible to have a curriculum record, but no lesson record for the mentee or mentor.
            if current_lesson:
                inner_list.append(current_lesson.lesson_id)
            else:
                inner_list.append('NA')
        else:
            inner_list.append('NA')

        latest_counterparty = get_latest_mentor_for_mentee(mentee.mentee_user_id)
        if latest_counterparty:
            mentor_details = DBSession.query(
                IuserUser.first_name.label('mentor_first_name'),
                IuserUser.last_name.label('mentor_last_name'),
                IuserUser.email.label('mentor_email')).\
                options(FromCache(DOGPILE_CACHE_REGION)).\
                filter(IuserUser.id == latest_counterparty.mentor_user_id).\
                first()
        
            inner_list.append(mentor_details.mentor_first_name)
            inner_list.append(mentor_details.mentor_last_name)
            inner_list.append(latest_counterparty.mentor_user_id)
            inner_list.append(latest_counterparty.mentor_persona_id)

            mentor_profile_link = '/iuser/backend_profile/' + str(latest_counterparty.mentor_persona_id) + '/'
            inner_list.append(mentor_profile_link)
            
            inner_list.append(mentor_details.mentor_email)

            # We obtain the current lesson ID for mentors and mentees, so that text message reminders are easy.
            current_curriculum = get_lesson(partner_id, 'current', mentee.mentee_user_id)
            if current_curriculum[0] != 'NA':
                current_lesson = DBSession.query(
                    CanvasSet.id.label('lesson_id')).\
                    options(FromCache(DOGPILE_CACHE_REGION)).\
                    filter(CanvasSet.curriculum_id == current_curriculum[0]).\
                    filter(CanvasSet.role == 4).\
                    first()
                
                # It's possible to have a curriculum record, but no lesson record for the mentee or mentor.
                if current_lesson:
                    inner_list.append(current_lesson.lesson_id)
                else:
                    inner_list.append('NA')
            else:
                inner_list.append('NA')
        else:
            inner_list.append('NA')
            inner_list.append('NA')
            inner_list.append('NA')
            inner_list.append('NA')
            inner_list.append('NA')
            inner_list.append('NA')
            inner_list.append('NA')

        inner_list.append(mentee.staff_email)

        outer_list.append(tuple(inner_list))

    return outer_list

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_lesson(partner_id, period, user_id):

    # This is a bit weird because we have a date when canvas changed drastically, and we made new masters:
    # Nov 20, 2016. We could have overlaps in lesson dates because of this, and it should not be a problem. 
    # Under normal circumstances it is impossible to overlap. The code adjusts the end dates
    # to accommodate the newly scheduled class.

    if period == 'current_minus_1':
        limit = 2
    elif period == 'current_minus_2':
        limit = 3
    else: limit = 1

    # Get one or more "current" lessons, including all wierd overlaps first. Then try for older
    # lessons when these are no longer found.
    result = [x for x in DBSession.query(
        PartnersSessionCurriculum.curr_id.label('curriculum_id'),
        PartnersSession.description.label('lesson_description'),
        PartnersSession.start.label('lesson_start'),
        PartnersSession.end_date.label('lesson_end')).\
        options(FromCache(DOGPILE_CACHE_REGION)).\
        join(PartnersSession, PartnersSessionCurriculum.p_session_id == PartnersSession.id).\
        filter(PartnersSession.partner_id == partner_id).\
        filter(PartnersSession.end_date > datetime.datetime.utcnow()).\
        filter(PartnersSession.start <= datetime.datetime.utcnow()).\
        order_by(PartnersSession.start.desc()).\
        limit(limit).\
        all()]

    index = limit - 1
    limit -= len(result)
    if limit <= 0:
        result = result[index] # Found result
    else:
        index = limit - 1
        result = [x for x in DBSession.query(
            PartnersSessionCurriculum.curr_id.label('curriculum_id'),
            PartnersSession.description.label('lesson_description'),
            PartnersSession.start.label('lesson_start'),
            PartnersSession.end_date.label('lesson_end')).\
            options(FromCache(DOGPILE_CACHE_REGION)).\
            join(PartnersSession, PartnersSessionCurriculum.p_session_id == PartnersSession.id).\
            filter(PartnersSession.partner_id == partner_id).\
            filter(PartnersSession.end_date < datetime.datetime.utcnow()).\
            order_by(PartnersSession.start.desc()).\
            limit(limit).\
            all()]

        if result:
            if (len(result) - 1) < index:
                result = result[-1]
            else:
                result = result[index]

    inner_list = []

    if result:
        inner_list.append(result.curriculum_id)
        inner_list.append(result.lesson_description)
        
        to_tz = user_timezone(user_id)
        start_display = result.lesson_start.replace(tzinfo=tz.gettz('UTC')).astimezone(to_tz).replace(tzinfo=None)
        end_display = result.lesson_end.replace(tzinfo=tz.gettz('UTC')).astimezone(to_tz).replace(tzinfo=None)
        
        inner_list.append(start_display.strftime(DATE_DISPLAY_FORMAT))
        inner_list.append(end_display.strftime(DATE_DISPLAY_FORMAT))
    else:
        inner_list.append('NA')
        inner_list.append('NA')
        inner_list.append('NA')
        inner_list.append('NA')

    return tuple(inner_list)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_lesson_engagement(partner_id, curriculum_id, admin_user):

    class_roster = get_class_roster(partner_id)
    outer_list = []
    for mentee in class_roster:
        inner_list = []
        canvas_details = get_canvas_engagement_details(mentee[2], curriculum_id, mentee[9])

        # We confirm whether the lesson is available for the mentee.
        if canvas_details and canvas_details.cscopy_id and canvas_details.party_user_id:
            # We confirm whether the lesson was started yet.
            if canvas_details.party_viewed:
                if canvas_details.party_canvas_first_completed:
                    # We confirm whether the lesson was completed on time.
                    if canvas_details.party_canvas_first_completed >= canvas_details.party_lesson_start and canvas_details.party_canvas_first_completed < canvas_details.party_lesson_end:
                        inner_list.append('Finished')
                    else:
                        inner_list.append('Finished late')
                else:
                    inner_list.append('Not finished')
            else:
                # We confirm whether the lesson was completed by staff on behalf of the student.
                # In this case, party_viewed is NULL, but party_canvas_first_completed is not NULL.
                if canvas_details.party_canvas_first_completed:
                    # We confirm whether the lesson was completed on time.
                    if canvas_details.party_canvas_first_completed >= canvas_details.party_lesson_start and canvas_details.party_canvas_first_completed < canvas_details.party_lesson_end:
                        inner_list.append('Finished')
                    else:
                        inner_list.append('Finished late')
                else:
                    inner_list.append('Not started')

            if canvas_details.cscopy_id:
                party_lesson_link = '/canvas/lessoncopy/' + str(canvas_details.cscopy_id) + '/' + str(canvas_details.party_user_id) + '/'

                inner_list.append(party_lesson_link)
            else:
                inner_list.append(None)

            # Get convs matching the match at that time.
            if hasattr(canvas_details,'counterparty_user_id') and canvas_details.counterparty_user_id:
                # We check for conversations from the mentee during the lesson date range.
                party_conversation_details = get_conversation_engagement_details(mentee[2], canvas_details.counterparty_user_id, canvas_details.party_lesson_start, canvas_details.party_lesson_end)
    
                if party_conversation_details:
                    # We determine whether any conversations exist for this lesson.
                    inner_list.append('Sent message')
                else:
                    inner_list.append('Not started')

                # We pass the Conversations link to the front end every time.
                party_conversation_link = str(mentee[2]) + "," + canvas_details.party_lesson_start.strftime(CONV_DATE_FORMAT) + "," + canvas_details.party_lesson_end.strftime(CONV_DATE_FORMAT)
                inner_list.append(party_conversation_link)
            else:
                inner_list.append('Not available')
                inner_list.append('NA')
        else:
            inner_list.append('Not available')
            inner_list.append('NA')
            inner_list.append('Not available')
            inner_list.append('NA')

        # We consider engagement with Canvas only for matched mentees.
        # We also consider engagement with Conversations only for matched mentees.
        #if mentee[9] != 'NA':
        # We confirm whether the lesson is available for the mentor.
        if canvas_details and hasattr(canvas_details,'cscopy2_id') and \
            canvas_details.cscopy2_id and hasattr(canvas_details,'counterparty_user_id') and \
            canvas_details.counterparty_user_id:

            # We confirm whether the lesson was started yet.
            if canvas_details.counterparty_viewed:
                # We confirm whether the lesson was completed on time.
                if canvas_details.counterparty_canvas_first_completed:
                    if canvas_details.counterparty_canvas_first_completed >= canvas_details.counterparty_lesson_start and canvas_details.counterparty_canvas_first_completed < canvas_details.counterparty_lesson_end:
                        inner_list.append('Finished')
                    else:
                        inner_list.append('Finished late')
                else:
                    inner_list.append('Not finished')
            else:
                # We confirm whether the lesson was completed by staff on behalf of the student.
                # In this case, party_viewed is NULL, but party_canvas_first_completed is not NULL.
                if canvas_details.counterparty_canvas_first_completed:
                    # We confirm whether the lesson was completed on time.
                    if canvas_details.counterparty_canvas_first_completed >= canvas_details.counterparty_lesson_start and canvas_details.counterparty_canvas_first_completed < canvas_details.counterparty_lesson_end:
                        inner_list.append('Finished')
                    else:
                        inner_list.append('Finished late')
                else:
                    inner_list.append('Not started')
    
            if hasattr(canvas_details,'cscopy2_id') and canvas_details.cscopy2_id:
                counterparty_lesson_link = '/canvas/lessoncopy/' + str(canvas_details.cscopy2_id) + '/' + str(canvas_details.counterparty_user_id) + '/'
                inner_list.append(counterparty_lesson_link)
            else:
                inner_list.append(None)
        else:
            inner_list.append('Not available')
            inner_list.append('NA')

        # Get convs matching the match at that time.
        if hasattr(canvas_details,'counterparty_user_id') and canvas_details.counterparty_user_id:
            counterparty_conversation_details = get_conversation_engagement_details(canvas_details.counterparty_user_id, mentee[2], canvas_details.counterparty_lesson_start, canvas_details.counterparty_lesson_end)

            if counterparty_conversation_details:
                # We determine whether any conversations exist for this lesson.
                inner_list.append('Sent message')
            else:
                inner_list.append('Not started')

            # We pass the Conversations link to the front end every time.
            counterparty_conversation_link = str(mentee[9]) + "," + canvas_details.counterparty_lesson_start.strftime(CONV_DATE_FORMAT) + "," + canvas_details.counterparty_lesson_end.strftime(CONV_DATE_FORMAT)
            inner_list.append(counterparty_conversation_link)
        else:
            inner_list.append('Not available')
            inner_list.append('NA')

        inner_list.append(canvas_details.cscopy_id)
        if hasattr(canvas_details,'cscopy2_id'):
            inner_list.append(canvas_details.cscopy2_id)

        outer_list.append(tuple(inner_list))

    return outer_list

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_lesson_engagement_statistics(partner_id, curriculum_id):

    class_roster = get_class_roster(partner_id)
    statistics_mentee_any_count = 0
    statistics_mentee_count = 0
    statistics_mentee_ontime_canvas_count = 0
    statistics_mentee_conversations_count = 0
    statistics_mentor_any_count = 0
    statistics_mentor_count = 0
    statistics_mentor_ontime_canvas_count = 0
    statistics_mentor_conversations_count = 0
    statistics_pair_count = 0
    statistics_pair_any_count = 0
    statistics_pair_ontime_canvas_count = 0
    statistics_pair_conversations_count = 0
    inner_list = []

    for mentee in class_roster:
        # We reset these flags to prevent spillover from previous mentees.
        statistics_mentee_ontime_canvas_flag = False
        statistics_mentor_ontime_canvas_flag = False
        statistics_mentee_conversations_flag = False
        statistics_mentor_conversations_flag = False
        
        canvas_details = get_canvas_engagement_details(mentee[2], curriculum_id, mentee[9])

        # We confirm whether the lesson is available for the mentee.
        if canvas_details and canvas_details.cscopy_id and canvas_details.party_user_id:
            statistics_mentee_count += 1

            # We confirm that the mentee was matched.
            if hasattr(canvas_details,'counterparty_user_id') and canvas_details.counterparty_user_id:

                # We confirm whether the lesson was completed on time.
                if canvas_details.party_canvas_first_completed:
                    if canvas_details.party_canvas_first_completed >= canvas_details.party_lesson_start and canvas_details.party_canvas_first_completed < canvas_details.party_lesson_end:
                        statistics_mentee_ontime_canvas_flag = True
                        statistics_mentee_ontime_canvas_count += 1

                # We check for conversations from the mentee during the lesson date range.
                party_conversation_details = get_conversation_engagement_details(mentee[2], canvas_details.counterparty_user_id, canvas_details.party_lesson_start, canvas_details.party_lesson_end)
    
                if party_conversation_details:
                    # We don't require a loop through messages here, since we're counting users, not messages.
                    statistics_mentee_conversations_flag = True
                    statistics_mentee_conversations_count += 1

            if statistics_mentee_ontime_canvas_flag or statistics_mentee_conversations_flag:
                statistics_mentee_any_count += 1

        else:
            continue

        # We confirm whether the lesson is available for the mentor.
        if canvas_details and hasattr(canvas_details,'cscopy2_id') and canvas_details.cscopy2_id:

            statistics_mentor_count += 1

            # We confirm that the mentor was matched.
            if hasattr(canvas_details,'counterparty_user_id') and \
                canvas_details.counterparty_user_id and canvas_details.party_user_id:

                # We only want to count records involving matches. It doesn't necessarily have to be
                # a person's current match.
                statistics_pair_count += 1

                canvas_details = get_canvas_engagement_details(mentee[2], curriculum_id, mentee[9])
    
                # We confirm whether the lesson was completed on time.
                if canvas_details.counterparty_canvas_first_completed:
                    if canvas_details.counterparty_canvas_first_completed >= canvas_details.counterparty_lesson_start and canvas_details.counterparty_canvas_first_completed < canvas_details.counterparty_lesson_end:
                        statistics_mentor_ontime_canvas_flag = True
                        statistics_mentor_ontime_canvas_count += 1

                        if statistics_mentee_ontime_canvas_flag:
                            statistics_pair_ontime_canvas_count += 1
        
                # We check for conversations from the mentor during the lesson date range.
                if hasattr(canvas_details,'counterparty_user_id') and canvas_details.counterparty_user_id:
                    counterparty_conversation_details = get_conversation_engagement_details(canvas_details.counterparty_user_id, mentee[2], canvas_details.counterparty_lesson_start, canvas_details.counterparty_lesson_end)
    
                if counterparty_conversation_details:
                    # We don't require a loop through messages here, since we're counting users, not messages.
                    statistics_mentor_conversations_flag = True
                    statistics_mentor_conversations_count += 1

                    if statistics_mentee_conversations_flag:
                        statistics_pair_conversations_count += 1

                if statistics_mentor_ontime_canvas_flag or statistics_mentor_conversations_flag:
                    statistics_mentor_any_count += 1
        else:
            continue

        if (statistics_mentee_ontime_canvas_flag or statistics_mentee_conversations_flag) and \
            (statistics_mentor_ontime_canvas_flag or statistics_mentor_conversations_flag):
            statistics_pair_any_count += 1

    # We use statistics_pair_count as the denominator in all cases here,
    # since unmatched mentees are not part of our formal program model at the moment.

    if statistics_pair_count > 0:
        statistics_mentee_any_participation = (Decimal(statistics_mentee_any_count)/Decimal(statistics_pair_count)) * 100
        statistics_mentee_ontime_canvas_participation = (Decimal(statistics_mentee_ontime_canvas_count)/Decimal(statistics_pair_count)) * 100
        statistics_mentee_conversations_participation = (Decimal(statistics_mentee_conversations_count)/Decimal(statistics_pair_count)) * 100
        statistics_mentor_any_participation = (Decimal(statistics_mentor_any_count)/Decimal(statistics_pair_count)) * 100
        statistics_mentor_ontime_canvas_participation = (Decimal(statistics_mentor_ontime_canvas_count)/Decimal(statistics_pair_count)) * 100
        statistics_mentor_conversations_participation = (Decimal(statistics_mentor_conversations_count)/Decimal(statistics_pair_count)) * 100
        statistics_pair_any_participation = (Decimal(statistics_pair_any_count)/Decimal(statistics_pair_count)) * 100
        statistics_pair_ontime_canvas_participation = (Decimal(statistics_pair_ontime_canvas_count)/Decimal(statistics_pair_count)) * 100
        statistics_pair_conversations_participation = (Decimal(statistics_pair_conversations_count)/Decimal(statistics_pair_count)) * 100
    else:
        statistics_mentee_any_participation = 0
        statistics_mentee_ontime_canvas_participation = 0
        statistics_mentee_conversations_participation = 0
        statistics_mentor_any_participation = 0
        statistics_mentor_ontime_canvas_participation = 0
        statistics_mentor_conversations_participation = 0
        statistics_pair_any_participation = 0
        statistics_pair_ontime_canvas_participation = 0
        statistics_pair_conversations_participation = 0

    inner_list.append('{:.0f}'.format(statistics_mentee_any_participation))
    inner_list.append('{:.0f}'.format(statistics_mentor_any_participation))
    inner_list.append('{:.0f}'.format(statistics_pair_any_participation))
    inner_list.append('{:.0f}'.format(statistics_mentee_ontime_canvas_participation))
    inner_list.append('{:.0f}'.format(statistics_mentor_ontime_canvas_participation))
    inner_list.append('{:.0f}'.format(statistics_pair_ontime_canvas_participation))
    inner_list.append('{:.0f}'.format(statistics_mentee_conversations_participation))
    inner_list.append('{:.0f}'.format(statistics_mentor_conversations_participation))
    inner_list.append('{:.0f}'.format(statistics_pair_conversations_participation))
    
    # No outer list is necessary here, since we expect only one row of results.
    return tuple(inner_list)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_canvas_engagement_details(user_id, curriculum_id, latest_counterparty_user_id):

        # The many ordering clauses in the queries below ensure the relevant data
        # appears in the first row of results, since we only retrieve the first row.
        #if latest_counterparty_user_id != 'NA':

        CanvasSet2 = aliased(CanvasSet)
        CanvasSetCopy2 = aliased(CanvasSetCopy)
        
        result = DBSession.query(
            Curriculum.id.label('curriculum_id'),
            CanvasSet.id.label('canvas_set_id'),
            CanvasSet.description.label('lesson_description'),
            GradeInfo.grade_number.label('grade_number'),
            UnitInfo.unit_number.label('unit_number'),
            Curriculum.curriculum_number.label('lesson_number'),
            CanvasSetCopy.id.label('cscopy_id'),
            CanvasSetCopy.start_datetime.label('party_lesson_start'),
            CanvasSetCopy.end_datetime.label('party_lesson_end'),
            CanvasSetCopy.role.label('party_canvas_role'),
            CanvasSetCopy.last_viewed.label('party_viewed'),
            CanvasSetCopy.user_completed.label('party_canvas_ever_completed'),
            CanvasSetCopy.user_first_completed.label('party_canvas_first_completed'),
            CanvasSetCopy.admin_last_viewed.label('party_staff_last_viewed'),
            CanvasSetCopy.parent_id.label('party_lesson_id'),
            CanvasSetCopy.user_id.label('party_user_id'),
            CanvasSetCopy.persona_id.label('party_persona_id'),
            CanvasSetCopy2.id.label('cscopy2_id'),
            CanvasSetCopy2.start_datetime.label('counterparty_lesson_start'),
            CanvasSetCopy2.end_datetime.label('counterparty_lesson_end'),
            CanvasSetCopy2.role.label('counterparty_canvas_role'),
            CanvasSetCopy2.last_viewed.label('counterparty_viewed'),
            CanvasSetCopy2.user_completed.label('counterparty_canvas_ever_completed'),
            CanvasSetCopy2.user_first_completed.label('counterparty_canvas_first_completed'),
            CanvasSetCopy2.admin_last_viewed.label('counterparty_staff_last_viewed'),
            CanvasSetCopy2.parent_id.label('counterparty_lesson_id'),
            CanvasSetCopy2.user_id.label('counterparty_user_id'),
            CanvasSetCopy2.persona_id.label('counterparty_persona_id')).\
            options(FromCache(DOGPILE_CACHE_REGION)).\
            distinct(GradeInfo.grade_number).\
            distinct(UnitInfo.unit_number).\
            distinct(Curriculum.curriculum_number).\
            distinct(Curriculum.id).\
            join(GradeInfo, Curriculum.grade_id == GradeInfo.id).\
            join(UnitInfo, Curriculum.unit_id == UnitInfo.id).\
            join(CanvasSet, Curriculum.id == CanvasSet.curriculum_id).\
            outerjoin(CanvasSetCopy, and_(CanvasSet.id == CanvasSetCopy.parent_id, user_id == CanvasSetCopy.user_id)).\
            join(CanvasSet2, Curriculum.id == CanvasSet2.curriculum_id).\
            outerjoin(CanvasSetCopy2, CanvasSet2.id == CanvasSetCopy2.parent_id).\
            filter(CanvasSetCopy2.matched_user_id == CanvasSetCopy.user_id).\
            filter(Curriculum.id == curriculum_id).\
            order_by(GradeInfo.grade_number.asc()).\
            order_by(UnitInfo.unit_number.asc()).\
            order_by(Curriculum.curriculum_number.asc()).\
            order_by(Curriculum.id.desc()).\
            order_by(CanvasSetCopy2.user_id.asc()).\
            order_by(CanvasSetCopy.user_id.asc()).\
            first()

        if result:
            return result

        result = DBSession.query(
            Curriculum.id.label('curriculum_id'),
            CanvasSet.id.label('canvas_set_id'),
            CanvasSet.description.label('lesson_description'),
            GradeInfo.grade_number.label('grade_number'),
            UnitInfo.unit_number.label('unit_number'),
            Curriculum.curriculum_number.label('lesson_number'),
            CanvasSetCopy.id.label('cscopy_id'),
            CanvasSetCopy.start_datetime.label('party_lesson_start'),
            CanvasSetCopy.end_datetime.label('party_lesson_end'),
            CanvasSetCopy.role.label('party_canvas_role'),
            CanvasSetCopy.last_viewed.label('party_viewed'),
            CanvasSetCopy.user_completed.label('party_canvas_ever_completed'),
            CanvasSetCopy.user_first_completed.label('party_canvas_first_completed'),
            CanvasSetCopy.admin_last_viewed.label('party_staff_last_viewed'),
            CanvasSetCopy.parent_id.label('party_lesson_id'),
            CanvasSetCopy.user_id.label('party_user_id'),
            CanvasSetCopy.persona_id.label('party_persona_id')).\
            options(FromCache(DOGPILE_CACHE_REGION)).\
            distinct(GradeInfo.grade_number).\
            distinct(UnitInfo.unit_number).\
            distinct(Curriculum.curriculum_number).\
            distinct(Curriculum.id).\
            join(GradeInfo, Curriculum.grade_id == GradeInfo.id).\
            join(UnitInfo, Curriculum.unit_id == UnitInfo.id).\
            join(CanvasSet, Curriculum.id == CanvasSet.curriculum_id).\
            outerjoin(CanvasSetCopy, and_(CanvasSet.id == CanvasSetCopy.parent_id, user_id == CanvasSetCopy.user_id)).\
            filter(Curriculum.id == curriculum_id).\
            order_by(GradeInfo.grade_number.asc()).\
            order_by(UnitInfo.unit_number.asc()).\
            order_by(Curriculum.curriculum_number.desc()).\
            order_by(Curriculum.id.asc()).\
            order_by(CanvasSetCopy.user_id.asc()).\
            first()

        return result

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def get_conversation_engagement_details(user_id, latest_counterparty_user_id, lesson_start, lesson_end):

    results = DBSession.query(
        Conversation.id.label('conversation_id'),
        Conversation.user_id.label('party_user_id'),
        Conversation.recipient_user_id.label('counterparty_user_id'),
        Conversation.received_by_server.label('conversation_start'),
        Conversation.admin_last_viewed.label('staff_last_viewed')).\
        options(FromCache(DOGPILE_CACHE_REGION)).\
        filter(Conversation.user_id == user_id).\
        filter(Conversation.recipient_user_id == latest_counterparty_user_id).\
        filter(Conversation.received_by_server >= lesson_start).\
        filter(Conversation.received_by_server < lesson_end).\
        order_by(Conversation.id.asc()).\
        all()

    return results

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~    
def get_delinquent_mentors():

    # Joey sends email reminders to mentors who haven't completed their lessons by the lookback date.
    lookback_date = datetime.datetime.utcnow().date() - datetime.timedelta(days = 3)

    results = DBSession.query(
        CanvasSetCopy.description.label('lesson_description'),
        CanvasSetCopy.start_datetime.label('lesson_start'),
        CanvasSetCopy.end_datetime.label('lesson_end'),
        IuserUser.first_name.label('first_name'),
        IuserUser.email.label('email'),
        IuserUser.id.label('user_id'),
        IuserUser.member_id.label('member_id'),
        PartnersPartner.name.label('class_name')).\
        options(FromCache(DOGPILE_CACHE_REGION)).\
        join(IuserPersona, CanvasSetCopy.persona_id == IuserPersona.id).\
        join(IuserPersonaPartner, IuserPersona.id == IuserPersonaPartner.persona_id).\
        join(IuserAssignedusertype, IuserPersona.assigned_usertype_id == IuserAssignedusertype.id).\
        join(IuserUsertype, IuserAssignedusertype.usertype_id == IuserUsertype.id).\
        join(PartnersPartner, IuserPersonaPartner.partner_id == PartnersPartner.id).\
        join(IuserUser, IuserPersona.user_id == IuserUser.id).\
        filter(IuserUsertype.id == 4).\
        filter(IuserPersona.match_status != P_MATCH_STATUS_CLOSED).\
        filter(IuserUser.status.in_([USER_STATUS_ACTIVE,USER_STATUS_APPLICATION_INCOMPLETE,USER_STATUS_SCREENING_INCOMPLETE])).\
        filter(CanvasSetCopy.user_first_completed == None).\
        filter(CanvasSetCopy.active == True).\
        filter(cast(CanvasSetCopy.start_datetime, Date) == lookback_date).\
        filter(cast(CanvasSetCopy.end_datetime, Date) >= datetime.datetime.utcnow().date()).\
        all()

    return results

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
if __name__=="__main__":
    get_class_roster(1817)
    #get_lesson(1821, 'current_minus_2')
    #get_lesson_engagement(1817, 14)
    #get_lesson_engagement_statistics(1817, 14)
    #get_canvas_engagement_details(151865, 99)
    #get_conversation_engagement_details(151667, 134, 151666)
    #get_delinquent_mentors()
