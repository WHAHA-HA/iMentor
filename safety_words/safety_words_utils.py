# -*- coding: iso8859-15 -*-
import pdb
import psycopg2
import pprint
import copy
import os,sys
import csv
import time
import re
from dateutil import parser
from elasticsearch import Elasticsearch
from datetime import datetime
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import (get_scoped_session,Base,
    metadata,DBSession,DOMAIN)
from config.settings import (ENV_TYPE,LOGIN_DISABLED,
    DEFAULT_TEST_USER_ID,SUPERUSER_ANNOUNCER_ID,ESEARCH_HOST,ESEARCH_PORT)

import sqlalchemy
from sqlalchemy import desc
from sqlalchemy.sql.expression import func, or_, not_, and_
from sqlalchemy.orm import sessionmaker 
from sqlalchemy.orm.exc import NoResultFound, MultipleResultsFound

#Import 'app' object from auth as well
from auth import api, app, login_required

from legacy_models.iuser import IuserUser,IuserPersonaPartner,USER_STATUS_ACTIVE
from legacy_models.partners import PartnersPartner
from safety_words import prep_send_email
from safety_words.models import (SafetyWordSource,SafetyPhrase,SafetyCheckTracking,
    ALERT_FREQUENCY_HOURLY,ALERT_FREQUENCY_DAILY,SAFETY_CHECK_CANVAS,
    SAFETY_CHECK_CONVERSATIONS,SAFETY_CHECK_PORTFOLIO,SAFETY_APPS,APP_SETTINGS)


class WordParseException(Exception):
    pass

class InvalidFrequencyException(Exception):
    pass

class MissingInfoException:
    pass


START_MARKER = "===>"
END_MARKER   = "<==="
SAFETY_FILTER = {
  "query":{
      "constant_score":{
      "filter":{
          "bool":{
              "should":[
                  'TERM_PLACEHOLDER'
              ],
              "must":[
                  {"range" : { "date_indexed" : {"gt" : "from_time_placeholder", "lte" : "to_time_placeholder"} } }
              ]
          }
      }
      }
  },
  "highlight" : {
      "fields" : {
          "text_field_placeholder":{
              "pre_tags": [
                "===>"
              ],
              "post_tags": [
                "<==="
              ],
              "fragment_size": 200,
              "number_of_fragments": 100
          }
      }
   }
}

es = Elasticsearch([{'host':ESEARCH_HOST,'port':ESEARCH_PORT},])

