#!/usr/bin/env python
import sys
import time
from skipped import *
from helper_utilities import *

import json
import requests
from requests.auth import HTTPBasicAuth

import string
import copy

import nose

#Basic Authentication Credentials to access the dev site
BASIC_USER='imentor'
BASIC_PASSWORD='2qa3ws4ed5rf6tg7yh'

#Mentot/mentee Login Credentials
mentee_login = {'email': 'Mentee_02242015_1@auto.com', 'password': 'test123'}

#These are the common headers used for all the API's
plain_headers = {'Content-Type': 'application/json;charset=UTF-8', 'Accept': 'application/json, text/plain, */*',
    'connection': 'keep-alive', 'Host': 'automation.imentor.org','Accept-Language': 'en-US,en;q=0.8',
    'Accept-Encoding': 'gzip, deflate'}


target_json=[{'id': 1, 'name': 'Target'}, {'id': 2, 'name': 'Safety'}, {'id': 3, 'name': 'Reach'},
             {'id': 0, 'name': 'No selection'}, {'id': 4, 'name': 'Not sure'}]


gURL = get_url()
print(gURL)
plain_headers['Host'] = "automation.imentor.org"

#Generic Choices
YES=1
NA=2
NONE=0

#Category choices 
CATEGORY_TARGET=1
CATEGORY_SAFETY=2
CATEGORY_REACH=3
CATEGORY_NOTSURE=4

#Result choices
RESULT_ACCEPTED=1
RESULT_REJECTED=2
RESULT_WAITLISTED=3

#The Lists for various fields and their choices
#None/Yes
app_completion_choice=[NONE,YES]
#None/Yes/NA
app_review_choice=[NONE,YES,NA]
#None/Yes/NA
fee_payment_choice=[NONE,YES,NA]
#None/Yes/NA
transcript_submission_choice=[NONE,YES,NA]
#None/Yes/NA
essay_submission_choice=[NONE,YES,NA]
#None/Yes/NA
recommendation_submission_choice=[NONE,YES,NA]
#None/Yes/NA
fafsa_submission_choice=[NONE,YES,NA]
#None/Accepted/Rejected/WaitListed
result_choice=[NONE,RESULT_ACCEPTED,RESULT_REJECTED,RESULT_WAITLISTED]
#None/Yes/NA
test_submission_choice=[NONE,YES,NA]
#None/Terget/Safety/Reach/NotSure
category_id_choice=[NONE,CATEGORY_TARGET,CATEGORY_SAFETY,CATEGORY_REACH,CATEGORY_NOTSURE]

#The format in which the date accepted as input is
#diffrent than the response received, need to be consistent
#in rest api implementation
app_submission_choice=[]
app_deadline_choice=[]


#Create a session and preserve the cookie across the api's
session=requests.Session()

Logged_In = False

#Logs in using Basic and Mentee Credentials there by creating a
#Session
def Login():
    global session
    global mentee_login
    global gURL
    global Logged_In

    Logged_In = False

    func_name = sys._getframe().f_code.co_name
    #print(func_name)

    MyHeader=plain_headers
    MyHeader.update({'X-Requested-With': 'XMLHttpRequest'})

    url = gURL + '/iuser/ajax_login/'
    r=session.post(url,
            #auth=HTTPBasicAuth(BASIC_USER,BASIC_PASSWORD),
            headers=MyHeader,
            data=json.dumps(mentee_login),
            verify=True
                         )
    if(r.status_code==requests.codes.ok):
        MyCookie=r.headers['set-cookie']
        #print(MyCookie)
        #print(r.text)
        res=json.loads(r.text)
        print(res)
        assert(res['success']==True)
        print('Logged In')
        Logged_In = True
    else:
        print(r.status_code)
        print('Log In Fail')
        assert(False)




