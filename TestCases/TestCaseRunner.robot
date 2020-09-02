*** Settings ***
#Author    chetan.bhoi
Resource  ../Common/php_travels_resources.robot
Force Tags    TC-2855001
Suite Setup  Open Browser and Login
Suite Teardown  Logout and Close Browser
Test Teardown  Take ScreenShot On Fail TestCase

*** Test Cases ***
Search Hotel with valid hotel name
    ${hotelName} =    Get data from jsonfile    valid_hotel_name.hotel_name
    ${response} =   Search Hotel By Name    ${hotelName}
    should be equal    ${response}    found

Search Hotel with invalid hotel name
    ${hotelName} =    Get data from jsonfile    invalid_hotel_name.hotel_name
    ${response} =    Search Hotel By Name    ${hotelName}
    should be equal    ${response}    not found

Search Hotel with date picker
    ${hotelName} =    Get data from jsonfile    valid_hotel_name_and_date.hotel_name
    ${checkIndate} =    Get data from jsonfile    valid_hotel_name_and_date.start_date
    ${checkOutdate} =    Get data from jsonfile    valid_hotel_name_and_date.end_date
    ${response} =    Search Hotel By Name    ${hotelName}    ${checkIndate}   ${checkOutdate}
    should be equal    ${response}    found

Search Hotel with date picker and persons
    ${hotelName} =    Get data from jsonfile    valid_hotel_name_and_date_and_persons.hotel_name
    ${checkIndate} =    Get data from jsonfile    valid_hotel_name_and_date_and_persons.start_date
    ${checkOutdate} =    Get data from jsonfile    valid_hotel_name_and_date_and_persons.end_date
    ${adults} =    Get data from jsonfile    valid_hotel_name_and_date_and_persons.adults
    ${child} =    Get data from jsonfile    valid_hotel_name_and_date_and_persons.child
    ${response} =    Search Hotel By Name    ${hotelName}    ${checkIndate}   ${checkOutdate}    ${adults}    ${child}
    should be equal    ${response}    found
