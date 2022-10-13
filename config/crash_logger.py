# -*- coding: iso8859-15 -*-
import os,sys
import json
import traceback
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

import logging
from logging.handlers import SMTPHandler, RotatingFileHandler
from retrying import retry
from config.settings import ENV_TYPE,HOSTNAME

formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s' + \
        ' - %(message)s')


def log_handler(app):
    from config.settings import LOG_FILENAME, MAX_BYTES, BACKUP_COUNT

    file_handler = RotatingFileHandler(LOG_FILENAME, \
        maxBytes=MAX_BYTES, backupCount=BACKUP_COUNT)

    file_handler.setLevel(logging.WARNING)
    file_handler.setFormatter(formatter)
    app.logger.addHandler(file_handler)

def crash_mailer(app,env_type,hostname):
    # emails only get sent out when app.debug is false 
    # in dev/local setup, this setting is toggled in runserver by ENV_TYPE 
    #print("in crash mailer")
    from config.settings import (EMAIL_USE_TLS, EMAIL_HOST, EMAIL_HOST_USER, \
            EMAIL_HOST_PASSWORD, EMAIL_PORT, FROM_EMAIL, ADMINS)

    mail_handler = SMTPHandler(EMAIL_HOST, FROM_EMAIL, ADMINS,
        'ENV: {0}, {1}: API Code Exception Occurred'.format(env_type,hostname),
        credentials=(EMAIL_HOST_USER,EMAIL_HOST_PASSWORD),
        secure = () if EMAIL_USE_TLS else None)

    mail_handler.setLevel(logging.ERROR)
    mail_handler.setFormatter(formatter)
    app.logger.addHandler(mail_handler)