#Searches for colleges containing the string 'santa' as specified
#by parameter 'Search' and return the subset pf result data in
#'AddCollegeList' which is a college List found
def SearchCollege(Search):
    global session
    global gURL
    #time.sleep(10)

    func_name = sys._getframe().f_code.co_name
    #print(func_name)

    url = gURL + '/cchklist/fullsearch/'+Search+'/'
    r=session.get(url,
                  headers=plain_headers,
                  #auth=HTTPBasicAuth(BASIC_USER,BASIC_PASSWORD),
                  verify=True
                  )

    if(r.status_code==requests.codes.ok):
        #print(r.text)
        AddCollegeList=json.loads(r.text)
        #print(AddCollegeList)
        #Generate dict with the 'alias' key pair eliminated
        #This is to generate the list 'AddCollegeList' which
        #is subset of data later passed as body to HTTP api
        #in 'Addcollege' for adding colleges. The below logic
        #also verifies if the college name and it's alias
        #contains the string we searched for.
        for i in range (0,len(AddCollegeList)):
            str1=str((AddCollegeList[i])['name'])
            str2=str((AddCollegeList[i])['alias'])
            if ((str1.lower()).find(Search.lower()) < 0):
                if((str2.lower()).find(Search.lower()) < 0):
                    assert(False)
            del (AddCollegeList[i])['alias']
    else:
        print(r.status_code)
        assert(False)

    return AddCollegeList




#Adds all the colleges corresponding to the data contained
#in  'CollegeList' parameter passed
def AddCollege(CollegeList):
    global session
    global gURL
    ID=[]
    func_name = sys._getframe().f_code.co_name
    #print(func_name)


    #Generate the body 'final' to be passsed as parameter to add colleges
    final=[]
    for i in range (0,len(CollegeList)):
        #Generate the body to be passed to add the college
        payload={'college':'none','category_id':0}
        payload['college']=CollegeList[i]
        #print(payload)
        #This is a list of 'body' to be passed for all colleges being
        #added
        final.append(payload)

    #print(final)

    #Add colleges
    for i in range(0,len(final)):
        #print(final[i])
        url = gURL + '/cchklist/picks/'
        r=session.post(url,
                headers=plain_headers,
                #auth=HTTPBasicAuth(BASIC_USER,BASIC_PASSWORD),
                data=json.dumps(final[i]),
                verify=True
                             )
        if(r.status_code==requests.codes.ok):
            #print(r.text)
            res=json.loads(r.text)
            #print(res)
            #global ID
            ID.append(res.get('id'))
            #print(ID)
            assert(res['success']==True)
        else:
            print(r.status_code)
            assert(False)

    #return the list of 'id's for all colleges added
    return ID




#Reads the data for List of colleges currently added
#and returns it
def ReadList():
    global session
    global gURL
    func_name = sys._getframe().f_code.co_name
    #print(func_name)

    url = gURL + '/cchklist/picks/'
    r=session.get(url,
            headers=plain_headers,
            #auth=HTTPBasicAuth(BASIC_USER,BASIC_PASSWORD),
            verify=True
                         )

    if(r.status_code==requests.codes.ok):
        MyList=json.loads(r.text)
        #print(MyList)
    else:
        print(r.status_code)
        assert(False)

    return MyList



#Verify if the api returns the various choices for the
#Target for college correctly. The choices are
#None/No Selection/Safety/Target/Reached
def GetCategoryChoices():
    #time.sleep(10)
    global session
    global gURL

    func_name = sys._getframe().f_code.co_name
    #print(func_name)

    url = gURL + '/cchklist/picks/choices/'
    r=session.get(url,
            headers=plain_headers,
            #auth=HTTPBasicAuth(BASIC_USER,BASIC_PASSWORD),
            verify=True
                  )
    if(r.status_code==requests.codes.ok):
        List=json.loads(r.text)
        print(List)
        #removes the 'ordinal' key:value pair
        for i in range(0,len(List)):
            del List[i]['ordinal']

        #Re-ordering the dict list
        for i in range(0,len(List)):
         x=List[i]['id']
         List[i]['id']=x

        #print(List)
        #verify if the response matches the expected data
        assert(target_json==List);
    else:
        print(r.status_code)
        assert(False)




