# -*- coding: iso8859-15 -*-
import os,sys
import pprint
import logging
import datetime
import re
import csv
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'../..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import db,Base,metadata,DBSession,DOGPILE_CACHE_REGION
from legacy_models.iuser import IuserReferencecheck,IuserUser
from apiforms.models import *

'''
We only care about the user ID and the reference notes: 0,45,50,55,60.
User_ID,Persona_ID,First_Name,Last_Name,Invited,Submit,Status,Email,Partner,Occupation,Employer,Question_1:_Have_you_already_passed_$MEMBER_NAME;'s_screening_and_training_requirements_and_served_as_mentor_in_the_program?,"Question_2:_If_yes,_what_year(s)_were_you_a_volunteer_with_$MEMBER_NAME;?",Question_3:_Blank_Question,Question_4:_Driver's_License_Number:,Question_5:_Driver's_License_State:,Question_6:_Have_you_ever_been_convicted_of_a_felony?_NOTE:_Any_offenses_omitted_from_this_application_may_result_in_automatic_disqualification_from_the_volunteer_screening_process.,"Question_7:_If_yes,_please_explain.__Include_the_date_and_nature_of_the_crime_and_sentence,_as_well_as_the_court_and_jurisdiction_in_which_you_were_convicted.",Question_8:_Have_you_ever_been_convicted_of_a_misdemeanor_including_any_involving_violence_and/or_children?_NOTE:_Any_offenses_omitted_from_this_application_may_result_in_automatic_disqualification_from_the_volunteer_screening_process.,"Question_9:_If_yes,_please_explain._Include_the_date_and_nature_of_the_crime_and_sentence,_as_well_as_the_court_and_jurisdiction_in_which_you_were_convicted.","Question_10:_Please_provide_us_with_separate_definitions,_limited_to_one_or_two_sentences,_for_each_of_the_following_types_of_abuse:_physical,_sexual,_and_emotion.","Question_11:_Have_you_ever_been_terminated_or_otherwise_disciplined,_placed_on_probation,_or_warned_not_to_continue_engaging_in_certain_conduct_while_volunteering_with_any_agency_(whether_or_not_youth_were_involved)?","Question_12:_If_yes,_please_explain:",Question_13:_Current_Work_Supervisor's_Name:,"Question_14:_Current_Work_Supervisor's_Email_and/or_Phone_Number._NOTE:_If_you_are_an_entrepreneur,_consultant,_or_otherwise_self-employed,_please_type_""self-employed""_in_the_field._For_the_phone_number,_please_list_your_business_contact_number.",Question_15:_First_Reference_Name,Question_16:_First_Reference_Email_Address,Question_17:_First_Reference_Mobile/Home_Phone_Number,Question_18:_First_Reference:_What_is_your_relationship_to_this_person?,Question_19:_First_Reference_Notes:,Question_20:_Second_Reference_Name,Question_21:_Second_Reference_Email_Address,Question_22:_Second_Reference_Mobile_Phone/Home_Phone_Number,Question_23:_Second_Reference:_What_is_your_relationship_to_this_person?,Question_24:_Second_Reference_Notes:,Question_25:_Third_Reference_Name,Question_26:_Third_Reference_Email_Address,Question_27:_Third_Reference_Mobile_Phone/Home_Phone_Number,Question_28:_Third_Reference:_What_is_your_relationship_to_this_person?,Question_29:_Third_Reference_Notes:,Question_30:_Fourth_Reference_Name,Question_31:_Fourth_Reference_Email_Address,Question_32:_Fourth_Reference_Mobile_Phone/_Home_Phone_Number,Question_33:_Fourth_Reference:_What_is_your_relationship_to_this_person?,Question_34:_Fourth_Reference_Notes:^M
'''

mapped_names = {}

for csvf in ('survey_501_results_2015619.csv',):
  with open(csvf, 'rb') as csvfile:
    reader = csv.DictReader(csvfile, delimiter=',', quotechar='"')
    count = 0
    for row in reader:
        count += 1
        print "Row count: %s" % count
        user_id = int(row['User_ID'])
        user = IuserUser.query.filter(IuserUser.id == user_id).one()
        if user.reference_check.notes:
            try:
                print "User general ref notes: {0} {1}".format(user_id,user.reference_check.notes.replace('\r','\n').encode("ascii", "ignore"))
            except:
                pass

        if user.reference_check.first_reference_notes in (None,'','None','null'):
            if row['Question_19:_First_Reference_Notes:']:
                IuserReferencecheck.query.filter(IuserReferencecheck.id == user.reference_check_id
                    ).update({'first_reference_notes':row['Question_19:_First_Reference_Notes:']})
                try:
                    print "******Updating first ref notes for user {0}:{1}".format(
                        user_id,row['Question_19:_First_Reference_Notes:'].replace('\r','\n').encode("ascii", "ignore"))
                except:
                    pass
        else:
            try:
                print "******Found existing ref notes for user {0}:{1}".format(
                    user_id,user.reference_check.first_reference_notes.replace('\r','\n').encode("ascii", "ignore"))
            except:
                pass

        if user.reference_check.second_reference_notes in (None,'','None','null'):
            if row['Question_24:_Second_Reference_Notes:']:
                IuserReferencecheck.query.filter(IuserReferencecheck.id == user.reference_check_id
                    ).update({'second_reference_notes':row['Question_24:_Second_Reference_Notes:']})
                try:
                    print "******Updating second ref notes for user {0}:{1}".format(
                        user_id,row['Question_24:_Second_Reference_Notes:'].replace('\r','\n').encode("ascii", "ignore"))
                except:
                    pass
        else:
            try:
                print "******Found existing ref notes for user {0}:{1}".format(
                    user_id,user.reference_check.second_reference_notes.replace('\r','\n').encode("ascii", "ignore"))
            except:
                pass

        if user.reference_check.third_reference_notes in (None,'','None','null'):
            if row['Question_29:_Third_Reference_Notes:']:
                IuserReferencecheck.query.filter(IuserReferencecheck.id == user.reference_check_id
                    ).update({'third_reference_notes':row['Question_29:_Third_Reference_Notes:']})
                try:
                    print "******Updating third ref notes for user {0}:{1}".format(
                        user_id,row['Question_29:_Third_Reference_Notes:'].replace('\r','\n').encode("ascii", "ignore"))
                except:
                    pass
        else:
            try:
                print "******Found existing ref notes for user {0}:{1}".format(
                    user_id,user.reference_check.third_reference_notes.replace('\r','\n').encode("ascii", "ignore"))
            except:
                pass

        if user.reference_check.fourth_reference_notes in (None,'','None','null'):
            if row['Question_34:_Fourth_Reference_Notes:']:
                IuserReferencecheck.query.filter(IuserReferencecheck.id == user.reference_check_id
                    ).update({'fourth_reference_notes':row['Question_34:_Fourth_Reference_Notes:']})
                try:
                    print "******Updating fourth ref notes for user {0}:{1}".format(
                        user_id,row['Question_34:_Fourth_Reference_Notes:'].replace('\r','\n').encode("ascii", "ignore"))
                except:
                    pass
        else:
            try:
                print "******Found existing ref notes for user {0}:{1}".format(
                    user_id,user.reference_check.fourth_reference_notes.replace('\r','\n').encode("ascii", "ignore"))
            except:
                pass

        db.session.commit()
