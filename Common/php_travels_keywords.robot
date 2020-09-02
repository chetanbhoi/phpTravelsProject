*** Settings ***
#Author: chetan.bhoi
Library  SeleniumLibrary
Library    Collections
Library    String
Variables  ./php_travels_variables.py

*** Variables ***
${BASEURL}    https://www.phptravels.net/
${BROWSER}    chrome
${USERNAME}  chetan@gmail.com
${PASSWORD}  123456
${USERFNAME}    Chetan
${USERLNAME}    Bhoi

*** Keywords ***
Open Browser and Login
    Open Browser and Maximize
#    SignUp Into phpTravels    chetan@gmail.com    123456    Chetan    Bhoi
    Login Into phpTravels  ${USERNAME}  ${PASSWORD}

Logout and Close Browser
    Logout From phpTravels
    Close Browser

Open Browser and Maximize
    Open Browser  ${BASEURL}  ${BROWSER}
    Maximize Browser window
    Set Selenium Implicit Wait  5 sec
#    set selenium speed    1 sec

SignUp Into phpTravels
    [Arguments]  ${email}  ${password}  ${firstName}  ${lastName}
    Click Element  ${MyAccountDropDown}
    Click Element  ${SignUpLink}
    Input Text  ${FirstNameInput}  ${firstName}
    Input Text  ${LastNameInput}  ${lastName}
    Input Text  ${MobileInput}  9876543210
    Input Text  ${EmailInput}  ${email}
    Input Text  ${PasswordInput}  ${password}
    Input Text  ${ConfirmPasswordInput}  ${password}
    execute javascript  window.scrollTo(0,1000)
    Click Button  ${SignUpButton}
    wait until element is visible    xpath://*[contains(text(),'Hi, ${firstName} ${lastName}')]

Login Into phpTravels
    [Arguments]     ${username}     ${password}
    Click Element  ${MyAccountDropDown}
    Click Element  ${LoginLink}
    Input Text  ${UsernameInput}  ${username}
    Input Text  ${PasswordInput}  ${password}
    Click Button  ${LoginButton}
    wait until element is visible    xpath://*[contains(text(),'Hi, ${USERFNAME} ${USERLNAME}')]
    ${accName} =    get text    ${MyAccountDropDown}
    [Return]    ${accName}

Logout From phpTravels
    Click Element  ${HomeLogoImage}
    Click Element  ${MyAccountDropDown}
    Click Element  ${LogoutLink}
    wait until element is visible    ${LoginLabel}

Search Hotel By Name
    [Arguments]    ${searchValue}    ${checkIn}=${EMPTY}     ${checkOut}=${EMPTY}     ${adults}=${EMPTY}     ${children}=${EMPTY}
    Click Element    ${HomeLogoImage}
    execute javascript    window.scrollTo(0,5000)
    scroll element into view    ${HotelNavTab}
    wait until element is visible    ${HotelNavTab}
    click element    ${HotelNavTab}
    wait until element is visible    ${SearchLabelInput}
    click element    ${SearchLabelInput}
    input text       ${SearchInput}    ${searchValue}
    wait until element is visible    xpath://div[@id ='select2-drop']//ul[@class ='select2-results']//li
    ${length} =    get element count    ${SearchListView}
    FOR    ${i}    IN RANGE    5
           Exit For Loop If    ${length} > 1
           Sleep    1
           ${length} =    get element count    ${SearchListView}
    END
    ${SearchListedValue} =    Replace Dynamic Elements    ${SearchListedValue}    ${searchValue}
    Run Keyword If    '${length}' > '1'
    ...    click element     ${SearchListedValue}
    ...    ELSE    Press Keys    ${SearchInput}    TAB

    Run Keyword If    '${checkIn}' != '${EMPTY}'    Send CheckIn Date    ${checkIn}
    Run Keyword If    '${checkOut}' != '${EMPTY}'    Send checkout date    ${checkOut}
    run keyword if    '${adults}' != '${EMPTY}'     Select Persons    ${adults}    adults
    run keyword if    '${children}' != '${EMPTY}'    Select Persons    ${children}    children
    Run Keyword If    '${length}' > '1'  click element    ${SearchButton}

    ${response} =    Set Variable If    '${length}' > '1'    found
    ...    '${length}' == '1'     not found

    [Return]    ${response}


Take ScreenShot On Fail TestCase
    run keyword if test failed    capture page screenshot    ${TEST NAME}.png
    run keyword if test failed    log source

