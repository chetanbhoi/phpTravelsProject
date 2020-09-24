*** Settings ***
#Author    chetan.bhoi
#Library    SeleniumLibrary
Resource  ../Common/tabulator_resources.txt
Force Tags    SC 001.2
Suite Setup  Open Browser and Maximize    ${BASEURL}  ${BROWSER}  ${BROWSERPATH}
Suite Teardown  Close Tabulator Browser
Test Teardown  Take ScreenShot On Fail TestCase

*** Test Cases ***
Verify First Pagination button
    element should be visible   ${FirstPagingButtonDisable}
    click element    ${NextPagingButton}
    element should not be visible   ${FirstPagingButtonDisable}
    click element    ${LastPagingButton}
    element should not be visible   ${FirstPagingButtonDisable}
    click element    ${FirstPagingButton}
    element should be visible   ${FirstPagingButtonDisable}

Verify Prev pagination button
    click element     ${FirstPagingButton}
    element should be visible   ${PrevPagingButtonDisable}
    click element    ${NextPagingButton}
    element should not be visible   ${PrevPagingButtonDisable}
    click element    ${LastPagingButton}
    element should not be visible   ${PrevPagingButtonDisable}
    click element    ${FirstPagingButton}
    element should be visible   ${PrevPagingButtonDisable}

Verify Next pagination button
    click element     ${FirstPagingButton}
    element should not be visible   ${NextPagingButtonDisable}
    click element    ${LastPagingButton}
    element should be visible   ${NextPagingButtonDisable}
    click element    ${PrevPagingButton}
    element should not be visible   ${NextPagingButtonDisable}
    click element    ${FirstPagingButton}
    element should not be visible   ${NextPagingButtonDisable}

Verify Last pagination button
    click element     ${FirstPagingButton}
    element should not be visible   ${LastPagingButtonDisable}
    click element    ${LastPagingButton}
    element should be visible   ${LastPagingButtonDisable}
    click element    ${PrevPagingButton}
    element should not be visible   ${LastPagingButtonDisable}
    click element    ${FirstPagingButton}
    element should not be visible    ${LastPagingButtonDisable}
    click element     ${NextPagingButton}
    element should not be visible    ${LastPagingButtonDisable}

Verify First and Prev buttons as disable
    click element     ${FirstPagingButton}
    element should be visible    ${FirstPagingButtonDisable}
    element should be visible    ${PrevPagingButtonDisable}
    click element     ${LastPagingButton}
    element should not be visible    ${FirstPagingButtonDisable}
    element should not be visible    ${PrevPagingButtonDisable}

Verify Next and Last buttons as disable
    click element     ${FirstPagingButton}
    element should not be visible    ${NextPagingButtonDisable}
    element should not be visible    ${LastPagingButtonDisable}
    click element     ${LastPagingButton}
    element should be visible    ${NextPagingButtonDisable}
    element should be visible    ${LastPagingButtonDisable}

Verify all pagination button as enable
    click element     ${FirstPagingButton}
    element should be visible    ${FirstPagingButtonDisable}
    element should be visible    ${PrevPagingButtonDisable}
    element should not be visible    ${NextPagingButtonDisable}
    element should not be visible    ${LastPagingButtonDisable}
    click element     ${NextPagingButton}
    element should not be visible    ${FirstPagingButtonDisable}
    element should not be visible    ${PrevPagingButtonDisable}
    element should not be visible    ${NextPagingButtonDisable}
    element should not be visible    ${LastPagingButtonDisable}

Verify all pagination button as disable
    click element     ${FirstPagingButton}
    element should be visible    ${FirstPagingButtonDisable}
    element should be visible    ${PrevPagingButtonDisable}
    element should not be visible    ${NextPagingButtonDisable}
    element should not be visible    ${LastPagingButtonDisable}
    input text    ${FilterTableByNameInput}    TestTabName
    element should be visible    ${FirstPagingButtonDisable}
    element should be visible    ${PrevPagingButtonDisable}
    element should be visible    ${NextPagingButtonDisable}
    element should be visible    ${LastPagingButtonDisable}
    Clear Element Text    ${FilterTableByNameInput}