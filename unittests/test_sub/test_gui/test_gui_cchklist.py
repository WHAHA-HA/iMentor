import os
from selenium import webdriver
from selenium.webdriver.common.by import By
import unittest, time, re
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions
from selenium.common.exceptions import NoSuchElementException
import sys
from skipped import *
from helper_utilities import *

LoginCred = ({'MenteeName': 'Mentee_02242015_1@auto.com', 'MenteePasswd': 'test123',
              'MentorName': 'Mentor_02112015_1@auto.com', 'MentorPasswd': 'test123'},
             {'MenteeName': 'Mentee_02242015_1@auto.com', 'MenteePasswd': 'test123',
              'MentorName': 'Mentor_02112015_1@auto.com', 'MentorPasswd': 'test123'}
             )

browser = ""

app_completion = 'Is your application complete?'
app_review = 'Have you reviewed your application?'
fee_payment = 'Have you paid your application fee?'
transcript_submission = 'Did you submit your transcripts?'
test_submission = 'Did you submit your test scores?'
essay_submission = 'Did you submit your essay and personal statement?'
recommendation_submission = 'Did you submit your letters of recommendation?'
fafsa_submission = 'Did you submit your FAFSA?'
going_to_college = "Are you going to this college?"

CollegList = (('santa', 'Anamarc College-Santa Teresa', 'Safety'),
              ('hat', 'Chattanooga State Community College', 'Reach'),
              ('harv', 'Harvard University', 'Target'),
              ('harv', 'City Colleges of Chicago-Olive-Harvey College', 'Not sure')
              )

CategoryId = ('Not sure', 'Safety', 'Target', 'Reach')

SearchColleg = (('Santa', ('Anamarc College-Santa Teresa', 'Santa Fe College', 'Antioch University-Santa Barbara',
                           'Santa Fe University of Art and Design'), 10),
                ('Harv', ('City Colleges of Chicago-Olive-Harvey College', 'Harvard University', 'Harvey Mudd College'),
                 3),
                ('Wxyz', (), 0)
                )

ChkDteails = (({app_completion: 'none', app_review: 'Yes', fee_payment: 'Yes', transcript_submission: 'none',
                test_submission: 'none', essay_submission: 'none', recommendation_submission: 'none',
                fafsa_submission: 'N/A', going_to_college: 'No'},
               {'app_submission': '05/28/15', 'result': 'Waitlisted', 'Closure': 'Ignore'},
               {'app_deadline': '06/17/15', 'perc': '50.0'}),
              ({app_completion: 'Yes', app_review: 'N/A', fee_payment: 'Yes', transcript_submission: 'N/A',
                test_submission: 'Yes', essay_submission: 'N/A', recommendation_submission: 'Yes',
                fafsa_submission: 'N/A', going_to_college: 'Yes'},
               {'app_submission': '05/28/15', 'result': 'Accepted', 'Closure': 'Close'},
               {'app_deadline': '06/17/15', 'perc': '90.90'}),
              ({app_completion: 'Yes', app_review: 'Yes', fee_payment: 'Yes', transcript_submission: 'Yes',
                test_submission: 'Yes', essay_submission: 'N/A', recommendation_submission: 'Yes',
                fafsa_submission: 'N/A', going_to_college: 'No'},
               {'app_submission': '05/28/15', 'result': 'Rejected', 'Closure': 'Ignore'},
               {'app_deadline': '06/17/15', 'perc': '90.90'}),
              ({app_completion: 'Yes', app_review: 'N/A', fee_payment: 'N/A', transcript_submission: 'N/A',
                test_submission: 'N/A', essay_submission: 'N/A', recommendation_submission: 'N/A',
                fafsa_submission: 'N/A', going_to_college: 'Yes'},
               {'app_submission': '05/28/15', 'result': 'Accepted', 'Closure': 'Close'},
               {'app_deadline': '06/17/15', 'perc': '90.90'}))

gBase_url = get_url()
print(gBase_url)

GLOBAL_TIMEOUT = 20

def SetGlobalTimeout(driver, sec):
    driver.implicitly_wait(sec)

