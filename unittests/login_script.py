#!/usr/bin/env python
import requests
import pprint
import json

from requests.auth import HTTPBasicAuth

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def check_result(return_value):
    print "Inbound: {0}".format(pprint.pprint(return_value.__dict__))
    if not return_value.ok:
        raise Exception("Test failed: status %d, response: %s" % (return_value.status_code,return_value.text))

    if return_value.text:
        j = json.loads(return_value.text)
        #print(return_value)
        #pprint.pprint(j['data'])
        return j
    return None

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

BASIC_USER="imentor"
BASIC_PASSWORD="2qa3ws4ed5rf6tg7yh"

#EMAIL="testemails+user_1241@imentor.org"
EMAIL="roger.mitchell@arkusinc.com"
PASSWORD="cde4rfbgt6yh"
DEBUG=True

headers = {'Content-type': 'application/json',
    'Accept': 'application/json, text/javascript, */*; q=0.01',
    'X-Requested-With': 'XMLHttpRequest'}

URI="https://nyc.imentor.org"

login_payload = {'email': EMAIL, 'password': PASSWORD} #email or username

s = requests.Session()

# 'auth' parameter is not required in production.
'''
result = check_result(
    s.post(URI + '/iuser/ajax_login/', data=json.dumps(login_payload), 
        headers=headers, auth=HTTPBasicAuth(BASIC_USER,BASIC_PASSWORD)
    )
)
'''
print "Outbound: {0} {1}".format(pprint.pprint(headers),pprint.pprint(s.__dict__))
result = check_result(
    s.post(URI + '/iuser/ajax_login/', data=json.dumps(login_payload), 
        headers=headers
    )
)
import pdb;pdb.set_trace()
result = s.get(URI + '/sfclient/match_status/') 
#         auth=HTTPBasicAuth(BASIC_USER,BASIC_PASSWORD))

print "Outbound: {0} {1}".format(pprint.pprint(headers),pprint.pprint(s.__dict__))
print result.text.encode('utf-8')

