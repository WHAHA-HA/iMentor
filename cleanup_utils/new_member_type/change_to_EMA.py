# -*- coding: iso8859-15 -*-
import os,sys
import pprint
import logging
import datetime
import re
import csv
from pytz import timezone
from sqlalchemy import and_,exc
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'../..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import get_scoped_session,Base,metadata,DBSession,DOGPILE_CACHE_REGION
from utils.roles import Role

from utils.user_details import get_partners_for_user
from legacy_models.iuser import (IuserPersonaPartner,IuserPersona,IuserUsertype,
    IuserAssignedusertype,IuserUser,ACTIVE_PERSONA_STATUS)
from legacy_models.member import MemberMember
from legacy_models.permissions import PermissionsAssignedpermission

user_ids = [
    183441,
    183563,
    170205,
    185265,
    186160,
    161693,
    174698,
    186161,
    184874,
    183439,
    162761,
    184137,
    160463,
    160435,
    162784,
    184139,
    150221,
    168357,
    171951,
    169999,
    184875,
    141402,
    184230,
    162337,
    183562,
    170942,
    162343,
    162340,
    184550,
    185623,
    163137,
    160462,
    174083,
    173670,
    162181,
    184876,
    172578,
    184872,
    167371,
    149426,
    189862,
    160408,
    186182,
    147239,
    170002,
    184797,
    170206,
    162334,
    180922,
    183954,
    172167,
    167815,
    162336,
    185395,
    153866,
    189667,
    189668,
    121209,
    184844,
    184640,
    183976,
    172076,
    170305,
    106384,
    184355,
    133314,
    189424,
    140742,
    184845,
    174877,
    184641,
    184642,
    163088,
    148667,
    184846,
    171307,
    140139,
    184767,
    184766,
    184765,
    184772,
    184771,
    184773,
    186030,
    139267,
    171328,
    115005,
    181070,
    132857,
    125226,
    182858,
    169229,
    169538,
    189344,
    143241,
    184909,
    186621,
    187735,
    173414,
    149539,
    167909,
    153868,
    132628,
    189410,
    184275,
    164122,
    173415,
    186925,
    164021,
    186926,
    184647,
    189129,
    168471,
    158311,
    186380,
    187736,
    160251,
    148668,
    113418,
    183013,
    3313,
    169259,
    184776,
    184775,
    132853,
    184774,
    185254,
    185253,
    185252,
    185776,
    120499,
    143247,
    160253,
    185083,
    186028,
    163320,
    184768,
    184770,
    184769,
    138991,
    159349,
    159239,
    186029,
    144536,
    184645,
    184646,
    172079,
    106385,
    180085,
    170187,
    132851,
    ]

def change_to_ema():
    local_db_session = get_scoped_session()
    for user_id in user_ids:
        print "Doing {0}".format(user_id)
        result = local_db_session.query(IuserUser,IuserPersona,MemberMember,IuserAssignedusertype,IuserUsertype).\
            filter(IuserUser.id==user_id).\
            filter(IuserAssignedusertype.id==IuserPersona.assigned_usertype_id).\
            filter(IuserUsertype.id==IuserAssignedusertype.usertype_id).\
            join(IuserPersona,IuserPersona.user_id==IuserUser.id).\
            outerjoin(MemberMember, MemberMember.id==IuserUser.member_id).\
            order_by(IuserPersona.id.desc()).\
            limit(1)[0]

        ema_for_this_member = local_db_session.query(IuserAssignedusertype).filter(
            IuserAssignedusertype.member_id==result[0].member_id).filter(
            IuserAssignedusertype.usertype_id==7).one()

        local_db_session.query(IuserPersona).filter(
            IuserPersona.id==result[1].id).update({
            'assigned_usertype_id':ema_for_this_member.id})

    local_db_session.commit()
            
def check_emas():
    for user_id in user_ids:
        print "User {0}, role {1}".format(user_id, Role(user_id).role)
        


if  __name__ == '__main__':
    change_to_ema()
    check_emas()
