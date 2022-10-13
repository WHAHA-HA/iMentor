# -*- coding: iso8859-15 -*-
import os,sys
import pprint
import logging
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import db,Base,metadata,DBSession

from sqlalchemy import (BigInteger, Boolean, Column, Date, DateTime, 
    Float, ForeignKey, Index, Integer, Numeric, SmallInteger, 
    String, Table, Text, Time, text, func)
from sqlalchemy.dialects.postgresql.base import INET, TSVECTOR
from sqlalchemy.orm import relationship

from legacy_models.iuser import (BASIC_USER,
    MEMBER_ADMIN,E_MEMBER_ADMIN,REGIONAL_ADMIN,PARTNER_ADMIN,MENTOR,
    MENTEE,SUPER_ADMIN)
from new_platform.utils import user_details

class RoleInitException(Exception):
     pass
 
class Role(object):
    def __init__(self,user_id=None,email=None):
        if not user_id and not email:
            raise RoleInitException("Need to pass either user id or user email.")

        # Join returns IuserUser,IuserPersona,IuserPersonaPartners,
        # PartnersPartner,MemberMember,IuserAssignedusertype,IuserUsertype
        user_info = user_details.get_details_for_user(user_id,email)
        self.user = user_info[0]
        self.persona = user_info[1]
        self.role = user_info[5].usertype_id
        self.site = user_info[4]     # member_member

    @property
    def is_mentee(self):
        return self.role == MENTEE

    @property
    def is_mentor(self):
        return self.role == MENTOR

    def are_both_users_from_same_member_site(
        self,other_user_id=None,other_user_email=None):
        return user_details.is_user_in_same_member_site(
            self.member.id,other_user_id,other_user_email
            )

    @property
    def is_member_admin(self):
        return self.role == MEMBER_ADMIN

    @property
    def is_enhanced_member_admin(self):
        return self.role == E_MEMBER_ADMIN

    def is_member_admin_for_site_id(self,site_id):
        return self.role == MEMBER_ADMIN and self.site.id == site_id

    def is_enhanced_member_admin_for_site_id(self,site_id):
        return self.role == E_MEMBER_ADMIN and self.site.id == site_id

    @property
    def is_regional_admin(self):
        return self.role == REGIONAL_ADMIN

    def is_regional_admin_for_site_id(self,site_id):
        return self.role == REGIONAL_ADMIN and self.site.id == site_id

    @property
    def is_partner_admin(self):
        return self.role == PARTNER_ADMIN

    def is_partner_admin_for_site_id(self,site_id):
        return self.role == PARTNER_ADMIN and self.site.id == site_id

    @property
    def is_some_admin(self):
        return (self.role == MEMBER_ADMIN) or (self.role == PARTNER_ADMIN) or \
            (self.role == E_MEMBER_ADMIN) or(self.role == REGIONAL_ADMIN) or (self.role == SUPER_ADMIN)

    def is_some_admin_for_site_id(self,site_id):
        #logging.warning("User: %s, role: %s" % (self.user, self.role))
        return (
            ( 
                (
                    (self.role == MEMBER_ADMIN) or (self.role == PARTNER_ADMIN) or \
                    (self.role == E_MEMBER_ADMIN) or (self.role == REGIONAL_ADMIN)
                ) 
                and (self.site.id == site_id)
            ) or (self.role == SUPER_ADMIN)
        )

    def is_matching_mentor_mentee(self,user_id):
        if self.role == MENTOR:
             mentee = user_details.get_latest_mentee_user_for_mentor(self.user.id)
             return ( mentee and mentee.id == user_id )

        elif self.role == MENTEE:
             mentor = user_details.get_latest_mentor_user_for_mentee(self.user.id)
             return ( mentor and mentor.id == user_id )

    def get_matching_mentor_mentee(self):
        if self.role == MENTOR:
             return user_details.get_latest_mentee_user_for_mentor(self.user.id)

        elif self.role == MENTEE:
             return user_details.get_latest_mentor_user_for_mentee(self.user.id)

    def get_admin_for_user(self,user_id):
        # Return info for this user's direct admin,if they have one.
        # Filtered = False will check for active and not matched. True = active & matched.
        return user_details.get_admin_for_user(user_id,filtered=False)

    def is_this_the_admin_for_this_user(self,user_id):
        admin_for_user_id = self.get_admin_for_user(user_id)

        # Is the current user "the" assigned admin for this user ID passed in?
        if admin_for_user_id and admin_for_user_id.admin_user_id==self.user.id and \
            admin_for_user_id.user_id==user_id:
            return True

        return False

    @property
    def is_super_admin(self):
        '''
        if self.role == SUPER_ADMIN:
            logging.warning("Roles: Yes, user {0} is a super admin".format(self.user.email))
        else:
            logging.warning("Roles: No, user {0} is not a super admin".format(self.user.email))
        '''
        return self.role == SUPER_ADMIN

if __name__ == "__main__":
    from legacy_models.iuser import IuserUser
    for i in DBSession.query(IuserUser).all():
        print "Doing {0}".format(i.id)
        role = Role(i.id)
        matching = role.get_matching_mentor_mentee()
        if matching:
            print "Match: User id {0} role {1}, matching id: {2} role {3}".format(
                i.id,role.role,matching.id,Role(matching.id).role)

    '''
    role_test = Role(email='sa.brobinson@imentor.org')
    assert role_test.is_super_admin
    role_test = Role(email='aagg@comcast.net')
    assert not role_test.is_super_admin
    '''