# Logs in to the imentor as mentee/mentor login credentials and navigates
# to college checklist page
def Login(UnitObj, user, passwd):
    global browser
    global gBase_url
    driver = UnitObj.driver
    driver.get(gBase_url + "/#/")

    el = WebDriverWait(driver, 20).until(
            expected_conditions.element_to_be_clickable((By.LINK_TEXT, "Sign in"))
    )
    el.click()

    el = WebDriverWait(driver, 20).until(
            lambda driver: driver.find_element_by_id("email")
    )
    el.clear()
    driver.find_element_by_id("email").send_keys(str(user))
    driver.find_element_by_id("password").clear()
    driver.find_element_by_id("password").send_keys(str(passwd))
    driver.find_element_by_id("sign-in").click()

    el = driver.find_elements_by_xpath("//*[contains(text(),'Canvas')]")
    time.sleep(5)
    url = gBase_url+ '/cchklist/list/#/'
    driver.get(url)
    el = driver.find_elements_by_xpath("//*[contains(text(),'College Checklist')]")


# Logs out as the mentee/mentor from college checklist home page
# precondition-should be at college checklist home page
def Logout(UnitObj):
    driver = UnitObj.driver
    xpath = "//*[contains(text(),'College Checklist')]/../*/button"
    WebDriverWait(driver, 20).until(
            expected_conditions.element_to_be_clickable((By.XPATH, xpath))
    ).click()
    WebDriverWait(driver, 15).until(
            expected_conditions.element_to_be_clickable((By.LINK_TEXT, "Sign out"))
    ).click()
    el = WebDriverWait(driver, 20).until(
            expected_conditions.element_to_be_clickable((By.LINK_TEXT, "Sign in"))
    )
    assert el is not None, 'Failure to find Sign in button post log out'


# Deletes all the colleges added if there are any from the college
# checklist home page.
# precondition-should be at college checklist home page
def deleteAll(UnitObj):
    driver = UnitObj.driver
    time.sleep(2)
    limit = 0
    Count = 0
    while True:
        list = []
        try:
            SetGlobalTimeout(driver, 5)
            el = WebDriverWait(driver, 5).until(
                    expected_conditions.visibility_of_element_located((By.XPATH, "//i[@class='fa fa-trash-o']"))
            )
            SetGlobalTimeout(driver, GLOBAL_TIMEOUT)
            if el is None:
                pass
            else:
                list = driver.find_elements_by_xpath("//i[@class='fa fa-trash-o']")
        except:
            pass
        Count = len(list)
        if (Count == 0 or limit > 3):
            break
        for i in range(0, Count):
            list[Count - i - 1].click()
            limit += 1
            time.sleep(1)
    return Count


# Seraches for the colleges based on the search strings provided
# as the test data at college checklist home page.
# precondition-should be at college checklist home page
def SearchCollege(UnitObj, SearchStr, ContainsStr=None):
    driver = UnitObj.driver
    if ContainsStr is None:
        ContainsStr = SearchStr

    el = WebDriverWait(driver, 20).until(
            expected_conditions.element_to_be_clickable((By.XPATH, "//input[@type='text']"))
    )
    el.clear()
    el.send_keys(str(SearchStr))
    sxpath = "//a[contains(.,'" + str(ContainsStr) + "')]"
    list = []
    try:
        SetGlobalTimeout(driver, 6)
        el = WebDriverWait(driver,6).until(
                expected_conditions.element_to_be_clickable((By.XPATH, sxpath))
        )
        SetGlobalTimeout(driver, GLOBAL_TIMEOUT)
        if el is None:
            print('Search fail')
        else:
            list = driver.find_elements_by_xpath(sxpath)
    except:
        pass
    return list


# Add colleges based on the search string provided
# as the test data.
# precondition-should be at college checklist home page
def AddCollege(UnitObj, SearchStr, ContainsStr=None):
    driver = UnitObj.driver
    res = False
    list = []
    list = SearchCollege(UnitObj, SearchStr, ContainsStr)
    # print(len(list))
    if len(list) > 0:
        colname = list[0].text
        print(colname)
        list[0].click()
        res = True
        SetGlobalTimeout(driver, 5)
        el = WebDriverWait(driver, 5).until(
                expected_conditions.text_to_be_present_in_element((By.ID, 'coll-name'), colname)
        )
        SetGlobalTimeout(driver, GLOBAL_TIMEOUT)
    return res


