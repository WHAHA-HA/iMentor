# -*- coding: iso8859-15 -*-
import time
from multiprocessing import Process
import subprocess
import os,sys
import pprint
import logging
import datetime
import re
import csv
from pytz import timezone
from sqlalchemy import and_,or_,desc
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'../..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import get_scoped_session,Base,metadata,DBSession,DOGPILE_CACHE_REGION
from config.settings import SUPERUSER_ANNOUNCER_ID
from utils.roles import Role

from utils.user_details import get_partners_for_user
from legacy_models.iuser import (IuserPersonaPartner,IuserPersona,IuserUsertype,
    IuserAssignedusertype,IuserUser,ACTIVE_PERSONA_STATUS)
from legacy_models.member import MemberMember
from legacy_models.iuser import IuserMatchhistory
from canvas.models import (CurriculumCopy,CanvasSetCopy,
    CanvasAppCopy,WidgetCopy,WidgetContentCopy,WidgetContentResponseMarkerCopy,
    WidgetContentMarkerReferenceCopy,WidgetContentUserResponse,WidgetContentUserResponseHistory,
    FlaggedLesson)

from add_match_utils import add_match_user_id_from_response

class MultiprocessMgmt():
    def __init__(self,function,data_set,max_processes):
        self.function = function
        self.data_set = data_set
        self.max_processes = max_processes
        self.jobs = []

    def run(self):
        while self.data_set or self.jobs: 
            for s in self.jobs:
                if not s.is_alive():
                    self.jobs.remove(s)
                    print "removed a job, total jobs = %d" % len(self.jobs)
                    #else:
                    #print "Job %s is still alive..." % s
    
            while (len(self.jobs) < self.max_processes) and self.data_set:
                self.jobs.append(Process(target=self.function, args=([self.data_set.pop(0)]),))
                self.jobs[-1].start()
                print "added a job, total jobs = %d" % len(self.jobs)

            time.sleep(5)
        #print "exiting loop..."

if __name__ == "__main__":
    local_db_session = get_scoped_session()
    responses = local_db_session.query(WidgetContentUserResponse).filter(
        WidgetContentUserResponse.matched_user_id == None).order_by(desc(WidgetContentUserResponse.id)).all()

    for response in responses:
        print "doing response {2} for user {0} perosna {1}".format(response.user_id,response.persona_id,response.id)
        history = local_db_session.query(WidgetContentUserResponseHistory).filter(
            WidgetContentUserResponseHistory.new_response_id==response.id).first()
        if not history:
            msg = "Response {1} for persona {0} has no history date, skipping response.".format(
                response.persona_id,response.id)
            print msg
            continue

        use_date = history.added_datetime

        intervals = [x for x in local_db_session.query(IuserMatchhistory).\
            filter(or_(IuserMatchhistory.mentor_id==response.persona_id,IuserMatchhistory.mentee_id==response.persona_id)).\
            filter(or_(
                and_(IuserMatchhistory.start <= use_date,IuserMatchhistory.end >= use_date),
                and_(IuserMatchhistory.start <= use_date,IuserMatchhistory.end.is_(None))
                )).all()]

        if len(intervals) > 1:
            msg = "Persona {0} has more than one match in match history for date intervals including this date: {1}, skipping this persona.".format(
                response.persona_id,response.response_datetime)
            print msg
            continue

        if len(intervals) < 1:
            add_match_user_id_from_response(local_db_session,response.user_id,response.persona_id,None,None,response,history)
            continue

        interval = intervals[0]
        if response.persona_id == interval.mentee_id:
            match_persona = local_db_session.query(IuserPersona).filter(
                IuserPersona.id == interval.mentor_id).one()
        else:
            match_persona = local_db_session.query(IuserPersona).filter(
                IuserPersona.id == interval.mentee_id).one()

        add_match_user_id_from_response(local_db_session,response.user_id,response.persona_id,match_persona.user_id,match_persona.id,response,history)
        local_db_session.commit()
        local_db_session.begin()

    #m = MultiprocessMgmt(add_match_user_id_from_response,personas,6)
    #m.run()

    local_db_session.commit()