#Sets the category for all colleges in 'CollegeList' as 'specified
#by choice in 'target'
def SetCategory(CollegeList,target):
    global session
    global gURL

    func_name = sys._getframe().f_code.co_name
    #print(func_name)

    for i in range(0,len(CollegeList)):
        payload=CollegeList[i]
        #change the target as Safety. 1-Target,2-Safety and 3-Reach
        payload['category_id']=target
        #print(payload)
        url = gURL + '/cchklist/picks/'
        r=session.post(url,
                headers=plain_headers,
                #auth=HTTPBasicAuth(BASIC_USER,BASIC_PASSWORD),
                data=json.dumps(payload),
                verify=True
                             )
        if(r.status_code==requests.codes.ok):
            #print(r.text)
            res=json.loads(r.text)
            #print(res)
            assert(res['success']==True)
        else:
            print(r.status_code)
            assert(False)

    CollegeList=ReadList()
    #Verify if the category_id changed as 'target'
    #for all the colleges
    for i in range(0,len(CollegeList)):
        assert(CollegeList[i]['category_id']==target)





#Delets the colleges specified by 'List'
#parameter 'Bad' if 'True' then invokes the
#api with incorrect data to check if the api
#return error
def DeleteCollege(List,Bad=False):
    global session
    global gURL
    func_name = sys._getframe().f_code.co_name
    print(func_name)

    #CollegeList=ReadList()
    #Totacount=len(CollegeList)
    Listlen=len(List)

    #generate the list of the 'id''s for all colleges to be deleted
    for i in range(0,Listlen):
        #access the 'id' of each college which are added to issue
        #delete college HTTP api
        ID=List[i]
        DID=ID['id']

        #corruput the api data
        if(Bad==True):
            DID=(DID+1)*7

        #print(DID)

        url = gURL + '/cchklist/picks/pick/'+str(DID)+'/'
        r=session.delete(url,
                headers=plain_headers,
                #auth=HTTPBasicAuth(BASIC_USER,BASIC_PASSWORD),
                verify=True
                             )

        if(r.status_code==requests.codes.ok):
            #print(r.text)
            res=json.loads(r.text)
            #assert(Bad==False)
            #print(res)
            assert(res['success']==True)
        else:
            print(r.status_code)
            #assert(Bad==True)
            #assert(False)

    #CollegeList=ReadList()
    #assert((len(CollegeList)==(Totacount-Listlen)))



#Excersises the api to change the various fileds of a
#college data passed with all possible values.
#parameter 'Bad' if 'True' then invokes the
#api with incorrect data to ensure api returns error

def SetCollegeDetails(List,Bad):
    global session
    global gURL
    offset=0

    func_name = sys._getframe().f_code.co_name
    #print(func_name)

    #print(List)
    #Know the 'id' of the college
    ID=List['id']
    #print(ID)

    if (Bad==True):
        #Non zero offset to corruput the api param data
        offset=1
        #Back up the original list of the college
        CloneList=copy.deepcopy(List)


    for i in range(0,6):
        #Construct the api param data and call the api for all possible values of the each field
        List['category_id']=category_id_choice[i%len(category_id_choice)] + (max(category_id_choice)+1)*offset
        List['app_completion']=app_completion_choice[i%len(app_completion_choice)] + (max(app_completion_choice)+1)*offset
        List['app_review']=app_review_choice[i%len(app_review_choice)] + (max(app_review_choice)+1)*offset
        List['fee_payment']=fee_payment_choice[i%len(fee_payment_choice)] + (max(fee_payment_choice)+1)*offset
        List['transcript_submission']=transcript_submission_choice[i%len(transcript_submission_choice)] + (max(transcript_submission_choice)+1)*offset
        List['essay_submission']=essay_submission_choice[i%len(essay_submission_choice)] + (max(essay_submission_choice)+1)*offset
        List['recommendation_submission']=recommendation_submission_choice[i%len(recommendation_submission_choice)] + (max(recommendation_submission_choice)+1)*offset
        List['fafsa_submission']=fafsa_submission_choice[i%len(fafsa_submission_choice)] + (max(fafsa_submission_choice)+1)*offset
        List['result']=result_choice[i%len(result_choice)] + (max(result_choice)+1)*offset
        List['test_submission']=test_submission_choice[i%len(test_submission_choice)] + (max(test_submission_choice)+1)*offset
        List['app_submission']='05/28/15'
        List['app_deadline']='06/17/15'

        url = gURL + '/cchklist/picks/'
        r=session.post(url,
                headers=plain_headers,
                #auth=HTTPBasicAuth(BASIC_USER,BASIC_PASSWORD),
                data=json.dumps(List),
                verify=True
                             )
        
        if(r.status_code==requests.codes.ok):
            #print (List)
            assert(Bad==False)
            #print(r.text)
            res=json.loads(r.text)
            #print(res)
            assert(res['success']==True)
        else:
            print(r.status_code)
            assert(Bad==True)

        CollegeList=ReadList()

        #re-copy the backed up orignal college list data
        #to compare against the latest data for the college
        #Incase of tesing for the corrupt data. The latest data
        #for the college should be same as what was passed as
        #parameter to the function.
        if (Bad==True):
            List=copy.deepcopy(CloneList)

        if (Bad==True):
            List['app_submission']=CloneList['app_submission']
            List['app_deadline']=CloneList['app_deadline']


        for i in range(0,len(CollegeList)):
            #Find the college data from list of colleges for which the api being executed
            if (ID==(CollegeList[i])['id']):
                #Ensure the data read for the college matches with the expected data
                assert(CollegeList[i]['category_id']==List['category_id'])
                assert(CollegeList[i]['app_completion']==List['app_completion'])
                assert(CollegeList[i]['app_review']==List['app_review'])
                assert(CollegeList[i]['fee_payment']==List['fee_payment'])
                assert(CollegeList[i]['transcript_submission']==List['transcript_submission'])
                assert(CollegeList[i]['essay_submission']==List['essay_submission'])
                assert(CollegeList[i]['recommendation_submission']==List['recommendation_submission'])
                assert(CollegeList[i]['fafsa_submission']==List['fafsa_submission'])
                assert(CollegeList[i]['result']==List['result'])
                assert(CollegeList[i]['test_submission']==List['test_submission'])

                #print (CollegeList[i]['app_submission'] + '----'+ List['app_submission'] +'----'+CollegeList[i]['app_deadline'] + '----'+ List['app_deadline'])
                #assert(CollegeList[i]['app_submission']==List['app_submission'])
                #assert(CollegeList[i]['app_deadline']==List['app_deadline'])
                break

        print('Check for the college details having changed')
        if(Bad==True):
            print('They should not as its Bad data')                  
        time.sleep(2)




