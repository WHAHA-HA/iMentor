# -*- coding: iso8859-15 -*-
import cgi
import requests
import json
from simple_salesforce import Salesforce

#login here:
#https://login.salesforce.com/services/oauth2/authorize?response_type=code&client_id=3MVG9A2kN3Bn17hsWsLDatw._IVMEUBoPKv.7ksp0tz7xLX4tWDVgyzwTCA7i_yTfP.qYuNOsSoPNcdVH6DuE&redirect_uri=http://localhost/cgi-bin/python/oauth.py

sf = Salesforce(username='hanming.zeng@nyu.edu', password='63812349z', security_token='G5fF1CUYjZMQd2cNT62y8sAV', sandbox=True)



#This doesn't work I guess it's not set up that way
#sf.query("SELECT match_status FROM iuser_persona WHERE id = 74623")

a = sf.query("SELECT Match_Status__c FROM Contact")


print a