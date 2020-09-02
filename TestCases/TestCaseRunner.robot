*** Settings ***
#Author    chetan.bhoi
Resource  ../Common/php_travels_resources.robot
Force Tags    TC-2855001
Suite Setup  Open Browser and Login
Suite Teardown  Logout and Close Browser
Test Teardown  Take ScreenShot On Fail TestCase

*** Test Cases ***
Search Hotel with valid hotel name
   ${hotelName} =    set variable    ${valid_hotel_name["options"]["hotel_name"]}
    ${response} =   Search Hotel By Name    ${hotelName}
    should be equal    ${response}    found

Search Hotel with invalid hotel name
   ${hotelName} =    set variable    ${invalid_hotel_name["options"]["hotel_name"]}
    ${response} =    Search Hotel By Name    ${hotelName}
    should be equal    ${response}    not found

Search Hotel with date picker
     ${hotelName} =    set variable    ${valid_hotel_name_and_date["options"]["hotel_name"]}
    ${checkIndate} =    set variable    ${valid_hotel_name_and_date["options"]["start_date"]}
    ${checkOutdate} =    set variable    ${valid_hotel_name_and_date["options"]["end_date"]}
    ${response} =    Search Hotel By Name    ${hotelName}    ${checkIndate}   ${checkOutdate}
    should be equal    ${response}    found

Search Hotel with date picker and persons
    ${hotelName} =    set variable    ${valid_hotel_name_and_date_and_persons["options"]["hotel_name"]}
    ${checkIndate} =    set variable    ${valid_hotel_name_and_date_and_persons["options"]["start_date"]}
    ${checkOutdate} =    set variable    ${valid_hotel_name_and_date_and_persons["options"]["end_date"]}
    ${adults} =    set variable    ${valid_hotel_name_and_date_and_persons["options"]["adults"]}
    ${child} =    set variable    ${valid_hotel_name_and_date_and_persons["options"]["child"]}
    ${response} =    Search Hotel By Name    ${hotelName}    ${checkIndate}   ${checkOutdate}    ${adults}    ${child}
    should be equal    ${response}    found
