#!/usr/bin/env python
# -*- coding: iso8859-15 -*-
import os,sys
import pprint
import logging
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from utils.roles import Role
from legacy_models.iuser import USERTYPE_MAP

if __name__ == "__main__":
    x=Role(email=sys.argv[1])
    pprint.pprint(USERTYPE_MAP[x.role])
    #pprint.pprint(x.persona.__dict__)
    #pprint.pprint(x.user.__dict__)
    #pprint.pprint(x.site.__dict__)
