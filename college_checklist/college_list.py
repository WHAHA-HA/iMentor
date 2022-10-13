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

from college_checklist import cchklist
from college_checklist.models import UtilsCollege
from legacy_models.iuser import IuserUser


from flask import Response, jsonify, make_response, abort
from flask import  current_app, request, redirect, render_template
from flask.views import View, MethodView
from flask_sqlalchemy import SQLAlchemy
from  sqlalchemy.sql.expression import func, or_, not_, and_
from flask_login import (current_user,
                             login_user, logout_user, UserMixin,
                             confirm_login, fresh_login_required)
from flask_restful import Resource, Api, fields, marshal_with

# import form auth to take advantage of login_required decorator.
from config.settings import (ENV_TYPE,LOGIN_DISABLED,
    DEFAULT_TEST_USER_ID, MAX_COLLEGE_LIST_SIZE, MAX_COLLEGE_LIST_ENTRIES)
from auth import api,app,login_required
from checklist_utils import get_mentee_for_mentor,get_current_selections

FIXED_URL = '/cchklist/fixed'
#SEARCH_URL = '/cchklist/search' we don't search the start of a string anymore.
FULLSEARCH_URL = '/cchklist/fullsearch'

#class CollegeListView(MethodView): use this for non flask-restful services.

class CollegeListView(Resource):
    '''
    This gets a list of colleges for the end user, properly filtered and
    softed based on parameters and endpoints. It does not take any POST
    data.
    '''

    view_fields = {
        'id':   fields.Integer,
        'name':   fields.String,
        'alias':  fields.String
    }
    WHOLE_LIST=0
    MOST_MENTEE_CHOSEN=1
    MOST_MENTOR_CHOSEN=2
    MOST_LIKELY=3

    if ENV_TYPE != "Production":
        def options(self,subset=WHOLE_LIST):
            resp = Response('', status=200, mimetype='application/json')
            return resp


    @login_required
    @marshal_with(view_fields)
    def get(self,subset=WHOLE_LIST):

        from flask_login import current_user
        if LOGIN_DISABLED:
            current_user = DBSession.query(IuserUser).filter(
                IuserUser.id==DEFAULT_TEST_USER_ID).one()

        '''
        This will throw a 404 if there is no mentee for the
        logged in mentor.
        '''
        act_on_user = get_mentee_for_mentor(current_user)

        '''
        Get user's current selections so we can eliminate these
        from the list we're about to pass back.

        We also want to limit them to MAX_COLLEGE_LIST_ENTRIES
        records.
        '''
        selected_ids = [x.college_id for x in get_current_selections(act_on_user)]
        if len(selected_ids) >= MAX_COLLEGE_LIST_ENTRIES:
            return {}

        print("request: {0}".format(pprint.pformat(request.__dict__)))
        outdict = {}
        string_search = False

        if subset == self.WHOLE_LIST:
            clist = DBSession.query(UtilsCollege).order_by('name')
        elif subset == self.MOST_MENTEE_CHOSEN: 
            clist = DBSession.query(UtilsCollege).order_by('name')
        elif subset == self.MOST_MENTOR_CHOSEN: 
            clist = DBSession.query(UtilsCollege).order_by('name')
        elif subset == self.MOST_LIKELY: 
            clist = DBSession.query(UtilsCollege).filter(or_(
                UtilsCollege.name.ilike('%cuny%'),
                UtilsCollege.name.ilike('%suny%')
                )).order_by('name')

        else: # string searches: anywhere in full string.

            string_search = True
            subset = subset.strip().lower()

            '''
            Get the union of name and alias text search
            Aliases are "|" separated. Append name to alias and
            search anywhere in the entire string.
            '''
            clist = DBSession.query(UtilsCollege).filter(
                or_(
                    UtilsCollege.alias.ilike( u'%{0}%'.format(subset) ),
                    UtilsCollege.name.ilike( u'%{0}%'.format(subset) )
                    )
                ).order_by('name')

        if selected_ids:
            clist = clist.filter(UtilsCollege.id.notin_(selected_ids))

        clist = clist.all()
            
        for c in clist:
            if c.alias not in ('',None):
                c.alias = c.alias.strip().lower() + '|' + c.name.strip().lower()
            else:
                c.alias = c.name.strip().lower()

            if string_search:
                if subset in c.alias:
                    outdict[c.alias] = copy.deepcopy(c)

            else:
                outdict[c.alias] = copy.deepcopy(c)
    
        if len(outdict.keys()) > MAX_COLLEGE_LIST_SIZE:
            return [y for x,y in sorted(outdict.items())][:MAX_COLLEGE_LIST_SIZE]

        return [y for x,y in sorted(outdict.items())]


# This is ignoring the Blueprint app prefix.
api.add_resource(CollegeListView, '{0}/<int:subset>/'.format(FIXED_URL),
    endpoint='fixed_subset')
api.add_resource(CollegeListView, '{0}/<string:subset>/'.format(FULLSEARCH_URL),
    endpoint='fullsearch_subset')


# College checklist landing pages.
@app.route('/cchklist/list/')
def cc_page_1():
    return render_template('cchklist/page_1.html')
    
@app.route('/cchklist/progress/')
def cc_page_2():
    return render_template('cchklist/page_2.html')
    
