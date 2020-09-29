*** Settings ***
#Author: chetan.bhoi
Library  SeleniumLibrary
Library    os
Library    Collections
Library    String
Library    DateTime
Library    OperatingSystem
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

Read Table Records
        @{originalList} =    Create List
        FOR    ${i}    IN RANGE    10
            @{originalList} =    Append Table Rows To List     ${i}    @{originalList}
            ${flag} =    run keyword and return status    element should be disabled    ${NextPageButton}
            run keyword if    ${flag}==False   Click Element      ${NextPageButton}
            ...    ELSE    exit for loop
        END
        [Return]    @{originalList}

Append Table Rows To List    [Arguments]     ${i}    @{list}
        ${rowCount} =    Get Element Count    ${PagingRowList}
        @{tempList} =    Create List
        @{tempList} =    run keyword if    ${i}==0    Get Header List    @{tempList}
        run keyword if    ${i}==0    Append To List    ${list}    ${tempList}
        FOR    ${rowNumber}    IN RANGE    1    ${rowCount}
            @{tempList} =    Get Row List    ${rowNumber}    @{tempList}
            Append To List    ${list}    ${tempList}
        END
        [Return]    @{list}


Get Header List    [Arguments]    @{headList}
    @{headerList} =    Get WebElements    ${HeaderTitleList}
    FOR    ${element}    IN    @{headerList}
        ${value} =    get text    ${element}
        run keyword if    '${value}'!=''     Append To List    ${headList}    ${value}
    END
    [Return]    @{headList}

Get Row List    [Arguments]    ${i}    @{subList}
        ${i} =    Convert To String    ${i}
        @{subList} =    create list
        ${cellNumber} =    Set Variable    1
        ${rowElement1} =    Replace String    ${RowCellValues}    %row%    ${i}

        ${rowElement} =    Replace String    ${rowElement1}    %cell%    ${cellNumber}
        ${name} =    Get Text    ${rowElement}
        Append To List    ${subList}    ${name}

        ${cellNumber} =    Evaluate   ${cellNumber}+1
        ${cellNumber} =    Convert To String    ${cellNumber}
        ${rowElement} =    Replace String    ${rowElement1}    %cell%    ${cellNumber}
        ${task} =    Get Element Attribute    ${rowElement}    aria-label
        Append To List    ${subList}    ${task}

        ${cellNumber} =    Evaluate   ${cellNumber}+1
        ${cellNumber} =    Convert To String    ${cellNumber}
        ${rowElement} =    Replace String    ${rowElement1}    %cell%    ${cellNumber}
        ${gender} =    Get Text    ${rowElement}
        Append To List    ${subList}    ${gender}

        ${cellNumber} =    Evaluate   ${cellNumber}+1
        ${cellNumber} =    Convert To String    ${cellNumber}
        ${rowElement} =    Replace String    ${rowElement1}    %cell%    ${cellNumber}
        ${ratAttri} =    Get Element Attribute    ${rowElement}    style
        ${flg} =    run keyword and return status    should not contain    ${ratAttri}    display
        ${rating} =    Get Element Attribute    ${rowElement}    aria-label
        run keyword if    '${flg}'=='True'     Append To List    ${subList}    ${rating}

        ${cellNumber} =    Evaluate   ${cellNumber}+1
        ${cellNumber} =    Convert To String    ${cellNumber}
        ${rowElement} =    Replace String    ${rowElement1}    %cell%    ${cellNumber}
        ${color} =    Get Text    ${rowElement}
        Append To List    ${subList}    ${color}

        ${cellNumber} =    Evaluate   ${cellNumber}+1
        ${cellNumber} =    Convert To String    ${cellNumber}
        ${rowElement} =    Replace String    ${rowElement1}    %cell%    ${cellNumber}
        ${dob} =    Get Text    ${rowElement}
        Append To List    ${subList}    ${dob}

        ${cellNumber} =    Evaluate   ${cellNumber}+1
        ${cellNumber} =    Convert To String    ${cellNumber}
        ${rowElement} =    Replace String    ${rowElement1}    %cell%    ${cellNumber}
        ${driver} =    Get Element Attribute    ${rowElement}    aria-checked
        Append To List    ${subList}    ${driver}

        [Return]    @{subList}


Download CSV And Verify Data
        Click Element    css:button[name='download']
