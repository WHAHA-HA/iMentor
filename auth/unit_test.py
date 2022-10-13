#!/usr/bin/env python
# Log into Django. test Flask login. Log out.
import copy
import os,sys
from flask import request
from flask_login import current_user

appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
sys.path.append(appdir)
sys.path.append(projdir)

from iuser import login,logout,authenticate # from imi/imentor

from auth import app, login_required

if __name__ == "__main__":

    app.config['TESTING']=True
    with app.test_request_context('/'):
        @login_required
        def logged_into_flask_ia_django(request):
            print "Yes! User is logged in: {0}".format(request.user)

        import pdb
        pdb.set_trace()
        '''
        Redo this without django dependencies

        djrequest = RequestFactory()
        djrequest.session = {}
        djrequest.user = authenticate("mentor@imentor.org","test123")
        current_user = djrequest.user
        login(djrequest,djrequest.user)
        for k,v in djrequest.session.items():
            request.cookies = {k:k}
            break
        logged_into_flask_ia_django(djrequest)
        '''
