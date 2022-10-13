# -*- coding: iso8859-15 -*-
import pdb
import psycopg2
import pprint
import copy
import os,sys
import csv
from datetime import datetime
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import get_scoped_session,Base,metadata,DBSession
from config.settings import (ENV_TYPE,LOGIN_DISABLED,
    DEFAULT_TEST_USER_ID,SUPERUSER_ANNOUNCER_ID)

import sqlalchemy
from sqlalchemy import desc
from sqlalchemy.sql.expression import func, or_, not_, and_
from sqlalchemy.orm import sessionmaker 
from sqlalchemy.orm.exc import NoResultFound, MultipleResultsFound

#Import 'app' object from auth as well
from auth import api, app, login_required

from new_platform.utils.roles import Role
from new_platform.utils import user_details
from conversations.models import Conversation,ConversationAutoSave
from legacy_models.iuser import IuserUser,IuserPersona
from legacy_models.partners import PartnersPartner
from utils.authz import check_authz
from utils.strip_html import strip_tags
from models import (SafetyWordContact,SafetyWordSource,SafetyPhrase,
    ALERT_FREQUENCY_HOURLY,ALERT_FREQUENCY_DAILY)

def load_csv():
    local_db_session = get_scoped_session()

    # list_name,keyword,alert_frequency,member_site_id,partner_site_id,alert_recipient,notes
    with open('./Safety Alerts.csv', 'rU') as f:
        reader = csv.DictReader(f)
        for row in reader:
            recips = row['alert_recipient']
            source = DBSession.query(SafetyWordSource).filter(
                SafetyWordSource.name==row['list_name']).first()
            if not source:
                source = SafetyWordSource(name=row['list_name'])
                local_db_session.add(source) 
                local_db_session.commit() 
                local_db_session.begin()

            alert_users = None
            if recips not in (None,''):
                alert_users = DBSession.query(SafetyWordContact
                    ).filter(SafetyWordContact.alert_recipient_user_id==None
                    ).filter(SafetyWordContact.additional_recipient_emails==recips
                    ).first()
                if not alert_users:
                    alert_users = SafetyWordContact(
                        alert_recipient_user_id=None,
                        additional_recipient_emails=recips
                        )
                    local_db_session.add(alert_users)
                    local_db_session.commit() 
                    local_db_session.begin()

            word_phrase = SafetyPhrase(
                word_or_phrase = row['keyword'].lower(),
                word_source_id = source.id,
                alert_frequency = ALERT_FREQUENCY_DAILY if row['alert_frequency'] == 'daily' \
                    else ALERT_FREQUENCY_HOURLY,
                member_site_id = None if row['member_site_id'] == 'all' else int(row['member_site_id']),
                partner_site_id = None if row['partner_site_id'] == 'all' else int(row['partner_site_id']),
                alert_user_info_id = None if not alert_users else alert_users.id
                )
            pprint.pprint(row)
            print word_phrase.word_or_phrase,word_phrase.alert_frequency
            local_db_session.add(word_phrase) 
            try:
                local_db_session.commit()
                local_db_session.begin()
            except sqlalchemy.exc.IntegrityError as e:
                if 'duplicate' in str(e.orig):
                    local_db_session.rollback() 
                    local_db_session.begin()
                    continue
                raise

    local_db_session.commit()


if __name__ == '__main__':
    load_csv()
