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

EMAIL="staff_showcase@imentor.org"
PASSWORD="test123"
DEBUG=True

headers = {'Content-type': 'application/json',
    'Accept': 'application/json, text/javascript, */*; q=0.01',
    'X-Requested-With': 'XMLHttpRequest'}

URI="http://127.0.0.1:8000"

login_payload = {'email': EMAIL, 'password': PASSWORD} #email or username

s = requests.Session()

# 'auth' parameter is not required in production.
'''
result = check_result(
    s.post(URI + '/auth/login/', data=json.dumps(login_payload), 
        headers=headers, auth=HTTPBasicAuth(BASIC_USER,BASIC_PASSWORD)
    )
)
'''
print "Outbound: {0} {1}".format(pprint.pprint(headers),pprint.pprint(s.__dict__))

import pdb;pdb.set_trace()
#result = s.post(URI + '/alt_login/', data=json.dumps(login_payload), 
#    headers=headers
#)
#result = check_result(result)

'''
file_data = open('/home/gloriajw/Pictures/to_june_2016/20160605_202014.jpg','rb').read().encode('base64')
payload = {'filename': '/home/gloriajw/Pictures/to_june_2016/20160605_202014.jpg',"data":{"uri":"data:image/jpeg;base64," + file_data}}

result = s.post(URI + '/muser_content/profile_image/',data=json.dumps(payload),headers=headers) 

print "Outbound: {0} {1}".format(pprint.pprint(headers),pprint.pprint(s.__dict__))
print result.text.encode('utf-8')

payload = {'filename': '/muser_content/151865/home_gloriajw_Pictures_to_june_2016_20160605_202014.jpg',"data":{"uri":"data:image/jpeg;base64," + file_data}}

'''
result = s.get(URI + '/muser_content/base64/profile_pic/',headers=headers) 
print result.text.encode('utf-8')
