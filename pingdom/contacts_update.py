# -*- coding: iso8859-15 -*-
import os, sys
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)
import requests
import json
import csv

from requests.auth import HTTPBasicAuth
from config.settings import PINGDOM_APP_KEY, PINGDOM_AUTH_EMAIL, PINGDOM_AUTH_PWD, PINGDOM_BASE_URL

#This is our client for connecting to the Pingdom API.
def update_contacts():

    app_key = PINGDOM_APP_KEY
    auth_email = PINGDOM_AUTH_EMAIL
    auth_pwd = PINGDOM_AUTH_PWD
    base_url = PINGDOM_BASE_URL
    headers = {"App-Key": app_key}
    
    #First, we obtain the list of existing contacts.
    resource = "/notification_contacts"
    params = {"limit": "10000"}
    r = requests.get(base_url + resource, auth = HTTPBasicAuth(auth_email, auth_pwd), headers = headers, params = params)
    print "Get existing contacts, status code: %s" % r.status_code
    
    #Next, we delete these contacts to prepare for the new contacts.
    existing_contact_list = []
    json_results = json.loads(r.text)
    for contact in json_results["contacts"]:
        existing_contact_list.append(str(contact["id"]))

    resource = "/notification_contacts"
    contact_ids_to_delete = ",".join(existing_contact_list)
    params = {"delcontactids": contact_ids_to_delete}
    r = requests.delete(base_url + resource, auth = HTTPBasicAuth(auth_email, auth_pwd), headers = headers, params = params)
    print "Delete existing contacts, status code: %s" % r.status_code

    #Next, we create contacts from our CSV.
    with open("pingdom_contacts.csv", "rU") as pingdom_contacts_csv:
        #The format of the CSV is as follows: first_name|last_name|email|cellphone|check
        reader = csv.DictReader(pingdom_contacts_csv, delimiter="|", quotechar="'")
        platform_contact_list = []
        partner_contact_list = []
        website_contact_list = []
        benjammr_contact_list = []
        times_contact_list = []
        for row in reader:
            resource = "/notification_contacts"
            #We cannot post an empty email or cellphone strong, so we remove those parameters as necessary.
            #We always will have at least an email or a cellphone value.
            if row["email"] != "" and row ["cellphone"] != "":
                params = {"name": row["first_name"] + " " + row["last_name"], "email": row["email"], "cellphone": row["cellphone"], "countrycode": "+1", "countryiso": "US"}
            elif row["email"] == "":
                params = {"name": row["first_name"] + " " + row["last_name"], "cellphone": row["cellphone"], "countrycode": "+1", "countryiso": "US"}
            elif row["cellphone"] == "":
                params = {"name": row["first_name"] + " " + row["last_name"], "email": row["email"]}
            r = requests.post(base_url + resource, auth = HTTPBasicAuth(auth_email, auth_pwd), headers = headers, params = params)
            print "Create a contact for %s %s, status code: %s" % (row["first_name"], row["last_name"], r.status_code)
            
            json_results = json.loads(r.text)
            #We generally have the following checks each program year.
            #Slack checks do not require contacts and therefore are not listed here.
            #We're intentionally creating multiple contacts, one for each check, which makes it simpler to add the appropriate contact ID, to the appropriate check, with the appropriate notification method.
            if row["check"] == "iMentor Platform":
                platform_contact_list.append(str(json_results["contact"]["id"]))
            elif row["check"] == "iMentor Platform (partner programs)":
                partner_contact_list.append(str(json_results["contact"]["id"]))
            elif row["check"] == "iMentor Public Website":
                website_contact_list.append(str(json_results["contact"]["id"]))

    #Finally, we add these contacts to the appropriate existing check for email and SMS notifications of platform outages.

    #The check ID below belongs to iMentor Platform.
    resource = "/checks/1191052"
    contact_ids_for_check = ",".join(platform_contact_list)
    params = {"contactids": contact_ids_for_check}
    r = requests.put(base_url + resource, auth = HTTPBasicAuth(auth_email, auth_pwd), headers = headers, params = params)
    print "Add new contacts to the iMentor Platform check, status code: %s" % r.status_code
    
    #The check ID below belongs to iMentor Platform (partner programs).
    resource = "/checks/1211237"
    contact_ids_for_check = ",".join(partner_contact_list)
    params = {"contactids": contact_ids_for_check}
    r = requests.put(base_url + resource, auth = HTTPBasicAuth(auth_email, auth_pwd), headers = headers, params = params)
    print "Add new contacts to the iMentor Platform (partner programs) check, status code: %s" % r.status_code

    #The check ID below belongs to iMentor Public Website.
    resource = "/checks/1298248"
    contact_ids_for_check = ",".join(website_contact_list)
    params = {"contactids": contact_ids_for_check}
    r = requests.put(base_url + resource, auth = HTTPBasicAuth(auth_email, auth_pwd), headers = headers, params = params)
    print "Add new contacts to the iMentor Public Website check, status code: %s" % r.status_code

def get_checks():

    app_key = PINGDOM_APP_KEY
    auth_email = PINGDOM_AUTH_EMAIL
    auth_pwd = PINGDOM_AUTH_PWD
    base_url = PINGDOM_BASE_URL
    headers = {"App-Key": app_key}
    
    #We obtain details about our existing checks, in particular the ID for the check modifications in update_contacts().
    resource = "/checks"
    params = None
    r = requests.get(base_url + resource, auth = HTTPBasicAuth(auth_email, auth_pwd), headers = headers, params = params)
    json_results = json.loads(r.text)
    print json_results["checks"]

if __name__ == "__main__":
    update_contacts()
    #get_checks()