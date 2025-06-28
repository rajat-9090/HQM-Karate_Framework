Feature: Add Group System Page Scenarios

  Background:

    * configure driver = { type: 'chrome', timeout: 60000 }

    #-------------Fetching JSON File for all the Add Group System Page Elements Details--------------
    * def AGSPage_locators = read("classpath:hqm_Test/testData/Hospital_Group_System_Page_ElementList.json")
    #-------------Calling the Login Scenario from LoginPage Feature File-----------------
    * call read("classpath:hqm_Test/testModule/LoginPage.feature@Login")
    #----------------Calling GenerateRandomData External File to create Dummy Entries---------------
    * def dummyDetails = Java.type("hqm_Test.utilities.GenerateRandomData")
    * def dummyFirstName = dummyDetails.getRandomFirstName()
    * def dummyNumber = dummyDetails.getRandomInteger(4)
    * def dummyGroupSystemID = "RSN" + dummyNumber
    * def dummyGroupSystem = dummyFirstName + "Hospital"
    * print dummyFirstName
    * print dummyNumber
    * print dummyGroupSystemID
    * print dummyGroupSystem
    #--------------Calling TimeFormat File for Adding TimeStamp Format for the Error ScreenShots----------------
    * def timestamp = Java.type("hqm_Test.utilities.TimeFormat")
    * def formattedTime = timestamp.getFormattedTimestamp()
    #-------------Adding the Path of HGSPage where all the Error Sceenshots will store-----------------
    * def screenShotPath = "errorScreenShots/HGSPage/"



  @ignore
  @positive_scenario_1
  Scenario: User should access the "AddGroupSystem" Page Successfully
    Given waitFor(AGSPage_locators.SupersetSection).click()
    Then waitFor(AGSPage_locators.HospitalGroupSystemSection).click()
    When waitFor(AGSPage_locators.addGroupSystemPage)
    * assert exists(AGSPage_locators.addGroupSystemPage) ? true : karate.fail("Validation Failed! Add Group System Page is not Accessable")
    * def required_Fields =
      """
      exists(AGSPage_locators.fieldGroupSystemID) &&
      exists(AGSPage_locators.fieldGroupSystem)

      """
    * print required_Fields
    * assert required_Fields ? true : karate.fail("One or more Fields are Missing! Please check the Elements")
    * print "Validation and Test Case Passed!  Add Group System Page accessed successfully and Required Fields are Present in the Screen"


  @ignore
  @positive_scenario_2
  Scenario: User should able to "Add" the New Group System
    Given waitFor(AGSPage_locators.SupersetSection).click()
    Then waitFor(AGSPage_locators.HospitalGroupSystemSection).click()
    When waitFor(AGSPage_locators.addGroupSystemPage)
    * assert exists(AGSPage_locators.addGroupSystemPage) ? true : karate.fail("Validation Failed! Add Group System Page is not Accessable")
    * def required_Fields =
      """
      exists(AGSPage_locators.fieldGroupSystemID) &&
      exists(AGSPage_locators.fieldGroupSystem)

      """
    * print required_Fields
    * assert required_Fields ? true : karate.fail("One or more Fields are Missing! Please check the Elements")
    #-----------------------Adding New Group System---------------------------------
    * input(AGSPage_locators.GroupSystemIDSection, dummyGroupSystemID)
    * input(AGSPage_locators.GroupSystemSection, dummyGroupSystem)
    * click(AGSPage_locators.btnAdd)
    * def isSuccessmsgExists = delay(2000).exists(AGSPage_locators.successMSG)
    * print "Is the Success Message Element Exists" ,isSuccessmsgExists
    * assert exists(AGSPage_locators.successMSG) ? true : karate.fail("Adding New Group System Mechanism is Failed and Not able to find the Success Message")
    * print text(AGSPage_locators.successMSG)
    #----------------------Validating Newly Added Group System Details---------------------------
    * scroll(AGSPage_locators.showDropdown)
    * select(AGSPage_locators.showDropdown, "{}100")
    #------------Fetching Last Row Details from the Add Group System Table using CSS Selectors "Pseudo-class"-------------
    * def LastRow = delay(3000).script("return document.querySelector('tbody tr:nth-last-child(2)').innerText;")
    * print "Newly Added Group System Details", LastRow
    * match LastRow contains dummyGroupSystemID
    * match LastRow contains dummyGroupSystem
    * print "Validation and Test Case Passed! New Group System is Added Successfully and All the New Group System Details avaialble in the AddUserPage Table"


  @ignore
  @positive_scenario_3
  Scenario: User should able to "Update" the Group System Details by accessing the "Edit" Button
    Given waitFor(AGSPage_locators.SupersetSection).click()
    Then waitFor(AGSPage_locators.HospitalGroupSystemSection).click()
    When waitFor(AGSPage_locators.addGroupSystemPage)
    * assert exists(AGSPage_locators.addGroupSystemPage) ? true : karate.fail("Validation Failed! Add Group System Page is not Accessable")
    * def required_Fields =
      """
      exists(AGSPage_locators.fieldGroupSystemID) &&
      exists(AGSPage_locators.fieldGroupSystem)

      """
    * print required_Fields
    * assert required_Fields ? true : karate.fail("One or more Fields are Missing! Please check the Elements")
    #------------------------Updating the Details of Existing Group System from the AddGroupSystemPage Table---------------------------------
    * scroll(AGSPage_locators.showDropdown)
    * select(AGSPage_locators.showDropdown, "{}100")
    #------------Fetching Last Row Edit Button from the AddGroupSystemPage Table using CSS Selectors "Pseudo-class"-------------
    * delay(2000).script("document.querySelector('tbody tr:nth-last-child(2) button:nth-child(1)').scrollIntoView({ behavior: 'smooth', block: 'center' });")
    * click(AGSPage_locators.btnEdit)
    * scroll(AGSPage_locators.GroupSystemIDSection)
    * clear(AGSPage_locators.GroupSystemIDSection)
    * input(AGSPage_locators.GroupSystemIDSection, dummyGroupSystemID)
    * clear(AGSPage_locators.GroupSystemSection)
    * input(AGSPage_locators.GroupSystemSection, dummyGroupSystem)
    * click(AGSPage_locators.btnUpdate)
    * def isSuccessmsgExists = delay(2000).exists(AGSPage_locators.successMSG)
    * print "Is the Success Message Element Exists" ,isSuccessmsgExists
    * assert exists(AGSPage_locators.successMSG) ? true : karate.fail("Updating GroupSystem Details Mechanism is Failed and Not able to find the Success Message")
    * print text(AGSPage_locators.successMSG)
    * delay(2000).scroll(AGSPage_locators.showDropdown)
    * select(AGSPage_locators.showDropdown, "{}100")
    #-------------Fetching Updated Last Row Details from the AddGroupSystemPage using CSS Selectors Pseudo-class--------------
    * def updateRow = delay(3000).script("return document.querySelector('tbody tr:nth-last-child(2)').innerText;")
    * print "Updated GroupSystem Details", updateRow
    * match updateRow contains dummyGroupSystemID
    * match updateRow contains dummyGroupSystem
    * print "Validation and Test Case Passed! Existing GroupSystem Details are Updated Successfully"



  @ignore
  @positive_scenario_4
  Scenario: User should able to stop the Edit Mechanism by accessing "Cancel" Button
    Given waitFor(AGSPage_locators.SupersetSection).click()
    Then waitFor(AGSPage_locators.HospitalGroupSystemSection).click()
    When waitFor(AGSPage_locators.addGroupSystemPage)
    * assert exists(AGSPage_locators.addGroupSystemPage) ? true : karate.fail("Validation Failed! Add Group System Page is not Accessable")
    * def required_Fields =
      """
      exists(AGSPage_locators.fieldGroupSystemID) &&
      exists(AGSPage_locators.fieldGroupSystem)

      """
    * print required_Fields
    * assert required_Fields ? true : karate.fail("One or more Fields are Missing! Please check the Elements")
    #---------------------------------Edit Mechanism Flow Started-------------------------
    * scroll(AGSPage_locators.showDropdown)
    * select(AGSPage_locators.showDropdown, "{}100")
    #-------------Fetching Last Row Details from the AddGroupSystemPage using CSS Selectors Pseudo-class--------------
    * def beforeEdit = delay(3000).script("return document.querySelector('tbody tr:nth-last-child(2)').innerText;")
    * print "GroupSystem Details Before Edit", beforeEdit
    #------------Fetching Last Row Edit Button from the AddGroupSystemPage Table using CSS Selectors "Pseudo-class"-------------
    * script("document.querySelector('tbody tr:nth-last-child(2) button:nth-child(1)').scrollIntoView({ behavior: 'smooth', block: 'center' });")
    * click(AGSPage_locators.btnEdit)
    * scroll(AGSPage_locators.btnCancel)
    #--------------------------Clicking Cancel Button in the middle of Edit Mechanism Flow----------------------
    * click(AGSPage_locators.btnCancel)
    * scroll(AGSPage_locators.showDropdown)
    * select(AGSPage_locators.showDropdown, "{}100")
    #-------------Fetching Last Row Details from the AddGroupSystemPage using CSS Selectors Pseudo-class--------------
    * def afterEdit = delay(3000).script("return document.querySelector('tbody tr:nth-last-child(2)').innerText;")
    * print "GroupSystem Details After Edit", afterEdit
    * assert beforeEdit == afterEdit ? true : karate.fail("Canceling Edit Mechanism Flow is not working!")
    * print "Validation and Test Case Passed! Canceling Edit Mechanism Flow is working Successfully"


  #@ignore
  @negative_scenario_1
  Scenario: User should not able to Add New GroupSystem with Invalid Group System
    Given waitFor(AGSPage_locators.SupersetSection).click()
    Then waitFor(AGSPage_locators.HospitalGroupSystemSection).click()
    When waitFor(AGSPage_locators.addGroupSystemPage)
    * assert exists(AGSPage_locators.addGroupSystemPage) ? true : karate.fail("Validation Failed! Add Group System Page is not Accessable")
    * def required_Fields =
      """
      exists(AGSPage_locators.fieldGroupSystemID) &&
      exists(AGSPage_locators.fieldGroupSystem)

      """
    * print required_Fields
    * assert required_Fields ? true : karate.fail("One or more Fields are Missing! Please check the Elements")
    #-----------------------Adding New GroupSystem with Invalid Group System---------------------------------
    * input(AGSPage_locators.GroupSystemIDSection, dummyGroupSystemID)
    * input(AGSPage_locators.GroupSystemSection, dummyGroupSystemID)
    * click(AGSPage_locators.btnAdd)
    * def isErrormsgExists = delay(2000).exists(AGSPage_locators.InvalidGroupSystemError)
    * print "Is the Error Message Element Exists" ,isErrormsgExists
    * assert exists(AGSPage_locators.InvalidGroupSystemError) ? true : karate.fail("System should throw a Error Message when Invalid Details added to Group System Field")
    * print text(AGSPage_locators.InvalidGroupSystemError)
    * script("document.querySelector('.error.text-danger').style.border='3px solid red';")
    * def screenshotName = screenShotPath + 'InvalidGroupSystemError_' + formattedTime + '.png'
    * if(exists(AGSPage_locators.InvalidGroupSystemError)) karate.write(screenshot(false), screenshotName)
    * print 'Adding New GroupSystem Scenario failed! Screenshot is saved in the target folder as:- ', screenshotName
    * print "Validation and Test Case Passed! Adding New GroupSystem Failed due to Invalid Group System"


  #@ignore
  @negative_scenario_2
  Scenario: User should not able to Add New GroupSystem without Group System ID
    Given waitFor(AGSPage_locators.SupersetSection).click()
    Then waitFor(AGSPage_locators.HospitalGroupSystemSection).click()
    When waitFor(AGSPage_locators.addGroupSystemPage)
    * assert exists(AGSPage_locators.addGroupSystemPage) ? true : karate.fail("Validation Failed! Add Group System Page is not Accessable")
    * def required_Fields =
      """
      exists(AGSPage_locators.fieldGroupSystemID) &&
      exists(AGSPage_locators.fieldGroupSystem)

      """
    * print required_Fields
    * assert required_Fields ? true : karate.fail("One or more Fields are Missing! Please check the Elements")
    #-----------------------Adding New User without Group System ID---------------------------------
    * input(AGSPage_locators.GroupSystemSection, dummyGroupSystem)
    * click(AGSPage_locators.btnAdd)
    * def isErrormsgExists = delay(2000).exists(AGSPage_locators.BlankGroupSystemIDError)
    * print "Is the Error Message Element Exists" ,isErrormsgExists
    * assert exists(AGSPage_locators.BlankGroupSystemIDError) ? true : karate.fail("System should throw a Error Message when Group System ID Field is Blank")
    * print text(AGSPage_locators.BlankGroupSystemIDError)
    * script("document.querySelector('.error.text-danger').style.border='3px solid red';")
    * def screenshotName = screenShotPath + 'BlankGroupSystemIDError_' + formattedTime + '.png'
    * if(exists(AGSPage_locators.BlankGroupSystemIDError)) karate.write(screenshot(false), screenshotName)
    * print 'Adding New GroupSystem Scenario failed! Screenshot is saved in the target folder as:- ', screenshotName
    * print "Validation and Test Case Passed! Adding New GroupSystem Failed due to Blank Group System ID Field"


  #@ignore
  @negative_scenario_3
  Scenario: User should not able to Add New GroupSystem without Group System
    Given waitFor(AGSPage_locators.SupersetSection).click()
    Then waitFor(AGSPage_locators.HospitalGroupSystemSection).click()
    When waitFor(AGSPage_locators.addGroupSystemPage)
    * assert exists(AGSPage_locators.addGroupSystemPage) ? true : karate.fail("Validation Failed! Add Group System Page is not Accessable")
    * def required_Fields =
      """
      exists(AGSPage_locators.fieldGroupSystemID) &&
      exists(AGSPage_locators.fieldGroupSystem)

      """
    * print required_Fields
    * assert required_Fields ? true : karate.fail("One or more Fields are Missing! Please check the Elements")
    #-----------------------Adding New User without Group System---------------------------------
    * input(AGSPage_locators.GroupSystemIDSection, dummyGroupSystemID)
    * waitFor(AGSPage_locators.btnAdd)
    * click(AGSPage_locators.btnAdd)
    * def isErrormsgExists = delay(2000).exists(AGSPage_locators.BlankGroupSystemError)
    * print "Is the Error Message Element Exists" ,isErrormsgExists
    * assert exists(AGSPage_locators.BlankGroupSystemError) ? true : karate.fail("System should throw a Error Message when Group System Field is Blank")
    * print text(AGSPage_locators.BlankGroupSystemError)
    * script("document.querySelector('.error.text-danger').style.border='3px solid red';")
    * def screenshotName = screenShotPath + 'BlankGroupSystemError_' + formattedTime + '.png'
    * if(exists(AGSPage_locators.BlankGroupSystemError)) karate.write(screenshot(false), screenshotName)
    * print 'Adding New GroupSystem Scenario failed! Screenshot is saved in the target folder as:- ', screenshotName
    * print "Validation and Test Case Passed! Adding New GroupSystem Failed due to Blank Group System Field"

