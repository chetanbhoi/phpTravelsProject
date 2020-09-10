*** Settings ***
#Author: chetan.bhoi
Library  SeleniumLibrary
Library    os
Library    Collections
Library    String
Library    DateTime
Resource    ../Common/php_travels_hotels_variables.txt
Resource    ../Common/php_travels_flights_variables.txt

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
    Wait Until Element Is Visible    ${SignUpLink}
    Click Element  ${SignUpLink}
    Input Text  ${FirstNameInput}  ${firstName}
    Input Text  ${LastNameInput}  ${lastName}
    Input Text  ${MobileInput}  9876543210
    Input Text  ${EmailInput}  ${email}
    Input Text  ${PasswordInput}  ${password}
    Input Text  ${ConfirmPasswordInput}  ${password}
    Execute Javascript  window.scrollTo(0,1000)
    Click Button  ${SignUpButton}
    Wait Until Element Is Visible    xpath://*[contains(text(),'Hi, ${firstName} ${lastName}')]

Login Into phpTravels    [Arguments]     ${username}     ${password}
    Click Element  ${MyAccountDropDown}
    Click Element  ${LoginLink}
    Input Text  ${UsernameInput}  ${username}
    Input Text  ${PasswordInput}  ${password}
    Click Button  ${LoginButton}
    Wait Until Element Is Visible    xpath://*[contains(text(),'Hi, ${USERFNAME} ${USERLNAME}')]
    ${accName} =    Get Text   ${MyAccountDropDown}
    [Return]    ${accName}

Logout From phpTravels
    Click Element  ${HomeLogoImage}
    Click Element  ${MyAccountDropDown}
    Click Element  ${LogoutLink}
    Wait Until Element Is Visible    ${LoginLabel}

Search Hotel By Name    [Arguments]    ${searchValue}    ${checkIn}=${EMPTY}     ${checkOut}=${EMPTY}     ${adults}=${EMPTY}     ${children}=${EMPTY}
    Click Element    ${HomeLogoImage}
    Scroll Element Into View    ${LatestBlogTitle}
    Wait Until Element Is Visible    ${HotelNavTab}
    Click Element    ${HotelNavTab}
    Wait Until Element Is Visible    ${SearchLabelInput}
    Click Element    ${SearchLabelInput}
    Input Text       ${SearchInput}    ${searchValue}

    Wait Until Element Is Visible    ${SearchListView}
    Run Keyword And Return Status   wait until keyword succeeds    1 min    5 sec    Element Should Not Be Visible    ${SearchingElement}
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

    Run Keyword If    '${checkIn}' != '${EMPTY}'    Send Date To Input    ${CheckInDateInput}    ${checkIn}
    Run Keyword If    '${checkOut}' != '${EMPTY}'    Send Date To Input    ${CheckOutDateInput}    ${checkOut}
    Run Keyword If    '${adults}' != '${EMPTY}'     Select Person    ${adults}    ${PersonAdultsInput}  ${PersonAdultsPlusButton}  ${PersonAdultsMinusButton}
    Run Keyword If    '${children}' != '${EMPTY}'    Select Person    ${children}    ${PersonChildInput}  ${PersonChildPlusButton}  ${PersonChildMinusButton}

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

Send Date To Input    [Arguments]    ${elementInput}    ${date}
    Click Element    ${elementInput}
    Clear Element Text    ${elementInput}
    Input Text    ${elementInput}    ${date}
    Press Keys    ${elementInput}    TAB

Update Person Value    [Arguments]    ${PersonButton}    ${numberOfClick}
    FOR    ${i}   IN RANGE    ${numberOfClick}
           Click Element    ${PersonButton}
    END

Replace Dynamic Elements    [Arguments]    ${element}    ${value}
    ${result} =  Replace String    ${element}    %s%    ${value}
    [Return]    ${result}

Get Date With Days    [Arguments]    ${incrementDays}    ${result_formate}=%d/%m/%Y
    ${date} =    Get Current Date    result_format=${result_formate}    increment=${incrementDays} day
    [Return]     ${date}


#Flight keyword are started from here....*** Variables ***