def reorg_search_results(results,app_settings,existing_sorted=None):
    # Reorg results, to make the grouping of notifications easier.

    # Append to existing, if an existing struct is passed in.
    by_member_by_partner = existing_sorted if existing_sorted else {}

    print("%d documents found" % results['hits']['total'])
    pprint.pprint(results)
    for doc in results['hits']['hits']:
        mid = doc['_source']['member_site_id']
        pid = doc['_source']['partner_site_id']
        if mid not in by_member_by_partner:
            by_member_by_partner[mid] = {}
        if pid not in by_member_by_partner[mid]:
            by_member_by_partner[mid][pid] = [{'_source':[],'highlight':[],'words':[],'admins':{},'user':{},'url':None}]
        else:
            by_member_by_partner[mid][pid].append({'_source':[],'highlight':[],'words':[],'admins':{},'user':{}, 'url':None})

        # Append things to the last, newly created index.
        bmbp_marker = by_member_by_partner[mid][pid][-1]

        bmbp_marker['_source'] = doc['_source']

        # Look up class name
        per_par = DBSession.query(IuserPersonaPartner).filter(
            IuserPersonaPartner.partner_id == pid).filter(
            IuserPersonaPartner.persona_id ==  bmbp_marker['_source']['persona_id']).first()
        if not per_par:
            partner_name = "NO_NAME_FOUND_Partnerid_{0}_Personaid_{1}".format(
                pid,bmbp_marker['_source']['persona_id']) 
        else:
            partner_name = per_par.partner.name

        bmbp_marker['_source']['class_name'] = partner_name

        # Concatenate all highlighted words and surrounding text
        bmbp_marker['highlight'] = ' [...] '.join(doc['highlight'][app_settings['text_field_name']])
        words = re.findall('{0}\s*(\w+[\s+\w+]*)\s*{1}'.format(START_MARKER,END_MARKER),
                bmbp_marker['highlight'])
        # Make spacing consistent so we find multi-word (phrase) instances in the DB reverse lookup.
        words = [re.sub(r'  *', ' ', x) for x in words]

        # Identify the originator of this response, and the corresponding url prefix.
        user = DBSession.query(IuserUser).filter(
            IuserUser.id==doc['_source']['user_id']
            ).first()
        url_prefix_of_this_match = user.member.url_name
        user_dict = user.__dict__
        del user_dict['_sa_instance_state']

        bmbp_marker['user'] = copy.deepcopy(user_dict)
        del user

        # Position 0 is always user id. We are always generating OBO links, assuming
        # an admin needs to see this.
        if 'url_field2' in app_settings:
            bmbp_marker['url'] = app_settings['url'].format(user_dict['id'],doc['_source'][app_settings['url_field1']],doc['_source'][app_settings['url_field2']])

        elif 'received_by_server' in app_settings['url_field1']:
            the_date = parser.parse(doc['_source']['received_by_server'])
            start_dmy = '{0:0>2}{1:0>2}{2}'.format(the_date.day,the_date.month,the_date.year)
            end_date = datetime.utcnow()
            end_dmy = '{0:0>2}{1:0>2}{2}'.format(end_date.day,end_date.month,end_date.year)
            bmbp_marker['url'] = app_settings['url'].format(user_dict['id'],start_dmy,end_dmy)

        else:
            bmbp_marker['url'] = app_settings['url'].format(user_dict['id'],doc['_source'][app_settings['url_field1']])

        admins = {}
        
        word_copy = copy.deepcopy(words)
        safety_entry = None
        word_phrase = ""
        word_keep = []

        while not safety_entry and word_copy:

            word_phrase += word_copy.pop(0)
            # Accumulating admins requires a reverse lookup of found words for member and partner.
            # This is the only way to map elasticsearch results back to our safety table, unfortunately.
            # It would be awesome to somehow get elasticsearch to do something like: "when you find 
            # the word 'shot', add 'index':567 to the results", so we can map it back easier.

            # This could be on the global list, which applies to all members and partners.
            # In that case, meber and/or partner could be null.
            safety_entry = DBSession.query(SafetyPhrase).filter(
                and_(
                or_(SafetyPhrase.member_site_id==mid,SafetyPhrase.member_site_id==None),
                or_(SafetyPhrase.partner_site_id==pid,SafetyPhrase.partner_site_id==None)
                )).filter(
                SafetyPhrase.word_or_phrase==word_phrase.strip().lower()
                ).first()

            # If word isn't found, find phrase.
            if not safety_entry:
                if not word_copy:
                    raise WordParseException("We have an issue trying to piece together words for a phrase. This phrase was not found in the safety word DB: {0}".format(word_phrase))
                word_phrase += ' '
                continue

            word_keep.append(word_phrase)
            word_phrase = ""

            # If this is null, default to the user's admin, and we have no additional admins.
            # Otherwise see who should receive this alert.
            if safety_entry.alert_user:
                # If this is null, default to the user's admin
                # Otherwise see who receives this alert.
                if safety_entry.alert_user.alert_recipient_user_id:
                    user = DBSession.query(IuserUser).filter(
                        IuserUser.id==safety_entry.alert_user.alert_recipient_user_id).filter(
                        IuserUser.status==USER_STATUS_ACTIVE
                        ).first()
                    if not user:
                        app.logger.exception("Safety word processing: trying to notify this user: {0} from this entry in our SafetyPhrase table entry {1}, but they either aren't active, or no longer exist in the user table. Skipping, not crashing.".format(
                            safety_entry.alert_user.alert_recipient_user_id,safety_entry.id))
                    else:
                        # NOTE: Use the URL prefix oif the user, not the admin!
                        admins[user.id] = (user.email,url_prefix_of_this_match,user.first_name)

                else: # default to user's admin

                    # Derive the admin to contact by default, based on partner info.
                    ua = DBSession.query(PartnersPartner).filter(
                        PartnersPartner.id==pid).filter(
                        PartnersPartner.member_id==mid).first()
                    if not ua:
                        raise MissingInfoException("This partners_partner id: {0} doesn't map to this member id {1}, crashing!".format(
                           pid,mid))
                    else:
                        users_admin = ua.member_contact.user
                        # NOTE: Use the URL prefix oif the user, not the admin!
                        admins[users_admin.id] = (users_admin.email,url_prefix_of_this_match,users_admin.first_name)

                # We MAY have additional admins in the email field, whether the alert_recipient_user_id
                # is null or not.
                more_admins = safety_entry.alert_user.additional_recipient_emails
                if more_admins:
                    for email in more_admins.split(','):
                        user = DBSession.query(IuserUser).filter(
                            IuserUser.email==email).filter(
                            IuserUser.status==USER_STATUS_ACTIVE
                            ).first()
                        if not user:
                            app.logger.exception("Safety word processing: trying to notify this user: {0} from this entry in our SafetyPhrase table entry {1}, but they either aren't active, or no longer exist in the user table. Skipping, not crashing.".format(
                                email,safety_entry.id))
                        else:
                            admins[user.id] = (email,url_prefix_of_this_match,user.first_name)

            else: # No alert user, no additional emails. Default to user's admin

                # Derive the admin to contact by default, based on partner info.
                ua = DBSession.query(PartnersPartner).filter(
                    PartnersPartner.id==pid).filter(
                    PartnersPartner.member_id==mid).first()
                if not ua:
                    raise MissingInfoException("This partners_partner id: {0} doesn't map to this member id {1}, crashing!".format(
                        pid,mid))
                else:
                    users_admin = ua.member_contact.user
                    admins[users_admin.id] = (users_admin.email,url_prefix_of_this_match,users_admin.first_name)

            safety_entry = None

        # Guarantee uniqueness: admins by user, for each _source hit.
        bmbp_marker['admins'] = admins

        # Show constructed phrases and words.
        bmbp_marker['words'] = word_keep


    return by_member_by_partner


