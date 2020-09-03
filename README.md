#Run below command for run test and generate reports
robot -d ..\Results TestCaseRunner.robot

#Run below command with variable files
robot -d ..\Results -V ..\variable_files\ConfigData.py -V  ..\variable_files\SearchHotelData.py TestCaseRunner.robot

