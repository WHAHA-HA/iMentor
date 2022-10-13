import os
from datetime import date, datetime
import array
from selenium import webdriver
from selenium.webdriver.common.by import By
import time
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions
from selenium.webdriver.support.ui import Select
from selenium.webdriver.common.keys import Keys
from selenium.webdriver import ActionChains
from selenium.common.exceptions import *
from skipped import *
from helper_utilities import *
import random


gUserName = ""
gPassword = ""

gHandleAlert = False
gUseTab = False

MentorContactPage = (
    (  # ({'deselectopt': ({'nonthing': 'nonthing'})}),
       ({'textbox': {'Preferred First Name': 'Varun'}}),
       ({'textbox': {'Preferred Last Name': 'Sharma'}}),
       ({'textbox': {'Legal First Name': 'Varu'}}),
       ({'textbox': {'Legal Last Name': 'sharma'}}),
       ({'NR': {'textbox': {'Additional Email Address': 'san@gmail.com'}}}),
       ({'phone': {'Primary Phone Number': ('974', '248', '3082')}}),
       ({'selectIndex_1': {'option': {'Is this a cell phone?': ('Yes',)}}}),
       ({'NR': {'phone': {'Secondary Phone Number': ('974', '248', '3082')}}}),
       ({'NR': {'selectIndex_2': {'option': {'Is this a cell phone?': ('Yes',)}}}}),
       ({'option': {'Can iMentor NYC send you text message reminders': ('No',)}}),
       ({'address': {'Your Home Address': {'address': '185/15,North Street', 'city': 'San Jose', 'state': 'California',
                                           'zip': '1234'}}}),
       ({'autotextbox': {'Employer': 'Camintel'}}),
       ({'textbox': {'Job Title': 'tester'}}),
       ({'address': {'Work Address': {'address': '122/13,Times Street', 'city': 'San Mateo', 'state': 'California',
                                      'zip': '4567'}}}),
       ({'dob': {'What is your birthday?': ('October', '18', '1982')}}),
       ({'option': {'With which gender do you most closely identify?': ('Male',)}}),
       (
           {'option': {
               'With which race or races do you identify?': ('Black / African American', 'White (Non-Hispanic)')}}),
       ({'NR': {
           'option': {'Which location is more convenient for you? (Check all that apply)': ('Brooklyn', 'The Bronx')}}}),
       ({'NR': {'option': {'Which of the following transit options are most convenient for you? (Check all that apply)':
                               ('1/2/3', 'N/Q/R')}}}),
       ({'option': {
           'Program Preferences (Check all that apply)': (
               'No Preference',)}}),
       ({'ClickNextButton': 'none'}),
       # ({'sleep': 5})
       ),
    (  # ({'sleep': 5}),
       ({'textbox': {'Preferred First Name': 'arun'}}),
       ({'textbox': {'Preferred Last Name': 'harma'}}),
       ({'textbox': {'Legal First Name': 'Varu'}}),
       ({'textbox': {'Legal Last Name': 'sharma'}}),
       ({'NR': {'textbox': {'Additional Email Address': 'san@gmail.com'}}}),
       ({'phone': {'Primary Phone Number': ('974', '248', '3082')}}),
       ({'selectIndex_1': {'option': {'Is this a cell phone?': ('Yes',)}}}),
       ({'NR': {'phone': {'Secondary Phone Number': ('974', '248', '3082')}}}),
       ({'NR': {'selectIndex_2': {'option': {'Is this a cell phone?': ('Yes',)}}}}),
       ({'option': {'Can iMentor NYC send you text message reminders': ('No',)}}),
       ({'address': {'Your Home Address': {'address': '185/15,North Street', 'city': 'San Jose', 'state': 'California',
                                           'zip': '1234'}}}),
       ({'autotextbox': {'Employer': 'Camintel'}}),
       ({'textbox': {'Job Title': 'tester'}}),
       ({'address': {'Work Address': {'address': '122/13,Times Street', 'city': 'San Mateo', 'state': 'California',
                                      'zip': '4567'}}}),
       ({'dob': {'What is your birthday?': ('October', '18', '1982')}}),
       ({'option': {'With which gender do you most closely identify?': ('Male',)}}),
       (
           {'option': {
               'With which race or races do you identify?': ('Black / African American', 'White (Non-Hispanic)')}}),
       ({'NR': {
           'option': {'Which location is more convenient for you? (Check all that apply)': ('Brooklyn', 'The Bronx')}}}),
       ({'NR': {'option': {'Which of the following transit options are most convenient for you? (Check all that apply)':
                               ('1/2/3', 'N/Q/R')}}}),
       ({'option': {
           'Program Preferences (Check all that apply)': (
               'No Preference',)}}),
       ({'ClickNextButton': 'none'}),
       ({'sleep': 5})
       ),
)

