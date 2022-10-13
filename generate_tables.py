#!/usr/bin/env python
# -*- coding: iso8859-15 -*-
import os,sys
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import db,Base,metadata,engine
from config.settings import FLASK_HOST,FLASK_PORT

from auth import app,lauth
from qualtrics import qualtricsapi
from college_checklist import cchklist,college_list,college_picks
from forms import forms #, form_objs

if __name__ == "__main__":
    '''
    The sole purpose of this is to generate Postgresql tables for new objs.
    It will spew SQL, which must be captured and injected manually, to create
    the tables.
    '''
    from sqlalchemy.schema import CreateTable
    from forms.models import *

    print CreateTable(Form.__table__).compile(engine)
    print CreateTable(FormMemberSite.__table__).compile(engine)
    print CreateTable(FormRole.__table__).compile(engine)
    print CreateTable(Section.__table__).compile(engine)
    print CreateTable(SectionMemberSite.__table__).compile(engine)
    print CreateTable(SectionRole.__table__).compile(engine)
    print CreateTable(QuestionMemberSite.__table__).compile(engine)
    print CreateTable(QuestionRole.__table__).compile(engine)
    print CreateTable(Question.__table__).compile(engine)
    print CreateTable(AnswerMemberSite.__table__).compile(engine)
    print CreateTable(AnswerRole.__table__).compile(engine)
    print CreateTable(Answer.__table__).compile(engine)
    print CreateTable(FormUser.__table__).compile(engine)
    print CreateTable(FormRoleUser.__table__).compile(engine)
    print CreateTable(SectionUser.__table__).compile(engine)
    print CreateTable(SectionRoleUser.__table__).compile(engine)
    print CreateTable(QuestionRoleUser.__table__).compile(engine)
    print CreateTable(QuestionUser.__table__).compile(engine)
    print CreateTable(AnswerRoleUser.__table__).compile(engine)
    print CreateTable(AnswerUser.__table__).compile(engine)
    print CreateTable(UserResponse.__table__).compile(engine)
