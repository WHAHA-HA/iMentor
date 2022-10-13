# -*- coding: iso8859-15 -*-
import pdb
import os,sys
#pdb.set_trace()
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'../..'))
if projdir not in sys.path:
    # Insert, to circumvent django forms in sys path.
    sys.path.insert(0,appdir)
    sys.path.insert(0,projdir)

from api.utils import user_details
from forms.form_copy_functions import copy_form_cascade

user_data = {'users': [
      {'user_id': 169974, 'user_type': 'Mentee', 'site_id': 1, 'form_id': 1, 'member_site': 'nyc', 'script': '01'}]
}

old = {'users': [
      {'user_id': 1215, 'user_type': 'Mentor', 'site_id': 1, 'form_id': 1, 'member_site': 'nyc', 'script': '01'},
      {'user_id': 1241, 'user_type': 'Mentee', 'site_id': 1, 'form_id': 2, 'member_site': 'nyc', 'script': '02'},
      {'user_id': 166369, 'user_type': 'Mentor', 'site_id': 196, 'form_id': 3, 'member_site': 'mentor2', 'script': '03'},
      {'user_id': 164617, 'user_type': 'Mentee', 'site_id': 196, 'form_id': 4, 'member_site': 'mentor2', 'script': '03'},
      {'user_id': 161594, 'user_type': 'Mentor', 'site_id': 234, 'form_id': 5, 'member_site': 'bbbscharlotte', 'script': '06'},
      {'user_id': 164816, 'user_type': 'Mentee', 'site_id': 234, 'form_id': 6, 'member_site': 'bbbscharlotte', 'script': '07'},
      {'user_id': 169824, 'user_type': 'Mentor', 'site_id': 246, 'form_id': 7, 'member_site': 'bbbscil', 'script': '08'},
      {'user_id': 168944, 'user_type': 'Mentor', 'site_id': 243, 'form_id': 1, 'member_site': 'automation', 'script': '05'},
      {'user_id': 168945, 'user_type': 'Mentee', 'site_id': 243, 'form_id': 2, 'member_site': 'automation', 'script': '05'},
      {'user_id': 141476, 'user_type': 'Mentor', 'site_id': 181, 'form_id': 1, 'member_site': 'cymentor', 'script': '05'},
      {'user_id': 131452, 'user_type': 'Mentee', 'site_id': 181, 'form_id': 2, 'member_site': 'cymentor', 'script': '05'},
      {'user_id': 159742, 'user_type': 'Mentor', 'site_id': 86, 'form_id': 1, 'member_site': 'example', 'script': '05'},
      {'user_id': 121471, 'user_type': 'Mentee', 'site_id': 86, 'form_id': 2, 'member_site': 'example', 'script': '05'},
      {'user_id': 159761, 'user_type': 'Mentor', 'site_id': 179, 'form_id': 1, 'member_site': 'ipower', 'script': '05'},
      {'user_id': 129439, 'user_type': 'Mentee', 'site_id': 179, 'form_id': 2, 'member_site': 'ipower', 'script': '05'},
      {'user_id': 151915, 'user_type': 'Mentor', 'site_id': 197, 'form_id': 1, 'member_site': 'platformtraining', 'script': '05'},
      {'user_id': 154087, 'user_type': 'Mentee', 'site_id': 197, 'form_id': 2, 'member_site': 'platformtraining', 'script': '05'},
      {'user_id': 159314, 'user_type': 'Mentor', 'site_id': 187, 'form_id': 1, 'member_site': 'hsf', 'script': '05'},
      {'user_id': 142784, 'user_type': 'Mentee', 'site_id': 187, 'form_id': 2, 'member_site': 'hsf', 'script': '05'},
  ]
}


for data in user_data['users']:
    user_id = data['user_id']
    form_id = data['form_id']
    user_info = user_details.get_details_for_user(user_id=user_id)

    copy_form_cascade(
        form_id=form_id,
        user_id=user_id,
        persona_id=user_info[1].id,
        member_site_id=user_info[4].id)

#Using these for now:
#user id 1215, Mentor, site id 1, form 1, nyc, script 01
#user id 1241, Mentee, site id 1, form 2, nyc, script 02
#user id 166369, Mentor, site id 196, form 3, mentor2, script 03
#user id 164617, Mentee, site id 196, form 4, mentor2, script 04
#user id 161594, Mentor, site id 234, form 5, bbbscharlotte, script 06
#user id 164816, Mentee, site id 234, form 6, bbbscharlotte, script 07
#user id 169824, Mentor, site id 246, form 7, bbbscil, script 08
#user id 168944, Mentor, site id 243, form 1, automation, script 05
#user id 168945, Mentee, site id 243, form 2, automation, script 05
#user id 141476, Mentor, site id 181, form 1, cymentor, script 05
#user id 131452, Mentee, site id 181, form 2, cymentor, script 05
#user id 159742, Mentor, site id 86, form 1, example, script 05
#user id 121471, Mentee, site id 86, form 2, example, script 05
#user id 159761, Mentor, site id 179, form 1, ipower, script 05
#user id 129439, Mentee, site id 179, form 2, ipower, script 05
#user id 151915, Mentor, site id 197, form 1, platformtraining, script 05
#user id 154087, Mentee, site id 197, form 2, platformtraining, script 05
#user id 159314, Mentor, site id 187, form 1, hsf, script 05
#user id 142784, Mentee, site id 187, form 2, hsf, script 05


# === old code
#user_id=142784
#form_id=2
#user_info = user_details.get_details_for_user(user_id=user_id)
#
#copy_form_cascade(
#    form_id=form_id,
#    user_id=user_id,
#    persona_id=user_info[1].id,
#    member_site_id=user_info[4].id)