MentorEvaluatePage = (
    (
        ({'option': {'Is this the first time you will be a mentor in a volunteer program?': ('Yes',)}}),
        # ({'textarea': {'Please list all of the programs you have mentored with in the past:': 'Forget Past'}}),
        ({'NR': {'option': {'What is your annual household income?': ('$51,000 - $75,000',)}}}),
        ({'option': {'What was the highest level of education that you completed?': ('PhD, JD, or MD',)}}),
        ({'sleep': 3}),
        ({'autotextbox': {'At what schools (colleges and graduate schools) did you study?':
                              'Academy for Jewish Religion-California'}}),
        ({'option': {'Did either of your parents (or guardians) graduate from college?': ('No',)}}),
        ({'option': {'Do you speak a language other than English?': ('Yes',)}}),
        (
            {'NR': {'option': {'What is the primary language (other than English) that you speak?': ('French', 'Urdu',)}}}),
        ({'NR': {'option': {'What is your proficiency in the language above?': ('Basic',)}}}),
        ({'NR': {'textarea': {'If you speak additional languages, please indicate which additional languages here:':
                                  'Monkey Language'}}}),
        ({'option': {'How did you hear about iMentor NYC?': ('Facebook',)}}),
        ({'option': {'Where have you seen an iMentor ad? (Check all that apply)': ('LinkedIn', 'TV Ad')}}),
        ({'NR': {'textbox': {'Who referred you to iMentor NYC?': 'Never mind'}}}),
        ({'sleep': 5}),
        ({'ClickNextButton': 'none'}),
    ),
    (
        ({'option': {'Is this the first time you will be a mentor in a volunteer program?': ('Yes',)}}),
        ({'NR': {'option': {'What is your annual household income?': ('$51,000 - $75,000',)}}}),
        ({'option': {'What was the highest level of education that you completed?': ('PhD, JD, or MD',)}}),
        ({'autotextbox': {'At what schools (colleges and graduate schools) did you study?':
                              'Academy for Jewish Religion-California'}}),
        ({'option': {'Did either of your parents (or guardians) graduate from college?': ('No',)}}),
        ({'option': {'Do you speak a language other than English?': ('Yes',)}}),
        ({'sleep': 3}),
        ({'NR': {'option': {'What is the primary language (other than English) that you speak?': ('French', 'Urdu')}}}),
        ({'NR': {'option': {'What is your proficiency in the language above?': ('Basic',)}}}),
        ({'NR': {'textarea': {'If you speak additional languages, please indicate which additional languages here:':
                                  'Monkey Language'}}}),
        ({'option': {'How did you hear about iMentor NYC?': ('Facebook',)}}),
        ({'option': {'Where have you seen an iMentor ad? (Check all that apply)': ('LinkedIn', 'TV Ad')}}),
        ({'NR': {'textbox': {'Who referred you to iMentor NYC?': 'Never mind'}}}),
        ({'sleep': 5}),
        ({'ClickNextButton': 'none'}),
    ),
)

MentorMatchingPage = (
    (
        ({'option': {'Which of the following categories best represents your current career and job function?':
                         ('Business',)}}),
        ({'option': {'Which of the following categories best represents your current career and job function?': (
            'Accounting',
            'Consulting')
        }}),
        ({'option': {'Please select any additional fields in which you have work experience. (Check all that apply)': (
            'Athletics', 'Trades / Vocations')}}),
        ({'option': {'The following is a list of projects you might work on with your mentee. Please select at '
                     'least two that you are excited to work on. (Check all that apply)':
                         ('Writing a resume and cover letter', 'Learning how to prepare for your career')}}),
        ({'option': {'Looking at the list below, which options most closely resemble your major(s), minor(s), '
                     'or areas of focus during college and graduate school (if applicable)? (Check all that apply)':
                         ('Biochemistry', 'Geography')}}),
        ({'option': {'Even if you did not focus on this area of study in college or graduate school, which '
                     'academic subjects are you also interested in? (Check all that apply)':
                         ('Advertising', 'English')}}),
        ({'option': {'Which of the following did you experience during high school/adolescence? (Check all that apply)':
                         ('Was not a native English speaker', 'Participated in Student Government')}}),
        ({'option': {'While we do not expect our mentors to be tutors, some students express a strong preference'
                     ' for a mentor with particular academic strengths. In which of the following academic subjects would you feel'
                     ' prepared to help your mentee improve their skills/understanding? (Check all that apply)':
                         ('English', 'History')}}),
        ({'option': {'Select all of the following personality traits that best describe you. '
                     '(Check all that apply)':
                         ('Funny', 'Spiritual')}}),
        ({'option': {'Which of the following have you experienced in your life? (Check all that apply)':
                         ('Speak language other than English', 'Has children')}}),
        ({'option': {'Many mentees express a preference for a mentor who is experienced in handling the many '
                     'challenges that teenagers face today. Of the following list of potential challenges, with which ones do you '
                     'have experience? (Check all that apply)':
                         ('Dealing with personal/emotional challenges', 'Dealing with health challenges')}}),
        ({'option': {'What are your favorite things to do in your free time? (Check all that apply)':
                         ('Watch TV', 'Take pictures')}}),
        ({'textarea': {'Please tell us a little bit about yourself that we couldn\'t learn from the previous questions.'
                       ' What else do you think we should know in order to find you the best possible match? Tell us '
                       'what makes you different from everyone else!': 'developing'}}),
        ({'sleep': 5}),
        ({'ClickNextButton': 'none'}),
    ),
    (
        ({'option': {'Which of the following categories best represents your current career and job function?':
                         ('Business',)}}),
        ({'option': {'Which of the following categories best represents your current career and job function?': (
            'Accounting',
            'Consulting')
        }}),
        ({'option': {'Please select any additional fields in which you have work experience. (Check all that apply)': (
            'Athletics', 'Trades / Vocations')}}),
        ({'option': {'The following is a list of projects you might work on with your mentee. Please select at '
                     'least two that you are excited to work on. (Check all that apply)':
                         ('Writing a resume and cover letter', 'Learning how to prepare for your career')}}),
        ({'option': {'Looking at the list below, which options most closely resemble your major(s), minor(s), '
                     'or areas of focus during college and graduate school (if applicable)? (Check all that apply)':
                         ('Biochemistry', 'Geography')}}),
        ({'option': {'Even if you did not focus on this area of study in college or graduate school, which '
                     'academic subjects are you also interested in? (Check all that apply)':
                         ('Advertising', 'English')}}),
        ({'option': {'Which of the following did you experience during high school/adolescence? (Check all that apply)':
                         ('Was not a native English speaker', 'Participated in Student Government')}}),
        ({'option': {'While we do not expect our mentors to be tutors, some students express a strong preference'
                     ' for a mentor with particular academic strengths. In which of the following academic subjects would you feel'
                     ' prepared to help your mentee improve their skills/understanding? (Check all that apply)':
                         ('English', 'History')}}),
        ({'option': {'Select all of the following personality traits that best describe you. '
                     '(Check all that apply)':
                         ('Funny', 'Spiritual')}}),
        ({'option': {'Which of the following have you experienced in your life? (Check all that apply)':
                         ('Speak language other than English', 'Has children')}}),
        ({'option': {'Many mentees express a preference for a mentor who is experienced in handling the many '
                     'challenges that teenagers face today. Of the following list of potential challenges, with which ones do you '
                     'have experience? (Check all that apply)':
                         ('Dealing with personal/emotional challenges', 'Dealing with health challenges')}}),
        ({'option': {'What are your favorite things to do in your free time? (Check all that apply)':
                         ('Watch TV', 'Take pictures')}}),
        ({'textarea': {'Please tell us a little bit about yourself that we couldn\'t learn from the previous questions.'
                       ' What else do you think we should know in order to find you the best possible match? Tell us '
                       'what makes you different from everyone else!': 'developing'}}),
        ({'sleep': 5}),
        ({'ClickNextButton': 'none'}),
    ),
)

