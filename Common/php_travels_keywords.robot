*** Settings ***
#Author: chetan.bhoi
Library  SeleniumLibrary
Library    os
Library    Collections
Library    String
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
    ${length} =    Get Element Count    ${SearchListView}
    FOR    ${i}    IN RANGE    5
           Exit For Loop If    ${length} > 1
           Sleep    1
           ${length} =    Get Element Count    ${SearchListView}
    END
    ${SearchListedValue} =    Replace Dynamic Elements    ${SearchListedValue}    ${searchValue}
    Run Keyword If    '${length}' > '1'
    ...    Click Element     ${SearchListedValue}
    ...    ELSE    Press Keys    ${SearchInput}    TAB

#    Run Keyword If    '${checkIn}' != '${EMPTY}'    Select Date From DatePicker   ${CheckInDateInput}  ${checkIn}
#    Run Keyword If    '${checkOut}' != '${EMPTY}'    Select Date From DatePicker   ${CheckOutDateInput}  ${checkOut}
    Run Keyword If    '${checkIn}' != '${EMPTY}'    Send CheckIn Date    ${checkIn}
    Run Keyword If    '${checkOut}' != '${EMPTY}'    Send checkout date    ${checkOut}
    Run Keyword If    '${adults}' != '${EMPTY}'     Select Persons    ${adults}    adults
    Run Keyword If    '${children}' != '${EMPTY}'    Select Persons    ${children}    children
    Run Keyword If    '${length}' > '1'  Click Element    ${SearchButton}

    Run Keyword If    '${length}' > '1'  Wait Until Element Is Visible    ${HotelNameValue}

    ${responseHotelName} =    Run Keyword If   '${length}' > '1'    Get Text    ${HotelNameValue}
    ...    ELSE IF    '${length}' == '1'    Set Variable    No matches found

    Run Keyword If   '${length}' > '1'    Scroll Element Into View    ${ChildsValue}
    ${responseCheckInDate} =    Run Keyword If   '${checkIn}' != '${EMPTY}'    Get Element Attribute    ${CheckInDateValue}    value
    ...    ELSE    set variable    ${EMPTY}
    ${responseCheckOutDate} =    Run Keyword If   '${checkOut}' != '${EMPTY}'   Get Element Attribute    ${CheckOutDateValue}    value
    ...    ELSE   set variable    ${EMPTY}
    ${responseAdults} =    Run Keyword If   '${adults}' != '${EMPTY}'     Get Element Attribute     ${AdultsValue}    value
    ...    ELSE    set variable    ${EMPTY}
    ${responseChilds} =    Run Keyword If   '${children}' != '${EMPTY}'     Get Element Attribute     ${ChildsValue}    value
    ...    ELSE   set variable    ${EMPTY}

    ${responseDict} =    Create Dictionary
    ...    HotelName    ${responseHotelName}
    ...    CheckInDate    ${responseCheckInDate}
    ...    CheckOutDate    ${responseCheckOutDate}
    ...    Adults    ${responseAdults}
    ...    Childs    ${responseChilds}

    [Return]    ${responseDict}


Take ScreenShot On Fail TestCase
    Run Keyword If Test Failed    capture page screenshot    ${TEST NAME}.png
    Run Keyword If Test Failed    log source

Select Date From DatePicker    [Arguments]    ${element}    ${dateValue}
    @{splitDate} =  Split String  ${dateValue}  /
    ${day} =    Set Variable    ${splitdate}[0]
    ${month} =    Set Variable    ${splitdate}[1]
    ${year} =    Set Variable    ${splitdate}[2]
    Click Element    ${element}
    ${type} =   Get Element Attribute    ${element}    id
    ${iV} =    Set Variable If    '${type}' == 'checkin'    1
    ...    '${type}' == 'checkout'  2

    ${DatePickerTitle} =    Replace Dynamic Elements    ${DatePickerTitle}    ${iV}
#    Run Keyword If    '${type}' == 'checkin'    Execute Javascript   window.scrollTo(0,5000)
#    Run Keyword If    '${type}' == 'checkout'    Execute Javascript   window.scrollTo(0,7000)

    Click Element    ${DatePickerTitle}
    Click Element    ${DatePickerTitle}
    ${DatePickerYear} =    Replace Dynamic Elements    ${DatePickerYear}    ${iV}
    ${DatePickerYear} =    Replace String    ${DatePickerYear}    {year}    ${year}
    ${flag} =    Get Element Count    ${DatePickerYear}
    FOR    ${i}    IN RANGE    10
           Exit For Loop If    ${flag} == 1
           ${DatePickerNextButton} =    Replace Dynamic Elements    ${DatePickerNextButton}    ${iV}
           Click Element    ${DatePickerNextButton}
           ${flag} =    Get Element Count    ${DatePickerYear}
    END
    Scroll Element Into View    ${DatePickerYear}
    Click Element     ${DatePickerYear}
    ${DatePickerMonth} =   Replace Dynamic Elements    ${DatePickerMonth}    ${iV}
    ${DatePickerMonth} =   Replace String    ${DatePickerMonth}    {month}    ${month}
    Wait Until Element is Visible    ${DatePickerMonth}
    Click Element at coordinates    ${DatePickerMonth}    0    0
    ${DatePickerDays} =    Replace Dynamic Elements    ${DatePickerDays}    ${iV}
    ${DatePickerDays} =    Replace String    ${DatePickerDays}    {day}    ${day}
    ${DatePickerDays} =    Replace String    ${DatePickerDays}    {month}    ${month}
    Wait Until Element Is Enabled     ${DatePickerDays}
    Click Element     ${DatePickerDays}

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