#!/bin/env python
# -*- coding: iso8859-15 -*-
import pdb
import pprint
import copy
import traceback
import os,sys
import csv
from dateutil import tz
from datetime import datetime,timedelta
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'../..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import db,Base,metadata,DBSession
from config.settings import (ENV_TYPE,LOGIN_DISABLED,
    DEFAULT_TEST_USER_ID)

from sqlalchemy.sql.expression import func, or_, not_, and_
from sqlalchemy.orm import sessionmaker 
from sqlalchemy.orm.exc import NoResultFound, MultipleResultsFound

from auth import app,lauth
from canvas import canvas
app.register_blueprint(canvas) # so templates can be found

from legacy_models.iuser import IuserUser,IuserMatchhistory,MENTOR,MENTEE
from legacy_models.mailer import MailerMessage
from legacy_models.message import MessageEmail,MessageEmailrecipient
from legacy_models.reporting import ReportingEmaillog,ReportingAllmatchemail
from legacy_models.curriculum import CurriculumPrompt
from legacy_models.partners import PartnersSession


from canvas.models import (WidgetContentResponseMarkerCopy,
    WidgetContentUserResponse,CanvasSetCopy,CanvasAppCopy,CanvasSet,
    WidgetCopy,WidgetContentCopy,WidgetContentResponseMarkerCopy,
    PartnersSessionCurriculum,Curriculum,CurriculumCopy,
    WIDGET_CRESPONSE_HTML,CANVAS_TYPE_LESSON)

from new_platform.utils.roles import Role
from new_platform.utils.user_details import (
    get_latest_mentor_user_for_mentee,get_latest_mentee_user_for_mentor,
    get_partners_for_user,get_details_for_user,get_persona_obj_for_user)
from new_platform.utils.strip_html import strip_tags


def update_legacy_dependencies_with_new_canvas_set():

  for curr_copy in CurriculumCopy.query.all():
    user = IuserUser.query.filter(IuserUser.id==curr_copy.user_id).one()
    role = Role(user.id)

    partners = get_partners_for_user(user,role)
    if len(partners) == 0:
        print "Ow! No partner site for this user: {0}, role {1}".format(user.id,role.role)
        continue

    partner = partners[0]

    '''
    psc_res = DBSession.query(PartnersSessionCurriculum,PartnersSession).\
        filter(PartnersSessionCurriculum.curr_id==curr_copy.parent_id).\
        filter(PartnersSessionCurriculum.p_session_id==PartnersSession.id).\
        filter(PartnersSession.partner_id==partner.id).first()

    if psc_res:
        psc = psc_res[0]
        psession = psc_res[1]
        if psession.partner_id != partner.id:
            print("Fail: psession id {0}, psc id: {1}".format(psession.id,psc.id))
    else:
        cprompt = CurriculumPrompt.query.filter(
            CurriculumPrompt.description==curr_copy.description).filter(
            CurriculumPrompt.created_date==curr_copy.start_datetime).first()

        if not cprompt:
    '''
    cprompt = CurriculumPrompt(
        title=curr_copy.description,
        description=curr_copy.description,
        prompt_text=curr_copy.description,
        created_date=curr_copy.start_datetime,
        modified_date=datetime.now(),
        status_id=3,
        created_by_id=1,
        modified_by_id=153864,
        is_deleted=False)

    local_db_session.add(cprompt)
    local_db_session.flush()
    local_db_session.refresh(cprompt)

    '''
    psession = PartnersSession.query.filter(
        PartnersSession.description==curr_copy.description).filter(
        PartnersSession.start==curr_copy.start_datetime).filter(
        PartnersSession.partner_id==partner.id).first()

    if not psession:
    '''
    psession = PartnersSession(
        description=curr_copy.description,
        start=curr_copy.start_datetime,
        prompt_id=cprompt.id,
        partner_id=partner.id,
        end_date=curr_copy.end_datetime,
        status_id = 1,
        activity_recorded = False)

    local_db_session.add(psession)
    local_db_session.flush()
    local_db_session.refresh(psession)

    pc_map = PartnersSessionCurriculum(
        curr_id=curr_copy.parent_id,
        p_session_id=psession.id)

    local_db_session.add(pc_map)
    local_db_session.flush()
    local_db_session.refresh(pc_map)

    # Close last legacy session.
    PartnersSession.query.filter(PartnersSession.end_date==None).filter(
        PartnersSession.partner_id==partner.id).update(
        {'end_date':curr_copy.start_datetime - timedelta(seconds = 1)})
    
    local_db_session.commit()

    print "Added a pc_map: {0}".format(pc_map.__dict__)