MentorReferencesPage = (
    (
        ({'NextButton': 'Submit'}),
        ({'option': {'Have you ever been convicted or pled no contest to a felony? NOTE: Any offenses omitted from '
                     'this application may result in automatic disqualification from the volunteer screening process.':
                         ('No',)}}),
        ({'option': {'Have you ever been convicted or pled no contest to a misdemeanor? NOTE: Any offenses omitted '
                     'from this application may result in automatic disqualification from the volunteer screening '
                     'process.': ('No',)}}),
        ({'option': {'Have you ever been terminated or otherwise disciplined, placed on probation, or warned not '
                     'to continue engaging in certain conduct while volunteering with any agency '
                     '(whether or not youth were involved?)': ('No',)}}),
        ({'textarea': {'Please provide us with 2-3 sentences of your personal definition of emotional abuse.':
                           'testing'}}),
        ({'textarea': {'Please provide us with 2-3 sentences of your personal definition of physical abuse.':
                           'software'}}),
        ({'textarea': {'Please provide us with 2-3 sentences of your personal definition of sexual abuse.':
                           'in progress'}}),
        ({'selectIndex_1': {'textbox': {'Full Name': 'Tinku'}}}),
        ({'selectIndex_1': {'textbox': {'Email Address': 'tinku@gmail.com'}}}),
        ({'selectIndex_1': {'phone': {'Mobile/Home Phone Number': ('974', '248', '3082')}}}),
        ({'selectIndex_1': {'textbox': {'What is your relationship to this person?': 'something'}}}),
        ({'selectIndex_2': {'textbox': {'Full Name': 'Minku'}}}),
        ({'selectIndex_2': {'textbox': {'Email Address': 'minku@gmail.com'}}}),
        ({'selectIndex_2': {'phone': {'Mobile/Home Phone Number': ('984', '258', '3192')}}}),
        ({'selectIndex_2': {'textbox': {'What is your relationship to this person?': 'nothing'}}}),
        ({'selectIndex_3': {'textbox': {'Full Name': 'Dinku'}}}),
        ({'selectIndex_3': {'textbox': {'Email Address': 'dinku@gmail.com'}}}),
        ({'selectIndex_3': {'phone': {'Mobile/Home Phone Number': ('994', '268', '3202')}}}),
        ({'selectIndex_3': {'textbox': {'What is your relationship to this person?': 'anything'}}}),
        ({'sleep': 4}),
        ({'ClickNextButton': 'none'}),
        ({'assert': {'How': 'locator', 'By': By.XPATH,
                     'What': '//button[contains(text(),"Learn more about our program")]'}}),
    ),
    (
        ({'NextButton': 'Submit'}),
        ({'option': {'Have you ever been convicted or pled no contest to a felony? NOTE: Any offenses omitted from '
                     'this application may result in automatic disqualification from the volunteer screening process.':
                         ('No',)}}),
        ({'option': {'Have you ever been convicted or pled no contest to a misdemeanor? NOTE: Any offenses omitted '
                     'from this application may result in automatic disqualification from the volunteer screening '
                     'process.': ('No',)}}),
        ({'option': {'Have you ever been terminated or otherwise disciplined, placed on probation, or warned not to '
                     'continue engaging in certain conduct while volunteering with any agency '
                     '(whether or not youth were involved?)': ('No',)}}),
        ({'textarea': {'Please provide us with 2-3 sentences of your personal definition of emotional abuse.':
                           'testing'}}),
        ({'textarea': {'Please provide us with 2-3 sentences of your personal definition of physical abuse.':
                           'software'}}),
        ({'textarea': {'Please provide us with 2-3 sentences of your personal definition of sexual abuse.':
                           'in progress'}}),
        ({'selectIndex_1': {'textbox': {'Full Name': 'Tinku'}}}),
        ({'selectIndex_1': {'textbox': {'Email Address': 'tinku@gmail.com'}}}),
        ({'selectIndex_1': {'phone': {'Mobile/Home Phone Number': ('974', '248', '3082')}}}),
        ({'selectIndex_1': {'textbox': {'What is your relationship to this person?': 'something'}}}),
        ({'selectIndex_2': {'textbox': {'Full Name': 'Minku'}}}),
        ({'selectIndex_2': {'textbox': {'Email Address': 'minku@gmail.com'}}}),
        ({'selectIndex_2': {'phone': {'Mobile/Home Phone Number': ('984', '258', '3192')}}}),
        ({'selectIndex_2': {'textbox': {'What is your relationship to this person?': 'nothing'}}}),
        ({'selectIndex_3': {'textbox': {'Full Name': 'Dinku'}}}),
        ({'selectIndex_3': {'textbox': {'Email Address': 'dinku@gmail.com'}}}),
        ({'selectIndex_3': {'phone': {'Mobile/Home Phone Number': ('994', '268', '3202')}}}),
        ({'selectIndex_3': {'textbox': {'What is your relationship to this person?': 'anything'}}}),
        ({'sleep': 4}),
        #({'ClickNextButton': 'none'}),
        #({'assert': {'How': 'locator', 'By': By.XPATH,
        #             'What': '//button[contains(text(),"Learn more about our program")]'}}),
    ),
)

