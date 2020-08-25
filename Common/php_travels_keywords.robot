*** Settings ***
Library  SeleniumLibrary
Variables  ../Common/php_travels_variables.py

*** Variables ***
${BASEURL}    https://www.phptravels.net/
${BROWSER}    chrome
${USERNAME}  chetan@gmail.com
${PASSWORD}  123456

*** Keywords ***
Open Browser and Login
    Open Browser and Maximize
    #SignUp Into phpTravels  ${USERNAME}  ${PASSWORD}  chetan  bhoi
    Login Into phpTravels  ${USERNAME}  ${PASSWORD}

Logout and Close Browser
    Logout From phpTravels
    Close Browser
    log to console  logout and close browser successfully

Open Browser and Maximize
    Open Browser  ${BASEURL}  ${BROWSER}
    Maximize Browser window
    Set Selenium Implicit Wait  10 sec
    log to console  Open browser and maximize successfully

SignUp Into phpTravels
    [Arguments]  ${email}  ${password}  ${firstName}  ${lastName}
    Click Element  ${ddb_myAccount}
    Click Element  ${lnk_signUp}
    Input Text  ${txt_fname}  ${firstName}
    Input Text  ${txt_lname}  ${lastName}
    Input Text  ${txt_mobile}  9876543210
    Input Text  ${txt_email}  ${email}
    Input Text  ${txt_password}  ${password}
    Input Text  ${txt_cPassword}  ${password}
    execute javascript  window.scrollTo(0,1000)
    Click Button  ${btn_signUp}
    Sleep  5
    log to console  signup successfully

Login Into phpTravels
    [Arguments]     ${username}     ${password}
    Click Element  ${ddb_myAccount}
    Click Element  ${lnk_login}
    Input Text  ${txt_username}  ${username}
    Input Text  ${txt_password}  ${password}
    Click Button  ${btn_login}
    Sleep  5
    Element Text Should Be   ${ddb_myAccount}  CHETAN
    log to console  successfully matched

Logout From phpTravels
    Click Element  ${img_homeLog}
    Click Element  ${ddb_myAccount}
    Click Element  ${lnk_logout}
    Sleep  5
    log to console  logout successfully
