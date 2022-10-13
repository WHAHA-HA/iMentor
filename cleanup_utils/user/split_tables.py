# -*- coding: iso8859-15 -*-
import os,sys
import pprint
import logging
import datetime
import re
import csv
from pytz import timezone
from sqlalchemy import and_
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'../..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import db,Base,metadata,DBSession,DOGPILE_CACHE_REGION
from legacy_models.iuser import IuserUser
from legacy_models.partners import PartnersAttributes,PartnersPartner
from legacy_models.member import MemberSchool
from utils.roles import Role
from apiforms.models import *


def split_table():
    for attrib in PartnersAttributes.query.all():
        # Should be a full year.
        if attrib.pclass and attrib.pclass < 2000:
            attrib.pclass += 2000

        print "Doing record {0}".format(attrib.id)
        mattr = MemberSchool.query.filter(and_(
            MemberSchool.school==attrib.school,
            MemberSchool.graduating_class==attrib.pclass,
            MemberSchool.member_id==attrib.member_id
            )).first()
        if not mattr and attrib.school and attrib.pclass:
            mattr = MemberSchool(
                school=attrib.school,
                graduating_class=attrib.pclass,
                member_id=attrib.member_id,
                )
            db.session.add(mattr)
            db.session.commit()
            db.session.refresh(mattr)

        pp = PartnersPartner.query.filter(PartnersPartner.id==attrib.partner_id).one()
        pp.graduating_class_id = mattr.id if mattr else None
        pp.program_name = attrib.program_name
        pp.program_length = attrib.program_length
        pp.program_start_date = timezone('America/New_York').localize(attrib.program_start_date) \
            if attrib.program_start_date else None


        # Do not run this more than once, ever.
        for q in QuestionCopy.query.filter(
            QuestionCopy.question_type==QUESTION_DROPDOWN_SCHOOLS).all():
            for u in UserResponse.query.filter(UserResponse.question_id==q.id
                ).filter(UserResponse.selected_id==attrib.id).all():
                print "Replacing User response selected id {0} with {1} in record {2}".format(u.selected_id,pp.id,u.id)
                u.selected_id  = pp.id
                db.session.commit()


    partner_ids = [x.id for x in PartnersPartner.query.all()]
    for q in QuestionCopy.query.filter(
        QuestionCopy.question_type==QUESTION_DROPDOWN_SCHOOLS).all():
        print "Here..."
        for u in UserResponse.query.filter(UserResponse.question_id==q.id
            ).filter(UserResponse.selected_id.notin_(partner_ids)).all():
            print "Found this: {0}".format(pprint.pformat(u))

       

        db.session.commit()

if  __name__ == '__main__':
    split_table()
