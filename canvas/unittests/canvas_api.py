#!/usr/bin/env python
# -*- coding: iso8859-15 -*-
import os,sys
import pprint
from datetime import datetime
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'../..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

import imp
import os,sys
import time 
import traceback 
from datetime import datetime,timedelta 

import unittest
import json
import requests
from requests.auth import HTTPBasicAuth
from canvas.models import *

#Basic Authentication Credentials to access the dev site
# Use mentor 100112, mentee 156618,
BASIC_USER='imentor'
BASIC_PASSWORD='2qa3ws4ed5rf6tg7yh'

POST_URL='https://nyc.imentordev.org/canvas/messages/'
#POST_URL='http://127.0.0.1:8000/canvas/messages/'

#Mentot/mentee Login Credentials
mentor_login = {'email': 'testemails+user_100112@imentor.org', 'password': 'test123'}
mentee_login = {'email': 'testemails+user_156618@imentor.org', 'password': 'test123'}

#These are the common headers used for all the API's
plain_headers = {'Content-Type': 'application/json;charset=UTF-8', 'Accept': 'application/json, text/plain, */*',
    'connection': 'keep-alive', 'Host': 'nyc.imentordev.org','Accept-Language': 'en-US,en;q=0.8',
    'Accept-Encoding': 'gzip, deflate','X-Requested-With': 'XMLHttpRequest'}

#Create a session and preserve the cookie across the api's
mentor_session=requests.Session()
mentee_session=requests.Session()

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Tests
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class APItests(unittest.TestCase):    
    
    #Logs in using Basic and Mentee Credentials there by creating a
    #Session
    def login_mentee(self):        
        global mentor_session
        global mentee_session
        global mentee_login
        
        func_name = sys._getframe().f_code.co_name
        print(func_name)
        
        MyHeader=plain_headers

        r=mentee_session.post('https://nyc.imentordev.org/iuser/ajax_login/',
                auth=HTTPBasicAuth(BASIC_USER,BASIC_PASSWORD), 
                headers=MyHeader,
                data=json.dumps(mentee_login),
                verify=True
                             )        
        if(r.status_code==requests.codes.ok):
            MyCookie=r.headers['set-cookie']
            print(MyCookie)
            #print(r.text)
            res=json.loads(r.text)
            print(res)
            assert(res['success']==True)
        else:
            print(r.status_code)
            assert(False)

         
    def canvas_hello(self):
        global mentee_session
        payload=[{
            'src_dst':WIDGET_BACKEND,
            'type':STATUS,
            'status':HELLO,
            'send_mask':MM_WRITER_1_SENDMASK,
            'recv_mask':0,
            'timestamp_ms':123456789123,
            }]

        r=mentee_session.post(POST_URL,
            headers=plain_headers,
            auth=HTTPBasicAuth(BASIC_USER,BASIC_PASSWORD),
            data=json.dumps(payload),
            verify=True)                

        if(r.status_code==requests.codes.ok):
            #print(r.text)
            res=json.loads(r.text)
            print(res)
            assert(r.ok)
        else:
            print(r.status_code)
            assert(False)

    def canvas_messages(self):
        global mentee_session
        payload=[
            {
            'src_dst':WIDGET_BACKEND,
            'type':MESSAGE,
            'send_mask':MM_WRITER_1_SENDMASK,
            'recv_mask':0,
            'timestamp_ms':123456789123,
            'data':{'message':'Hi mentor, this is mentee writing to you.'}
            },
            {
            'src_dst':WIDGET_BACKEND,
            'type':MESSAGE,
            'send_mask':MM_WRITER_1_SENDMASK,
            'recv_mask':0,
            'timestamp_ms':123456789124,
            'data':{'message':'My weekend was fun. I biked around this city. How about you?'}
            }
            ]

        r=mentee_session.post(POST_URL,
            headers=plain_headers,
            auth=HTTPBasicAuth(BASIC_USER,BASIC_PASSWORD),
            data=json.dumps(payload),
            verify=True)                

        if(r.status_code==requests.codes.ok):
            #print(r.text)
            res=json.loads(r.text)
            print(res)
            assert(r.ok)
        else:
            print(r.status_code)
            assert(False)

    def login_mentor(self):        
        global mentor_session
        global mentee_login
        
        func_name = sys._getframe().f_code.co_name
        print(func_name)
        
        MyHeader=plain_headers

        r=mentor_session.post('https://nyc.imentordev.org/iuser/ajax_login/',
                auth=HTTPBasicAuth(BASIC_USER,BASIC_PASSWORD), 
                headers=MyHeader,
                data=json.dumps(mentor_login),
                verify=True
                             )        
        if(r.status_code==requests.codes.ok):
            MyCookie=r.headers['set-cookie']
            print(MyCookie)
            #print(r.text)
            res=json.loads(r.text)
            print(res)
            assert(res['success']==True)
        else:
            print(r.status_code)
            assert(False)

         
    def canvas_mhello(self):
        global mentor_session
        payload=[{
            'src_dst':WIDGET_BACKEND,
            'type':STATUS,
            'status':HELLO,
            'send_mask':MM_WRITER_1_SENDMASK,
            'recv_mask':0,
            'timestamp_ms':123456789155,
            }]

        r=mentor_session.post(POST_URL,
            headers=plain_headers,
            auth=HTTPBasicAuth(BASIC_USER,BASIC_PASSWORD),
            data=json.dumps(payload),
            verify=True)                

        if(r.status_code==requests.codes.ok):
            #print(r.text)
            res=json.loads(r.text)
            print(res)
            assert(r.ok)
        else:
            print(r.status_code)
            assert(False)

    def canvas_mmessages(self):
        global mentor_session
        payload=[
            {
            'src_dst':WIDGET_BACKEND,
            'type':MESSAGE,
            'send_mask':MM_WRITER_1_SENDMASK,
            'recv_mask':0,
            'timestamp_ms':123456789123,
            'data':{'message':'Hi mentee, thanks for writing!'}
            },
            {
            'src_dst':WIDGET_BACKEND,
            'type':MESSAGE,
            'send_mask':MM_WRITER_1_SENDMASK,
            'recv_mask':0,
            'timestamp_ms':123456789124,
            'data':{'message':'I also biked around the city. We have a lot in common.'}
            }
            ]

        r=mentor_session.post(POST_URL,
            headers=plain_headers,
            auth=HTTPBasicAuth(BASIC_USER,BASIC_PASSWORD),
            data=json.dumps(payload),
            verify=True)                

        if(r.status_code==requests.codes.ok):
            #print(r.text)
            res=json.loads(r.text)
            print(res)
            assert(r.ok)
        else:
            print(r.status_code)
            assert(False)

        
    def tearDown(self):
        pass



if __name__ == '__main__':   
    suiteTotal = unittest.TestSuite()
    #generate a test suite
    suiteTotal.addTest(APItests('login_mentee'))
    suiteTotal.addTest(APItests('canvas_hello'))
    suiteTotal.addTest(APItests('canvas_messages'))
    suiteTotal.addTest(APItests('login_mentor'))
    suiteTotal.addTest(APItests('canvas_mhello'))
    suiteTotal.addTest(APItests('canvas_mmessages'))

    #Run the test suite
    unittest.TextTestRunner().run(suiteTotal)

