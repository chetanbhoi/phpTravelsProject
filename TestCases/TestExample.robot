*** Settings ***
Library    SeleniumLibrary
Resource  ../Common/php_travels_keywords.robot
Variables  ../Common/php_travels_variables.py


*** Test Cases ***
Test While loop
    Open Browser and Maximize
    Select Adults    3    children
#    ${numberOfAdults} =    set variable    1
#    execute javascript  window.scrollTo(0,2000)
#    ${adultValue} =   get element attribute    xpath:(//input[@name='children'])[1]    value
#    ${numb1} =    convert to integer    ${numberOfAdults}
#    ${numb2} =    convert to integer    ${adultValue}
#
#    ${flag} =    set variable if    ${numb2} == ${numb1}    0
#    ...    ${numb2} < ${numb1}    1
#    ...    ${numb2} > ${numb1}    2
#
#    ${tclick} =   run keyword if    ${flag}==1   Evaluate     ${numb1}-${numb2}
#    ...    ELSE IF   ${flag}==2   Evaluate     ${numb2}-${numb1}
#
#    log to console    flag: ${flag}
#    log to console    totl click: ${tclick}
#     FOR    ${i}    IN RANGE    ${tclick}
#           Exit For Loop If   ${numb2} == ${numb1}
#           run keyword if    ${flag} == 1    click element    xpath:(//input[@name='children'])[1]//..//span/button[text()='+']
#           ...    ELSE IF    ${flag} == 2    click element    xpath:(//input[@name='children'])[1]//..//span/button[text()='-']
#    END
#    log to console    successfully done

