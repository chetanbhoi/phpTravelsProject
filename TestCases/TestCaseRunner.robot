*** Settings ***
#Author    chetan.bhoi
Resource  ../Common/php_travels_resources.txt
Force Tags    TC-2855001
Suite Setup  Open Browser and Login    ${BASEURL}  ${BROWSER}  ${BROWSERPATH}   ${USERNAME}  ${PASSWORD}
Suite Teardown  Logout and Close Browser
Test Teardown  Take ScreenShot On Fail TestCase

*** Test Cases ***
Search Hotel with valid hotel name
    ${hotelName} =    Set Variable    ${valid_hotel_name["options"]["hotel_name"]}
    ${response} =   Search Hotel By Name    ${hotelName}
    ${resHotelName} =   Pop From Dictionary    ${response}    HotelName
    Should Be Equal    ${resHotelName}    ${hotelName}    Hotel name is not found as expected

Search Hotel with invalid hotel name
    ${hotelName} =    Set Variable    ${invalid_hotel_name["options"]["hotel_name"]}
    ${response} =    Search Hotel By Name    ${hotelName}
    ${resHotelName} =   Pop From Dictionary    ${response}    HotelName
    Should Be Equal    ${resHotelName}    No matches found    Hotel name is not found as expected


Search Hotel with date picker
    ${hotelName} =    Set Variable    ${valid_hotel_name_and_date["options"]["hotel_name"]}
    ${checkIndate} =    Set Variable    ${valid_hotel_name_and_date["options"]["start_date"]}
    ${checkOutdate} =    Set Variable    ${valid_hotel_name_and_date["options"]["end_date"]}
    ${response} =    Search Hotel By Name    ${hotelName}    ${checkIndate}   ${checkOutdate}
    ${resHotelName} =   Pop From Dictionary    ${response}    HotelName
    ${resCheckInDate} =   Pop From Dictionary    ${response}    CheckInDate
    ${resCheckOutDate} =   Pop From Dictionary    ${response}    CheckOutDate
    Should Be Equal    ${resHotelName}    ${hotelName}    Hotel name is not found as expected
    Should Be Equal    ${resCheckInDate}    ${checkIndate}    CheckOutDate is not found as expected
    Should Be Equal    ${resCheckOutDate}    ${checkOutdate}    CheckInDate is not found as expected


Search Hotel with date picker and persons
    ${hotelName} =    Set Variable    ${valid_hotel_name_and_date_and_persons["options"]["hotel_name"]}
    ${checkIndate} =    Set Variable    ${valid_hotel_name_and_date_and_persons["options"]["start_date"]}
    ${checkOutdate} =    Set Variable    ${valid_hotel_name_and_date_and_persons["options"]["end_date"]}
    ${adults} =    Set Variable    ${valid_hotel_name_and_date_and_persons["options"]["adults"]}
    ${child} =    Set Variable    ${valid_hotel_name_and_date_and_persons["options"]["child"]}
    ${response} =    Search Hotel By Name    ${hotelName}    ${checkIndate}   ${checkOutdate}    ${adults}    ${child}
    ${resHotelName} =   Pop From Dictionary    ${response}    HotelName
    ${resCheckInDate} =   Pop From Dictionary    ${response}    CheckInDate
    ${resCheckOutDate} =   Pop From Dictionary    ${response}    CheckOutDate
    ${resAdults} =   Pop From Dictionary    ${response}    Adults
    ${resChilds} =   Pop From Dictionary    ${response}    Childs
    Should Be Equal    ${resHotelName}    ${hotelName}    Hotel name is not found as expected
    Should Be Equal    ${resCheckInDate}    ${checkIndate}    CheckOutDate is not found as expected
    Should Be Equal    ${resCheckOutDate}    ${checkOutdate}    CheckInDate is not found as expected
    Should Be Equal    ${resAdults}    ${adults}    Adults value is not found as expected
    Should Be Equal    ${resChilds}    ${resChilds}    Childs value is not found as expected
