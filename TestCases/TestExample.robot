*** Settings ***
Library    SeleniumLibrary
Library    DateTime
Library    String
Resource    ../Common/tabulator_keywords.robot
Resource  ../Common/tabulator_resources.txt
Resource    ../Common/php_travels_flights_variables.txt
Variables    ../variable_files/ConfigData.py
Suite Setup    Open Browser and Maximize    ${BASEURL}  ${BROWSER}  ${BROWSERPATH}
Suite Teardown    Close Tabulator Browser

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
#Sorting Interget List
#        ${fildName} =    set variable    progress
#        ${sortType} =    set variable    desc
#        ${TableHeaderTitle} =    replace string    ${TableHeaderTitle}    %s%      ${fildName}
#        ${sortValue} =    Get Element Attribute    ${TableHeaderTitle}    aria-sort
#        Run Keyword If    '${sortValue}'!='${sortType}'    Click Element    ${TableHeaderTitle}
#        ${sortValue} =    Get Element Attribute    ${TableHeaderTitle}    aria-sort
#        Run Keyword If    '${sortValue}'!='${sortType}'    Click Element    ${TableHeaderTitle}
#        @{tempList} =    Create List
#        @{originalList} =    Create List
#        FOR    ${i}    IN RANGE    10
#            @{originalList} =    Append Value To List     ${fildName}    @{originalList}
#            ${flag} =    run keyword and return status    element should be disabled    ${NextPageButton}
#            run keyword if    ${flag}==False   Click Element      ${NextPageButton}
#            ...    ELSE    exit for loop
#        END
#        log to console     ${originalList}
#    @{tempList} =    Sort list integer    @{originalList}
#    log to console    Ogiganal values............................
#    FOR    ${i}    IN   @{originalList}
#        log to console    listvalue: ${i}
#    END
#
#    log to console    Temp values............................
#    FOR    ${i}    IN   @{tempList}
#        log to console    listvalue: ${i}
#    END
#Test loop
##    Filter Table By Name And Verify    nesfdsfdf
#    @{Listv} =    create list
#    @{Listv} =    append litvalue    @{Listv}
#    ${len} =    get length    ${Listv}
#    log to console    ${len}

#List_at_place_change
#    @{IFUP}    Create List    10    20
#    log to console    ${IFUP[0]}
#    Set List Value    ${IFUP}    0    30
#    log to console    ${IFUP}


#Check Element Number
#    @{MY_SIMPLE_LIST}=  Create List
#    @{MY_SIMPLE_LIST} =    Demo Keyword    @{MY_SIMPLE_LIST}
#    log to console    Name return:${MY_SIMPLE_LIST}
#    @{MY_SIMPLE_LIST} =    Demo Keyword2    @{MY_SIMPLE_LIST}
#    log to console    Name return:${MY_SIMPLE_LIST}


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

Convert date into timestemp
        ${fildName} =    set variable    dob
        ${sortType} =    set variable    desc
        ${TableHeaderTitle} =    replace string    ${TableHeaderTitle}    %s%      ${fildName}
        ${sortValue} =    Get Element Attribute    ${TableHeaderTitle}    aria-sort
        Run Keyword If    '${sortValue}'!='${sortType}'    Click Element    ${TableHeaderTitle}
        ${sortValue} =    Get Element Attribute    ${TableHeaderTitle}    aria-sort
        Run Keyword If    '${sortValue}'!='${sortType}'    Click Element    ${TableHeaderTitle}
        @{tempList} =    Create List
        @{originalList} =    Create List
        FOR    ${i}    IN RANGE    10
            @{originalList} =    Append Value To List     ${fildName}    @{originalList}
            ${flag} =    run keyword and return status    element should be disabled    ${NextPageButton}
            run keyword if    ${flag}==False   Click Element      ${NextPageButton}
            ...    ELSE    exit for loop
        END
        @{tempList} =     Covnert To DataList     @{originalList}
         lists should be equal    ${originalList}    ${tempList}

