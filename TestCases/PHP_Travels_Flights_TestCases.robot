*** Settings ***
#Author    chetan.bhoi
Resource  ../Common/php_travels_resources.txt
Force Tags    SC 001.2
Suite Setup  Open Browser and Login    ${BASEURL}  ${BROWSER}  ${BROWSERPATH}   ${USERNAME}  ${PASSWORD}
Suite Teardown  Logout and Close Browser
Test Teardown  Take ScreenShot On Fail TestCase

*** Test Cases ***
Search Flights With All Defaults Values
    ${searchData} =    Set Variable    ${search_flights_with_defaults_fields}
    Search Flights    ${searchData}
    Verify Flights Details Page    ${searchData}

Search Flights With Invalid Locations
    ${searchData} =    Set Variable    ${search_flights_with_invalid_locations}
    Search Flights    ${searchData}
    Verify Flights Details Page    ${searchData}

Search Flights With Only Valid Locations
    ${searchData} =    Set Variable    ${search_flights_with_valid_locations}
    Search Flights    ${searchData}
    Verify Flights Details Page    ${searchData}


Search Flights With All Valid Fields
    ${searchData} =    Set Variable    ${search_flights_with_all_valid_fields}
    Search Flights    ${searchData}
    Verify Flights Details Page    ${searchData}

