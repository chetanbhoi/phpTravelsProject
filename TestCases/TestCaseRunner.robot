*** Settings ***
#Author    chetan.bhoi
Resource  ../Common/php_travels_resources.robot
Force Tags    TC-2855001
Suite Setup  Open Browser and Login
Suite Teardown  Logout and Close Browser
Test Teardown  Take ScreenShot On Fail TestCase

*** Test Cases ***
Search Hotel with valid hotel name
    ${response} =   Search Hotel By Name    Rose Rayhaan Rotana
    should be equal    ${response}    found

Search Hotel with invalid hotel name
    ${response} =    Search Hotel By Name    dffgdgfdd
    should be equal    ${response}    not found

Search Hotel with date picker
    ${response} =    Search Hotel By Name    Rose Rayhaan Rotana    19/2/2022    10/10/2022
    should be equal    ${response}    found

Search Hotel with date picker and persons
    ${response} =    Search Hotel By Name    Rose Rayhaan Rotana    19/2/2022    10/10/2022    3    2
    should be equal    ${response}    found
