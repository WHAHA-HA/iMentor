export PATH=$PATH:$PWD:"$PWD""/webdrivers"
export BROWSER_ENV=$1
export SELENIUM_SERVER_JAR="$PWD""/webdrivers/selenium-server-standalone-2.45.0.jar"
echo "The browser is :""$BROWSER_ENV"
python -B start.py --with-xunit --with-coverage --cover-branches --cover-erase --cover-package=test_sub --cover-html --with-html --exe