MenteeMatchPage = (
    (({'textbox': {'First Name': 'Varun'}}),
     ({'textbox': {'Last Name': 'Sharma'}}),
     ({'phone': {'Primary Phone Number': ('974', '248', '3082')}}),
     ({'selectIndex_1': {'option': {'Is this a cell phone?': ('Yes',)}}}),
     ({'NR': {'phone': {'Secondary Phone Number': ('974', '248', '3082')}}}),
     ({'NR': {'selectIndex_2': {'option': {'Is this a cell phone?': ('Yes',)}}}}),
     ({'Logout': True}),
     ({'sleep': 4}),
     ({'Login': True}),
     ({'address': {'Home Address': {'address': '185/15,North Street', 'city': 'San Jose', 'state': 'California',
                                    'zip': '1234'}}}),
     ({'textbox': {'Parent/Guardian First Name': 'Manu'}}),
     ({'textbox': {'Parent/Guardian Last Name': 'Sharma'}}),
     ({'phone': {'Parent/Guardian Primary Phone': ('974', '248', '3082')}}),
     ({'selectIndex_3': {'option': {'Is this a cell phone?': ('Yes',)}}}),
     ({'address': {'Parent/Guardian\'s Address': {'address': '122/13,Times Street', 'city': 'San Mateo', 'state':
         'California', 'zip': '4567'}}}),
     ({'dob': {'What is your birthday?': ('October', '18', '1982')}}),
     ({'option': {'With which gender do you most closely identify?': ('Male',)}}),
     ({'option': {'With which race or races do you identify? (Check all that apply)':
                      ('I would prefer not to indicate my race',)}}),
     ({'dropdown': {'Please select your school and class': ('Automation', 'Automation 18 Class 1')}}),
     ({'sleep': 5}),
     ({'ClickNextButton': 'none'}),
     ),
)

MenteeEvaluatePage = (
    (
        ({'sleep': 5}),
        (
            {'option': {'Before iMentor NYC, had you ever been matched with a mentor through another program?': ('Yes',)}}),
        ({'sleep': 3}),
        ({'NR': {'textbox': {'What was the name of the mentoring program?': 'Testing it'}}}),
        ({'NR': {'option': {'Were both of your parents born in the United States?': ('Yes',)}}}),
        ({'NR': {'option': {'Were you born in the United States?': ('No',)}}}),
        ({'sleep': 3}),
        ({'NR': {'dropdown': {'In which country were you born?': ('India',)}}}),
        ({'option': {'Do you qualify for Free or Reduced lunch at your school?': ('No',)}}),
        ({'option': {'What was the highest level of education that your mother received?': ('High school diploma',)}}),
        ({'NR': {'option': {'Do you have a computer, phone or another device at home with internet access that you can '
                            'use?': ('No',)}}}),
        ({'Logout': True}),
        ({'sleep': 4}),
        ({'Login': True}),
        ({'clicktext': 'Next'}),
        ({'option': {'What was the highest level of education that your father received?':
                         ('Graduated from college',)}}),
        ({'sleep': 5}),
        ({'ClickNextButton': 'none'}),
    ),
)

MenteeCareerPage = (
    (
        ({'NextButton': 'Submit'}),
        ({'option': {'Which one of the following careers and jobs are you most interested in?': (
            'Communications', 'Journalism')}}),
        ({'option': {'What other careers are you interested in? (Check all that apply)': ('Business', 'Education')}}),
        ({'option': {'When you are matched with your mentor you may work on some of the following projects. Which are '
                     'you most interested in working on with your mentor? (Check all that apply)':
                         ('Writing a resume and cover letter',)}}),
        ({'option': {'Which subjects do you think you want to study in college? (Check all that apply)': (
            'Anthropology', 'Accounting')}}),
        ({'option': {
            'Even if you don\'t want to major in them, what other academic subjects are you interested in? (Majors are '
            'your official, or primary '
            'area of study in college). (Check all that apply)': ('American Studies',)}}),
        ({'option': {'Which of the following experiences would you like your mentor to have experienced in high '
                     'school? (Check all that apply)': ('Worked a job while in high school',)}}),
        ({'option': {'In which of the following academic subjects would you want your mentor to be able to help you? '
                     '(Check all that apply)': ('Mathematics',)}}),
        ({'option': {'Which of the following personality traits would you like your mentor to have? '
                     '(Check all that apply)': ('Independent',)}}),
        ({'option': {'Which of the following life experiences would you like your mentor to have had? '
                     '(Check all that apply)': ('Traveled internationally',)}}),
        ({'option': {'Are there any personal issues you would like to work on with your mentor? (Check all that apply)':
                         ('Dealing with personal/emotional challenges',)}}),
        ({'option': {'What are your favorite things to do in your free time? (Check all that apply)': (
            'Watch TV', 'Take pictures',)}}),
        ({'Logout': True}),
        ({'sleep': 4}),
        ({'Login': True}),
        ({'clicktext': 'Next'}),
        ({'sleep': 3}),
        ({'clicktext': 'Next'}),
        #({'textarea': {'Please tell us a little bit about yourself that we couldn\'t learn from the previous questions.'
        #               ' What else do you think we should know in order to find you the best possible match? Tell us '
        #               'what makes you different from everyone else!': 'testing'}}),
        #({'sleep': 5}),
        #({'ClickNextButton': 'none'}),
        #({'assert': {'How': 'locator', 'By': By.XPATH,
        #             'What': '//button[contains(text(),"Learn more about our program")]'}}),
    ),
)

Q_Type_Data = {
    'Mentor': ((1, 1), (2, 7), (3, 2), (4, 2), (5, 3),  (6, 1), (7, 2), (11, 1), (14, 1), (19, 1), (21, 1)),
    'Mentee': ((2, 4), (3, 3), (4, 2), (5, 4), (13, 1), (14, 1), (19, 1))
}

gBase_url = get_url()

browser = "firefox"

LoginCred = ({'MenteeName': 'san17@testinsane.com', 'MenteePasswd': 'test123',
              'MentorName': 'testemails+user_100092@imentor.org', 'MentorPasswd': 'test123'},
             )


