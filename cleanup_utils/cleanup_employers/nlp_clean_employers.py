# -*- coding: iso8859-15 -*-
import os,sys
import pprint
import logging
import datetime
import re
import nltk
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'../..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import db,Base,metadata,DBSession,DOGPILE_CACHE_REGION
from legacy_models.iuser import IuserEmployer,IuserEmployerMember,IuserUser
from legacy_models.member import MemberMember
from legacy_models.partners import PartnersPartner
from legacy_models.curriculum import CurriculumPrompt
from legacy_models.calendars import CalendarsEventtype

avoid_words=[
    'academy',
    'advancement',
    'advisory',
    'advisories',
    'advisors',
    'affairs',
    'agency',
    'air',
    'alliance',
    'america',
    'american',
    'attorney',
    'bank',
    'brooklyn',
    'business',
    'care',
    'center',
    'charter',
    'city',
    'commerce',
    'communications',
    'community',
    'consulting',
    'co',
    'coalition',
    'columbia',
    'construction',
    'corporate',
    'data',
    'design',
    'education',
    'eastern',
    'family',
    'federal',
    'financial',
    'foundation',
    'fund',
    'global',
    'government',
    'high',
    'holdings',
    'hospital',
    'houston',
    'housing',
    'inc',
    'incorporated',
    'investors',
    'investment',
    'jewish',
    'kids',
    'law',
    'learning',
    'life',
    'lord',
    'ltd',
    'marketing',
    'media',
    'memorial',
    'museum',
    'music',
    'national',
    'network',
    'new york',
    'one',
    'partnership',
    'productions',
    'project',
    'property',
    'public',
    'regional',
    'research',
    'resources',
    'san',
    'saint',
    'school',
    'service',
    'schools',
    'society',
    'system',
    'systems',
    'st',
    'state',
    'technology',
    'therapy',
    'travel',
    'two',
    'veterans',
    'union',
    'united',
    'us',
    'usa',
    'university',
    'world',
    'worldwide',
    ]

records = IuserEmployer.query.all()
tagged_text = {}
word_set = {}
word_bin = {}

for r in records:
    # No prepositions or coordinating conjuntions
    # Make name as simple as possible for matching.
    name = r.name.lower().strip()
    name = re.sub('[^0-9a-zA-Z ]+','',name)
    tagged_text[r.id] = \
        [n for n in nltk.pos_tag(nltk.word_tokenize(name)) \
            if n[1] not in ('IN','CC','TO','DT') and n[0] not in avoid_words]

    word_set[r.id] = sorted([n[0] for n in tagged_text[r.id]])

for k,v in word_set.items():
    for word in v:
        if word in word_bin:
            word_bin[word].append({k:v})
        else:
            word_bin[word] = [{k:v}]

for wbin in word_bin:
    if len(word_bin[wbin]) > 1:
        for ritem in word_bin[wbin]:
           for s,t in ritem.items():
               dbitem = IuserEmployer.query.filter(IuserEmployer.id==s).one()
               name = re.sub(r'0x*','',dbitem.name)
               print "{0}|{1}|".format(dbitem.id,name),
        print ""
            