def check_member_partner_for_safety(to_time,member_id,partner_id,words,freq,app_settings):

    if freq not in (ALERT_FREQUENCY_HOURLY,ALERT_FREQUENCY_DAILY):
        raise InvalidFrequencyException("Invalid frequency: {0}".format(freq))

    local_db_session = get_scoped_session()

    # Get the "from" time.
    if freq == ALERT_FREQUENCY_HOURLY:
        from_time = DBSession.query(SafetyCheckTracking).filter(
            SafetyCheckTracking.app==app_settings['app_id'],
            SafetyCheckTracking.frequency==ALERT_FREQUENCY_HOURLY
            ).one().epoch_time_last_checked
    elif freq == ALERT_FREQUENCY_DAILY:
        from_time = DBSession.query(SafetyCheckTracking).filter(
            SafetyCheckTracking.app==app_settings['app_id'],
            SafetyCheckTracking.frequency==ALERT_FREQUENCY_DAILY
            ).one().epoch_time_last_checked

    term_array = []
    for x in words:
        if len(x.split()) >= 2:
            term_array.append({"match_phrase":{app_settings['text_field_name']:"{0}".format(x)}})
        else:
            term_array.append({"term":{app_settings['text_field_name']:"{0}".format(x)}})

    safety_filter = copy.deepcopy(SAFETY_FILTER)
    
    # Make the search text field match the index we're working with.
    safety_filter['highlight']['fields'][app_settings['text_field_name']] = safety_filter['highlight']['fields'].pop('text_field_placeholder')

    safety_filter['query']['constant_score']['filter']['bool']['should'] = term_array

    safety_filter['query']['constant_score']['filter']['bool']['must'][0]['range']['date_indexed']['gt'] = from_time
    safety_filter['query']['constant_score']['filter']['bool']['must'][0]['range']['date_indexed']['lte'] = to_time
    
    # A "null" partner id is fine. Member site safety word lsist are allowed.
    # Notifications still only get delivered to the user's direct partner admin.
    if member_id:
        safety_filter['query']['constant_score']['filter']['bool']['must'].append({'term':{'member_site_id':member_id}})
    if partner_id:
        safety_filter['query']['constant_score']['filter']['bool']['must'].append({'term':{'partner_site_id':partner_id}})

    #pprint.pprint(safety_filter)
    res = es.search(index=app_settings['app_name'], doc_type=app_settings['doc_type'], 
        body=safety_filter)

    local_db_session.commit()

    print("%d documents found" % res['hits']['total'])
    pprint.pprint(res)
    '''
    for doc in res['hits']['hits']:
        pprint.pprint("text: {0}".format('\t'.join(doc['highlight'][app_settings['text_field_name']])))
    '''

    return res