def helper_ScrollClick(UnitObj, button):
    driver = UnitObj
    print("scroll to " + str(button))
    Ele = WebDriverWait(driver, 20).until(
        expected_conditions.element_to_be_clickable((By.XPATH, "//*[contains(text(),'" + str(button) + "')]"))
    )

    driver.execute_script("window.scrollTo(arguments[0],arguments[1])", Ele.location['x'],
                          (Ele.location['y'] - 300))
    print("clicking " + str(button))
    Ele.click()


def helper_ScrollClickEle(UnitObj, Ele):
    driver = UnitObj
    driver.execute_script("window.scrollTo(arguments[0],arguments[1])", Ele.location['x'],
                          (Ele.location['y'] - 300))
    time.sleep(1)
    Ele.click()


def helper_deselectAllMultipleChoices(driver):
    EleList = driver.find_elements_by_xpath("//*[(@class='multi-select-field ng-scope selected')]")
    for i in range(len(EleList)):
        driver.execute_script("window.scrollTo(arguments[0],arguments[1])", EleList[i].location['x'],
                              (EleList[i].location['y'] - 300))
        time.sleep(1)
        EleList[i].click()


def helper_SelectToggle(el, index):
    EleList = el.find_elements_by_tag_name("button")
    EleList[index].click()

def helper_SelectMultipleChoicesBytext(driver, question, answers, which=1):
    for i in range((len(answers))):
        print(question)
        answer = answers[i]
        print(answer)
        selector = "(//*[contains(@data-question-text,\"" + str(question) + "\")])[" + str(
            which) + "]//*[contains(text(),'" + str(answer) + "')]"
        el = WebDriverWait(driver, 20).until(
            expected_conditions.element_to_be_clickable((By.XPATH, selector))
        )
        #print(el)
        helper_ScrollClickEle(driver, el)


def helper_SelectMultipleChoicesEle(driver, el):
        els = el.find_elements_by_xpath("./descendant::*[contains(@class,'multi-select-field')]")
        for el in els:
            driver.execute_script("window.scrollTo(arguments[0],arguments[1])", el.location['x'],
                      (el.location['y'] - 300))
            el.click()
            time.sleep(1)

def helper_MoveEnterText(driver, by, selector, text):
    el = WebDriverWait(driver, 20).until(
        expected_conditions.element_to_be_clickable((by, selector))
    )
    driver.execute_script("window.scrollTo(arguments[0],arguments[1])", el.location['x'],
                          (el.location['y'] - 300))
    el.clear()
    el.send_keys(text)


def helper_EnterText(driver, by, selector, text, which=1):
    which -= 1
    els = driver.find_elements(by, selector)
    el = els[which]
    el.clear()
    el.send_keys(text)
    return el


def helper_EnterSelectText(driver, by, selector, text):
    el = WebDriverWait(driver, 20).until(
        expected_conditions.visibility_of_element_located((by, selector))
    )
    el.clear()
    time.sleep(1)
    el.send_keys(text)
    el = WebDriverWait(driver, 20).until(
        expected_conditions.element_to_be_clickable((By.XPATH, "//a[contains(.,'" + str(text) + "')]"))
    )
    el.click()


def helper_EditDOBEle(UnitObj, EleListDOB, info):
    driver = UnitObj
    EleListDOBFields = EleListDOB.find_elements_by_tag_name('select')
    assert len(EleListDOBFields) == 3

    for i in range(len(EleListDOBFields)):
        el = EleListDOBFields[i]
        print(info[i])
        driver.execute_script("window.scrollTo(arguments[0],arguments[1])", EleListDOB.location['x'],
                              (EleListDOB.location['y'] - 300))
        Select(el).select_by_visible_text(str(info[i]))
        el.send_keys(Keys.TAB)

def helper_EditDOB(UnitObj, header, info):
    driver = UnitObj

    EleListDOB = driver.find_element_by_xpath("//*[@data-question-text='" + str(header) + "']")
    EleListDOBFields = EleListDOB.find_elements_by_tag_name('select')
    assert len(EleListDOBFields) == 3

    for i in range(len(EleListDOBFields)):
        el = EleListDOBFields[i]
        print(info[i])
        driver.execute_script("window.scrollTo(arguments[0],arguments[1])", EleListDOB.location['x'],
                              (EleListDOB.location['y'] - 300))
        Select(el).select_by_visible_text(str(info[i]))
        el.send_keys(Keys.TAB)


def helper_EditDropdownEle(UnitObj, EleListDOB, index):
    driver = UnitObj
    time.sleep(2)
    EleListDOBFields = EleListDOB.find_elements_by_tag_name('select')
    for i in range(len(EleListDOBFields)):
        el = EleListDOBFields[i]
        Select(el).select_by_index(index)
        time.sleep(2)
        el.send_keys(Keys.TAB)

def helper_EditDropdown(UnitObj, header, info):
    driver = UnitObj
    time.sleep(2)
    EleListDOB = driver.find_element_by_xpath("//*[@data-question-text='" + str(header) + "']")
    EleListDOBFields = EleListDOB.find_elements_by_tag_name('select')
    for i in range(len(EleListDOBFields)):
        el = EleListDOBFields[i]
        Select(el).select_by_visible_text(str(info[i]))
        time.sleep(2)
        el.send_keys(Keys.TAB)


def helper_EditAddressEle(UnitObj, EleAddress, addressInfo):
    driver = UnitObj
    Select(EleAddress.find_element_by_id("address-state")).select_by_visible_text(addressInfo['state'])
    helper_EnterText(EleAddress, By.ID, "address-street1", str(addressInfo['address']))
    helper_EnterText(EleAddress, By.ID, "address-street2", str(addressInfo['city']))
    helper_EnterText(EleAddress, By.ID, "address-zip", str(addressInfo['zip']))


def helper_EditAddress(UnitObj, whoseAddress, addressInfo):
    driver = UnitObj
    EleAddress = driver.find_element_by_xpath("//*[@data-question-text=\"" + str(whoseAddress) + "\"]")
    Select(EleAddress.find_element_by_id("address-state")).select_by_visible_text(addressInfo['state'])
    helper_EnterText(EleAddress, By.ID, "address-street1", str(addressInfo['address']))
    helper_EnterText(EleAddress, By.ID, "address-street2", str(addressInfo['city']))
    helper_EnterText(EleAddress, By.ID, "address-zip", str(addressInfo['zip']))


