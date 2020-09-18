*** Settings ***
#Author: chetan.bhoi
Library  SeleniumLibrary
Library    os
Library    Collections
Library    String
Library    DateTime
Resource    ../Common/tabulator_variables.txt


*** Keywords ***
Open Browser and Maximize    [Arguments]    ${BASEURL}    ${BROWSER}    ${BROWSERPATH}
    Create Webdriver    Chrome    executable_path=${BROWSERPATH}
    Go To     ${BASEURL}
    Maximize Browser window
    Set Selenium Implicit Wait  5 sec

Close Tabuler Browser
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
