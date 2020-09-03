*** Settings ***
Library    SeleniumLibrary
Resource  ../Common/php_travels_resources.txt
Variables    ../variable_files/ConfigData.py

*** Test Cases ***
TestLoop1
    Open Browser and Maximize    ${BASEURL}  ${BROWSER}   ${BROWSERPATH}
                                                   ##    Create Webdriver    Chrome    executable_path=D:/Selenium/drivers/chromedriver.exe
#    Go To    http://www.google.com