def check_app_all_members_partners_for_safety(to_time,freq,app_settings):

    if freq not in (ALERT_FREQUENCY_HOURLY,ALERT_FREQUENCY_DAILY):
        raise InvalidFrequencyException("Invalid frequency: {0}".format(freq))

    local_db_session = get_scoped_session()

    if freq == ALERT_FREQUENCY_HOURLY:
        all_phrase_objs = DBSession.query(SafetyPhrase).filter(and_(
            SafetyPhrase.member_site_id == None,
            SafetyPhrase.partner_site_id == None,
            SafetyPhrase.alert_frequency == ALERT_FREQUENCY_HOURLY
            )).all()
    elif freq == ALERT_FREQUENCY_DAILY:
        all_phrase_objs = DBSession.query(SafetyPhrase).filter(and_(
            SafetyPhrase.member_site_id == None,
            SafetyPhrase.partner_site_id == None,
            SafetyPhrase.alert_frequency == ALERT_FREQUENCY_DAILY
            )).all()
    else:
        InvalidFrequencyException("BOOM!")

    # complie a list of safety words and phrases.
    all_words = [x.word_or_phrase for x in all_phrase_objs]
    if not all_words:
        '''
        if ENV_TYPE == 'Production':
            app.logger.exception("check_app_all_members_partners_for_safety(): There are no entries for all members AND all partners. Not crashing, skipping this particular check.")
        '''
        return

    # Get the from_time
    if freq == ALERT_FREQUENCY_HOURLY:
        from_time = DBSession.query(SafetyCheckTracking).filter(
            SafetyCheckTracking.app==app_settings['app_id'],
            SafetyCheckTracking.frequency==ALERT_FREQUENCY_HOURLY
            ).one().epoch_time_last_checked
    elif freq == ALERT_FREQUENCY_DAILY:
        from_time = DBSession.query(SafetyCheckTracking).filter(
            SafetyCheckTracking.app==app_settings['app_id'],
            SafetyCheckTracking.frequency==ALERT_FREQUENCY_DAILY
            ).one().epoch_time_last_checked

    # Fill in Safety Filter JSON to pass to elasticsearch.
    term_array = []
    for x in all_words:
        if len(x.split()) >= 2:
            term_array.append({"match_phrase":{app_settings['text_field_name']:"{0}".format(x)}})
        else:
            term_array.append({"term":{app_settings['text_field_name']:"{0}".format(x)}})

    safety_filter = copy.deepcopy(SAFETY_FILTER)

    # Make the search text field match the index we're working with.
    safety_filter['highlight']['fields'][app_settings['text_field_name']] = safety_filter['highlight']['fields'].pop('text_field_placeholder')

    safety_filter['query']['constant_score']['filter']['bool']['should'] = term_array

    safety_filter['query']['constant_score']['filter']['bool']['must'][0]['range']['date_indexed']['gt'] = from_time
    safety_filter['query']['constant_score']['filter']['bool']['must'][0]['range']['date_indexed']['lte'] = to_time
    
    #pprint.pprint(safety_filter)

    # Do the elastic search
    results = es.search(index=app_settings['app_name'], doc_type=app_settings['doc_type'], 
        body=safety_filter)

    local_db_session.commit()

    '''
    for doc in results['hits']['hits']:
        pprint.pprint("text: {0}".format('\t'.join(doc['highlight'][app_settings['text_field_name']])))
    '''

    return reorg_search_results(results,app_settings)


