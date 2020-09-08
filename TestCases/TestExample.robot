*** Settings ***
Library    SeleniumLibrary
Library    DateTime
Library    String
Resource  ../Common/php_travels_resources.txt
Variables    ../variable_files/ConfigData.py
#Suite Setup    Start Browser
#Suite Teardown    Close Browser

*** Variables ***
${URL}                      about:none
${BROWSER}                  Chrome
${ALIAS}                    None
${REMOTE_URL}               http://192.168.1.100:4444/wd/hub
${DESIRED_CAPABILITIES}     platform:WIN10,name:chrome,version:86
${BROWSERPATH}     D:/Selenium/drivers/IEDriverServer.exe


*** Test Cases ***
TestDATE
    ${currenDate} =    Get Current Date    result_format=result_format=%d.%m.%Y    increment=2 day
    log to console    ${currenDate}
    ${d1} =    Replace String    ${currenDate}    .    /
    log to console    ${d1}
    [Return]     ${d1}

#TestLoop1
#    go to    http://www.google.com
#    log to console     Start Browser
#
#TestLoop2
#    go to    http://www.yahoo.co
#    log to console    Start Browser

*** Keywords ***
Start Browser
    [Documentation]         Start browser on Selenium Grid
    Open Browser            ${URL}  ${BROWSER}  ${ALIAS}  ${REMOTE_URL}
    Maximize Browser Window


Select Date From DatePicker    [Arguments]    ${element}    ${dateValue}
    @{splitDate} =  Split String  ${dateValue}  /
    ${day} =    Set Variable    ${splitdate}[0]
    ${month} =    Set Variable    ${splitdate}[1]
    ${year} =    Set Variable    ${splitdate}[2]
    Click Element    ${element}
    ${type} =   Get Element Attribute    ${element}    id
    ${iV} =    Set Variable If    '${type}' == 'checkin'    1
    ...    '${type}' == 'checkout'  2

    ${DatePickerTitle} =    Replace Dynamic Elements    ${DatePickerTitle}    ${iV}

    Click Element    ${DatePickerTitle}
    Click Element    ${DatePickerTitle}
    ${DatePickerYear} =    Replace Dynamic Elements    ${DatePickerYear}    ${iV}
    ${DatePickerYear} =    Replace String    ${DatePickerYear}    {year}    ${year}
    ${flag} =    Get Element Count    ${DatePickerYear}
    FOR    ${i}    IN RANGE    10
           Exit For Loop If    ${flag} == 1
           ${DatePickerNextButton} =    Replace Dynamic Elements    ${DatePickerNextButton}    ${iV}
           Click Element    ${DatePickerNextButton}
           ${flag} =    Get Element Count    ${DatePickerYear}
    END
    Scroll Element Into View    ${DatePickerYear}
    Click Element     ${DatePickerYear}
    ${DatePickerMonth} =   Replace Dynamic Elements    ${DatePickerMonth}    ${iV}
    ${DatePickerMonth} =   Replace String    ${DatePickerMonth}    {month}    ${month}
    Wait Until Element is Visible    ${DatePickerMonth}
    Click Element at coordinates    ${DatePickerMonth}    0    0
    ${DatePickerDays} =    Replace Dynamic Elements    ${DatePickerDays}    ${iV}
    ${DatePickerDays} =    Replace String    ${DatePickerDays}    {day}    ${day}
    ${DatePickerDays} =    Replace String    ${DatePickerDays}    {month}    ${month}
    Wait Until Element Is Enabled     ${DatePickerDays}
    Click Element     ${DatePickerDays}
