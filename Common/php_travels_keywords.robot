*** Settings ***
#Author: chetan.bhoi
Library  SeleniumLibrary
Library    Collections
Library    String
Variables  ../Common/php_travels_variables.py

*** Variables ***
${BASEURL}    https://www.phptravels.net/
${BROWSER}    chrome
${USERNAME}  chetan@gmail.com
${PASSWORD}  123456
${USERFNAME}    Chetan
${USERLNAME}    Bhoi

*** Keywords ***
Open Browser and Login
    Open Browser and Maximize
    #SignUp Into phpTravels    chetan@gmail.com    123456    Chetan    Bhoi
    Login Into phpTravels  ${USERNAME}  ${PASSWORD}

Logout and Close Browser
    Logout From phpTravels
    Close Browser

Open Browser and Maximize
    Open Browser  ${BASEURL}  ${BROWSER}
    Maximize Browser window
    Set Selenium Implicit Wait  5 sec

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
    wait until element is visible    xpath://*[contains(text(),'Hi, ${firstName} ${lastName}')]

Login Into phpTravels
    [Arguments]     ${username}     ${password}
    Click Element  ${ddb_myAccount}
    Click Element  ${lnk_login}
    Input Text  ${txt_username}  ${username}
    Input Text  ${txt_password}  ${password}
    Click Button  ${btn_login}
    wait until element is visible    xpath://*[contains(text(),'Hi, ${USERFNAME} ${USERLNAME}')]
    ${accName} =    get text    ${ddb_myAccount}
    [Return]    ${accName}

Logout From phpTravels
    Click Element  ${img_homeLog}
    Click Element  ${ddb_myAccount}
    Click Element  ${lnk_logout}
    wait until element is visible    xpath://h3[text()='Login']

Search Hotel By Name
    [Arguments]    ${searchValue}    ${checkIn}=${EMPTY}     ${checkOut}=${EMPTY}     ${adults}=${EMPTY}     ${children}=${EMPTY}
    Click Element    ${img_homeLog}
    execute javascript    window.scrollTo(0,5000)
    scroll element into view    xpath://nav[@class='menu-horizontal-02']//a[contains(text(),'Hotel')]
    wait until element is visible    xpath://nav[@class='menu-horizontal-02']//a[contains(text(),'Hotel')]
    click element    xpath://nav[@class='menu-horizontal-02']//a[contains(text(),'Hotel')]
    click element    xpath://div[@id='s2id_autogen16']//a[@class='select2-choice']
    input text       xpath://div[@id='select2-drop']//div//input    ${searchValue}
    wait until element is visible    xpath://div[@id='select2-drop']//ul[@class='select2-results']//li
    ${length} =    get element count    xpath://div[@id='select2-drop']//ul[@class='select2-results']//li
    Run Keyword If    '${length}' > '1'
    ...    click element    xpath://ul[@class='select2-result-sub']//span[contains(text(),'${searchValue}')]
    ...    ELSE    Press Keys    xpath://div[@id='select2-drop']//div//input    TAB

    Run Keyword If    '${checkIn}' != '${EMPTY}'    Send CheckIn Date    ${checkIn}
    Run Keyword If    '${checkOut}' != '${EMPTY}'    Send checkout date    ${checkOut}
    run keyword if    '${adults}' != '${EMPTY}'     Select Persons    ${adults}    adults
    run keyword if    '${children}' != '${EMPTY}'    Select Persons    ${children}    children
    sleep    3 sec
    Run Keyword If    '${length}' > '1'    click button    xpath://div[@id='hotels']//button[contains(text(),'Search')]

    ${response} =    Set Variable If    '${length}' > '1'    found
    ...    '${length}' == '1'     not found

    [Return]    ${response}


Take ScreenShot On Fail TestCase
    run keyword if test failed    capture page screenshot    ${TEST NAME}.png
    run keyword if test failed    log source

