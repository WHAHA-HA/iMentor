#!/usr/bin/env python
# -*- coding: iso8859-15 -*-

import sys,os

appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'../..'))
projdir2 = os.path.abspath(os.path.join(appdir,'../../..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)
    sys.path.append(projdir2)

from config.project_globals import (Base,metadata,
    get_scoped_session,DBSession)

local_db_session = get_scoped_session()
from new_platform.apiforms.form_proc_and_notify import FormDataProcessing
FormDataProcessing().preprocess_form(local_db_session)
local_db_session.commit()
