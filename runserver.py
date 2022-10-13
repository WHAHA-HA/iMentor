#!/usr/bin/env python
# -*- coding: iso8859-15 -*-
import pdb
import os,sys
from gevent.pywsgi import WSGIServer

appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import Base,metadata,engine
from config.settings import FLASK_HOST,FLASK_PORT, ENV_TYPE,CHAOS_KITTEN
from config.signals import add_signals

from auth import app,lauth,legal_static_pages
# Below, cchklist,forms,canvas, etc are app names
from apiforms import forms, user_web_services, data_services
from canvas import canvas, canvas_objs, canvas_presentation
from snapshot import snapshot,snapshot_objs
from college_checklist import cchklist,checklist,college_list
from conversations import conv,conversation_api
from enrollment import enrollment,enrollment_objs
from file_upload import file_upload,upload
from flipbook import flipbook,flipbook_objs
from generic import generic, generic_api
from lesson_management import lesson_mgmt,lesson_mgmt_objs
from mentor_rubric import mentor_rubric, mentor_rubric_objs
from attendance import attendance, attendance_objs
from menu import menu,menu_objs
from portfolio import portfolio,portfolio_objs
from qualtrics import qualtrics, qualtrics_objs
from salesforce import salesforce,salesforce_objs
from sms_notifications import sms_notifications,sms_inbound
from tableau_reports import tableau_reports,tableau_objs
from tasks import tasks,tasks_objs
from mobile_notifications import mobile_nots,mobile_notifications_api
if ENV_TYPE != "Production" and CHAOS_KITTEN:
    #from chaos_kitten.bad_canvas import bad_canvas, bad_canvas_objs, bad_canvas_presentation
    #from chaos_kitten.bad_lesson_management import bad_lesson_mgmt, bad_lesson_mgmt_objs
    pass


add_signals(app)

app.register_blueprint(canvas)
app.register_blueprint(cchklist)
app.register_blueprint(snapshot)
app.register_blueprint(enrollment)
app.register_blueprint(file_upload)
app.register_blueprint(flipbook)
app.register_blueprint(forms)
app.register_blueprint(lauth)
app.register_blueprint(lesson_mgmt)
app.register_blueprint(mentor_rubric)
app.register_blueprint(attendance)
app.register_blueprint(menu)
app.register_blueprint(portfolio)
app.register_blueprint(qualtrics)
app.register_blueprint(salesforce)
app.register_blueprint(sms_notifications)
app.register_blueprint(tableau_reports)
app.register_blueprint(tasks)
app.register_blueprint(mobile_nots)
if ENV_TYPE != "Production" and CHAOS_KITTEN:
    #app.register_blueprint(bad_canvas)
    #app.register_blueprint(bad_lesson_mgmt)
    pass

if __name__ == "__main__":
    #app.run(host=FLASK_HOST, port=FLASK_PORT)
    WSGIServer((FLASK_HOST, FLASK_PORT), app).serve_forever()

