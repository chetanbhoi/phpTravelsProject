*** Settings ***
#Author    chetan.bhoi
Resource  ../Common/php_travels_resources.txt
Force Tags    SC 001.1
Suite Setup  Open Browser and Login    ${BASEURL}  ${BROWSER}  ${BROWSERPATH}   ${USERNAME}  ${PASSWORD}
Suite Teardown  Logout and Close Browser
Test Teardown  Take ScreenShot On Fail TestCase

*** Test Cases ***
Search Hotel with valid hotel name
    ${defaultCheckInDate} =    Get Date With Days    3
    ${defaultCheckOutDate} =   Get Date With Days    4
    ${hotelName} =    Set Variable    ${valid_hotel_name["options"]["hotel_name"]}
    ${expectedDictionary} =    Create Dictionary
    ...    HotelName    ${hotelName}
    ...    CheckInDate    ${defaultCheckInDate}
    ...    CheckOutDate    ${defaultCheckOutDate}
    ...    Adults    2
    ...    Childs    0

    ${actuallDictionary} =   Search Hotel By Name    ${hotelName}
    Dictionaries Should Be Equal    ${expectedDictionary}    ${actuallDictionary}    Mismatch dictionary values

Search Hotel with invalid hotel name
    ${defaultCheckInDate} =    Get Date With Days    3
    ${defaultCheckOutDate} =    Get Date With Days    4
    ${hotelName} =    Set Variable    ${invalid_hotel_name["options"]["hotel_name"]}
    ${expectedDictionary} =    Create Dictionary
    ...    HotelName    No matches found
    ...    CheckInDate    ${defaultCheckInDate}
    ...    CheckOutDate    ${defaultCheckOutDate}
    ...    Adults    2
    ...    Childs    0

    ${actuallDictionary} =   Search Hotel By Name    ${hotelName}
    Dictionaries Should Be Equal    ${expectedDictionary}    ${actuallDictionary}    Mismatch dictionary values

Search Hotel with date picker
    ${hotelName} =    Set Variable    ${valid_hotel_name_and_date["options"]["hotel_name"]}
    ${checkIndate} =    Set Variable    ${valid_hotel_name_and_date["options"]["start_date"]}
    ${checkOutdate} =    Set Variable    ${valid_hotel_name_and_date["options"]["end_date"]}
    ${expectedDictionary} =    Create Dictionary
    ...    HotelName    ${hotelName}
    ...    CheckInDate    ${checkIndate}
    ...    CheckOutDate    ${checkOutdate}
    ...    Adults    2
    ...    Childs    0

    ${actuallDictionary} =    Search Hotel By Name    ${hotelName}    ${checkIndate}   ${checkOutdate}
    Dictionaries Should Be Equal    ${expectedDictionary}    ${actuallDictionary}    Mismatch dictionary values


Search Hotel with date picker and persons
    ${hotelName} =    Set Variable    ${valid_hotel_name_and_date_and_persons["options"]["hotel_name"]}
    ${checkIndate} =    Set Variable    ${valid_hotel_name_and_date_and_persons["options"]["start_date"]}
    ${checkOutdate} =    Set Variable    ${valid_hotel_name_and_date_and_persons["options"]["end_date"]}
    ${adults} =    Set Variable    ${valid_hotel_name_and_date_and_persons["options"]["adults"]}
    ${child} =    Set Variable    ${valid_hotel_name_and_date_and_persons["options"]["child"]}
    ${expectedDictionary} =    Create Dictionary
    ...    HotelName    ${hotelName}
    ...    CheckInDate    ${checkIndate}
    ...    CheckOutDate    ${checkOutdate}
    ...    Adults    ${adults}
    ...    Childs    ${child}

    ${actuallDictionary} =    Search Hotel By Name    ${hotelName}    ${checkIndate}   ${checkOutdate}    ${adults}    ${child}
    Dictionaries Should Be Equal    ${expectedDictionary}    ${actuallDictionary}    Mismatch dictionary values
