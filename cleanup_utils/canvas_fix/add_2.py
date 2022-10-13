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

from add_match_utils import add_match_user_id_from_lesson


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
    lessons = local_db_session.query(CanvasSetCopy).filter(
        CanvasSetCopy.matched_user_id == None).order_by(desc(CanvasSetCopy.start_datetime)).all()

    for lesson in lessons:
        print "doing lesson {2} for user {0} perosna {1}".format(lesson.user_id,lesson.persona_id,lesson.id)

        intervals = [x for x in local_db_session.query(IuserMatchhistory).\
            filter(or_(IuserMatchhistory.mentor_id==lesson.persona_id,IuserMatchhistory.mentee_id==lesson.persona_id)).\
            filter(or_(
                and_(IuserMatchhistory.start <= lesson.start_datetime,IuserMatchhistory.end >= lesson.start_datetime),
                and_(IuserMatchhistory.start <= lesson.start_datetime,IuserMatchhistory.end == None),
                and_(IuserMatchhistory.start <= lesson.end_datetime,IuserMatchhistory.end >= lesson.end_datetime),
                and_(IuserMatchhistory.start <= lesson.end_datetime,IuserMatchhistory.end == None)

                )).all()]

        if len(intervals) > 1:
            msg = "Persona {0} has more than one match in match history for date intervals including this date: {1}, skipping this persona.".format(
                lesson.persona_id,lesson.start_datetime)
            print msg
            continue

        if len(intervals) < 1:
            add_match_user_id_from_lesson(local_db_session,lesson.user_id,lesson.persona_id,None,None,lesson)
            continue

        interval = intervals[0]
        if lesson.persona_id == interval.mentee_id:
            match_persona = local_db_session.query(IuserPersona).filter(
                IuserPersona.id == interval.mentor_id).one()
        else:
            match_persona = local_db_session.query(IuserPersona).filter(
                IuserPersona.id == interval.mentee_id).one()

        add_match_user_id_from_lesson(local_db_session,lesson.user_id,lesson.persona_id,match_persona.user_id,match_persona.id,lesson)
        local_db_session.commit()
        local_db_session.begin()

    #m = MultiprocessMgmt(add_match_user_id_from_lesson,personas,6)
    #m.run()

    local_db_session.commit()