def app_mass_check(freq,to_time,app_settings):
    if freq not in (ALERT_FREQUENCY_HOURLY,ALERT_FREQUENCY_DAILY):
        raise InvalidFrequencyException("Invalid frequency: {0}".format(freq))

    # (1) Check the safety words which apply to all partner sites in all member sites.
    sorted_results = check_app_all_members_partners_for_safety(
        to_time,freq=freq,app_settings=app_settings)

    # (2) Check the safety words which only apply to specific member and/or partner sites.

    # (2a) First compile a list of safety words and phrases specific to member and/or partner.
    mp_phrases = DBSession.query(SafetyPhrase).filter(and_(or_(
        SafetyPhrase.member_site_id != None,
        SafetyPhrase.partner_site_id != None
        ),
        SafetyPhrase.alert_frequency == freq
        )).order_by(SafetyPhrase.member_site_id,SafetyPhrase.partner_site_id).all()

    # (2b) Sort words and phrases out by member and partner site.
    by_member_partner = {}

    for i in mp_phrases:
        DBSession.expunge(i)
        if i.member_site_id not in by_member_partner:
            by_member_partner[i.member_site_id] = {i.partner_site_id:[i.word_or_phrase]}
        elif i.partner_site_id not in by_member_partner[i.member_site_id]:
            by_member_partner[i.member_site_id][i.partner_site_id] = [i.word_or_phrase]
        else:
            by_member_partner[i.member_site_id][i.partner_site_id].append(i.word_or_phrase)

    # (2c) Run search for each member/partner combo that has custom safety words.
    # Notice results are collated into existing, already sorted results.
    for member_id in by_member_partner:
        for partner_id in by_member_partner[member_id]:
            all_words = by_member_partner[member_id][partner_id]
            results = check_member_partner_for_safety(
                to_time,member_id=member_id,partner_id=partner_id,
                words=all_words,freq=freq,app_settings=app_settings)

            if sorted_results:
                sorted_results = reorg_search_results(results,app_settings,sorted_results)

            else: # No "all partners and all members" safety words found.
                sorted_results = reorg_search_results(results,app_settings)

    return sorted_results

def results_by_admin(sorted_results):
    by_admin = {}
    
    for member_id,partner in sorted_results.iteritems():
        partner_id = partner.keys()[0]

        for data_set in sorted_results[member_id][partner_id]:
            for user_id in data_set['admins']:
                email,url_prefix,first_name = data_set['admins'][user_id]
                if email not in by_admin:
                    by_admin[email] = {}

                # Avoid possible dups that happen if > 1 safety word appears
                # in the same response.
                if data_set['_source']['id'] not in by_admin[email]:
                    by_admin[email][data_set['_source']['id']] = copy.deepcopy(data_set)
                    by_admin[email][data_set['_source']['id']]['url'] = \
                        'https://' + url_prefix + '.' + DOMAIN + by_admin[email][data_set['_source']['id']]['url']
                    by_admin[email][data_set['_source']['id']]['admin_user_id'] = user_id
                    by_admin[email][data_set['_source']['id']]['admin_first_name'] = first_name
            
    return by_admin

        
def run_all_hourly(): 

    local_db_session = get_scoped_session()
    # subtract 1 second to avoid race condition of things being written right now.
    to_time = int(time.time()) - 1 

    for app in SAFETY_APPS:
        sorted_results = app_mass_check(ALERT_FREQUENCY_HOURLY,to_time,APP_SETTINGS[app])
        if not sorted_results:
            continue

        by_admin = results_by_admin(sorted_results)
        prep_send_email.send_results(by_admin,app,ALERT_FREQUENCY_HOURLY)

        # Update one universal time stamp per frequncy for all 
        # hourly/daily (freq) operations.
        local_db_session.query(SafetyCheckTracking).filter(
            SafetyCheckTracking.app==APP_SETTINGS[app]['app_id'],
            SafetyCheckTracking.frequency==ALERT_FREQUENCY_HOURLY).update(
                {'epoch_time_last_checked':to_time})
   
    local_db_session.commit()

def run_all_daily(): 
    local_db_session = get_scoped_session()
    # subtract 1 second to avoid race condition of things being written right now.
    to_time = int(time.time()) - 1 

    for app in SAFETY_APPS:
        sorted_results = app_mass_check(ALERT_FREQUENCY_DAILY,to_time,APP_SETTINGS[app])
        if not sorted_results:
            continue

        by_admin = results_by_admin(sorted_results)
        prep_send_email.send_results(by_admin,app,ALERT_FREQUENCY_DAILY)
        
        # Update one universal time stamp per frequncy for all 
        # hourly/daily (freq) operations.
        local_db_session.query(SafetyCheckTracking).filter(
            SafetyCheckTracking.app==APP_SETTINGS[app]['app_id'],
            SafetyCheckTracking.frequency==ALERT_FREQUENCY_DAILY).update(
            {'epoch_time_last_checked':to_time})
    
    local_db_session.commit()
