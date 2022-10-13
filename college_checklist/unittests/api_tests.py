#!/usr/bin/env python
import os,sys
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'../..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

import copy 
import pprint 
import time 
import traceback 
import pdb 
from datetime import datetime,timedelta 

import json
import unittest
import requests
from requests.auth import HTTPBasicAuth


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# generic functions
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def check_result(return_value):
    if not return_value.ok:
        raise Exception("Test failed: status %d, response: %s" % (return_value.status_code,return_value.text))

    if return_value.text:
        j = json.loads(return_value.text)
        #print(return_value)
        #pprint.pprint(j['data'])
        return j
    return None

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Global settings
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
BASIC_USER="imentor"
BASIC_PASSWORD="2qa3ws4ed5rf6tg7yh"

USER="nnnn"
EMAIL="nnnnnnnnnnnnnn"
PASSWORD="nnnnnnnnnnnnnnnn"
API_KEY="nnnnnnnnnnnnnnnnnnnnnnn"
DEBUG=True

plain_headers = {'Content-type': 'text/json', 'Accept': 'text/json',
    'connection': 'close'}

headers = copy.deepcopy(plain_headers)

auth_headers = {'Authorization': USER + ':{0}'}

URI="https://dev.imentordev.org/cchklist/"

login_payload = {'user': USER, 'password': PASSWORD} #email or username

# Grab temp key to use for the entire session.
# Add it to the headers, to make life easier.
#result = check_result(
#    requests.post(URI + 'authn/login/', data=json.dumps(login_payload), headers=headers)
#    )

#tempkey = result['temp_key']
#auth_headers['Authorization'] = auth_headers['Authorization'].format(tempkey)
#headers.update(auth_headers)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Tests
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class APItests(unittest.TestCase):

    def setUp(self):
        pass

    def test_00_college_lists(self):
        result = check_result(
            requests.get(URI + 'fixed/0',
                #auth=HTTPBasicAuth(BASIC_USER,BASIC_PASSWORD), 
                headers=plain_headers)
            )
        with open(appdir + '/fixed_0_results.txt') as f:
            saved_result = json.loads(f.read())
            assert result == saved_result, "/fixed/0/ API call returned something different than expected"

        #result = requests.post(URI + 'zone_group/%d/zones/' % new_zonegroup['id'], 
        #    data=json.dumps(zone_ids[:2]), headers = headers)

    def tearDown(self):
        pass



if __name__ == '__main__':
    unittest.main()
    #suite = unittest.TestSuite()
    #suite.addTest(APItests('test_12_light_on_off_one_zone'))
    #unittest.TextTestRunner().run(suite)

