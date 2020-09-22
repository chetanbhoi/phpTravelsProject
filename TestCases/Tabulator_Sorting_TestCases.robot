*** Settings ***
#Author    chetan.bhoi
Resource  ../Common/tabulator_resources.txt
Force Tags    SC 001.2
Suite Setup  Open Browser and Maximize    ${BASEURL}  ${BROWSER}  ${BROWSERPATH}
Suite Teardown  Close Tabulator Browser
Test Teardown  Take ScreenShot On Fail TestCase

*** Test Cases ***
Sort Table By Name In Ascending Order And Verify
    ${searchData} =    Set Variable    ${sort_table_by_name_field}
    Sort Table Field And Verify Sorting    ${searchData}

Sort Table By Progress In Ascending Order And Verify
    ${searchData} =    Set Variable    ${sort_table_by_progress_field}
    Sort Table Field And Verify Sorting    ${searchData}

Sort Table By Gender In Ascending Order And Verify
    ${searchData} =    Set Variable    ${sort_table_by_gender_field}
    Sort Table Field And Verify Sorting    ${searchData}

Sort Table By Rating In Ascending Order And Verify
    ${searchData} =    Set Variable    ${sort_table_by_rating_field}
    Sort Table Field And Verify Sorting    ${searchData}

Sort Table By Color In Ascending Order And Verify
    ${searchData} =    Set Variable    ${sort_table_by_color_field}
    Sort Table Field And Verify Sorting    ${searchData}

Sort Table By DOB In Ascending Order And Verify
    ${searchData} =    Set Variable    ${sort_table_by_dob_field}
    Sort Table Field And Verify Sorting    ${searchData}

Sort Table By Driver In Ascending Order And Verify
    ${searchData} =    Set Variable    ${sort_table_by_driver_field}
    Sort Table Field And Verify Sorting    ${searchData}