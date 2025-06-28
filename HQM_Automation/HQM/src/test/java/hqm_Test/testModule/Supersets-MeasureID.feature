Feature: Add MeasureID Page Scenarios

  Background:

    * configure driver = { type: 'chrome', timeout: 60000 }

    #-------------Fetching JSON File for all the Add MeasureID Page Elements Details--------------
    * def MIDPage_locators = read("classpath:hqm_Test/testData/MeasureID_Page_Elements.json")
    #-------------Calling the Login Scenario from LoginPage Feature File-----------------
    * call read("classpath:hqm_Test/testModule/LoginPage.feature@Login")
    #----------------Calling GenerateRandomData External File to create Dummy Entries---------------
    * def dummyDetails = Java.type("hqm_Test.utilities.GenerateRandomData")
    * def dummyFirstName = dummyDetails.getRandomFirstName()
    * def dummyNumber = dummyDetails.getRandomInteger(5)
    * def dummyCompanyName = dummyDetails.getRandomCompanyName()
    * def dummyMeasureGroupName = dummyCompanyName + "Health"
    * def dummyMeasureIDName = dummyFirstName + " Health Overall Rating of Care Given"
    * def dummyMeasureID = "RSN-" + dummyNumber
    * print dummyFirstName
    * print dummyMeasureIDName
    * print dummyNumber
    * print dummyMeasureID
    * print dummyCompanyName
    * print dummyMeasureGroupName
    #--------------Calling TimeFormat File for Adding TimeStamp Format for the Error ScreenShots----------------
    * def timestamp = Java.type("hqm_Test.utilities.TimeFormat")
    * def formattedTime = timestamp.getFormattedTimestamp()
    #-------------Adding the Path of MeasureIDPage where all the Error Sceenshots will store-----------------
    * def screenShotPath = "errorScreenShots/MeasureIDPage/"



  @ignore
  @positive_scenario_1
  Scenario: User should access the "AddMeasureID" Page Successfully
    Given waitFor(MIDPage_locators.SupersetSection).click()
    Then waitFor(MIDPage_locators.MeasureIDSection).click()
    When waitFor(MIDPage_locators.addMeasureIDPage)
    * assert exists(MIDPage_locators.addMeasureIDPage) ? true : karate.fail("Validation Failed! Add MeasureID Page is not Accessable")
    * def required_Fields =
      """
      exists(MIDPage_locators.fieldMeasureGroup) &&
      exists(MIDPage_locators.fieldMeasureID) &&
      exists(MIDPage_locators.fieldMeasureName)
      """
    * print required_Fields
    * assert required_Fields ? true : karate.fail("One or more Fields are Missing! Please check the Elements")
    * print "Validation and Test Case Passed! Add MeasureID Page accessed successfully and Required Fields are Present in the Screen"



  @ignore
  @positive_scenario_2
  Scenario: User should able to "Add" the New MeasureID
    Given waitFor(MIDPage_locators.SupersetSection).click()
    Then waitFor(MIDPage_locators.MeasureIDSection).click()
    When waitFor(MIDPage_locators.addMeasureIDPage)
    * assert exists(MIDPage_locators.addMeasureIDPage) ? true : karate.fail("Validation Failed! Add MeasureID Page is not Accessable")
    * def required_Fields =
      """
      exists(MIDPage_locators.fieldMeasureGroup) &&
      exists(MIDPage_locators.fieldMeasureID) &&
      exists(MIDPage_locators.fieldMeasureName)
      """
    * print required_Fields
    * assert required_Fields ? true : karate.fail("One or more Fields are Missing! Please check the Elements")
    #-----------------------Adding New MeasureID---------------------------------
    * select(MIDPage_locators.MeasureGroupDropDown, "{}Test Hospital")
    * input(MIDPage_locators.MeasureIDInputSection, dummyMeasureID)
    * input(MIDPage_locators.MeasureNameInputSection, dummyMeasureIDName)
    * click(MIDPage_locators.btnAdd)
    * def isSuccessmsgExists = delay(2000).exists(MIDPage_locators.successMSG)
    * print "Is the Success Message Element Exists" ,isSuccessmsgExists
    * assert exists(MIDPage_locators.successMSG) ? true : karate.fail("Adding New MeasureID Mechanism is Failed and Not able to find the Success Message")
    * print text(MIDPage_locators.successMSG)
    #----------------------Validating Newly Added MeasureID Details---------------------------
    * scroll(MIDPage_locators.showDropdown)
    * select(MIDPage_locators.showDropdown, "{}100")
    #------------Fetching Last Row Details from the Add MeasureID Table using CSS Selectors "Pseudo-class"-------------
    * def LastRow = delay(3000).script("return document.querySelector('tbody tr:nth-last-child(2)').innerText;")
    * print "Newly Added MeasureID Details", LastRow
    * match LastRow contains "Test Hospital"
    * match LastRow contains dummyMeasureID
    * match LastRow contains dummyMeasureIDName
    * print "Validation and Test Case Passed! New MeasureID is Added Successfully and All the New MeasureID Details avaialble in the AddMeasureIDPage Table"



  @ignore
  @positive_scenario_3
  Scenario: User should able to "Add" the New MeasureID by Accessing the "+" Button
    Given waitFor(MIDPage_locators.SupersetSection).click()
    Then waitFor(MIDPage_locators.MeasureIDSection).click()
    When waitFor(MIDPage_locators.addMeasureIDPage)
    * assert exists(MIDPage_locators.addMeasureIDPage) ? true : karate.fail("Validation Failed! Add MeasureID Page is not Accessable")
    * def required_Fields =
      """
      exists(MIDPage_locators.fieldMeasureGroup) &&
      exists(MIDPage_locators.fieldMeasureID) &&
      exists(MIDPage_locators.fieldMeasureName)
      """
    * print required_Fields
    * assert required_Fields ? true : karate.fail("One or more Fields are Missing! Please check the Elements")
    #-----------------Adding New MeasureGroup by Accessing "+" Button-----------------------
    * mouse(MIDPage_locators.btnPlus).click()
    * delay(2000).waitForUrl("/masters/add-measure-group")
    * assert exists(MIDPage_locators.addMeasureGroupPage) ? true : karate.fail("Validation Failed! AddMeasureGroupPage is not Accessible")
    * input(MIDPage_locators.AMGMeasureGroupSection, dummyMeasureGroupName)
    * click(MIDPage_locators.AMGbtnAdd)
    * def isSuccessmsgExists = delay(2000).exists(MIDPage_locators.successMSG)
    * print "Is the Success Message Element Exists" ,isSuccessmsgExists
    * assert exists(MIDPage_locators.successMSG) ? true : karate.fail("Adding New MeasureGroup Mechanism is Failed and Not able to find the Success Message")
    * print text(MIDPage_locators.successMSG)
    #----------------------Validating Newly Added MeasureGroup Details---------------------------
    * scroll(MIDPage_locators.AMGshowDropdown)
    * select(MIDPage_locators.AMGshowDropdown, "{}100")
    #------------Fetching Newly Added MeasureGroup Name from the Add MeasureGroup Table using CSS Selectors "Pseudo-class"-------------
    * def NewMG = delay(3000).script("return document.querySelector('tbody tr:nth-last-child(2) td:nth-child(1)').innerText;")
    * print "Newly Added MeasureGroup Name", NewMG
    #-----------Heading Back to MeasureID Screen to use the Newly Added MeasureGroup using "+" Button to Add New MeasureID----------------
    * waitFor(MIDPage_locators.MeasureIDSection).click()
    * waitFor(MIDPage_locators.addMeasureIDPage)
    * assert exists(MIDPage_locators.addMeasureIDPage) ? true : karate.fail("Validation Failed! Add MeasureID Page is not Accessible")
    * scroll(MIDPage_locators.MeasureGroupDropDown)
    * delay(2000).select(MIDPage_locators.MeasureGroupDropDown, "{}"+ NewMG +"")
    * input(MIDPage_locators.MeasureIDInputSection, dummyMeasureID)
    * input(MIDPage_locators.MeasureNameInputSection, dummyMeasureIDName)
    * click(MIDPage_locators.btnAdd)
    * def isSuccessmsgExists = delay(2000).exists(MIDPage_locators.successMSG)
    * print "Is the Success Message Element Exists" ,isSuccessmsgExists
    * assert exists(MIDPage_locators.successMSG) ? true : karate.fail("Adding New MeasureID Mechanism is Failed and Not able to find the Success Message")
    * print text(MIDPage_locators.successMSG)
    #----------------------Validating Newly Added MeasureID Details---------------------------
    * scroll(MIDPage_locators.showDropdown)
    * select(MIDPage_locators.showDropdown, "{}100")
    #------------Fetching Last Row Details from the Add MeasureID Table using CSS Selectors "Pseudo-class"-------------
    * def LastRow = delay(3000).script("return document.querySelector('tbody tr:nth-last-child(2)').innerText;")
    * print "Newly Added MeasureID Details", LastRow
    * match LastRow contains NewMG
    * match LastRow contains dummyMeasureID
    * match LastRow contains dummyMeasureIDName
    * print "Validation and Test Case Passed! New MeasureID is Added Successfully by using plus mechanism and All the New MeasureID Details avaialble in the AddMeasureIDPage Table"



  @ignore
  @positive_scenario_4
  Scenario: User should able to "Update" the MeasureID Details by accessing the "Edit" Button
    Given waitFor(MIDPage_locators.SupersetSection).click()
    Then waitFor(MIDPage_locators.MeasureIDSection).click()
    When waitFor(MIDPage_locators.addMeasureIDPage)
    * assert exists(MIDPage_locators.addMeasureIDPage) ? true : karate.fail("Validation Failed! Add MeasureID Page is not Accessable")
    * def required_Fields =
      """
      exists(MIDPage_locators.fieldMeasureGroup) &&
      exists(MIDPage_locators.fieldMeasureID) &&
      exists(MIDPage_locators.fieldMeasureName)
      """
    * print required_Fields
    * assert required_Fields ? true : karate.fail("One or more Fields are Missing! Please check the Elements")
    #------------------------Updating the Details of Existing MeasureID from the "AddMeasureID" Page Table---------------------------------
    * scroll(MIDPage_locators.AMGshowDropdown)
    * select(MIDPage_locators.AMGshowDropdown, "{}100")
    #------------Fetching Last Row Edit Button from the "AddMeasureID" Page Table using CSS Selectors "Pseudo-class"-------------
    * delay(2000).script("document.querySelector('tbody tr:nth-last-child(2) button:nth-child(1)').scrollIntoView({ behavior: 'smooth', block: 'center' });")
    * click(MIDPage_locators.btnEdit)
    * scroll(MIDPage_locators.MeasureIDInputSection)
    * clear(MIDPage_locators.MeasureIDInputSection)
    * input(MIDPage_locators.MeasureIDInputSection, dummyMeasureID)
    * clear(MIDPage_locators.MeasureNameInputSection)
    * input(MIDPage_locators.MeasureNameInputSection, dummyMeasureIDName)
    * click(MIDPage_locators.btnUpdate)
    * def isSuccessmsgExists = delay(2000).exists(MIDPage_locators.successMSG)
    * print "Is the Success Message Element Exists" ,isSuccessmsgExists
    * assert exists(MIDPage_locators.successMSG) ? true : karate.fail("Updating MeasureID Details Mechanism is Failed and Not able to find the Success Message")
    * print text(MIDPage_locators.successMSG)
    * delay(2000).scroll(MIDPage_locators.showDropdown)
    * select(MIDPage_locators.showDropdown, "{}100")
    #-------------Fetching Updated Last Row Details from the AddMeasureIDPage using CSS Selectors Pseudo-class--------------
    * def updateRow = delay(3000).script("return document.querySelector('tbody tr:nth-last-child(2)').innerText;")
    * print "Updated MeasureID Details", updateRow
    * match updateRow contains dummyMeasureID
    * match updateRow contains dummyMeasureIDName
    * print "Validation and Test Case Passed! Existing MeasureID Details are Updated Successfully"



  @ignore
  @positive_scenario_5
  Scenario: User should able to stop the Edit Mechanism by accessing "Cancel" Button
    Given waitFor(MIDPage_locators.SupersetSection).click()
    Then waitFor(MIDPage_locators.MeasureIDSection).click()
    When waitFor(MIDPage_locators.addMeasureIDPage)
    * assert exists(MIDPage_locators.addMeasureIDPage) ? true : karate.fail("Validation Failed! Add MeasureID Page is not Accessable")
    * def required_Fields =
      """
      exists(MIDPage_locators.fieldMeasureGroup) &&
      exists(MIDPage_locators.fieldMeasureID) &&
      exists(MIDPage_locators.fieldMeasureName)
      """
    * print required_Fields
    * assert required_Fields ? true : karate.fail("One or more Fields are Missing! Please check the Elements")
    #---------------------------------Edit Mechanism Flow Started-------------------------
    * scroll(MIDPage_locators.showDropdown)
    * select(MIDPage_locators.showDropdown, "{}100")
    #-------------Fetching Last Row Details from the AddMeasureIDPage using CSS Selectors Pseudo-class--------------
    * def beforeEdit = delay(3000).script("return document.querySelector('tbody tr:nth-last-child(2)').innerText;")
    * print "MeasureID Details Before Edit", beforeEdit
    #------------Fetching Last Row Edit Button from the AddMeasureIDPage Table using CSS Selectors "Pseudo-class"-------------
    * script("document.querySelector('tbody tr:nth-last-child(2) button:nth-child(1)').scrollIntoView({ behavior: 'smooth', block: 'center' });")
    * click(MIDPage_locators.btnEdit)
    * scroll(MIDPage_locators.btnCancel)
    #--------------------------Clicking Cancel Button in the middle of Edit Mechanism Flow----------------------
    * click(MIDPage_locators.btnCancel)
    * scroll(MIDPage_locators.showDropdown)
    * select(MIDPage_locators.showDropdown, "{}100")
    #-------------Fetching Last Row Details from the AddMeasureIDPage using CSS Selectors Pseudo-class--------------
    * def afterEdit = delay(3000).script("return document.querySelector('tbody tr:nth-last-child(2)').innerText;")
    * print "MeasureID Details After Edit", afterEdit
    * assert beforeEdit == afterEdit ? true : karate.fail("Canceling Edit Mechanism Flow is not working!")
    * print "Validation and Test Case Passed! Canceling Edit Mechanism Flow is working Successfully"



  #@ignore
  @negative_scenario_1
  Scenario: User should not able to Add New Hospital without MeasureID Field
    Given waitFor(MIDPage_locators.SupersetSection).click()
    Then waitFor(MIDPage_locators.MeasureIDSection).click()
    When waitFor(MIDPage_locators.addMeasureIDPage)
    * assert exists(MIDPage_locators.addMeasureIDPage) ? true : karate.fail("Validation Failed! Add MeasureID Page is not Accessable")
    * def required_Fields =
      """
      exists(MIDPage_locators.fieldMeasureGroup) &&
      exists(MIDPage_locators.fieldMeasureID) &&
      exists(MIDPage_locators.fieldMeasureName)
      """
    * print required_Fields
    * assert required_Fields ? true : karate.fail("One or more Fields are Missing! Please check the Elements")
    #-----------------------Adding New Measure ID without MeasureID Field---------------------------------
    * select(MIDPage_locators.MeasureGroupDropDown, "{}Test Hospital")
    * input(MIDPage_locators.MeasureNameInputSection, dummyMeasureIDName)
    * click(MIDPage_locators.btnAdd)
    * def isErrormsgExists = delay(2000).exists(MIDPage_locators.BlankMeasureIDError)
    * print "Is the Error Message Element Exists" ,isErrormsgExists
    * assert exists(MIDPage_locators.BlankMeasureIDError) ? true : karate.fail("System should throw a Error Message when MeasureID Field is left Blank")
    * print text(MIDPage_locators.BlankMeasureIDError)
    * script("document.querySelector('.error.text-danger').style.border='3px solid red';")
    * def screenshotName = screenShotPath + 'BlankMeasureIDError_' + formattedTime + '.png'
    * if(exists(MIDPage_locators.BlankMeasureIDError)) karate.write(screenshot(false), screenshotName)
    * print 'Adding New MeasureID Scenario failed! Screenshot is saved in the target folder as:- ', screenshotName
    * print "Validation and Test Case Passed! Adding New Measure ID Failed due to Blank MeasureID Field"



  #@ignore
  @negative_scenario_2
  Scenario: User should not able to Add New Hospital without MeasureName Field
    Given waitFor(MIDPage_locators.SupersetSection).click()
    Then waitFor(MIDPage_locators.MeasureIDSection).click()
    When waitFor(MIDPage_locators.addMeasureIDPage)
    * assert exists(MIDPage_locators.addMeasureIDPage) ? true : karate.fail("Validation Failed! Add MeasureID Page is not Accessable")
    * def required_Fields =
      """
      exists(MIDPage_locators.fieldMeasureGroup) &&
      exists(MIDPage_locators.fieldMeasureID) &&
      exists(MIDPage_locators.fieldMeasureName)
      """
    * print required_Fields
    * assert required_Fields ? true : karate.fail("One or more Fields are Missing! Please check the Elements")
    #-----------------------Adding New Measure ID without MeasureName Field---------------------------------
    * select(MIDPage_locators.MeasureGroupDropDown, "{}Test Hospital")
    * input(MIDPage_locators.MeasureIDInputSection, dummyMeasureID)
    * click(MIDPage_locators.btnAdd)
    * def isErrormsgExists = delay(2000).exists(MIDPage_locators.BlankMeasureNameError)
    * print "Is the Error Message Element Exists" ,isErrormsgExists
    * assert exists(MIDPage_locators.BlankMeasureNameError) ? true : karate.fail("System should throw a Error Message when MeasureName Field is left Blank")
    * print text(MIDPage_locators.BlankMeasureNameError)
    * script("document.querySelector('.error.text-danger').style.border='3px solid red';")
    * def screenshotName = screenShotPath + 'BlankMeasureNameError_' + formattedTime + '.png'
    * if(exists(MIDPage_locators.BlankMeasureNameError)) karate.write(screenshot(false), screenshotName)
    * print 'Adding New MeasureID Scenario failed! Screenshot is saved in the target folder as:- ', screenshotName
    * print "Validation and Test Case Passed! Adding New Measure ID Failed due to Blank MeasureName Field"



  #@ignore
  @negative_scenario_3
  Scenario: User should not able to Add New Hospital without selection of MeasureGroup Field
    Given waitFor(MIDPage_locators.SupersetSection).click()
    Then waitFor(MIDPage_locators.MeasureIDSection).click()
    When waitFor(MIDPage_locators.addMeasureIDPage)
    * assert exists(MIDPage_locators.addMeasureIDPage) ? true : karate.fail("Validation Failed! Add MeasureID Page is not Accessible")
    * def required_Fields =
      """
      exists(MIDPage_locators.fieldMeasureGroup) &&
      exists(MIDPage_locators.fieldMeasureID) &&
      exists(MIDPage_locators.fieldMeasureName)
      """
    * print required_Fields
    * assert required_Fields ? true : karate.fail("One or more Fields are Missing! Please check the Elements")
    #-----------------------Adding New Measure ID without MeasureGroup Field---------------------------------
    * input(MIDPage_locators.MeasureIDInputSection, dummyMeasureID)
    * input(MIDPage_locators.MeasureNameInputSection, dummyMeasureIDName)
    * click(MIDPage_locators.btnAdd)
    * def isErrormsgExists = delay(2000).exists(MIDPage_locators.UnselectedMeasureGroupError)
    * print "Is the Error Message Element Exists" ,isErrormsgExists
    * assert exists(MIDPage_locators.UnselectedMeasureGroupError) ? true : karate.fail("System should throw a Error Message when MeasureGroup Field is left Unselected")
    * print text(MIDPage_locators.UnselectedMeasureGroupError)
    * script("document.querySelector('.error.text-danger').style.border='3px solid red';")
    * def screenshotName = screenShotPath + 'UnselectedMeasureGroupError_' + formattedTime + '.png'
    * if(exists(MIDPage_locators.UnselectedMeasureGroupError)) karate.write(screenshot(false), screenshotName)
    * print 'Adding New MeasureID Scenario failed! Screenshot is saved in the target folder as:- ', screenshotName
    * print "Validation and Test Case Passed! Adding New Measure ID Failed due to Unselected MeasureGroup Field"
