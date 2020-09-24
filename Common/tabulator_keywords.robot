*** Settings ***
#Author: chetan.bhoi
Library  SeleniumLibrary
Library    os
Library    Collections
Library    String
Library    DateTime
Library    ../Common/common_functions.py
Resource    ../Common/tabulator_variables.txt


*** Keywords ***
Open Browser and Maximize    [Arguments]    ${BASEURL}    ${BROWSER}    ${BROWSERPATH}
    Create Webdriver    Chrome    executable_path=${BROWSERPATH}
    Go To     ${BASEURL}
    Maximize Browser window
    Set Selenium Implicit Wait  5 sec

Close Tabulator Browser
   Close Browser

Take ScreenShot On Fail TestCase
    Run Keyword If Test Failed    Capture Page Screenshot    ${TEST NAME}.png
    Run Keyword If Test Failed    Log Source

Filter Table By Name And Verify    [Arguments]    ${searchData}    ${isIgnoreCase}
        ${name} =    Set Variable    ${searchData["filter"]["name"]}
        ${rowCount} =    Set Variable    ${searchData["verify_data"]["rowCount"]}
        Clear Element Text    ${FilterTableByNameInput}
        Input Text    ${FilterTableByNameInput}    ${name}
        ${len} =    get element count    ${FilteredNameList}
        ${len} =    Convert To String    ${len}

        Run Keyword If    '${rowCount}'=='1'    Verify Each Row   ${name}    ${isIgnoreCase}
        Run Keyword If    '${rowCount}'=='0'    Should Be Equal   ${rowCount}    ${len}

Verify Each Row    [Arguments]    ${name}    ${isIgnoreCase}
        @{filteredNameList} =    Get WebElements    ${FilteredNameList}
        FOR    ${i}    IN    @{filteredNameList}
            ${value} =    Get Text    ${i}
            Should Contain    ${value}    ${name}    ignore_case=${isIgnoreCase}
        END

Sort Table Field And Verify Sorting    [Arguments]    ${testData}
        ${fildName} =    set variable    ${testData["sort"]["fieldName"]}
        ${sortType} =    set variable    ${testData["sort"]["sortType"]}
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

        @{tempList} =    copy list    ${originalList}
        Sort List    ${tempList}
        run keyword if    '${sortType}'=='desc'    Reverse List    ${tempList}

        ${sortValue} =    Get Element Attribute    ${TableHeaderTitle}    aria-sort

        lists should be equal    ${originalList}    ${tempList}
        should be equal   ${sortValue}  ${sortType}

Sort Number Table Field And Verify Sorting    [Arguments]    ${testData}
        ${fildName} =    set variable    ${testData["sort"]["fieldName"]}
        ${sortType} =    set variable    ${testData["sort"]["sortType"]}
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

        @{tempList} =    Run Keyword If    '${fildName}'=='dob'    Sort Date Values    @{originalList}
        ...    ELSE    Sort Integer List1    @{originalList}

        run keyword if    '${sortType}'=='desc'    Reverse List    ${tempList}

        ${sortValue} =    Get Element Attribute    ${TableHeaderTitle}    aria-sort

        lists should be equal    ${originalList}    ${tempList}
        should be equal   ${sortValue}  ${sortType}

Append Value To List    [Arguments]     ${filed}    @{list}
        ${TableColumnList} =    replace string    ${TableColumnList}    %s%      ${filed}
        @{filteredNameList} =    Get WebElements    ${TableColumnList}
        FOR    ${element}    IN    @{FilteredNameList}
            ${value} =    Run keyword if    '${filed}'=='progress'    get element attribute    ${element}   aria-label
            ...    ELSE IF        '${filed}'=='rating'    get element attribute    ${element}    aria-label
            ...    ELSE IF        '${filed}'=='car'    get element attribute    ${element}    aria-checked
            ...    ELSE    Get Text    ${element}
            Append To List    ${list}    ${value}
        END
        [Return]    @{list}

Read List Values    [Arguments]    @{ListValues}
        FOR    ${j}    IN    @{ListValues}
            log to console    Listvalue is: ${j}
        END

Sort Integer List1    [Arguments]    @{list_Int}
    ${len} =    get length   ${list_Int}
    FOR    ${i}    IN RANGE   ${len}
        @{list_Int} =    Second Loop For Sort    ${i}    @{list_Int}
    END
    [Return]    @{list_Int}

Second Loop For Sort    [Arguments]    ${i}    @{listInt}
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

Sort Date Values   [Arguments]    @{originalList}
        @{tempList} =    Create List
        FOR    ${i}    IN    @{originalList}
            @{date} =     split string    ${i}    /
            ${day} =    set variable    ${date}[0]
            ${month} =    set variable    ${date}[1]
            ${year} =    set variable    ${date}[2]
            ${tempDate} =    set variable    ${year}-${month}-${day}
            Append To List    ${tempList}    ${tempDate}
        END
        Sort List    ${tempList}
        @{tempList2} =    Create List
        FOR    ${i}    IN    @{tempList}
            @{date} =     split string    ${i}    -
            ${day} =    set variable    ${date}[2]
            ${month} =    set variable    ${date}[1]
            ${year} =    set variable    ${date}[0]
            ${tempDate} =    set variable    ${day}/${month}/${year}
            Append To List    ${tempList2}    ${tempDate}
        END
        [Return]    @{tempList2}


