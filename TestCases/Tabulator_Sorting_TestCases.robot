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
    Sort Number Table Field And Verify Sorting    ${searchData}

Sort Table By Gender In Ascending Order And Verify
    ${searchData} =    Set Variable    ${sort_table_by_gender_field}
    Sort Table Field And Verify Sorting    ${searchData}

Sort Table By Rating In Ascending Order And Verify
    ${searchData} =    Set Variable    ${sort_table_by_rating_field}
    Sort Number Table Field And Verify Sorting    ${searchData}

Sort Table By Color In Ascending Order And Verify
    ${searchData} =    Set Variable    ${sort_table_by_color_field}
    Sort Table Field And Verify Sorting    ${searchData}

Sort Table By DOB In Ascending Order And Verify
    ${searchData} =    Set Variable    ${sort_table_by_dob_field}
    Sort Number Table Field And Verify Sorting    ${searchData}

Sort Table By Driver In Ascending Order And Verify
    ${searchData} =    Set Variable    ${sort_table_by_driver_field}
    Sort Table Field And Verify Sorting    ${searchData}

Sort Table By Name In Descending Order And Verify
    ${searchData} =    Set Variable    ${sort_table_by_name_field_as_desc}
    Sort Table Field And Verify Sorting    ${searchData}

Sort Table By Progress In Descending Order And Verify
    ${searchData} =    Set Variable    ${sort_table_by_progress_field_as_desc}
    Sort Number Table Field And Verify Sorting    ${searchData}

Sort Table By Gender In Descending Order And Verify
    ${searchData} =    Set Variable    ${sort_table_by_gender_field_as_desc}
    Sort Table Field And Verify Sorting    ${searchData}

Sort Table By Rating In Descending Order And Verify
    ${searchData} =    Set Variable    ${sort_table_by_rating_field_as_desc}
    Sort Number Table Field And Verify Sorting    ${searchData}

Sort Table By Color In Descending Order And Verify
    ${searchData} =    Set Variable    ${sort_table_by_color_field_as_desc}
    Sort Table Field And Verify Sorting    ${searchData}

Sort Table By DOB In Descending Order And Verify
    ${searchData} =    Set Variable    ${sort_table_by_dob_field_as_desc}
    Sort Number Table Field And Verify Sorting    ${searchData}

Sort Table By Driver In Descending Order And Verify
    ${searchData} =    Set Variable    ${sort_table_by_driver_field_as_desc}
    Sort Table Field And Verify Sorting    ${searchData}

Verify Hide Rating Column
    Hide Rating Field And Verify

Verify Show Rating Column
    Show Rating Field And Verify