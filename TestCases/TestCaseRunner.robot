*** Settings ***
Resource  ../Common/php_travels_keywords.robot
Suite Setup  Open Browser and Login
Suite Teardown  Logout and Close Browser

*** Variables ***

*** Test Cases ***
Logout from phpTravels
    Logout From phpTravels

SignUp for phpTravels
    SignUp Into phpTravels  s1@gmail.com  ${PASSWORD}  chetan  bhoi