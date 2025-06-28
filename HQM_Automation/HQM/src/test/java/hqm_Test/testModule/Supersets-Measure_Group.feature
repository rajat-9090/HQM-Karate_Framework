Feature: Add MeasureGroup Page Scenarios

  Background:

    * configure driver = { type: 'chrome', timeout: 60000 }

    #-------------Fetching JSON File for all the Add MeasureGroup Page Elements Details--------------
    * def MGPage_locators = read("classpath:hqm_Test/testData/MeasureGroup_Page_Elements.json")
    #-------------Calling the Login Scenario from LoginPage Feature File-----------------
    * call read("classpath:hqm_Test/testModule/LoginPage.feature@Login")
    #----------------Calling GenerateRandomData External File to create Dummy Entries---------------
    * def dummyDetails = Java.type("hqm_Test.utilities.GenerateRandomData")
    * def dummyCompanyName = dummyDetails.getRandomCompanyName()
    * def dummyMeasureGroupName = dummyCompanyName + "Health"
    * print dummyCompanyName
    * print dummyMeasureGroupName
    #--------------Calling TimeFormat File for Adding TimeStamp Format for the Error ScreenShots----------------
    * def timestamp = Java.type("hqm_Test.utilities.TimeFormat")
    * def formattedTime = timestamp.getFormattedTimestamp()
    #-------------Adding the Path of HGSPage where all the Error Sceenshots will store-----------------
    * def screenShotPath = "errorScreenShots/MeasureGroupPage/"



  @ignore
  @positive_scenario_1
  Scenario: User should access the "AddMeasureGroup" Page Successfully
    Given waitFor(MGPage_locators.SupersetSection).click()
    Then waitFor(MGPage_locators.MeasureGroupsSection).click()
    When waitFor(MGPage_locators.addMeasureGroupPage)
    * assert exists(MGPage_locators.addMeasureGroupPage) ? true : karate.fail("Validation Failed! Add MeasureGroup Page is not Accessable")
    * def required_Fields = exists(MGPage_locators.fieldMeasureGroup)
    * print required_Fields
    * assert required_Fields ? true : karate.fail("One or more Fields are Missing! Please check the Elements")
    * print "Validation and Test Case Passed! Add Hospital Page accessed successfully and Required Fields are Present in the Screen"



  @ignore
  @positive_scenario_2
  Scenario: User should able to "Add" the New MeasureGroup
    Given waitFor(MGPage_locators.SupersetSection).click()
    Then waitFor(MGPage_locators.MeasureGroupsSection).click()
    When waitFor(MGPage_locators.addMeasureGroupPage)
    * assert exists(MGPage_locators.addMeasureGroupPage) ? true : karate.fail("Validation Failed! Add MeasureGroup Page is not Accessable")
    * def required_Fields = exists(MGPage_locators.fieldMeasureGroup)
    * print required_Fields
    * assert required_Fields ? true : karate.fail("One or more Fields are Missing! Please check the Elements")
    * print "Validation and Test Case Passed! AddMeasureGroup Page accessed successfully and Required Fields are Present in the Screen"
    #-----------------------Adding New MeasureGroup---------------------------------
    * input(MGPage_locators.MeasureGroupSection, dummyMeasureGroupName)
    * click(MGPage_locators.btnAdd)
    * def isSuccessmsgExists = delay(2000).exists(MGPage_locators.successMSG)
    * print "Is the Success Message Element Exists" ,isSuccessmsgExists
    * assert exists(MGPage_locators.successMSG) ? true : karate.fail("Adding New MeasureGroup Mechanism is Failed and Not able to find the Success Message")
    * print text(MGPage_locators.successMSG)
    #----------------------Validating Newly Added Hospital Details---------------------------
    * scroll(MGPage_locators.showDropdown)
    * select(MGPage_locators.showDropdown, "{}100")
    #------------Fetching Last Row Details from the AddMeasureGroup Table using CSS Selectors "Pseudo-class"-------------
    * def LastRow = delay(3000).script("return document.querySelector('tbody tr:nth-last-child(2)').innerText;")
    * print "Newly Added MeasureGroup Details", LastRow
    * match LastRow contains dummyMeasureGroupName
    * print "Validation and Test Case Passed! New MeasureGroup is Added Successfully and All the New MeasureGroup Details avaialble in the AddMeasureGroupPage Table"




  @ignore
  @positive_scenario_3
  Scenario: User should able to "Update" the MeasureGroup Details by accessing the "Edit" Button
    Given waitFor(MGPage_locators.SupersetSection).click()
    Then waitFor(MGPage_locators.MeasureGroupsSection).click()
    When waitFor(MGPage_locators.addMeasureGroupPage)
    * assert exists(MGPage_locators.addMeasureGroupPage) ? true : karate.fail("Validation Failed! Add MeasureGroup Page is not Accessable")
    * def required_Fields = exists(MGPage_locators.fieldMeasureGroup)
    * print required_Fields
    * assert required_Fields ? true : karate.fail("One or more Fields are Missing! Please check the Elements")
    #------------------------Updating the Details of Existing MeasureGroup from the "AddMeasureGroup" Page Table---------------------------------
    * scroll(MGPage_locators.showDropdown)
    * select(MGPage_locators.showDropdown, "{}100")
    #------------Fetching Last Row Edit Button from the "AddMeasureGroup" Page Table using CSS Selectors "Pseudo-class"-------------
    * delay(2000).script("document.querySelector('tbody tr:nth-last-child(2) button:nth-child(1)').scrollIntoView({ behavior: 'smooth', block: 'center' });")
    * click(MGPage_locators.btnEdit)
    * scroll(MGPage_locators.MeasureGroupSection)
    * clear(MGPage_locators.MeasureGroupSection)
    * input(MGPage_locators.MeasureGroupSection, dummyMeasureGroupName)
    * click(MGPage_locators.btnUpdate)
    * def isSuccessmsgExists = delay(2000).exists(MGPage_locators.successMSG)
    * print "Is the Success Message Element Exists" ,isSuccessmsgExists
    * assert exists(MGPage_locators.successMSG) ? true : karate.fail("Updating Hospital Details Mechanism is Failed and Not able to find the Success Message")
    * print text(MGPage_locators.successMSG)
    * delay(2000).scroll(MGPage_locators.showDropdown)
    * select(MGPage_locators.showDropdown, "{}100")
    #-------------Fetching Updated Last Row Details from the AddMeasureGroupPage using CSS Selectors Pseudo-class--------------
    * def updateRow = delay(3000).script("return document.querySelector('tbody tr:nth-last-child(2)').innerText;")
    * print "Updated GroupSystem Details", updateRow
    * match updateRow contains dummyMeasureGroupName
    * print "Validation and Test Case Passed! Existing MeasureGroup Details are Updated Successfully"



  @ignore
  @positive_scenario_4
  Scenario: User should able to stop the Edit Mechanism by accessing "Cancel" Button
    Given waitFor(MGPage_locators.SupersetSection).click()
    Then waitFor(MGPage_locators.MeasureGroupsSection).click()
    When waitFor(MGPage_locators.addMeasureGroupPage)
    * assert exists(MGPage_locators.addMeasureGroupPage) ? true : karate.fail("Validation Failed! Add MeasureGroup Page is not Accessable")
    * def required_Fields = exists(MGPage_locators.fieldMeasureGroup)
    * print required_Fields
    * assert required_Fields ? true : karate.fail("One or more Fields are Missing! Please check the Elements")
    #---------------------------------Edit Mechanism Flow Started-------------------------
    * scroll(MGPage_locators.showDropdown)
    * select(MGPage_locators.showDropdown, "{}100")
    #-------------Fetching Last Row Details from the AddMeasureGroupPage using CSS Selectors Pseudo-class--------------
    * def beforeEdit = delay(3000).script("return document.querySelector('tbody tr:nth-last-child(2)').innerText;")
    * print "MeasureGroup Details Before Edit", beforeEdit
    #------------Fetching Last Row Edit Button from the AddMeasureGroupPage Table using CSS Selectors "Pseudo-class"-------------
    * script("document.querySelector('tbody tr:nth-last-child(2) button:nth-child(1)').scrollIntoView({ behavior: 'smooth', block: 'center' });")
    * click(MGPage_locators.btnEdit)
    * scroll(MGPage_locators.fieldMeasureGroup)
    #--------------------------Clicking Cancel Button in the middle of Edit Mechanism Flow----------------------
    * click(MGPage_locators.btnCancel)
    * scroll(MGPage_locators.showDropdown)
    * select(MGPage_locators.showDropdown, "{}100")
    #-------------Fetching Last Row Details from the AddMeasureGroupPage using CSS Selectors Pseudo-class--------------
    * def afterEdit = delay(3000).script("return document.querySelector('tbody tr:nth-last-child(2)').innerText;")
    * print "MeasureGroup Details After Edit", afterEdit
    * assert beforeEdit == afterEdit ? true : karate.fail("Canceling Edit Mechanism Flow is not working!")
    * print "Validation and Test Case Passed! Canceling Edit Mechanism Flow is working Successfully"



  #@ignore
  @negative_scenario_1
  Scenario: User should not able to Add New Hospital without MeasureGroup Field
    Given waitFor(MGPage_locators.SupersetSection).click()
    Then waitFor(MGPage_locators.MeasureGroupsSection).click()
    When waitFor(MGPage_locators.addMeasureGroupPage)
    * assert exists(MGPage_locators.addMeasureGroupPage) ? true : karate.fail("Validation Failed! Add MeasureGroup Page is not Accessable")
    * def required_Fields = exists(MGPage_locators.fieldMeasureGroup)
    * print required_Fields
    * assert required_Fields ? true : karate.fail("One or more Fields are Missing! Please check the Elements")
    #-----------------------Adding New Measure Group without MeasureGroup Field---------------------------------
    * click(MGPage_locators.btnAdd)
    * def isErrormsgExists = delay(2000).exists(MGPage_locators.BlankMeasureGroupError)
    * print "Is the Error Message Element Exists" ,isErrormsgExists
    * assert exists(MGPage_locators.BlankMeasureGroupError) ? true : karate.fail("System should throw a Error Message when when MeasureGroup Field is left Blank")
    * print text(MGPage_locators.BlankMeasureGroupError)
    * script("document.querySelector('.error.text-danger').style.border='3px solid red';")
    * def screenshotName = screenShotPath + 'BlankMeasureGroupError_' + formattedTime + '.png'
    * if(exists(MGPage_locators.BlankMeasureGroupError)) karate.write(screenshot(false), screenshotName)
    * print 'Adding New MeasureGroup Scenario failed! Screenshot is saved in the target folder as:- ', screenshotName
    * print "Validation and Test Case Passed! Adding New Measure Group Failed due to Blank MeasureGroup Field"