#Covnert To DataList    [Arguments]    @{originalList}
#        @{tempList} =    Create List
#        FOR    ${i}    IN    @{originalList}
#            @{date} =     split string    ${i}    /
#            ${day} =    set variable    ${date}[0]
#            ${month} =    set variable    ${date}[1]
#            ${year} =    set variable    ${date}[2]
#            ${tempDate} =    set variable    ${year}-${month}-${day}
#            Append To List    ${tempList}    ${tempDate}
#        END
#        Sort List    ${tempList}
#        @{tempList2} =    Create List
#        FOR    ${i}    IN    @{tempList}
#            @{date} =     split string    ${i}    -
#            ${day} =    set variable    ${date}[2]
#            ${month} =    set variable    ${date}[1]
#            ${year} =    set variable    ${date}[0]
#            ${tempDate} =    set variable    ${day}/${month}/${year}
#            Append To List    ${tempList2}    ${tempDate}
#        END
#        log to console    After tempList    converting formate..................................................
#        Read List Values     @{tempList2}
#        log to console    After originalList formate..................................................
#        Read List Values     @{originalList}
##        lists should be equal    ${originalList}    ${tempList2}
#    ${date} =    set variable    1400-05-19 00:00:00.000
#    ${date1} =	Convert Date	${date}	    result_format=%d.%m.%
#    ${date1}    Convert Date    ${date}    result_format=timestamp    exclude_millis=yes
#    log to console    ${date1}
#    ${currenDate} =    Get Current Date    result_format=result_format=%Y/%m/%d    increment=2 day
#    ${currenDate2} =    Get Current Date    result_format=result_format=%Y/%m/%d    increment=1 day
#    ${currenDate3} =    Get Current Date    result_format=result_format=%Y/%m/%d    increment=20 day
#    ${date}    Convert Date    ${currenDate}    result_format=timestamp    exclude_millis=yes
#    ${date2}    Convert Date    ${currenDate2}    result_format=timestamp    exclude_millis=yes
#    ${date3}    Convert Date    ${currenDate3}    result_format=timestamp    exclude_millis=yes
#    @{DateList} =    Create List    ${date}    ${date2}    ${date3}    2005-10-13 00:00:00.000
#    log to console    ${tempList}
#    Sort List    ${tempList}
#    log to console    ${tempList}
#    log to console    ${currenDate}
#    log to console    ${currenDate2}
#    log to console    ${currenDate3}
#    log to console    ${date}


*** Keywords ***
Covnert To DataList    [Arguments]    @{originalList}
        @{tempList} =    Create List
        FOR    ${i}    IN    @{originalList}
            @{date} =     split string    ${i}    /
            ${day} =    set variable    ${date}[0]
            ${month} =    set variable    ${date}[1]
            ${year} =    set variable    ${date}[2]
            ${tempDate} =    set variable    ${year}-${month}-${day}
            Append To List    ${tempList}    ${tempDate}
        END
#        Sort List    ${tempList}
        @{tempList2} =    Create List
        FOR    ${i}    IN    @{tempList}
            @{date} =     split string    ${i}    -
            ${day} =    set variable    ${date}[2]
            ${month} =    set variable    ${date}[1]
            ${year} =    set variable    ${date}[0]
            ${tempDate} =    set variable    ${day}/${month}/${year}
            Append To List    ${tempList2}    ${tempDate}
        END
#        log to console    After tempList    converting formate..................................................
#        Read List Values     @{tempList2}
#        log to console    After originalList formate..................................................
#        Read List Values     @{originalList}
        [Return]    @{tempList2}
#        lists should be equal    ${originalList}    ${tempList2}
Append litvalue    [Arguments]    @{list}
    FOR    ${i}    IN RANGE    1-10
        log to console    ${i}
        append to list    ${list}    ${i}
    END
    [Return]    ${List}
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

Sort list integer    [Arguments]    @{list_Int}
#    @{list_Int} =    Create List    1    2    20    5    3    7    2
    ${len} =    get length   ${list_Int}
#    log to console    ${len}
    FOR    ${i}    IN RANGE   ${len}
        @{list_Int} =    SecondLoop    ${i}    @{list_Int}
    END

#    FOR    ${i}    IN   @{list_Int}
#        log to console    listvalue: ${i}
#    END
    [Return]    @{list_Int}
SecondLoop    [Arguments]    ${i}    @{listInt}
    ${jlen} =    get length    ${listInt}
    ${l} =    evaluate    ${i} + 1
    FOR    ${j}    IN RANGE    ${l}    ${jlen}
        ${iValue} =    set variable     ${listInt[${i}]}
        ${jValue} =    set variable    ${listInt[${j}]}
        ${temp} =    run keyword if    ${iValue} > ${jValue}    set variable    ${iValue}
        run keyword if    ${iValue} > ${jValue}    Set List Value    ${listInt}    ${i}    ${jValue}
        run keyword if    ${iValue} > ${jValue}    Set List Value    ${listInt}    ${j}    ${temp}
    END
    [Return]    @{listInt}


Demo Keyword
    [Arguments]   @{MY_SIMPLE_LIST}
    append to list    ${MY_SIMPLE_LIST}    test1
    [Return]    @{MY_SIMPLE_LIST}

Demo Keyword2
    [Arguments]   @{MY_SIMPLE_LIST}
    append to list    ${MY_SIMPLE_LIST}    test51
    [Return]    @{MY_SIMPLE_LIST}