# Add category for a college or all colleges as indicated
# by the test data
# precondition-should be at college checklist home page
def ChangeCategory(UnitObj, Category, CollegeName=None):
    driver = UnitObj.driver
    if CollegeName is None:
        xpath = "//button[not(contains(@class,'selected')) and  contains(.,'" + str(Category) + "')]"
        driver.refresh()
        print("refreshing..")
        SetGlobalTimeout(driver, 5)
        Elelist = driver.find_elements_by_xpath(xpath)
        SetGlobalTimeout(driver, GLOBAL_TIMEOUT)
        if len(Elelist) == 0:
            return
        print(Elelist)
        for j in range(0, len(Elelist)):
            el = Elelist[j]
            driver.execute_script("window.scrollTo(arguments[0],arguments[1])", el.location['x'],
                                  (el.location['y'] - 300))
            el.click()
            time.sleep(1)
    else:
        xpath = "//*[contains(text(),'" + str(CollegeName) + "')]" + \
                "/following-sibling::*/button[contains(text(),'" + str(Category) + "')]"
        WebDriverWait(driver, 10).until(
                expected_conditions.element_to_be_clickable((By.XPATH, xpath))
        ).click()
    return


# Edit the details
# by the test data
# precondition-should be at college checklist home page
def EditCollegeDetails(UnitObj, EleEditButton, ChkDteails):
    driver = UnitObj.driver
    time.sleep(2)
    ApplOptions_0 = ChkDteails[0]
    ApplOptions_1 = ChkDteails[1]

    EleEditButton.click()

    xpath = "//button[text()='"+str(ApplOptions_1['result']) +"']"
    el = WebDriverWait(driver, 20).until(
            expected_conditions.visibility_of_element_located((By.XPATH, xpath))
    )
    el.click()
    #driver.execute_script("arguments[0].scrollIntoView();", el)
    #driver.get_screenshot_as_file('./screenshot-3.png')
    #print(driver.page_source.encode("utf-8"))
    #res = driver.execute_script("return $(\"button:contains("+str(ApplOptions_1['result'])+")\").click()")
    #print(res)

    datakeys = ApplOptions_0.keys()
    for mkey in datakeys:
        print(mkey)
        if (ApplOptions_0[mkey] == 'none'):
            continue
        #time.sleep(2)
        xpath = "//*[@class='row fields']/*[contains(text(),'" + str(mkey) + "')]/../descendant::" \
                                                                             "button[contains(text(),'" + \
                str(ApplOptions_0[mkey]) + "')]"
        WebDriverWait(driver, 15).until(
                expected_conditions.element_to_be_clickable((By.XPATH, xpath))
        ).click()

    print(ApplOptions_1['Closure'])
    if (str(ApplOptions_1['Closure']).find('Close') > 0):
        WebDriverWait(driver, 15).until(
                expected_conditions.element_to_be_clickable((By.XPATH, "(//*[contains(., 'Close')])[last()]"))
        ).click()
    else:
        WebDriverWait(driver, 15).until(
                expected_conditions.element_to_be_clickable((By.XPATH, "//button[@ng-click='close()']"))
        ).click()
    return