Select Date From DatePicker
    [Arguments]    ${element}    ${dateValue}
    @{splitDate} =  Split String  ${dateValue}  /
    ${day} =    set variable    ${splitdate}[0]
    ${month} =    set variable    ${splitdate}[1]
    ${year} =    set variable    ${splitdate}[2]
    click element    ${element}
    ${type} =    get element attribute    ${element}    id
    ${iV} =    set variable if    '${type}' == 'checkin'    1
    ...    '${type}' == 'checkout'  2

    log to console    ${iV}
    log to console    ${type}
    #scroll element into view    xpath://div[@id='datepickers-container']//div[1]//nav[1]//div[@class='datepicker--nav-title']
    run keyword if    '${type}' == 'checkin'    execute javascript   window.scrollTo(0,5000)
    run keyword if    '${type}' == 'checkout'    execute javascript   window.scrollTo(0,7000)

    click element    xpath://div[@id='datepickers-container']//div[${iV}]//nav[1]//div[@class='datepicker--nav-title']
    click element    xpath://div[@id='datepickers-container']//div[${iV}]//nav[1]//div[@class='datepicker--nav-title']
    ${flag} =    get element count    xpath://div[@id='datepickers-container']//div[${iV}]//div[contains(@class,'datepicker--cell datepicker--cell-year')][@data-year='${year}']
    FOR    ${i}    IN RANGE    10
           Exit For Loop If    ${flag} == 1
           click element    xpath://div[@id='datepickers-container']//div[${iV}]//div[contains(@class,'datepicker--nav-action')][@data-action='next']
           ${flag} =    get element count    xpath://div[@id='datepickers-container']//div[${iV}]//div[contains(@class,'datepicker--cell datepicker--cell-year')][@data-year='${year}']
    END
    click element     xpath://div[@id='datepickers-container']//div[${iV}]//div[contains(@class,'datepicker--cell datepicker--cell-year')][@data-year='${year}']
    sleep    3 sec
    wait until element is visible    xpath://div[@id='datepickers-container']//div[${iV}]//div[@class='datepicker--cell datepicker--cell-month'][@data-month='${month}']
    click element at coordinates    xpath://div[@id='datepickers-container']//div[${iV}]//div[@class='datepicker--cell datepicker--cell-month'][@data-month='${month}']    0    0
    sleep    3 sec
    wait until element is enabled     xpath://div[@id='datepickers-container']//div[${iV}]//div[contains(@class,'datepicker--cell datepicker--cell-day')][@data-date='${day}'][@data-month='${month}']
    click element     xpath://div[@id='datepickers-container']//div[${iV}]//div[contains(@class,'datepicker--cell datepicker--cell-day')][@data-date='${day}'][@data-month='${month}']
    log to console    Selected date is: ${dateValue}



Send CheckOut Date
    [Arguments]    ${date}
    click element    xpath://input[@id='checkout']
    clear element text    xpath://input[@id='checkout']
    input text    xpath://input[@id='checkout']    ${date}
    press keys    xpath://input[@id='checkout']    TAB

Send CheckIn Date
    [Arguments]    ${date}
    click element    xpath://input[@id='checkin']
    clear element text    xpath://input[@id='checkin']
    input text    xpath://input[@id='checkin']    ${date}
    press keys    xpath://input[@id='checkin']    TAB

Select Persons
    [Arguments]    ${numberOfAdults}    ${type}
    ${name} =    convert to lower case    ${type}
    ${txt_adults} =    replace string    ${txt_adults}    %name%    ${name}
    ${btn_adult_plus} =    replace string    ${btn_adult_plus}    %name%    ${name}
    ${btn_adult_minus} =    replace string    ${btn_adult_minus}    %name%    ${name}

    ${adultValue} =   get element attribute    ${txt_adults}    value
    ${numb1} =    convert to integer    ${numberOfAdults}
    ${numb2} =    convert to integer    ${adultValue}

    ${flag} =    set variable if    ${numb2} == ${numb1}    0
    ...    ${numb2} < ${numb1}    1
    ...    ${numb2} > ${numb1}    2

    ${tclick} =   run keyword if    ${flag}==1   Evaluate     ${numb1}-${numb2}
    ...    ELSE IF   ${flag}==2   Evaluate     ${numb2}-${numb1}

     FOR    ${i}    IN RANGE    ${tclick}
           Exit For Loop If   ${numb2} == ${numb1}
           run keyword if    ${flag} == 1    click element    ${btn_adult_plus}
           ...    ELSE IF    ${flag} == 2    click element    ${btn_adult_minus}
    END
    log to console    successfully selected adults
