from __future__ import with_statement
from sqlalchemy import engine_from_config, pool
from logging.config import fileConfig

import os,sys
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from flask_sqlalchemy import SQLAlchemy
from flask import Flask
from flask_triangle import Triangle

from config.project_globals import db,Base,metadata,engine

from legacy_models import *
from qualtrics import *

import alembic

metadata.reflect(engine)


