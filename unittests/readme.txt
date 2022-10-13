Python Version:
Not all the test scripts are compatible with the python 2.x. Kindly use python 3.x to ensure all the scripts function without failure.

Dependencies:
The test scripts need the following packages to be installed. Use pip to install
nose
selenium
requests
nose-cov
nose-html-reporting(Does not work with python3.x, use nose-htmloutput)
nose-htmloutput (This replaces 'nose-html-reporting' with python3.x)

On Windows:
The powershell scripts is used to trigger automation on Windows. The powershell may throw some permission related errors to 
run script for the first time. Kindly resolve it to get it running.
To run the tests for api and gui tests use the command:
runtests.ps1 <bowser>
The <browser> options are firefox, chrome, opera and ie

On Linux:
runtests.sh <bowser>
The <browser> options are firefox, chrome, opera and ie

On Mac OS X:
Safari on Mac:
a) Need to install the Safar browser extension SafariDriver.safariextz from location
http://selenium-release.storage.googleapis.com/index.html?path=2.45/
b) Need to create a certificate with apple developer account login and install it on the mac. The following link shall
throw some light on how to get ot done. We might need the developer licence to be bought.
https://itisatechiesworld.wordpress.com/2015/04/15/steps-to-get-selenium-webdriver-running-on-safari-browser/
c) Go to Safari->Preferences->Security uncheck option "Fraudulent Sites" to get rid of "Phishing site" warning

Firefox on Mac:
works without any addition seetings

Chrome on Mac:
The chromedriver.app for mac put under /webdriver folder like it's done on windows with .exe to support. The currently 2.9 version is downloaded from location
http://chromedriver.storage.googleapis.com/index.html?path=2.9/

To run a Individual script:
nosetests --with-xunit --nocapture <path-to-script-file>
ex:
nosetests --with-xunit --nocapture ./test_sub/test_api/test_api_intake.py

To run a specific unit test:
nosetests --with-xunit <path to .py script>:<test class name>.<unit test name>
ex:
nosetests --with-xunit test_sub\test_api\test_api_cchklist.py:test_APItests.test_VerifyCategotyChoices

Configuring Tests to Run/Skip:
Edit the json data(Key is unit test name and value 1 means skip) in test.cfg file to enable or skip
individual unit tests.

Reports:
Test results are vailable in nostests.xml
The coverage report is available as .coverage and the HTML reports are as part of "coverage" folder

Important:
The tests are no more being maintained to work with the ie and opera for webdriver stability(on opera) and setting related overhead(on ie)
if they work it's by luck.
