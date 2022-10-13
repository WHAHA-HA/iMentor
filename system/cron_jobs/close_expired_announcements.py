#!/usr/bin/env python
# -*- coding: iso8859-15 -*-

import sys,os
from datetime import datetime

appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'../../..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from new_platform.config.project_globals import get_scoped_session
from new_platform.tasks.models import Announcement

def close_expired():
    local_db_session = get_scoped_session()
    local_db_session.query(Announcement).filter(
        Announcement.end_date <= datetime.utcnow()).update(
        {'is_active':False})
    local_db_session.commit()


if __name__ == "__main__":
    close_expired()
