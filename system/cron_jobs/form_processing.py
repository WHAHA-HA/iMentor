#!/usr/bin/env python
# -*- coding: iso8859-15 -*-

import sys,os


appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'../../..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from new_platform.apiforms.form_proc_and_notify import FormDataProcessing
FormDataProcessing().popQ()
