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

        @{tempList} =    Copy List  ${originalList}
        @{tempList} =    run keyword if    '${fildName}'=='progress'    Get Sorted Number    ${tempList}
        ...    ELSE IF    '${fildName}'=='rating'    Get Sorted Number    ${tempList}
        ...    ELSE IF    '${fildName}'=='dob'    Get Sorted Dates    ${tempList}
        ...    ELSE    Get Sorted String Values    @{tempList}

        run keyword if    '${sortType}'=='desc'    Reverse List    ${tempList}

        ${sortValue} =    Get Element Attribute    ${TableHeaderTitle}    aria-sort

        lists should be equal    ${originalList}    ${tempList}
        should be equal   ${sortValue}  ${sortType}

Get Sorted String Values    [Arguments]    @{List}
    Sort List    ${List}
    [Return]    @{List}


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

Download CSV And Verify Data
        Click Element    css:button[name='download']