def helper_EditPhoneDetailsEle(Element, phoneInfo):
    EleListPhoneFields = Element.find_elements_by_tag_name("input")
    for i in range(len(phoneInfo)):
        EleListPhoneFields[i].clear()
        EleListPhoneFields[i].send_keys(str(phoneInfo[i]))


def helper_EditPhoneDetails(UnitObj, whosePhone, phoneInfo, which=1):
    which -= 1
    driver = UnitObj
    Els = driver.find_elements_by_xpath("//*[@data-question-text='" + str(whosePhone) + "']")
    helper_EditPhoneDetailsEle(Els[which], phoneInfo)


def helper_EditReference(UnitObj, whose, Info):
    driver = UnitObj
    helper_EnterText(driver, By.XPATH,
                     "//*[contains(text(),'" + str(whose) + "')]/following::*[@placeholder='Full Name']",
                     str(Info['Full Name']))
    helper_EnterText(driver, By.XPATH,
                     "//*[contains(text(),'" + str(whose) + "')]/following::*[@placeholder='Email Address']",
                     str(Info['Email Address']))
    Ele = driver.find_element_by_xpath("//*[contains(text(),'" + str(whose) + "')]/following::*[@data-question-text="
                                                                              "'Mobile/Home Phone Number']")
    helper_EditPhoneDetailsEle(Ele, Info['Mobile/Home Phone Number'])
    helper_EnterText(driver, By.XPATH,
                     "//*[contains(text(),'" + str(whose) + "')]/following::*[@placeholder='What is your "
                                                            "relationship to this person?']",
                     str(Info['What is your relationship to this person?']))



def EditBy_QuestionType(driver):
    global gUserName
    global gPassword
    ret = None
    track = array.array('i', (0 for i in range(30)))
    EleList=driver.find_elements_by_xpath("//*[@data-question-type!='100']")

    max = len(EleList)
    rn = random.randint(1, max-1)
    print(rn)
    for i in range(len(EleList)):
        el = EleList[i]
        print(el.get_attribute('data-question-text'))
        driver.execute_script("window.scrollTo(arguments[0],arguments[1])", el.location['x'], (el.location['y'] - 300))

        qid = el.get_attribute('data-question-type')
        track[int(qid)] += 1

        if qid == '2':
                ret=helper_EnterText(el,By.XPATH, "./descendant::*[(@type='text')]", "testing")
        elif qid == '1':
                ret=helper_EnterText(el,By.XPATH, "./descendant::*/textarea", "testing")
        elif qid == '3':
            helper_EditPhoneDetailsEle(el,['974', '248', '3082'])
        elif qid == '4':
            add = {'address': '185/15,North Street', 'city': 'San Jose', 'state': 'California', 'zip': '1234'}
            helper_EditAddressEle(driver, el, add)
        elif qid == '5':
            helper_SelectToggle(el, 0)
            time.sleep(1)
            helper_SelectToggle(el, 1)
        elif qid == '6':
            helper_SelectMultipleChoicesEle(driver, el)
        elif qid == '13':
            helper_EditDropdownEle(driver, el, 1)
        elif qid == '14':
            dob = ('October', '18', '1982')
            helper_EditDOBEle(driver, el, dob)
        elif qid == '19':
            helper_SelectMultipleChoicesEle(driver, el)
        elif qid == '7':
            helper_SelectMultipleChoicesEle(driver, el)
        elif qid == '21':
            helper_SelectMultipleChoicesEle(driver, el)
        elif qid == '11':
                ret = helper_EnterText(el, By.XPATH, "./descendant::*[(@type='text')]", "test")
                time.sleep(1)
                driver.find_element_by_xpath("//*[@data-question-type='11']/descendant::*/a").click()
        time.sleep(1)
        if i == rn:
            if qid == '1' or qid == '2' or qid == '11':
                ret.send_keys(Keys.TAB)
            Logout(driver)
            time.sleep(4)
            print("user : "+str(gUserName)+"\n"+"password : "+str(gPassword))
            Login(driver, gUserName, gPassword)
            el = driver.find_element_by_xpath("//*[@data-question-type='2' or @data-question-type='1']"
                                              "/descendant::*[(@type='text')]")
            elText = el.get_attribute('value')
            print(elText)
            assert str(elText).find("test") != -1
        EleList=driver.find_elements_by_xpath("//*[@data-question-type!='100']")

    return track


def check_Required(driver, question):
    helper_ScrollClick(driver, 'Next')
    el = driver.find_element(By.XPATH, "//span[contains(text(),'Required') and not(contains(@class,'hide'))]"
                                  "/ancestor::*[contains(@data-question-text,'"+question+"')]")
    return el



