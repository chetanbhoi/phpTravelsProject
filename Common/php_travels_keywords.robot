*** Settings ***
#Author: chetan.bhoi
Library  SeleniumLibrary
Library    os
Library    Collections
Library    String
Library    DateTime
Resource    ../Common/php_travels_variables.txt

*** Keywords ***
Open Browser and Login    [Arguments]    ${BASEURL}  ${BROWSER}   ${BROWSERPATH}    ${USERNAME}   ${PASSWORD}
    Open Browser and Maximize    ${BASEURL}  ${BROWSER}    ${BROWSERPATH}
#    SignUp Into phpTravels    chetan@gmail.com    123456    Chetan    Bhoi
#    Login Into phpTravels  ${USERNAME}  ${PASSWORD}

Logout and Close Browser
#    Logout From phpTravels
    Close Browser

Open Browser and Maximize    [Arguments]    ${BASEURL}    ${BROWSER}    ${BROWSERPATH}
    Create Webdriver    Chrome    executable_path=${BROWSERPATH}
    Go To     ${BASEURL}
    Maximize Browser window
    Set Selenium Implicit Wait  5 sec

SignUp Into phpTravels    [Arguments]  ${email}  ${password}  ${firstName}  ${lastName}
    Click Element  ${MyAccountDropDown}
    Wait Until Element is Visible    ${SignUpLink}
    Click Element  ${SignUpLink}
    Input Text  ${FirstNameInput}  ${firstName}
    Input Text  ${LastNameInput}  ${lastName}
    Input Text  ${MobileInput}  9876543210
    Input Text  ${EmailInput}  ${email}
    Input Text  ${PasswordInput}  ${password}
    Input Text  ${ConfirmPasswordInput}  ${password}
    Execute Javascript  window.scrollTo(0,1000)
    Click Button  ${SignUpButton}
    Wait Until Element is Visible    xpath://*[contains(text(),'Hi, ${firstName} ${lastName}')]

Login Into phpTravels    [Arguments]     ${username}     ${password}
    Click Element  ${MyAccountDropDown}
    Click Element  ${LoginLink}
    Input Text  ${UsernameInput}  ${username}
    Input Text  ${PasswordInput}  ${password}
    Click Button  ${LoginButton}
    Wait Until Element is Visible    xpath://*[contains(text(),'Hi, ${USERFNAME} ${USERLNAME}')]
    ${accName} =    Get Text   ${MyAccountDropDown}
    [Return]    ${accName}

Logout From phpTravels
    Click Element  ${HomeLogoImage}
    Click Element  ${MyAccountDropDown}
    Click Element  ${LogoutLink}
    Wait Until Element is Visible    ${LoginLabel}

Search Hotel By Name    [Arguments]    ${searchValue}    ${checkIn}=${EMPTY}     ${checkOut}=${EMPTY}     ${adults}=${EMPTY}     ${children}=${EMPTY}
    Click Element    ${HomeLogoImage}
    Scroll Element Into View    ${LatestBlogTitle}
    Wait Until Element is Visible    ${HotelNavTab}
    Click Element    ${HotelNavTab}
    Wait Until Element is Visible    ${SearchLabelInput}
    Click Element    ${SearchLabelInput}
    Input Text       ${SearchInput}    ${searchValue}

    Wait Until Element is Visible    ${SearchListView}
    Run Keyword And Return Status   Element Should Be Visible    ${HotelLableInListView}

    ${length} =  Get Element Count    ${SearchListView}
    ${noResultValue} =    Run Keyword If    '${length}' == '1'    Get Text    ${SearchListView}

    ${SearchListedValue} =    Replace Dynamic Elements    ${SearchListedValue}    ${searchValue}
    Run Keyword If    '${length}' > '1'
    ...    Click Element     ${SearchListedValue}
    ...    ELSE    Press Keys    ${SearchInput}    TAB

    ${defaultCheckInDate} =     Run Keyword If    '${checkIn}' == '${EMPTY}'   Get Element Attribute    ${CheckInDateInput}    placeholder
    ${defaultCheckOutDate} =     Run Keyword If    '${checkOut}' == '${EMPTY}'   Get Element Attribute    ${CheckOutDateInput}    placeholder
    ${defaultAdultValue} =     Run Keyword If    '${adults}' == '${EMPTY}'   Get Element Attribute    ${AdultsValue}    value
    ${defaultChildValue} =     Run Keyword If    '${children}' == '${EMPTY}'   Get Element Attribute    ${ChildsValueDefault}     placeholder

    Run Keyword If    '${checkIn}' != '${EMPTY}'    Send CheckIn Date    ${checkIn}
    Run Keyword If    '${checkOut}' != '${EMPTY}'    Send checkout Date    ${checkOut}
    Run Keyword If    '${adults}' != '${EMPTY}'     Select Persons    ${adults}    adults
    Run Keyword If    '${children}' != '${EMPTY}'    Select Persons    ${children}    children

    Wait Until Element Is Visible    ${SearchButton}
    Run Keyword If    '${length}' > '1'  Click Element    ${SearchButton}

    Run Keyword If    '${length}' > '1'  Wait Until Element Is Visible    ${HotelNameValue}

    ${responseHotelName} =    Run Keyword If   '${length}' > '1'    Get Text    ${HotelNameValue}
    ...    ELSE    Set Variable     ${noResultValue}

    Run Keyword If   '${length}' > '1'    Scroll Element Into View    ${ChildsValue}
    ${responseCheckInDate} =    Run Keyword If   '${length}' > '1'    Get Element Attribute    ${CheckInDateValue}    value
    ...    ELSE    Set Variable    ${defaultCheckInDate}
    ${responseCheckOutDate} =    Run Keyword If   '${length}' > '1'   Get Element Attribute    ${CheckOutDateValue}    value
    ...    ELSE    Set Variable    ${defaultCheckOutDate}
    ${responseAdults} =    Run Keyword If   '${length}' > '1'     Get Element Attribute     ${AdultsValue}    value
    ...    ELSE    Set Variable    ${defaultAdultValue}
    ${responseChilds} =    Run Keyword If   '${length}' > '1'     Get Element Attribute     ${ChildsValue}    value
    ...    ELSE    Set Variable    ${defaultChildValue}

    ${responseDict} =    Create Dictionary
    ...    HotelName    ${responseHotelName}
    ...    CheckInDate    ${responseCheckInDate}
    ...    CheckOutDate    ${responseCheckOutDate}
    ...    Adults    ${responseAdults}
    ...    Childs    ${responseChilds}

    [Return]    ${responseDict}


