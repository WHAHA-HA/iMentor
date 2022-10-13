#!/usr/bin/env python
# -*- coding: iso8859-15 -*-
import copy
from datetime import datetime
import traceback
import httplib
import json
import math
import pdb
import pprint
import requests
import traceback
import time
import os,sys

appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'../..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

import esearch.canvas_entries
import esearch.portfolio_entries
import esearch.conversation_entries
esearch.canvas_entries.pop_queue_add_del()
esearch.portfolio_entries.pop_queue_add_del()
esearch.conversation_entries.pop_queue_add_del()
