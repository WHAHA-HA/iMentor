# -*- coding: iso8859-15 -*-
import os,sys
import pprint
import logging
import datetime
import re
import csv
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'../..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import db,Base,metadata,DBSession,DOGPILE_CACHE_REGION
from legacy_models.iuser import IuserUser,IuserCareer,IuserCareer
from legacy_models.utils import UtilsCareer,UtilsOccupation
from legacy_models.calendars import CalendarsEventtype
from legacy_models.curriculum import CurriculumPrompt

from apiforms.models import *
from legacy_models.iuser import *
from utils.user_details import get_persona_for_user

def fix_dates():
    import pdb
    pdb.set_trace()
    new_users = FormCopy.query.all()
    for i in new_users:
        persona_id = get_persona_for_user(
            i.user_id,ignore_match_status=True)[1].id

        if i.persona_id != persona_id:
            print "Ow!!! Persona ID in form: {0} doesn't match found persona id: {1} for user {2}".format(i.persona_id,persona_id,i.user_id)

        persona_obj = IuserPersona.query.filter(IuserPersona.id==persona_id)
        persona = persona_obj.one()

        if (datetime.datetime.now() - persona.intake_last_updated.replace(tzinfo=None)).days > 365:
            persona_obj.update({'intake_last_updated':datetime.datetime.now()})
            print "Updating user {0} persona date.".format(i.user_id)
        else:
            print "{0} persona date is fine: {1}.".format(i.user_id,persona.intake_last_updated)

    db.session.commit()

    new_users = FormCopy.query.filter(
        FormCopy.form_was_completed == True).all()

    for i in new_users:
        user = IuserUser.query.filter(IuserUser.id==i.user_id).one()
        if not user.application_submit_date:
            IuserUser.query.filter(IuserUser.id==i.user_id).update(
                {'application_submit_date':i.form_was_completed_datetime})
        else:
            print "User app submit date is fine: {0} {1}".format(
                i.user_id,user.application_submit_date)

        if i.started_datetime > i.form_was_completed_datetime:
            FormCopy.query.filter(FormCopy.id==i.id).update(
                {'started_datetime':i.form_was_completed_datetime})
        else:
            print "Started date is fine: {0} {1}".format(
                i.user_id,i.started_datetime)
        
    db.session.commit()

if __name__ == "__main__":        
    fix_dates()