def ParseExecute(driver, TestData, Required=False):
    NRequired = False
    nextpagebutton = 'Next'
    print("New Page processing.....")

    for row in TestData:
        try:
            NRequired = False
            UiType = (list(row.keys()))[0]
            Data = row[UiType]

            if UiType == 'NextButton':
                print("NextButton")
                nextpagebutton = Data
                continue
            elif UiType == 'Login' and Data == True:
                print(str(gUserName) + " : " + str(gPassword))
                Login(driver, gUserName, gPassword)
                continue
            elif UiType == 'Logout' and Data == True:
                Logout(driver)
                continue

            if Required == True and (UiType == 'NR' or UiType == 'sleep' or UiType == 'assert'):
                NRequired = True
                if UiType == 'NR':
                    continue

            if gUseTab:
                actions = ActionChains(driver)
                actions.send_keys(Keys.TAB).perform()

            if (Required is True and NRequired is False and UiType != 'clicktext') or UiType == 'ClickNextButton':
                print("Page button is : " + str(nextpagebutton))
                # The Required may not appear if the delay is removed
                if UiType != 'ClickNextButton':
                    time.sleep(2)
                helper_ScrollClick(driver, nextpagebutton)
                if gHandleAlert:
                    try:
                        alert = driver.switch_to.alert
                        print(alert)
                        alert.accept()
                        helper_ScrollClick(driver, nextpagebutton)
                    except Exception as e:
                        print('type is and ignoring:', e.__class__.__name__)
                if UiType == 'ClickNextButton':
                    continue
                # The auto scroll has to occur before the next question processed
                time.sleep(2)

            if UiType == 'clicktext' or UiType == 'assert' or UiType == 'sleep':
                if UiType == 'clicktext':
                    time.sleep(4)
                    print(Data)
                    helper_ScrollClick(driver, Data)
                elif UiType == 'assert':
                    print(Data)
                    how = Data['How']
                    if how == 'locator':
                        el = WebDriverWait(driver, 20).until(
                            lambda driver: driver.find_element(Data['By'], Data['What']))
                    elif how == 'text':
                        el = WebDriverWait(driver, 20).until(lambda driver: driver.find_element_by_name(Data['What']))
                    assert el, "failed to assert for the presence of an element" + str(el)
                    print(el)
                elif UiType == 'sleep':
                    time.sleep(Data)
                continue

            which = 1
            while True:
                if (Required is False and UiType == 'NR') or 'selectIndex' in UiType:
                    if 'selectIndex' in UiType:
                        which = int(UiType.split("_")[1])
                    subUiType = (list(Data.keys()))[0]
                    subData = Data[subUiType]
                    subHeader = (list(subData.keys()))[0]
                    print(str(UiType) + " : " + str(subUiType))
                    print(str(UiType) + " : " + str(subHeader))
                    print(str(UiType) + " : " + str(subData[subHeader]))
                    UiType = subUiType
                    Data = subData
                else:
                    break

            header = (list(Data.keys()))[0]
            print(str(UiType) + " - " + str(header) + " : " + str(Data[header]))

            if Required:
                strXpath = "//span[contains(text(),'Required') and not(contains(@class,'hide'))]" \
                           "/ancestor::*[contains(@data-question-text,\"" + str(header) + "\")]"
                print(strXpath)
                # need to assert success in finding Require field for missing question which is should be answered
                try:
                    el = WebDriverWait(driver, 20).until(lambda driver: driver.find_element(By.XPATH, strXpath))
                    print("Success : Required Field for : " + str(header))
                except TimeoutException:
                    print("Failure : Required Field for : " + str(header))
                    print("--------------------------------------------------------------")
                    # Check if the exception is element missing and verify if there are elements with "Required" fields
                    print("Following were the questions which were left unanswered")
                    els = driver.find_elements(By.XPATH,
                                               "//span[contains(text(),'Required') and not(contains(@class,'hide'))]"
                                               "/ancestor::*[@data-question-text]")
                    if els:
                        for el in els:
                            print(el.get_attribute("data-question-text"))
                    print("--------------------------------------------------------------")
                    assert False, ("Failure : Required Field for : " + str(header))

            if (UiType == 'option' or UiType == 'textbox' or UiType == 'textarea' or UiType == 'phone' or UiType ==
                'address' or 'selectIndex' in UiType or UiType == 'reference' or UiType == 'autotextbox' or
                        UiType == 'autotextarea' or UiType == 'dob' or UiType == 'deselectopt' or UiType == 'dropdown'):
                if UiType == 'option':
                    if header == 'Many':
                        for option in Data[header]:
                            subheader = (list(option.keys()))[0]
                            print(str(subheader))
                            helper_SelectMultipleChoicesBytext(driver, str(subheader), option[subheader])
                    else:
                        helper_SelectMultipleChoicesBytext(driver, str(header), Data[header], which)
                elif UiType == 'textbox':
                    helper_MoveEnterText(driver, By.XPATH,
                                         "(//*[(@placeholder='" + str(header) + "')])[" + str(which) + "]",
                                         Data[header])
                elif UiType == 'textarea':
                    helper_EnterText(driver, By.XPATH,
                                     "//*[contains(@data-question-text,\"" + str(header) + "\")]//textarea",
                                     Data[header])
                elif UiType == 'phone':
                    helper_EditPhoneDetails(driver, str(header), Data[header], which)
                elif UiType == 'address':
                    helper_EditAddress(driver, str(header), Data[header])
                elif UiType == 'reference':
                    helper_EditReference(driver, str(header), Data[header])
                elif UiType == 'autotextbox':
                    helper_EnterSelectText(driver, By.XPATH, "//*[(@placeholder='" + str(header) + "')]", Data[header])
                elif UiType == 'autotextarea':
                    helper_EnterSelectText(driver, By.XPATH, "//*[contains(@data-question-text,'" + str(header) + "')]"
                                                                                                                  "//textarea",
                                           Data[header])
                elif UiType == 'dob':
                    helper_EditDOB(driver, str(header), Data[header])
                elif UiType == 'deselectopt':
                    helper_deselectAllMultipleChoices(driver)
                elif UiType == 'dropdown':
                    helper_EditDropdown(driver, str(header), Data[header])
        except Exception as e:
            from datetime import datetime

            now = datetime.now().strftime('%Y-%m-%d_%H-%M-%S')
            driver.get_screenshot_as_file('E:/newImentor/api/unittests/screenshot-%s.png' % now)
            print("captured screenshot")
            raise

        if browser == "ie" or browser == "opera":
            time.sleep(3)



def Login(UnitObj, user, passwd):
    driver = UnitObj
    driver.get(gBase_url + "/#/")

    el = WebDriverWait(driver, 20).until(
        expected_conditions.element_to_be_clickable((By.LINK_TEXT, "Sign in"))
    )
    el.click()

    el = WebDriverWait(driver, 20).until(
        expected_conditions.visibility_of_element_located((By.ID, "email"))
    )

    helper_EnterText(driver, By.ID, "email", str(user))
    helper_EnterText(driver, By.ID, "password", str(passwd))
    driver.find_element_by_id("sign-in").click()

    el = WebDriverWait(driver, 30).until(
        expected_conditions.visibility_of_element_located((By.XPATH, "//*[contains(text(),'Contact Information')]"))
    )
    assert el is not None


