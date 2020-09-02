*** Settings ***
#Author    chetan.bhoi
Library    JSONLibrary
Library    os
Library    Collections

*** Variables ***
${searchHotelDataJsonFile} =    ../TestData/SearchHotelData.json

*** Keywords ***
Get data from jsonfile
    [Arguments]    ${jsonKeyName}
    ${jsonObject} =    load json from file    ${searchHotelDataJsonFile}
    ${jsonValue} =    get value from json    ${jsonObject}    ${jsonKeyName}
    [Return]    ${jsonValue[0]}