# -*- coding: iso8859-15 -*-
import pprint
import copy
import os,sys
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import db,Base,metadata,DBSession


from flask import Response, jsonify, make_response
from flask import  current_app, request, redirect, render_template
from flask.views import View, MethodView
from flask_sqlalchemy import SQLAlchemy
from  sqlalchemy.sql.expression import func, or_, not_, and_
from flask_login import (current_user,
                             login_user, logout_user, UserMixin,
                             confirm_login, fresh_login_required)
from flask_restful import Resource, Api, fields, marshal_with, reqparse

from auth import api, login_required

CHOICE = '/some/endpoint'

class SampleClass(Resource):

    pass
    #@login_required
    #@marshal_with(some_fields)
    #def get(self,some_parameter):
    #    return SomeAlchemyObj.query.filter(SomeAlchemyObj.user_id==user_id).all()


# This is ignoring the Blueprint app prefix.
#api.add_resource(SampleClass, '{0}/<int:user_id>'.format(CHOICE),
#    endpoint='some_endpoint')