def correct_legacy_dependencies_upon_finish():

    for cscopy in CanvasSetCopy.query.filter(CanvasSetCopy.user_completed != None).all():

        print "Doing {0}".format(cscopy.user_id)

        current_user = IuserUser.query.filter(IuserUser.id==cscopy.user_id).one()

        cacopies = CanvasAppCopy.query.filter(
            CanvasAppCopy.user_id==current_user.id).filter(
            CanvasAppCopy.canvas_set_id==cscopy.id).all()

        wcopies = WidgetCopy.query.filter(
            WidgetCopy.user_id==current_user.id).filter(
            WidgetCopy.canvas_app_id.in_([x.id for x in cacopies])).all()

        wcontentcopies = WidgetContentCopy.query.filter(
            WidgetContentCopy.user_id==current_user.id).filter(
            WidgetContentCopy.widget_id.in_([x.id for x in wcopies])).all()

        #print "content copies: {0}".format(pprint.pformat([x.__dict__ for x in wcontentcopies]))

        respmarkercopies = WidgetContentResponseMarkerCopy.query.filter(
            WidgetContentResponseMarkerCopy.user_id==current_user.id).filter(
            WidgetContentResponseMarkerCopy.widget_content_id.in_([x.id for x in wcontentcopies])).all()

        #print "response markers: {0}".format(pprint.pformat([x.__dict__ for x in respmarkercopies]))

        responses = WidgetContentUserResponse.query.filter(
            WidgetContentUserResponse.user_id==current_user.id).filter(
            WidgetContentUserResponse.marker_id.in_([x.id for x in respmarkercopies])).all()

        #print "responses: {0}".format(pprint.pformat([x.__dict__ for x in responses]))

        '''
        memail = MessageEmail.query.filter(
            MessageEmail.sender_id==current_user.id).filter(
            MessageEmail.subject==cscopy.curriculum_user_copy.description).first()

        if memail:
            memail.content = '+'.join([x.response_html for x in responses])
            memail.send_date=cscopy.user_completed.replace(tzinfo=tz.gettz('UTC'))
            memail.stripped_content = '+'.join([x.response_text for x in responses])
            memail.search_tsv = func.to_tsvector(' '.join([x.response_html for x in responses]))
            memail.priority=0
            memail.has_attachment=None
            memail.nr_recipients=None
            memail.nr_groups=None
            memail.event_notification=False
            memail.legacy=False

        else:
        '''
        memail = MessageEmail(
            sender_id=current_user.id,
            subject=cscopy.curriculum_user_copy.description,
            content = '+'.join([x.response_html for x in responses]),
            send_date=cscopy.user_completed.replace(tzinfo=tz.gettz('UTC')),
            stripped_content = '+'.join([x.response_text for x in responses]),
            search_tsv = func.to_tsvector(' '.join([x.response_text for x in responses])),
            priority=0,
            has_attachment=None,
            nr_recipients=None,
            nr_groups=None,
            event_notification=False,
            legacy=False
            )
    
        local_db_session.add(memail)
        local_db_session.flush()
        local_db_session.refresh(memail)
    
        '''
        memail_recip = MessageEmailrecipient.query.filter(
            MessageEmailrecipient.email_id==memail.id).filter(
            MessageEmailrecipient.user_id==current_user.id).first()

        if memail_recip:
            memail_recip.recipient_type=3
            memail_recip.group_id=None
            memail_recip.folder_id=2
            memail_recip.read_flag=True
            memail_recip.legacy=False
            memail_recip.gto_recipients=None
            memail_recip.gcc_recipients=None
            memail_recip.gbcc_recipients=None
            memail_recip.visible=True

        else:
        '''
        memail_recip = MessageEmailrecipient( # sender
            email_id=memail.id,
            user_id=current_user.id,
            recipient_type=3,
            group_id=None,
            folder_id=2,
            read_flag=True,
            legacy=False,
            gto_recipients=None,
            gcc_recipients=None,
            gbcc_recipients=None,
            visible=True
            )
    
        local_db_session.add(memail_recip)
    
        role = Role(current_user.id)
        other=None
        other_persona=None
        match_history_other=None
    
        if role.role == MENTEE:
            other = get_latest_mentor_user_for_mentee(current_user.id)
    
            if other:
                other_persona = get_persona_obj_for_user(user_id=other.id,
                    ignore_match_status=True)
    
            if other:
                match_history_other=IuserMatchhistory.query.filter(
                    IuserMatchhistory.mentor_id==other_persona.id).first()
        else:
            other = get_latest_mentee_user_for_mentor(current_user.id)
    
            if other:
                other_persona = get_persona_obj_for_user(user_id=other.id,
                    ignore_match_status=True)
    
            if other:
                match_history_other=IuserMatchhistory.query.filter(
                    IuserMatchhistory.mentee_id==other_persona.id).first()
    
        persona = get_persona_obj_for_user(current_user.id,ignore_match_status=True)
        if not persona:
            print "Skipping user {0}, no persona".format(current_user.id)
            local_db_session.commit()
            continue
    
        partner = None
        partners = get_partners_for_user(current_user,role)
        if partners:
            partner = partners[0]
        if not partners:
            app.logger.exception("update_legacy_dependencies_upon_finish(): Canvas user {0} has no partner sites! Skipping legacy insert. Not crashing.".format(current_user.id))
            return
    
        curr_copy = CurriculumCopy.query.filter(
            CurriculumCopy.id==cscopy.curriculum_id).one()
    
        psc_res = DBSession.query(PartnersSessionCurriculum,PartnersSession).\
            filter(PartnersSessionCurriculum.curr_id==curr_copy.parent_id).\
            filter(PartnersSessionCurriculum.p_session_id==PartnersSession.id).\
            filter(PartnersSession.partner_id==partner.id).one()

        pc_map = psc_res[0]
    
        user_id=other.id if other else current_user.id

        '''
        remail_recip = MessageEmailrecipient.query.filter(
            MessageEmailrecipient.email_id==memail.id).filter(
            MessageEmailrecipient.user_id==user_id).first()

        if remail_recip:
            remail_recip.recipient_type=0
            remail_recip.group_id=None
            remail_recip.folder_id=1
            remail_recip.read_flag=True
            remail_recip.legacy=False
            remail_recip.gto_recipients=None
            remail_recip.gcc_recipients=None
            remail_recip.gbcc_recipients=None
            remail_recip.visible=True

        else:
        '''
        remail_recip = MessageEmailrecipient( # recipient
            email_id=memail.id,
            user_id=user_id,
            recipient_type=0,
            group_id=None,
            folder_id=1,
            read_flag=True,
            legacy=False,
            gto_recipients=None,
            gcc_recipients=None,
            gbcc_recipients=None,
            visible=True
            )
    
        local_db_session.add(remail_recip)

        '''
        relog = ReportingEmaillog.query.filter(
            ReportingEmaillog.sent_date==memail.send_date).filter(
            ReportingEmaillog.email_id==memail.id).filter(
            ReportingEmaillog.sender_id==memail.sender_id).first()
            
        if relog:
            relog.user_type_id=role.role
            relog.partner_name_list=partner.name if partner else None
            relog.recipient_name=other.first_name + ' ' + other.last_name if other else ''
            relog.recipient_url=''
            relog.persona_id=persona.id
            relog.member_id=current_user.member_id

        else:
        '''
        relog = ReportingEmaillog(
            sent_date=memail.send_date,
            sender_id=memail.sender_id,
            user_type_id=role.role,
            partner_name_list=partner.name if partner else None,
            email_id=memail.id,
            recipient_name=other.first_name + ' ' + other.last_name if other else '',
            recipient_url='',
            persona_id=persona.id,
            member_id=current_user.member_id
            )
    
        local_db_session.add(relog)

        if match_history_other:
            '''
            rematch = ReportingAllmatchemail.query.filter(
                ReportingAllmatchemail.email_id==memail.id).filter(
                ReportingAllmatchemail.member_id==current_user.member_id).filter(
                ReportingAllmatchemail.send_date==memail.send_date).filter(
                ReportingAllmatchemail.sess_id==pc_map.p_session_id).first()

            if rematch:
                rematch.match_history_id=match_history_other.id if match_history_other else None
                rematch.partner_id=partner.id
                rematch.mentee_to_mentor = True if role.role==MENTEE else False
                rematch.orig_partner_id=partner.id
                rematch.sess_id=pc_map.p_session_id
            else:
            '''
            rematch = ReportingAllmatchemail(
                email_id=memail.id,
                match_history_id=match_history_other.id if match_history_other else None,
                member_id=current_user.member_id,
                partner_id=partner.id,
                send_date=memail.send_date,
                mentee_to_mentor = True if role.role==MENTEE else False,
                orig_partner_id=partner.id,
                sess_id=pc_map.p_session_id
                )
    
            local_db_session.add(rematch)
    
        '''
            mailermsg = MailerMessage(
                to_address=other.email if other else None,
                when_added=datetime.now(),
                from_address = FROM_EMAIL,
                subject = 'Check out the iMentor Canvas!',
                message_body = 'Hello there! Please sign into the iMentor Platform and navigate to the Canvas to see new content. Thanks as always.',
                priority = 2,
                content_subtype = ''
                )
    
            local_db_session.add(mailermsg)
        '''
    
        app.logger.info("Added legacy email related records for finished canvas set copy {0}, user {1}, legacy email record {2}".format(
            cscopy.id,current_user.id,pprint.pformat(memail.__dict__)))
    
        local_db_session.commit()
    
    
if __name__ == '__main__':
    update_legacy_dependencies_with_new_canvas_set()
    correct_legacy_dependencies_upon_finish()