def Register(UnitObj, who, user, passwd):
    driver = UnitObj
    check = ""

    print("Registering : " + str(user))

    driver.get(gBase_url + "/#/")

    if browser == "ie":
        try:
            time.sleep(5)
            alert = driver.switch_to.alert
            print(alert)
            alert.accept()
        except Exception as e:
            print('type is and ignoring:', e.__class__.__name__)

    driver.find_element_by_xpath("//button[contains(text(),'" + str(who) + "')]").click()

    try:
        el = WebDriverWait(driver, 5).until(
            expected_conditions.visibility_of_element_located((By.NAME, "email"))
        )
    except TimeoutException:
        if who == "New mentee":
            check = "Mentee"
            driver.get(str(gBase_url) + "#signupmentee")
        elif who == "New mentor":
            check = "Mentor"
            driver.get(str(gBase_url) + "#signupmentor")

    driver.find_element_by_name("email").send_keys(user)
    driver.find_element_by_name("password").send_keys(passwd)
    driver.find_element_by_name("confirmpass").send_keys(passwd)
    driver.find_element_by_xpath("//button[contains(text(),'Create')]").click()

    driver.find_element_by_xpath("//button[contains(text(),'Start application')]").click()
    el = WebDriverWait(driver, 30).until(
        lambda driver: driver.find_element_by_xpath("//*[contains(text(),'" + str(check) + "')]")
    )


def Logout(UnitObj):
    time.sleep(4)

    driver = UnitObj
    driver.execute_script("angular.element($(\".logout\")).trigger('click')")
    el = WebDriverWait(driver, 20).until(
        lambda driver: driver.find_element_by_link_text("Sign in")
    )
    assert el is not None


class test_gui_intake():
    def setup(self):
        global gBase_url
        global browser
        print("I am setup")

        browser = get_browser()
        self.driver = get_driver(browser)
        self.driver.implicitly_wait(25)

    def teardown(self):
        print("I am teardown")
        self.driver.quit()

    @skipped()
    def test_intake_mentor_random(self):
        global gUserName
        global gPassword
        driver = self.driver
        gUserName = "automate_mentor" + str(time.strftime("_%j_%H_%M_%S")) + "@test.com"
        gPassword = "test"
        Register(driver, "New mentor", gUserName, gPassword)

        question = 'First Name'
        el = check_Required(driver, question)
        assert el is not None, 'The Required text did not appear for unanswered question : '+question
        time.sleep(3)
        track = EditBy_QuestionType(driver)
        Logout(driver)
        for data in Q_Type_Data['Mentor']:
            assert track[data[0]] == data[1]

    @skipped()
    def test_intake_mentee_random(self):
        global gUserName
        global gPassword
        gUserName = "automate_mentee" + str(time.strftime("_%j_%H_%M_%S")) + "@test.com"
        gPassword = "test"
        Register(self.driver, "New mentee", gUserName, gPassword)
        driver = self.driver
        question = 'First Name'
        el = check_Required(driver, question)
        assert el is not None, 'The Required text did not appear for unanswered question : '+question
        time.sleep(3)
        track = EditBy_QuestionType(driver)
        Logout(driver)
        for data in Q_Type_Data['Mentee']:
            assert track[data[0]] == data[1]
        assert False

    @skipped()
    def test_intake_mentor(self):
        for i in range(len(MentorContactPage)):
            yield self.gen_mentor, i
        pass

    @skipped()
    def test_intake_mentee(self):
        print(len(MenteeMatchPage))
        for i in range(len(MenteeMatchPage)):
            yield self.gen_mentee, i
        pass

    @skipped()
    def test_intake_menteeRequired(self):
        n = 1
        for i in range(n):
            yield self.gen_menteeRequired
        pass

    @skipped()
    def test_intake_mentorRequired(self):
        n = 1
        for i in range(n):
            yield self.gen_mentorRequired
        pass

    def gen_mentor(self, i):
        gUserName = "automate_mentor" + str(time.strftime("_%j_%H_%M_%S")) + "@test.com"
        gPassword = "test"
        Register(self.driver, "New mentor", gUserName, gPassword)

        data = MentorContactPage[i]
        ParseExecute(self.driver, data)

        data = MentorEvaluatePage[i]
        ParseExecute(self.driver, data)

        data = MentorMatchingPage[i]
        ParseExecute(self.driver, data)

        data = MentorReferencesPage[i]
        ParseExecute(self.driver, data)

    def gen_mentee(self, i):
        global gUserName
        global gPassword

        gUserName = "automate_mentee" + str(time.strftime("_%j_%H_%M_%S")) + "@test.com"
        gPassword = "test"
        Register(self.driver, "New mentee", gUserName, gPassword)

        data = MenteeMatchPage[i]
        ParseExecute(self.driver, data)

        data = MenteeEvaluatePage[i]
        ParseExecute(self.driver, data)

        data = MenteeCareerPage[i]
        ParseExecute(self.driver, data)
        pass

    def gen_menteeRequired(self):
        global gUserName
        global gPassword

        gUserName = "automate_mentee" + str(time.strftime("_%j_%H_%M_%S")) + "@test.com"
        gPassword = "test"
        Register(self.driver, "New mentee", gUserName, gPassword)

        data = MenteeMatchPage[0]
        ParseExecute(self.driver, data, True)

        data = MenteeEvaluatePage[0]
        ParseExecute(self.driver, data, True)

        data = MenteeCareerPage[0]
        ParseExecute(self.driver, data, True)
        pass

    def gen_mentorRequired(self):
        global gUserName
        global gPassword
        gUserName = "automate_mentor" + str(time.strftime("_%j_%H_%M_%S")) + "@test.com"
        gPassword = "test"
        Register(self.driver, "New mentor", gUserName, gPassword)

        data = MentorContactPage[0]
        ParseExecute(self.driver, data, True)

        data = MentorEvaluatePage[0]
        ParseExecute(self.driver, data, True)

        data = MentorMatchingPage[0]
        ParseExecute(self.driver, data, True)

        data = MentorReferencesPage[0]
        ParseExecute(self.driver, data, True)
        pass
