#!/bin/env python
# -*- coding: iso8859-15 -*-
import pdb
import pprint
import copy
import traceback
import os,sys
import csv
from datetime import datetime
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'../..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import db,Base,metadata
from config.settings import (ENV_TYPE,LOGIN_DISABLED,
    DEFAULT_TEST_USER_ID)

from sqlalchemy.sql.expression import func, or_, not_, and_
from sqlalchemy.orm import sessionmaker 
from sqlalchemy.orm.exc import NoResultFound, MultipleResultsFound

from auth import app,lauth
from canvas import canvas
app.register_blueprint(canvas) # so templates can be found

from utils.roles import Role
from utils.user_details import get_partners_for_user
from legacy_models.iuser import IuserUser,MENTOR,MENTEE
from canvas.legacy_updates import (update_legacy_dependencies_with_new_canvas_set,
    update_legacy_dependencies_upon_finish)
from canvas.models import CanvasSetCopy


def backfill_legacy():
    for i in CanvasSetCopy.query.all():
        user = IuserUser.query.filter(IuserUser.id==i.user_id).one()
        role = Role(user.id)
        partner = None
        partners = get_partners_for_user(user,role)
        if partners:
            partner = partners[0]

        # Pass in the curriculum copy ID. We use it to get the parent curriculum id.
        update_legacy_dependencies_with_new_canvas_set(i.curriculum_id,
            partner.id,i.start_datetime,i.end_datetime,backfill=True)

        if i.user_completed:
            # pass the canvas set copy id
            update_legacy_dependencies_upon_finish(user,i.id,backfill=True)


if __name__ == "__main__":
    backfill_legacy()
