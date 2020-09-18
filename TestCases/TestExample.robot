*** Settings ***
Library    SeleniumLibrary
Library    DateTime
Library    String
Resource    ../Common/tabulator_keywords.robot
Resource  ../Common/php_travels_resources.txt
Resource    ../Common/php_travels_flights_variables.txt
Variables    ../variable_files/ConfigData.py
Suite Setup    Open Browser and Maximize    ${BASEURL}  ${BROWSER}  ${BROWSERPATH}
Suite Teardown    Close Browser

*** Variables ***
${URL}                      about:none
${BROWSER}                  Chrome
${ALIAS}                    None
${REMOTE_URL}               http://192.168.1.100:4444/wd/hub
${DESIRED_CAPABILITIES}     platform:WIN10,name:chrome,version:86
${BROWSERPATH}     D:/Selenium/drivers/chromedriver.exe

*** Variables ***
${FlightListData} =  css:ul#LIST > li
${FlightListCity} =  css:first-of-type p.theme-search-results-item-flight-section-meta-city

*** Test Cases ***
Test loop
    Filter Table By Name And Verify    nesfdsfdf

#Verify search flight
#    ${searchData} =    Set Variable    ${search_flights_with_all_valid_fields}
#    ${fromLocation} =    Set Variable    ${searchData["verify_data"]["fromLocation"]}
#    log to console    ${fromLocation}
##    Search Flights    ${searchData}

#Verify fate
#    ${departDate} =    Get Date With Days  3    YYYY-MM-DD
#    log to console     ${departDate}
#Split value
#    ${flag} =    set variable    False
#    ${selectedAliase1} =    set variable    Ahmedabad (AMD)
#    log to console    aliasie1: ${selectedAliase1}
#    ${selectedAliase1} =    split string    ${selectedAliase1}    (
#    log to console    ${selectedAliase1}[0]
#    log to console    ${selectedAliase1}[1]
#    ${selectedAliase1} =    split string    ${selectedAliase1}[1]    )
#    log to console    aliasie: ${selectedAliase1}[0]
#
#    ${response} =    set variable if    '${flag}'=='True'     ${selectedAliase}[0]
#    ...    '${flag}'=='True'    ${selectedAliase1}

#Select date picker in flight
#    ${name} =    convert to lower case    First
#    ${flightClassName} =  run keyword if   '${name}'=='first'  set variable    First
#    ...    ELSE IF    '${name}'=='economy'    Economy
#    ...    ELSE    '${name}'=='business'    Business
#
#    log to console    ${flightClassName}

#TestDATE
#    ${currenDate} =    Get Current Date    result_format=result_format=%d.%m.%Y    increment=2 day
#    log to console    ${currenDate}
#    ${d1} =    Replace String    ${currenDate}    .    /
#    log to console    ${d1}
#    [Return]     ${d1}

#TestLoop1
#    go to    http://www.google.com
#    log to console     Start Browser
#
#TestLoop2
#    go to    http://www.yahoo.co
#    log to console    Start Browser

*** Keywords ***
Search Flights    [Arguments]    ${searchData}=${EMPTY}
    ${fromLocation} =    Set Variable    ${searchData["flight"]["fromLocation"]}
    ${toLocation} =    Set Variable    ${searchData["flight"]["toLocation"]}
    ${adults} =    Set Variable    ${searchData["flight"]["adult"]}
    ${childs} =    Set Variable    ${searchData["flight"]["child"]}
    ${infant} =    Set Variable    ${searchData["flight"]["infant"]}
    ${departDate} =    Get Date With Days    3    %Y-%m-%d
    run keyword if    '${fromLocation}'!=''    log to console    existvlue
    ...    ELSE    log to console    nullvalue
    log to console    fromLocation: ${fromLocation}
    log to console    toLocation: ${toLocation}
    log to console    adults: ${adults}
    log to console    childs: ${childs}
    log to console    infant: ${infant}
    log to console    departDate: ${departDate}

Start Browser
    [Documentation]         Start browser on Selenium Grid
    Open Browser            ${URL}  ${BROWSER}  ${ALIAS}  ${REMOTE_URL}
    Maximize Browser Window

Select date using javascript exc
    Wait Until Element Is Visible    ${FlightNavTab}
    Click Element    ${FlightNavTab}

    Execute Javascript          document.querySelector("input#FlightsDateStart").removeAttribute("readonly");
    Execute Javascript          document.querySelector("input#FlightsDateStart").setAttribute("value", "2020-09-12");

Select Date From DatePicker
# [Arguments]    ${element}    ${dateValue}
    Wait Until Element Is Visible    ${FlightNavTab}
    Click Element    ${FlightNavTab}
    ${dateValue} =    set variable    2020-09-12
    @{splitDate} =  Split String  ${dateValue}  -
    ${day} =    Set Variable    ${splitdate}[0]
    ${month} =    Set Variable    ${splitdate}[1]
    ${year} =    Set Variable    ${splitdate}[2]

    log to console    ${day}
    log to console    ${month}
    log to console    ${year}

    Click Element    css:input#FlightsDateStart
    Click Element    ${DatePickerTitle}
    Click Element    ${DatePickerTitle}
    ${DatePickerYear} =    Replace String    ${DatePickerYear}    {year}    ${year}
    ${flag} =    Get Element Count    ${DatePickerYear}
    FOR    ${i}    IN RANGE    10
           Exit For Loop If    ${flag} == 1
           Click Element    ${DatePickerNextButton}
           ${flag} =    Get Element Count    ${DatePickerYear}
    END
    Scroll Element Into View    ${DatePickerYear}
    Click Element     ${DatePickerYear}
    ${DatePickerMonth} =   Replace String    ${DatePickerMonth}    {month}    ${month}
    Wait Until Element is Visible    ${DatePickerMonth}
    Click Element at coordinates    ${DatePickerMonth}    0    0
    ${DatePickerDays} =    Replace String    ${DatePickerDays}    {day}    ${day}
    ${DatePickerDays} =    Replace String    ${DatePickerDays}    {month}    ${month}
    Wait Until Element Is Enabled     ${DatePickerDays}
    Click Element     ${DatePickerDays}


Select Adults
    Wait Until Element Is Visible    ${FlightNavTab}
    Click Element    ${FlightNavTab}
    Wait Until Element Is Visible    xpath://input[@name='fadults']/..//span//button[text()='+']


Sort Name By Assending
        ${sortValue} =    Get Element Attribute    ${NameTableTitle}    aria-sort
        Run Keyword If    '${sortValue}'!='asc'    Click Element    ${NameTableTitle}

Sort Name By Desending
        ${sortValue} =    Get Element Attribute    ${NameTableTitle}    aria-sort
        Run Keyword If    '${sortValue}'!='desc'    Click Element    ${NameTableTitle}

Hide Rating Field
        ${disValue} =    Get Element Attribute    ${RatingTableTitle}    display
Show Rating Field