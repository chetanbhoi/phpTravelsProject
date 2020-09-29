*** Settings ***
#Author    chetan.bhoi
#Library    SeleniumLibrary
Resource  ../Common/tabulator_resources.txt
Force Tags    SC 001.2
Suite Setup  Open Browser and Maximize    ${BASEURL}  ${BROWSER}  ${BROWSERPATH}
Suite Teardown  Close Tabulator Browser
Test Teardown  Take ScreenShot On Fail TestCase


*** Test Cases ***
Download CSV With All Data And Verify
    Click Element    ${CSVDownloadButton}
    Sleep    2 sec
    ${filename} =   Set Variable    ${DOWNLOAD_DIR}${CSV_FILENAME}
    @{list} =    Get Csv Data In List    ${filename}

    @{originalList} =    Read Table Records

    Remove File    ${filename}
    Lists Should Be Equal     ${originalList}    ${list}

Download CSV With Rating Field As Hide And Verify
    Reload Page
    ${flag} =    Run Keyword And Return Status    Element Should Ee Visible    ${ShowRatingColumnButton}
    Run Keyword If    ${flag}==True    Click Element    ${RatingColumnButton}

    Click Element    ${CSVDownloadButton}
    Sleep    2 sec
    ${filename} =   Set Variable    ${DOWNLOAD_DIR}${CSV_FILENAME}
    @{list} =    Get Csv Data In List    ${filename}
    @{originalList} =    Read Table Records
    Remove File    ${filename}
    Lists Should Be Equal     ${originalList}    ${list}

Download CSV With Searched Table Rows And Verify
    Reload Page
    Input Text    ${FilterTableByNameInput}    Alan Francis
    Sleep    2 sec`

    Click Element    ${CSVDownloadButton}
    Sleep    2 sec

    ${filename} =   Set Variable    ${DOWNLOAD_DIR}${CSV_FILENAME}
    @{list} =    Get Csv Data In List    ${filename}
    @{originalList} =    Read Table Records
    Remove File    ${filename}
    Lists Should Be Equal     ${originalList}    ${list}

