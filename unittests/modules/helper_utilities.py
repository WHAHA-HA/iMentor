#!/usr/bin/env python
import json
import os
from selenium import webdriver

# profile = webdriver.FirefoxProfile("E:\\softwares\\sleniumdrivers\\firefox")
# self.driver = webdriver.Firefox(profile)

all_browsers = ['firefox', 'chrome', 'safari', 'ie', 'phantom']
__all__ = ['get_url', 'get_browser', 'get_driver']

def get_url():
    testcfg = json.loads(open('test.cfg').read())
    return testcfg['test_url']

def get_browser():
    browser = str(os.environ['BROWSER_ENV'])
    if browser not in all_browsers:
        print("Unsupported browser : " + str(browser) + "...Running with default browser firefox.")
        browser = 'firefox'
    #print(browser)
    return browser


def get_driver(browser):
    if browser == "firefox":
        driver = webdriver.Firefox()
    elif browser == "chrome":
        driver = webdriver.Chrome()
    elif browser == "ie":
        driver = webdriver.Ie()
    elif browser == "opera":
        driver = webdriver.Opera()
    elif browser == "safari":
        driver = webdriver.Safari()
    elif browser == "phantom":
        driver = webdriver.PhantomJS()
    else:
        print("Unsupported browser : " + str(browser) + "...Running with default browser firefox.")
        driver = webdriver.Firefox()
    return driver

