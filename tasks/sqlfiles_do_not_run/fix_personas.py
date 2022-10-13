# -*- coding: iso8859-15 -*-
import os,sys
import re
import pdb
import pprint
import traceback
from datetime import datetime
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'../..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import DBSession,get_scoped_session

#Import 'app' object from auth as well
from auth import api, app

from tasks.models import Rating

local_session = get_scoped_session()

for r in DBSession.query(Rating).all():
    print "Doing {0}".format(r.id)
    local_session.query(Rating).filter(Rating.id==r.id).update(
        {'mentee_persona_id':r.mentor_persona_id,
        'mentor_persona_id':r.mentee_persona_id})
local_session.commit()

