# -*- coding: iso8859-15 -*-
import pdb
import pprint
import copy
import os,sys
from datetime import datetime
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import db,Base,metadata
from config.settings import (ENV_TYPE,LOGIN_DISABLED,
    DEFAULT_TEST_USER_ID)

from sqlalchemy.sql.expression import func, or_, not_, and_
from sqlalchemy.orm import sessionmaker 
from sqlalchemy.orm.exc import NoResultFound, MultipleResultsFound

#Import 'app' object from auth as well
from auth import api, app

from generic import generic # app name

from legacy_models.iuser import (IuserUser,MemberMember,USERTYPE_MAP,MENTOR,MENTEE,
    GENDER_CHOICES,MATCH_CHOICES,USER_STATUS_MAP)
from enrollment.models import SCHOOL_ATTENDANCE_VALUES,PROGRAM_READINESS_VALUES
from qualtrics.models import QUALTRICS_STATUS_MAP,QualtricsSurvey
from new_platform.utils.roles import Role
from new_platform.utils import user_details

def generic_user_info(current_user):
    # Only get user info for yourself or your mentee,
    # unless you're of a higher role.
    role_obj = Role(current_user.id)
    persona = user_details.get_persona_obj_for_user(current_user.id,
        ignore_match_status=True)

    if role_obj.is_mentor:
        mentee = user_details.get_latest_mentee_user_for_mentor(current_user.id)

        if not mentee:
            mentee_obj = {}
        else:
            mentee_obj = {'user_id': mentee.id,'role':USERTYPE_MAP[MENTEE],
                    'photo':'/media/' + mentee.photo,
                    'persona_id':user_details.get_persona_obj_for_user(mentee.id,
                        ignore_match_status=True).id,
                    'member_id':mentee.member_id,
                    'f_name':mentee.first_name,
                    'l_name':mentee.last_name}

        return {
            'self':{'user_id': current_user.id,'role':USERTYPE_MAP[role_obj.role],
                    'photo':'/media/' + current_user.photo,
                    'persona_id':persona.id,
                    'member_id':current_user.member_id,
                    'status':current_user.status,
                    'match_status':persona.match_status,
                    'f_name':current_user.first_name,
                    'l_name':current_user.last_name},
            'mentee':mentee_obj
            }

    elif role_obj.is_mentee:
        mentor = user_details.get_latest_mentor_user_for_mentee(current_user.id)

        if not mentor:
            mentor_obj = {}
        else:
            mentor_obj = {'user_id': mentor.id,'role':USERTYPE_MAP[MENTOR],
                    'photo':'/media/' + mentor.photo,
                    'persona_id':user_details.get_persona_obj_for_user(mentor.id,
                        ignore_match_status=True).id,
                    'member_id':mentor.member_id,
                    'f_name':mentor.first_name,
                    'l_name':mentor.last_name}

        return {
            'self':{'user_id': current_user.id,'role':USERTYPE_MAP[role_obj.role],
                    'photo':'/media/' + current_user.photo,
                    'persona_id':persona.id,
                    'member_id':current_user.member_id,
                    'status':current_user.status,
                    'match_status':persona.match_status,
                    'f_name':current_user.first_name,
                    'l_name':current_user.last_name},
            'mentor':mentor_obj
            }

    elif role_obj.is_some_admin:
        return {
            'self':{'user_id': current_user.id,'role':USERTYPE_MAP[role_obj.role],
                    'photo':'/media/' + current_user.photo,
                    'persona_id':persona.id,
                    'member_id':current_user.member_id,
                    'status':current_user.status,
                    'match_status':persona.match_status,
                    'f_name':current_user.first_name,
                    'l_name':current_user.last_name},
            'mentor':{},
            'mentee':{}
            }
    else:
            return {}