Search Flights    [Arguments]    ${flightType}=${EMPTY}    ${fromLocation}=${EMPTY}    ${toLocation}=${EMPTY}    ${departDate}=${EMPTY}    ${adults}=${EMPTY}    ${childs}=${EMPTY}    ${infant}=${EMPTY}
    #Navigate to Flights
    Click Element    ${HomeLogoImage}
    Wait Until Element Is Visible    ${FlightNavTab}
    Click Element    ${FlightNavTab}

    Scroll Element Into View    ${LatestBlogTitle}
    #Select FlighType
    ${flightType} =    Run Keyword If    '${flightType}'!='${EMPTY}'    Select Flight Type Class    ${flightType}
    ...    ELSE     Get Text    ${DefaultCabinClass}

    #select from locatioin....
    ${fromLocationAliase} =    Run Keyword If    '${fromLocation}'!='${EMPTY}'  Select Flight Location    ${LocationFrom}    ${fromLocation}
    ...    ELSE    Get Text    ${DefaultLocationFrom}

    #Select to location
    ${toLocationAliase} =    Run Keyword If    '${toLocation}'!='${EMPTY}'  Select Flight Location    ${LocationTo}    ${toLocation}
    ...    ELSE    Get Text    ${DefaultLocationTo}

    #Select depart date
    ${dateLocator} =    Split String    ${CSS_FlightStartDate}    :
    Run Keyword If    '${departDate}'!='${EMPTY}'    Execute Javascript          document.querySelector("${dateLocator}[1]").removeAttribute("readonly");
    Run Keyword If    '${departDate}'!='${EMPTY}'    Execute Javascript          document.querySelector("${dateLocator}[1]").setAttribute("value", "${departDate}");

    #Select Adults
    Run Keyword If    '${adults}'!='${EMPTY}'    Select Person    ${adults}    ${FlightAdultPersonInput}  ${FlightAdultsPlusButton}  ${FlightAdultsMinusButton}

    #Select Childs
    Run Keyword If    '${childs}'!='${EMPTY}'    Select Person    ${childs}    ${FlightChildPersonInput}  ${FlightChildPlusButton}  ${FlightChildMinusButton}

    #Select Infants
    Run Keyword If    '${infant}'!='${EMPTY}'    Select Person    ${infant}    ${FlightInfantPersonInput}  ${FlightInfantPlusButton}  ${FlightInfantMinusButton}

    #Click on search button
    Click Element    ${FlightSearchButton}

    #Verify details page
    Wait Until Element Is Visible    ${FilterSearchLabel}
    @{listLI} =    Get WebElements    ${FlightListData}
    ${listLIcount} =    Get Element Count    ${FlightListData}
    ${response} =    Set Variable    True
    FOR    ${element}    IN    @{listLI}
        Wait Until Element Is Visible    ${FlightListCity}
        @{listP} =    Get WebElements    ${FlightListCity}
        ${fromTxt} =    Get Text    ${listP}[0]
        ${toTxt} =    Get Text    ${listP}[1]
        ${classValue} =    Get Text     ${FlightCabinClass}
        Run Keyword If    '${fromTxt}' != '${fromLocationAliase}'    Set Variable    ${False}
        Run Keyword If    '${toTxt}' != '${toLocationAliase}'    Set Variable    ${False}
        Run Keyword If    '${classValue}' != '${flightType}'    Set Variable    ${False}
    END
    [Return]    ${response}


Select Person    [Arguments]    ${numberOfPerson}    ${personInputElement}    ${PersonPlusButton}    ${PersonMinusButton}
    Wait Until Element Is Visible    ${personInputElement}
    ${currentPersonValue} =   Get Element Attribute    ${personInputElement}    value
    ${numberOfPerson} =    Convert To Integer    ${numberOfPerson}
    ${currentPersonValue} =    Convert To Integer    ${currentPersonValue}

    ${flag} =    Set Variable If    ${currentPersonValue} == ${numberOfPerson}    0
    ...    ${currentPersonValue} < ${numberOfPerson}    1
    ...    ${currentPersonValue} > ${numberOfPerson}    2

    ${tclick} =   Run Keyword If    ${flag}==1   Evaluate     ${numberOfPerson}-${currentPersonValue}
    ...    ELSE IF   ${flag}==2   Evaluate     ${currentPersonValue}-${numberOfPerson}

    Run Keyword If    ${flag} == 1    Update Person Value      ${PersonPlusButton}    ${tclick}
    ...    ELSE IF    ${flag} == 2    Update Person Value    ${PersonMinusButton}    ${tclick}

Select Flight Location    [Arguments]    ${locationElement}    ${searchValue}
    Wait Until Element Is Visible    ${locationElement}
    Click Element    ${locationElement}
    Wait Until Element Is Visible    ${LocationInput}
    Input Text    ${LocationInput}    ${searchValue}
    Run Keyword And Return Status   Wait Until Keyword Succeeds    1 min    5 sec    Element Should Not Be Visible    ${SearchingElement}

    ${flag} =   Run Keyword And Return Status    Element Should Be Visible    ${FlightResultView}

    Run Keyword If    '${flag}'=='False'    Press Keys    ${LocationInput}    TAB
    Run Keyword If    '${flag}'=='True'    Click Element    ${FlightResultViewValue}

    ${selectedVale} =    Set Variable    ${locationElement} span.select2-chosen
    ${selectedAliase} =    Get Text    ${selectedVale}
    ${selectedAliase} =    Run Keyword If    '${flag}'=='True'    Split string    ${selectedAliase}    (
    ${selectedAliase} =    Run Keyword If    '${flag}'=='True'    Split string    ${selectedAliase}[1]    )
    ${response} =    Set Variable If    '${flag}'=='True'     ${selectedAliase}[0]
    ...    '${flag}'=='False'     ${selectedAliase}

    [Return]    ${response}

Select Flight Type Class    [Arguments]    ${flightClass}
    Wait Until Element Is Visible    ${CabinClassDropDown}
    Click Element    ${CabinClassDropDown}

    ${name} =    Convert To Lower Case    ${flightClass}
    ${flightClassName} =  Run Keyword If   '${name}'=='first'  Set Variable    First
    ...    ELSE IF    '${name}'=='economy'    Set Variable    Economy
    ...    ELSE    '${name}'=='business'    Set Variable    Business

    ${CabinClass} =    Replace Dynamic Elements    ${CabinClass}    ${flightClassName}
    Wait Until Element Is Visible    ${CabinClass}
    Click Element    ${CabinClass}
    Scroll Element Into View    ${LatestBlogTitle}
    [Return]    ${name}