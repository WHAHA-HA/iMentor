$env:BROWSER_ENV=$args[0]
$env:SELENIUM_SERVER_JAR="$PWD"+"\webdrivers\selenium-server-standalone-2.45.0.jar"
$path_env=(get-item env:\Path).value
$cd=(get-location).Path
$res=$path_env -match "\webdrivers;"
If($res -eq $False)  {
$env:Path=$path_env+";"+$cd+"\webdrivers;"
echo (get-item env:\Path).value
}
python -B start.py --with-xunit --with-coverage --cover-branches --cover-erase --cover-package=test_sub --cover-html --with-html --exe

