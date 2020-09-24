#Run below command for run test and generate reports
robot -d ..\Results TestCaseRunner.robot

#Run below command with variable files for hotels
robot -d ..\Results -V ..\variable_files\ConfigData.py -V  ..\variable_files\phpTravelsTestData.py PHP_Travels_Hotels_TestCases.robot

#Run below command with variable files for flights
robot -d ..\Results -V ..\variable_files\ConfigData.py -V  ..\variable_files\phpTravelsTestData.py PHP_Travels_Flights_TestCases.robot

robot -d ..\Results -V ..\variable_files\ConfigData.py -V  ..\variable_files\phpTravelsTestData.py Tabulator_Pagination_TestCases.robot