Take ScreenShot On Fail TestCase
    Run Keyword If Test Failed    Capture Page Screenshot    ${TEST NAME}.png
    Run Keyword If Test Failed    Log Source

Send CheckOut Date    [Arguments]    ${date}
    Click Element    ${CheckOutDateInput}
    Clear Element Text    ${CheckOutDateInput}
    Input Text    ${CheckOutDateInput}    ${date}
    Press Keys    ${CheckOutDateInput}    TAB

Send CheckIn Date    [Arguments]    ${date}
    Click Element    ${CheckInDateInput}
    Clear Element Text    ${CheckInDateInput}
    Input Text    ${CheckInDateInput}   ${date}
    Press Keys   ${CheckInDateInput}    TAB

Select Persons    [Arguments]    ${numberOfPerson}    ${type}
    ${name} =    Convert To Lower Case    ${type}
    ${PersonInput} =   Replace Dynamic Elements    ${PersonInput}   ${name}
    ${PersonPlusButton} =    Replace Dynamic Elements    ${PersonPlusButton}   ${name}
    ${PersonMinusButton} =    Replace Dynamic Elements   ${PersonMinusButton}    ${name}
    Wait Until Element Is Visible    ${PersonInput}
    ${currentPersonValue} =   Get Element Attribute    ${PersonInput}    value
    ${numberOfPerson} =    Convert To Integer    ${numberOfPerson}
    ${currentPersonValue} =    Convert To Integer    ${currentPersonValue}

    ${flag} =    Set Variable if    ${currentPersonValue} == ${numberOfPerson}    0
    ...    ${currentPersonValue} < ${numberOfPerson}    1
    ...    ${currentPersonValue} > ${numberOfPerson}    2

    ${tclick} =   Run Keyword If    ${flag}==1   Evaluate     ${numberOfPerson}-${currentPersonValue}
    ...    ELSE IF   ${flag}==2   Evaluate     ${currentPersonValue}-${numberOfPerson}

    Run Keyword If    ${flag} == 1    Add Person Value      ${PersonPlusButton}    ${tclick}
    ...    ELSE IF    ${flag} == 2    Minus Person Value    ${PersonMinusButton}    ${tclick}


Add Person Value    [Arguments]    ${PersonPlusButton}    ${numberOfClick}
    FOR    ${i}   IN RANGE    ${numberOfClick}
           Click Element    ${PersonPlusButton}
    END

Minus Person Value    [Arguments]   ${PersonMinusButton}    ${numberOfClick}
    FOR    ${i}   IN RANGE    ${numberOfClick}
           Click Element    ${PersonMinusButton}
    END

Replace Dynamic Elements    [Arguments]    ${element}    ${value}
    ${result} =  Replace String    ${element}    %s%    ${value}
    [Return]    ${result}

Get Date With Days    [Arguments]    ${incrementDays}
    ${date} =    Get Current Date    result_format=%d/%m/%Y    increment=${incrementDays} day
    [Return]     ${date}
