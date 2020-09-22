*** Settings ***
#Author    chetan.bhoi
Resource  ../Common/tabulator_resources.txt
Force Tags    SC 001.2
Suite Setup  Open Browser and Maximize    ${BASEURL}  ${BROWSER}  ${BROWSERPATH}
Suite Teardown  Close Tabulator Browser
Test Teardown  Take ScreenShot On Fail TestCase

*** Test Cases ***
Verify Filter Of Table Name By Paritally Name
    ${searchData} =    Set Variable    ${filter_table_with_valid_partially_name}
    Filter Table By Name And Verify    ${searchData}    ${True}

Verify Filter Of Table Name By Full Name
    ${searchData} =    Set Variable    ${filter_table_with_valid_full_name}
    Filter Table By Name And Verify    ${searchData}    ${False}

Verify Filter Of Table Name By Invalid Name
    ${searchData} =    Set Variable    ${filter_table_with_invalid_name}
    Filter Table By Name And Verify    ${searchData}    ${True}

Verify Filter Of Table Name By Name As Wild Card Chars
    ${searchData} =    Set Variable    ${filter_table_with_name_as_wildcardchars}
    Filter Table By Name And Verify    ${searchData}    ${True}