class test_gui_cchklist:
    def setUp(self):
        print("I am setup")
        browser = get_browser()
        self.driver = get_driver(browser)
        self.driver.implicitly_wait(25)

    @skipped()
    def test_cchklist_EditCollegeDetails(self):
        print("---------------------------------------------------------")
        func_name = sys._getframe().f_code.co_name
        print(func_name)
        driver = self.driver
        list = []
        Count = 0
        going = False

        MyLogin = LoginCred[0]
        MenteeName = MyLogin['MenteeName']
        MenteePasswd = MyLogin['MenteePasswd']
        Login(self, MenteeName, MenteePasswd)

        Count = deleteAll(self)
        assert (Count == 0), str(Count)

        for i in range(0, len(CollegList)):
            AddCollege(self, CollegList[i][0], CollegList[i][1])
            ChangeCategory(self, CollegList[i][2], CollegList[i][1])

        el = WebDriverWait(driver, 20).until(
                expected_conditions.element_to_be_clickable((By.XPATH,
                                                             "//button[contains(., 'Update application progress')]"))
        )
        el.click()

        el = WebDriverWait(driver, 20).until(
                expected_conditions.element_to_be_clickable((By.ID, "editSchool"))
        )
        assert el is not None, 'Edit list button not found'

        Looplen = len(ChkDteails)
        for k in range(0, Looplen):
            if get_browser()!='phantom':
                print(ChkDteails[k][0])
                if ChkDteails[k][0][going_to_college] == 'Yes':
                    going = True
                else:
                    going = False
                xpath = "(//button[@class='edit-college'])["+str(k+1)+"]"
                print(xpath)
                el = WebDriverWait(driver, 20).until(
                        expected_conditions.element_to_be_clickable((By.XPATH, xpath))
                )

                EditCollegeDetails(self, el, ChkDteails[k])

            ColNameList1 = driver.find_elements_by_id("coll-name")
            strColName = ColNameList1[k].text
            print(strColName)

            el = WebDriverWait(driver, 10).until(
                    lambda driver: driver.find_element_by_id("checklist_header")
            )
            assert (str(el.text).find("Update progress on your applications") >= 0)
            time.sleep(1)
            ColNameList2 = driver.find_elements_by_id("coll-name")
            x = 0
            for x in range(len(ColNameList2)):
                if (str(ColNameList2[x].text).find(str(strColName)) is not -1):
                    break

            perc_old = float(
                driver.find_elements_by_xpath("//*[contains(@class,'progress-bar')]")[x].get_attribute('aria-valuenow'))

            xpath = "(//*[@class='coll-row-sm bolded dateBar'])[" + str(x + 1) + "]/div/input"
            WebDriverWait(driver, 15).until(
                    expected_conditions.element_to_be_clickable((By.XPATH, xpath))
            ).click()

            print("->" + str(x))
            xpath = "(//*[@class='coll-row-sm bolded dateBar'])[" + str(x + 1) + "]/div/div/div[6]/a[17]"
            WebDriverWait(driver, 15).until(
                    expected_conditions.element_to_be_clickable((By.XPATH, xpath))
            ).click()

            time.sleep(5)

            perc = float(
                driver.find_elements_by_xpath("//*[contains(@class,'progress-bar')]")[x].get_attribute('aria-valuenow'))
            if get_browser()!='phantom':
                #print(driver.find_elements_by_xpath("//*[contains(@class,'progress-bar')]"))
                if (perc < (float(ChkDteails[k][2]['perc']) - 1.0) or perc > (float(ChkDteails[k][2]['perc']) + 1.0)):
                    print(perc)
                    print(ChkDteails[k][2]['perc'])
                if going is True:
                    els = driver.find_elements_by_xpath("//*[@id='coll-name']")
                    el = driver.find_element_by_xpath(
                        "//*[contains(@class,'progress-bar progress-bar-success')]/ancestor::*[contains(@id, 'college_')]/descendant::*[contains(@id,'coll-name')]")
                    print(str(els[k].text) + "\n" + str(el.text))
                    assert els[k].text == el.text
                assert (perc >= (float(ChkDteails[k][2]['perc']) - 1.0) and perc <= (float(ChkDteails[k][2]['perc']) + 1.0))
            else:
                assert perc > perc_old

        # assert there is only one college to which mentee is going to if his application accepted and he has decided so
        if get_browser()!='phantom':
            if going is True:
                els = driver.find_elements_by_xpath("//*[contains(@class,'progress-bar progress-bar-success')]")
                if len(els) > 1:
                    print("Successful colleges : " + str(len(els)))
                assert len(els) == 1, 'Successful college not Found in Mentee College List'

        el = WebDriverWait(driver, 30).until(
                expected_conditions.element_to_be_clickable((By.ID, "editSchool")))
        driver.execute_script("window.scrollTo(arguments[0],arguments[1])", el.location['x'],
                              (el.location['y']-300))
        el.click()

        Count = deleteAll(self)
        assert (Count == 0)
        Logout(self)

    @skipped()
    def test_cchklist_SearchCollege(self):
        for i in range(1):
            print("---------------------------------------------------------")
            func_name = sys._getframe().f_code.co_name
            print(func_name)
            Count = 0
            ExpCollegeList = []

            MyLogin = LoginCred[0]
            MenteeName = MyLogin['MenteeName']
            MenteePasswd = MyLogin['MenteePasswd']
            Login(self, MenteeName, MenteePasswd)

            Count = deleteAll(self)
            assert (Count == 0)

            for i in range(0, len(SearchColleg)):
                Count = 0
                ExpCollegeList = SearchColleg[i][1]
                #time.sleep(2)
                collegeListEl = SearchCollege(self, SearchColleg[i][0])
                print(len(collegeListEl))
                assert (SearchColleg[i][2] == len(collegeListEl))
                for j in range(0, len(collegeListEl)):
                    if ((str(SearchColleg[i][0]) in collegeListEl[j].text) and (collegeListEl[j].text in ExpCollegeList)):
                        Count += 1
                print(str(Count) + " AND " + str(len(ExpCollegeList)))
                assert (Count == len(ExpCollegeList))
            Logout(self)

    @skipped()
    def test_cchklist_AddCollegeCategory(self):
        for i in range(1):
            print("---------------------------------------------------------")
            func_name = sys._getframe().f_code.co_name
            print(func_name)
            HowMany = 0
            Count = 0
            driver = self.driver
            Elelist = []

            MyLogin = LoginCred[0]
            MenteeName = MyLogin['MenteeName']
            MenteePasswd = MyLogin['MenteePasswd']
            Login(self, MenteeName, MenteePasswd)

            Count = deleteAll(self)
            assert (Count == 0)

            for i in range(0, len(SearchColleg)):
                while 1:
                    try:
                        print(SearchColleg[i][0])
                        res = AddCollege(self, SearchColleg[i][0])
                        if res is False:
                            break
                        HowMany += 1
                    except NoSuchElementException:
                        break
                time.sleep(1)

            Elelist = driver.find_elements_by_xpath("//i[@class='fa fa-trash-o']")
            print(HowMany)
            print(len(Elelist))
            assert (HowMany == len(Elelist))

            for i in range(0, len(CategoryId)):
                time.sleep(4)
                ChangeCategory(self, CategoryId[i])

            Count = deleteAll(self)
            assert (Count == 0)
            Logout(self)

    @skipped()
    def test_cchklist_MentorMenteeSync(self):
        for i in range(1):
            print("---------------------------------------------------------")
            func_name = sys._getframe().f_code.co_name
            print(func_name)
            HowMany = 0
            Count = 0
            driver = self.driver
            Elelist = []

            MyLogin = LoginCred[0]

            MenteeName = MyLogin['MenteeName']
            MenteePasswd = MyLogin['MenteePasswd']
            MentorName = MyLogin['MentorName']
            MentorPasswd = MyLogin['MentorPasswd']

            Login(self, MentorName, MentorPasswd)
            Count = deleteAll(self)
            assert (Count == 0)

            for i in range(0, (len(SearchColleg)) - 1):
                try:
                    strCollegeName = str(SearchColleg[i][1][0])
                    print(strCollegeName)
                    res = AddCollege(self, strCollegeName)
                    if res is False:
                        break
                    HowMany += 1
                except NoSuchElementException:
                    break

            ChangeCategory(self, 'Target')
            Logout(self)

            Login(self, MenteeName, MenteePasswd)
            el = WebDriverWait(driver, 20).until(
                    expected_conditions.element_to_be_clickable((By.XPATH, "//i[@class='fa fa-trash-o']"))
            )
            assert el is not None
            Elelist = driver.find_elements_by_xpath("//i[@class='fa fa-trash-o']")
            print("HowMany : " + str(HowMany) + " and " + "len(Elelist) : " + str(len(Elelist)))
            assert (HowMany == len(Elelist)), "Verify if mentee and mentor are matched?"
            CollegeNameList = driver.find_elements_by_id("coll-name")
            assert (len(CollegeNameList) == HowMany)

            categoryList = driver.find_elements_by_xpath("//button[contains(text(),'Target')]")
            for i in range(HowMany):
                assert (CollegeNameList[i].text in SearchColleg[i][1][0])
                # Following api does not work. It returns False always
                # print(categoryList[i].is_selected())
                assert (str(categoryList[i].get_attribute('class')).find("selected") is not -1)

            Count = deleteAll(self)
            assert (Count == 0)
            Logout(self)

            Login(self, MentorName, MentorPasswd)
            CollegeNameList = driver.find_elements_by_id("coll-name")
            assert (len(CollegeNameList) == 0)
            Logout(self)

    def tearDown(self):
        self.driver.quit()


if __name__ == "__main__":
    unittest.main()
