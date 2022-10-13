# -*- coding: iso8859-15 -*-
import os, sys
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.settings import CROWDRISE_API_KEY, CROWDRISE_API_SECRET, \
        CROWDRISE_API_BASE_URL

from flask import Blueprint,render_template,request

APP_NAME='crowdrise'
crowdrise = Blueprint(APP_NAME, __name__, url_prefix='/{0}'.format(APP_NAME),
    template_folder='templates')

from config.project_globals import app, api

"""
# Requires a symlink from templates/404.html to local templates/app/404.html
@crowdrise.app_errorhandler(404)
def handle_404(err):
    return render_template('{0}/404.html'.format(APP_NAME)), 404

@crowdrise.app_errorhandler(500)
def handle_500(err):
    return render_template('{0}/500.html'.format(APP_NAME)), 500
"""

import requests
import urllib
import urlparse

class CrowdRiseClient(object):
    """Simple client for connecting to crowdrise API. Currently, only
    signup is implemented.
    """

    SIGNUP_PATH = "/signup"
    HEARTBEAT_PATH = "/heartbeat"

    def __init__(self, key, token, 
            url="http://apisandbox.crowdrise.com/api"):
        """Initialize a crowdrise api client. Minimally, we'll need a key and 
        a token (secret).
        """ 
        
        self.auth_params = {"api_key": key, "api_secret": token}
        self.base_url = url

    def __req_to_string(self, req):
        return '{}\n{}\n{}\n\n{}'.format(
            '-----------START-----------',
            req.method + ' ' + req.url,
            '\n'.join('{}: {}'.format(k, v) for k, v in req.headers.items()),
            req.body,
        )

    def send_api_request(self, path, params={}):
        """Send a post to CrowdRise's API, using the endpoint and credentials
        that this client was initialized with
        """

        # create our request
        # todo: use urlparse to put this together
        url = self.base_url + path
        params.update(self.auth_params)
        req = requests.Request('POST', url, data=params)
        prepared = req.prepare()

        # debug
        app.logger.debug(url, params)
        app.logger.debug(self.__req_to_string(prepared))

        # send request
        s = requests.Session()
        return s.send(prepared)
        # return requests.post(url, params=params)

    def signup(self, email, first, last, dob, password=None, ip_address=None):
        signup_options = {
                "email": email,
                "first_name": first,
                "last_name": last,
                "birthdate": dob,
                }

        if password:
            signup_options['password'] = password

        if ip_address:
            signup_options['ip_address'] = ip_address

        r = self.send_api_request(CrowdRiseClient.SIGNUP_PATH, 
                params=signup_options)

        app.logger.debug(r)
        app.logger.debug(r.text)
        app.logger.debug(r.json)

    def heartbeat(self):
        r = self.send_api_request(CrowdRiseClient.HEARTBEAT_PATH)
        app.logger.debug(r)
        app.logger.debug(r.text)
        app.logger.debug(r.json)
        
def test_heartbeat():
    cr = CrowdRiseClient(CROWDRISE_API_KEY, CROWDRISE_API_SECRET, \
            url=CROWDRISE_API_BASE_URL)
    cr.heartbeat()

def test_signup(test_num='015'):
    first = 'imentortest'
    last = test_num
    email = 'imentor.test.{0}@eyepaste.com'.format(test_num)
    dob = '1970-01-01'
    ip = '1.2.3.4'
    pw = ''
    
    curl_cmd = 'curl --data "api_key={0}&api_secret={1}&first_name={2}' + \
            '&last_name={3}&email={4}&birthdate={5}&ip_address={6}' + \
            '&password={7}" {8}'

    print("running test; to try manually, use the following curl command:")
    print(curl_cmd.format(CROWDRISE_API_KEY, CROWDRISE_API_SECRET, first, \
            last, email, dob, ip, pw, CROWDRISE_API_BASE_URL + "/signup"))

    cr = CrowdRiseClient(CROWDRISE_API_KEY, CROWDRISE_API_SECRET, \
            url=CROWDRISE_API_BASE_URL)

    print(cr.signup(email, first, last, dob, password=pw, ip_address=ip))

if __name__ == "__main__":
    test_signup()
