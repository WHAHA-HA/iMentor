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

# this is the Alembic Config object, which provides
# access to the values within the .ini file in use.
lconfig = alembic.context.config

# Interpret the config file for Python logging.
# This line sets up loggers basically.
fileConfig(lconfig.config_file_name)

# add your model's MetaData object here
# for 'autogenerate' support
# from myapp import mymodel
# target_metadata = mymodel.Base.metadata
target_metadata = metadata

# other values from the config, defined by the needs of env.py,
# can be acquired:
# my_important_option = config.get_main_option("my_important_option")
# ... etc.


def run_migrations_offline():
    """Run migrations in 'offline' mode.

    This configures the context with just a URL
    and not an Engine, though an Engine is acceptable
    here as well.  By skipping the Engine creation
    we don't even need a DBAPI to be available.

    Calls to context.execute() here emit the given string to the
    script output.

    """
    #url = lconfig.get_main_option("sqlalchemy.url")
    alembic.context.configure(target_metadata=metadata)

    with alembic.context.begin_transaction():
        alembic.context.run_migrations()


def run_migrations_online():
    """Run migrations in 'online' mode.

    In this scenario we need to create an Engine
    and associate a connection with the context.

    """
    engine = engine_from_config(
        lconfig.get_section(lconfig.config_ini_section),
        prefix='sqlalchemy.',
        poolclass=pool.NullPool)

    connection = engine.connect()
    alembic.context.configure(
        connection=connection,
        target_metadata=target_metadata
    )

    try:
        with alembic.context.begin_transaction():
            alembic.context.run_migrations()
    finally:
        connection.close()

if alembic.context.is_offline_mode():
    run_migrations_offline()
else:
    run_migrations_online()
