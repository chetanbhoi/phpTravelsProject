*** Settings ***
#Author    chetan.bhoi
Resource  ../Common/php_travels_resources.txt
Force Tags    TC-2855001
Suite Setup  Open Browser and Login    ${BASEURL}  ${BROWSER}  ${BROWSERPATH}   ${USERNAME}  ${PASSWORD}
Suite Teardown  Logout and Close Browser
Test Teardown  Take ScreenShot On Fail TestCase

*** Test Cases ***
Search Flights With All Defaults Values
    ${response} =    Search Flights
    should be equal    ${response}    True

Search Flights With All Valid Fields
    ${flightType} =    Set Variable    ${search_flights_with_all_valid_fields["flight"]["cabinClass"]}
    ${fromLocation} =    Set Variable    ${search_flights_with_all_valid_fields["flight"]["fromLocation"]}
    ${toLocation} =    Set Variable    ${search_flights_with_all_valid_fields["flight"]["toLocation"]}
    ${adult} =    Set Variable    ${search_flights_with_all_valid_fields["flight"]["adult"]}
    ${child} =    Set Variable    ${search_flights_with_all_valid_fields["flight"]["child"]}
    ${infant} =    Set Variable    ${search_flights_with_all_valid_fields["flight"]["infant"]}
    ${departDate} =    Get Date With Days    3    %y%y-%m-%d
    ${departDate} =    convert to string    ${departDate}
    log to console    ${departDate}

    ${response} =    Search Flights    ${flightType}    ${fromLocation}    ${toLocation}     ${departDate}   ${adult}   ${child}    ${infant}
    should be equal    ${response}    True

Search Flights With Invalid Locations
    ${fromLocation} =    Set Variable    ${search_flights_with_invalid_locations["flight"]["fromLocation"]}
    ${toLocation} =    Set Variable    ${search_flights_with_invalid_locations["flight"]["toLocation"]}

    ${response} =    Search Flights    ${EMPTY}    ${fromLocation}    ${toLocation}
    should be equal    ${response}    True

Search Flights With Only Valid Locations
    ${fromLocation} =    Set Variable    ${search_flights_with_only_valid_locations["flight"]["fromLocation"]}
    ${toLocation} =    Set Variable    ${search_flights_with_only_valid_locations["flight"]["toLocation"]}

    ${response} =    Search Flights    ${EMPTY}    ${fromLocation}    ${toLocation}
    should be equal    ${response}    True