Select Date From DatePicker
    [Arguments]    ${element}    ${dateValue}
    @{splitDate} =  Split String  ${dateValue}  /
    ${day} =    set variable    ${splitdate}[0]
    ${month} =    set variable    ${splitdate}[1]
    ${year} =    set variable    ${splitdate}[2]
    click element    ${element}
    ${type} =    get element attribute    ${element}    id
    ${iV} =    set variable if    '${type}' == 'checkin'    1
    ...    '${type}' == 'checkout'  2

    log to console    ${iV}
    log to console    ${type}
    #scroll element into view    xpath://div[@id='datepickers-container']//div[1]//nav[1]//div[@class='datepicker--nav-title']
    run keyword if    '${type}' == 'checkin'    execute javascript   window.scrollTo(0,5000)
    run keyword if    '${type}' == 'checkout'    execute javascript   window.scrollTo(0,7000)

    ${DatePickerTitle} =    Replace Dynamic Elements    ${DatePickerTitle}    ${iV}
    click element    ${DatePickerTitle}
    click element    ${DatePickerTitle}
    ${DatePickerYear} =    Replace Dynamic Elements    ${DatePickerYear}    ${iV}
    ${DatePickerYear} =    replace string    ${DatePickerYear}    ${year}    ${year}
    ${flag} =    get element count    ${DatePickerYear}
    FOR    ${i}    IN RANGE    10
           Exit For Loop If    ${flag} == 1
           ${DatePickerNextButton} =    Replace Dynamic Elements    ${DatePickerNextButton}    ${iV}
           click element    ${DatePickerNextButton}
           ${flag} =    get element count    ${DatePickerYear}
    END
    click element     ${DatePickerYear}
    ${DatePickerMonth} =   Replace Dynamic Elements    ${DatePickerMonth}    ${iV}
    ${DatePickerMonth} =   replace string    ${DatePickerMonth}    ${month}    ${month}
    wait until element is visible    ${DatePickerMonth}
    click element at coordinates    ${DatePickerMonth}    0    0
    ${DatePickerDays} =    Replace Dynamic Elements    ${DatePickerDays}    ${iV}
    ${DatePickerDays} =    replace string    ${DatePickerDays}    ${day}    ${day}
    ${DatePickerDays} =    replace string    ${DatePickerDays}    ${month}    ${month}
    wait until element is enabled     ${DatePickerDays}
    click element     ${DatePickerDays}

Send CheckOut Date
    [Arguments]    ${date}
    click element    ${CheckOutDateInput}
    clear element text    ${CheckOutDateInput}
    input text    ${CheckOutDateInput}    ${date}
    press keys    ${CheckOutDateInput}    TAB

Send CheckIn Date
    [Arguments]    ${date}
    click element    ${CheckInDateInput}
    clear element text    ${CheckInDateInput}
    input text    ${CheckInDateInput}   ${date}
    press keys   ${CheckInDateInput}    TAB

Select Persons
    [Arguments]    ${numberOfPerson}    ${type}
    ${name} =    convert to lower case    ${type}
    ${PersonInput} =   Replace Dynamic Elements    ${PersonInput}   ${name}
    ${PersonPlusButton} =    Replace Dynamic Elements    ${PersonPlusButton}   ${name}
    ${PersonMinusButton} =    Replace Dynamic Elements   ${PersonMinusButton}    ${name}

    ${currentPersonValue} =   get element attribute    ${PersonInput}    value
    ${numberOfPerson} =    convert to integer    ${numberOfPerson}
    ${currentPersonValue} =    convert to integer    ${currentPersonValue}

    ${flag} =    set variable if    ${currentPersonValue} == ${numberOfPerson}    0
    ...    ${currentPersonValue} < ${numberOfPerson}    1
    ...    ${currentPersonValue} > ${numberOfPerson}    2

    ${tclick} =   run keyword if    ${flag}==1   Evaluate     ${numberOfPerson}-${currentPersonValue}
    ...    ELSE IF   ${flag}==2   Evaluate     ${currentPersonValue}-${numberOfPerson}

    run keyword if    ${flag} == 1    Add Person Value      ${PersonPlusButton}    ${tclick}
    ...    ELSE IF    ${flag} == 2    Minus Person Value    ${PersonMinusButton}    ${tclick}


Add Person Value
    [Arguments]    ${PersonPlusButton}    ${numberOfClick}
    FOR    ${i}   IN RANGE    ${numberOfClick}
           click element    ${PersonPlusButton}
    END

Minus Person Value
    [Arguments]   ${PersonMinusButton}    ${numberOfClick}
    FOR    ${i}   IN RANGE    ${numberOfClick}
           click element    ${PersonMinusButton}
    END

Replace Dynamic Elements
    [Arguments]    ${element}    ${value}
    ${result} =  replace string    ${element}    %s%    ${value}
    [Return]    ${result}