#Logout iMentor Session
def Logout():
    global session
    global gURL
    func_name = sys._getframe().f_code.co_name
    #print(func_name)

    if Logged_In is False:
        return

    url = gURL + '/iuser/logout/'
    r=session.get(url,
            headers=plain_headers,
            #auth=HTTPBasicAuth(BASIC_USER,BASIC_PASSWORD),
            verify=True
                         )

    #print(r.status_code)
    if(r.status_code==requests.codes.ok):
        #print(r.text)
        print('Logged out')
        return
    else:
        print(r.status_code)
        print('Failed to Log out')        
        assert(False)



def tes_t_VerifyCategotyChoices():
    Login()
    GetCategoryChoices()

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Tests
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class test_APItests:

    def setUp(self):
        print('------------------------------------------------------------------')
        time.sleep(1)
        #Login to create a mentee session
        #Login()
        pass

    #Searches for colleges containing the string 'harv',
    #Adds them, sets the target for all colleges and then
    #deletes all colleges from the list
    @skipped()
    def test_cchklist_SearchAddTargetDleleteCollege(self):
        func_name = sys._getframe().f_code.co_name
        print(func_name)        

        #Login to create a mentee session
        Login()

        #delete the college list data if anything existing
        #this is to start test with clean data
        CollegeList=ReadList()
        if (len(CollegeList)>0):
            DeleteCollege(CollegeList)
        CollegeList=ReadList()
        assert((len(CollegeList)==0))

        #Search for the colleges with the partial string
        #and ensure the colleges are found
        CollegeList=SearchCollege('harv')
        count=len(CollegeList)
        assert(count>0)
        print('Search for the colleges containing string harv yielded '+str(count)+' results')

        #Add colleges found in search and ensure
        #the number of colleges added matches
        #with the number of colleges found in search
        CollegeIdList=AddCollege(CollegeList)
        assert(len(CollegeList)==count)
        print('Added colleges')

        #time.sleep(10)

        #read the list of colleges added and verify
        #again to see if the number of colleges matches
        #with number of colleges found in search
        CollegeList=ReadList()
        assert(len(CollegeList)==count)

        #Set the target as Safety for all colleges in the
        #list
        SetCategory(CollegeList,2)
        print('Set the category to Safety')
        
        #time.sleep(10)

        #Delete all the colleges in the list
        DeleteCollege(CollegeList)
        print('Deleted the colleges')
        #verify if the college list read is empty
        CollegeList=ReadList()
        assert((len(CollegeList)==0))

        #time.sleep(10)

    @skipped()
    def test_cchklist_VerifyCategotyChoices(self):
        func_name = sys._getframe().f_code.co_name
        print(func_name)        

        #Login to create a mentee session
        Login()

        GetCategoryChoices()

    @skipped()
    def test_cchklist_SearchAddSetDetailsDeleteCollege(self):
        func_name = sys._getframe().f_code.co_name
        print(func_name)        

        #Login to create a mentee session
        Login()

        #delete the college list data if anything existing
        #this is to start test with clean data
        CollegeList=ReadList()
        if (len(CollegeList)>0):
            DeleteCollege(CollegeList)
        CollegeList=ReadList()
        assert((len(CollegeList)==0))

        #Search for the colleges with the partial string
        #and ensure the colleges are found
        CollegeList=SearchCollege('harv')
        count=len(CollegeList)
        assert(count>0)
        print('Search for the colleges containing string harv yielded '+str(count)+' results')

        #Add colleges found in search and ensure
        #the number of colleges added matches
        #with the number of colleges found in search
        CollegeIdList=AddCollege(CollegeList)
        assert(len(CollegeList)==count)
        print('Added colleges')

        #time.sleep(10)
        
        #Set the target as Safety for all colleges in the
        #list
        CollegeList=ReadList()
        assert(len(CollegeList)==count)
        SetCategory(CollegeList,1)
        print('Set the category to Target for all colleges')        

        #time.sleep(10)
        
        CollegeList=ReadList()
        assert(len(CollegeList)==count)
        #Excersise the various fields for the college
        #being passed with all possible values and verify
        #the expcted behaviour
        SetCollegeDetails(CollegeList[0],False)

        #time.sleep(20)
        #Delete all the colleges in the list
        DeleteCollege(CollegeList)
        print('Deleted the colleges')
        #verify if the college list read is empty
        CollegeList=ReadList()
        assert((len(CollegeList)==0))

        #time.sleep(10)

    #The following test case has been disabled as it triggers crash in server
    @skipped()
    def test_cchklist_SearchAddBadSetDetailsBadDeleteCollege(self):
        func_name = sys._getframe().f_code.co_name
        print(func_name)        

        #Login to create a mentee session
        Login()

        #delete the college list data if anything existing
        #this is to start test with clean data
        CollegeList=ReadList()
        if (len(CollegeList)>0):
            DeleteCollege(CollegeList)
        CollegeList=ReadList()
        assert((len(CollegeList)==0))

        #Search for the colleges with the partial string
        #and ensure the colleges are found
        CollegeList=SearchCollege('harv')
        count=len(CollegeList)
        assert(count>0)
        print('Search for the colleges containing string harv yielded '+str(count)+' results')        

        #Add colleges found in search and ensure
        #the number of colleges added matches
        #with the number of colleges found in search
        CollegeIdList=AddCollege(CollegeList)
        assert(len(CollegeList)==count)
        print('Added colleges')

        #time.sleep(10)

        #Set the target as Safety for all colleges in the
        #list
        CollegeList=ReadList()
        assert(len(CollegeList)==count)
        SetCategory(CollegeList,3)
        print('Set the category to Reach for all colleges')          

        #time.sleep(10)

        #Excersise the various fields for the college
        #being passed with corrupt values and verify
        #the expcted behaviour
        CollegeList=ReadList()
        assert(len(CollegeList)==count)
        SetCollegeDetails(CollegeList[0],True)

        #time.sleep(10)
        
        #try Delete all the colleges in the list with
        #corrupt data
        DeleteCollege(CollegeList,True)
        #verify if the college list is not emptied
        CollegeList=ReadList()
        assert((len(CollegeList)==count))
        print('Attempted to delete colleges but should fail, thats expected with bad college id')
        #time.sleep(10)

    def tearDown(self):
        #Logs out of iMentor session
        #Logout()
        pass
