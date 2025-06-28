Feature: Add Hospital Page Scenarios

  Background:

    * configure driver = { type: 'chrome', timeout: 60000 }

    #-------------Fetching JSON File for all the Add Hospital Page Elements Details--------------
    * def AHPage_locators = read("classpath:hqm_Test/testData/Hospital_Page_ElementList.json")
    #-------------Calling the Login Scenario from LoginPage Feature File-----------------
    * call read("classpath:hqm_Test/testModule/LoginPage.feature@Login")
    #----------------Calling GenerateRandomData External File to create Dummy Entries---------------
    * def dummyDetails = Java.type("hqm_Test.utilities.GenerateRandomData")
    * def dummyFirstName = dummyDetails.getRandomFirstName()
    * def dummyNumber = dummyDetails.getRandomInteger(6)
    * def dummyHospitalName = dummyFirstName + "Hospital"
    * def dummyGroupSystemID = "RSN" + dummyNumber
    * print dummyFirstName
    * print dummyNumber
    * print dummyHospitalName
    * print dummyGroupSystemID
    #--------------Calling TimeFormat File for Adding TimeStamp Format for the Error ScreenShots----------------
    * def timestamp = Java.type("hqm_Test.utilities.TimeFormat")
    * def formattedTime = timestamp.getFormattedTimestamp()
    #-------------Adding the Path of HGSPage where all the Error Sceenshots will store-----------------
    * def screenShotPath = "errorScreenShots/HospitalPage/"



  @ignore
  @positive_scenario_1
  Scenario: User should access the "AddHospital" Page Successfully
    Given waitFor(AHPage_locators.SupersetSection).click()
    Then waitFor(AHPage_locators.HospitalSection).click()
    When waitFor(AHPage_locators.addHospitalPage)
    * assert exists(AHPage_locators.addHospitalPage) ? true : karate.fail("Validation Failed! Add Hospital Page is not Accessable")
    * def required_Fields =
      """
      exists(AHPage_locators.fieldGroupSystem) &&
      exists(AHPage_locators.fieldHospitalID) &&
      exists(AHPage_locators.fieldHospitalName)

      """
    * print required_Fields
    * assert required_Fields ? true : karate.fail("One or more Fields are Missing! Please check the Elements")
    * print "Validation and Test Case Passed! Add Hospital Page accessed successfully and Required Fields are Present in the Screen"



  @ignore
  @positive_scenario_2
  Scenario: User should able to "Add" the New Hospital
    Given waitFor(AHPage_locators.SupersetSection).click()
    Then waitFor(AHPage_locators.HospitalSection).click()
    When waitFor(AHPage_locators.addHospitalPage)
    * assert exists(AHPage_locators.addHospitalPage) ? true : karate.fail("Validation Failed! Add Hospital Page is not Accessable")
    * def required_Fields =
      """
      exists(AHPage_locators.fieldGroupSystem) &&
      exists(AHPage_locators.fieldHospitalID) &&
      exists(AHPage_locators.fieldHospitalName)

      """
    * print required_Fields
    * assert required_Fields ? true : karate.fail("One or more Fields are Missing! Please check the Elements")
    #-----------------------Adding New Hospital---------------------------------
    * select(AHPage_locators.GroupSystemDropDown, "{}Test Hospital")
    * input(AHPage_locators.HospitalIDSection, dummyNumber)
    * input(AHPage_locators.HospitalNameSection, dummyHospitalName)
    * click(AHPage_locators.btnAdd)
    * def isSuccessmsgExists = delay(2000).exists(AHPage_locators.successMSG)
    * print "Is the Success Message Element Exists" ,isSuccessmsgExists
    * assert exists(AHPage_locators.successMSG) ? true : karate.fail("Adding New Hospital Mechanism is Failed and Not able to find the Success Message")
    * print text(AHPage_locators.successMSG)
    #----------------------Validating Newly Added Hospital Details---------------------------
    * scroll(AHPage_locators.showDropdown)
    * select(AHPage_locators.showDropdown, "{}100")
    #------------Fetching Last Row Details from the Add Hospital Table using CSS Selectors "Pseudo-class"-------------
    * def LastRow = delay(3000).script("return document.querySelector('tbody tr:nth-last-child(2)').innerText;")
    * print "Newly Added Group System Details", LastRow
    * match LastRow contains "Test Hospital"
    * match LastRow contains dummyNumber
    * match LastRow contains dummyHospitalName
    * print "Validation and Test Case Passed! New Hospital is Added Successfully and All the New Hospital Details avaialble in the AddHospitalPage Table"



  @ignore
  @positive_scenario_3
  Scenario: User should able to "Add" the New Hospital by Accessing the "+" Button
    Given waitFor(AHPage_locators.SupersetSection).click()
    Then waitFor(AHPage_locators.HospitalSection).click()
    When waitFor(AHPage_locators.addHospitalPage)
    * assert exists(AHPage_locators.addHospitalPage) ? true : karate.fail("Validation Failed! Add Hospital Page is not Accessable")
    * def required_Fields =
      """
      exists(AHPage_locators.fieldGroupSystem) &&
      exists(AHPage_locators.fieldHospitalID) &&
      exists(AHPage_locators.fieldHospitalName)

      """
    * print required_Fields
    * assert required_Fields ? true : karate.fail("One or more Fields are Missing! Please check the Elements")
    #-----------------Adding New Group System by Accessing "+" Button-----------------------
    * mouse(AHPage_locators.btnPlus).click()
    * delay(2000).waitForUrl("/masters/add-group-system")
    * assert exists(AHPage_locators.addGroupSystemPage) ? true : karate.fail("Validation Failed! Add Group System Page is not Accessable")
    * input(AHPage_locators.AGSGroupSystemIDSection, dummyGroupSystemID)
    * input(AHPage_locators.AGSGroupSystemSection, dummyHospitalName)
    * click(AHPage_locators.AGSbtnAdd)
    * def isSuccessmsgExists = delay(2000).exists(AHPage_locators.successMSG)
    * print "Is the Success Message Element Exists" ,isSuccessmsgExists
    * assert exists(AHPage_locators.successMSG) ? true : karate.fail("Adding New Group System Mechanism is Failed and Not able to find the Success Message")
    * print text(AHPage_locators.successMSG)
    #----------------------Validating Newly Added Group System Details---------------------------
    * scroll(AHPage_locators.AGSshowDropdown)
    * select(AHPage_locators.AGSshowDropdown, "{}100")
    #------------Fetching Newly Added GroupSystem Name from the Add GroupSystem Table using CSS Selectors "Pseudo-class"-------------
    * def NewGS = delay(3000).script("return document.querySelector('tbody tr:nth-last-child(2) td:nth-child(2)').innerText;")
    * print "Newly Added Group System Name", NewGS
    #-----------Heading Back to Hospital Screen to use the Newly Added Group System using "+" Button to Add New Hospital----------------
    * waitFor(AHPage_locators.HospitalSection).click()
    * waitFor(AHPage_locators.addHospitalPage)
    * assert exists(AHPage_locators.addHospitalPage) ? true : karate.fail("Validation Failed! Add Hospital Page is not Accessable")
    * scroll(AHPage_locators.GroupSystemDropDown)
    * delay(2000).select(AHPage_locators.GroupSystemDropDown, "{}"+ NewGS +"")
    * input(AHPage_locators.HospitalIDSection, dummyNumber)
    * input(AHPage_locators.HospitalNameSection, dummyHospitalName)
    * click(AHPage_locators.btnAdd)
    * def isSuccessmsgExists = delay(2000).exists(AHPage_locators.successMSG)
    * print "Is the Success Message Element Exists" ,isSuccessmsgExists
    * assert exists(AHPage_locators.successMSG) ? true : karate.fail("Adding New Hospital Mechanism is Failed and Not able to find the Success Message")
    * print text(AHPage_locators.successMSG)
    #----------------------Validating Newly Added Hospital Details---------------------------
    * scroll(AHPage_locators.showDropdown)
    * select(AHPage_locators.showDropdown, "{}100")
    #------------Fetching Last Row Details from the Add Hospital Table using CSS Selectors "Pseudo-class"-------------
    * def LastRow = delay(3000).script("return document.querySelector('tbody tr:nth-last-child(2)').innerText;")
    * print "Newly Added Group System Details", LastRow
    * match LastRow contains NewGS
    * match LastRow contains dummyNumber
    * match LastRow contains dummyHospitalName
    * print "Validation and Test Case Passed! New Hospital is Added Successfully by using plus mechanism and All the New Hospital Details avaialble in the AddHospitalPage Table"




  @ignore
  @positive_scenario_4
  Scenario: User should able to "Update" the Hospital Details by accessing the "Edit" Button
    Given waitFor(AHPage_locators.SupersetSection).click()
    Then waitFor(AHPage_locators.HospitalSection).click()
    When waitFor(AHPage_locators.addHospitalPage)
    * assert exists(AHPage_locators.addHospitalPage) ? true : karate.fail("Validation Failed! Add Hospital Page is not Accessable")
    * def required_Fields =
      """
      exists(AHPage_locators.fieldGroupSystem) &&
      exists(AHPage_locators.fieldHospitalID) &&
      exists(AHPage_locators.fieldHospitalName)

      """
    * print required_Fields
    * assert required_Fields ? true : karate.fail("One or more Fields are Missing! Please check the Elements")
    #------------------------Updating the Details of Existing Hospital from the "AddHospital" Page Table---------------------------------
    * scroll(AHPage_locators.showDropdown)
    * select(AHPage_locators.showDropdown, "{}100")
    #------------Fetching Last Row Edit Button from the "AddHospital" Page Table using CSS Selectors "Pseudo-class"-------------
    * delay(2000).script("document.querySelector('tbody tr:nth-last-child(2) button:nth-child(1)').scrollIntoView({ behavior: 'smooth', block: 'center' });")
    * click(AHPage_locators.btnEdit)
    * scroll(AHPage_locators.HospitalIDSection)
    * clear(AHPage_locators.HospitalIDSection)
    * input(AHPage_locators.HospitalIDSection, dummyNumber)
    * clear(AHPage_locators.HospitalNameSection)
    * input(AHPage_locators.HospitalNameSection, dummyHospitalName)
    * click(AHPage_locators.btnUpdate)
    * def isSuccessmsgExists = delay(2000).exists(AHPage_locators.successMSG)
    * print "Is the Success Message Element Exists" ,isSuccessmsgExists
    * assert exists(AHPage_locators.successMSG) ? true : karate.fail("Updating Hospital Details Mechanism is Failed and Not able to find the Success Message")
    * print text(AHPage_locators.successMSG)
    * delay(2000).scroll(AHPage_locators.showDropdown)
    * select(AHPage_locators.showDropdown, "{}100")
    #-------------Fetching Updated Last Row Details from the AddGroupSystemPage using CSS Selectors Pseudo-class--------------
    * def updateRow = delay(3000).script("return document.querySelector('tbody tr:nth-last-child(2)').innerText;")
    * print "Updated GroupSystem Details", updateRow
    * match updateRow contains dummyNumber
    * match updateRow contains dummyHospitalName
    * print "Validation and Test Case Passed! Existing Hospital Details are Updated Successfully"




  @ignore
  @positive_scenario_5
  Scenario: User should able to stop the Edit Mechanism by accessing "Cancel" Button
    Given waitFor(AHPage_locators.SupersetSection).click()
    Then waitFor(AHPage_locators.HospitalSection).click()
    When waitFor(AHPage_locators.addHospitalPage)
    * assert exists(AHPage_locators.addHospitalPage) ? true : karate.fail("Validation Failed! Add Hospital Page is not Accessable")
    * def required_Fields =
      """
      exists(AHPage_locators.fieldGroupSystem) &&
      exists(AHPage_locators.fieldHospitalID) &&
      exists(AHPage_locators.fieldHospitalName)

      """
    * print required_Fields
    * assert required_Fields ? true : karate.fail("One or more Fields are Missing! Please check the Elements")
    #---------------------------------Edit Mechanism Flow Started-------------------------
    * scroll(AHPage_locators.showDropdown)
    * select(AHPage_locators.showDropdown, "{}100")
    #-------------Fetching Last Row Details from the AddGroupSystemPage using CSS Selectors Pseudo-class--------------
    * def beforeEdit = delay(3000).script("return document.querySelector('tbody tr:nth-last-child(2)').innerText;")
    * print "GroupSystem Details Before Edit", beforeEdit
    #------------Fetching Last Row Edit Button from the AddGroupSystemPage Table using CSS Selectors "Pseudo-class"-------------
    * script("document.querySelector('tbody tr:nth-last-child(2) button:nth-child(1)').scrollIntoView({ behavior: 'smooth', block: 'center' });")
    * click(AHPage_locators.btnEdit)
    * scroll(AHPage_locators.btnCancel)
    #--------------------------Clicking Cancel Button in the middle of Edit Mechanism Flow----------------------
    * click(AHPage_locators.btnCancel)
    * scroll(AHPage_locators.showDropdown)
    * select(AHPage_locators.showDropdown, "{}100")
    #-------------Fetching Last Row Details from the AddGroupSystemPage using CSS Selectors Pseudo-class--------------
    * def afterEdit = delay(3000).script("return document.querySelector('tbody tr:nth-last-child(2)').innerText;")
    * print "GroupSystem Details After Edit", afterEdit
    * assert beforeEdit == afterEdit ? true : karate.fail("Canceling Edit Mechanism Flow is not working!")
    * print "Validation and Test Case Passed! Canceling Edit Mechanism Flow is working Successfully"




  @ignore
  @negative_scenario_1
  Scenario: User should not able to Add New Hospital with Invalid HospitalID
    Given waitFor(AHPage_locators.SupersetSection).click()
    Then waitFor(AHPage_locators.HospitalSection).click()
    When waitFor(AHPage_locators.addHospitalPage)
    * assert exists(AHPage_locators.addHospitalPage) ? true : karate.fail("Validation Failed! Add Hospital Page is not Accessable")
    * def required_Fields =
      """
      exists(AHPage_locators.fieldGroupSystem) &&
      exists(AHPage_locators.fieldHospitalID) &&
      exists(AHPage_locators.fieldHospitalName)

      """
    * print required_Fields
    * assert required_Fields ? true : karate.fail("One or more Fields are Missing! Please check the Elements")
    #-----------------------Adding New Hospital with Invalid HospitalID---------------------------------
    * select(AHPage_locators.GroupSystemDropDown, "{}Test Hospital")
    * input(AHPage_locators.HospitalIDSection, dummyHospitalName)
    * input(AHPage_locators.HospitalNameSection, dummyHospitalName)
    * click(AHPage_locators.btnAdd)
    * def isErrormsgExists = delay(2000).exists(AHPage_locators.InvalidHospitalIDError)
    * print "Is the Error Message Element Exists" ,isErrormsgExists
    * assert exists(AHPage_locators.InvalidHospitalIDError) ? true : karate.fail("System should throw a Error Message when Invalid Details added to HospitalID Field")
    * print text(AHPage_locators.InvalidHospitalIDError)
    * script("document.querySelector('.error.text-danger').style.border='3px solid red';")
    * def screenshotName = screenShotPath + 'InvalidHospitalIDError_' + formattedTime + '.png'
    * if(exists(AHPage_locators.InvalidHospitalIDError)) karate.write(screenshot(false), screenshotName)
    * print 'Adding New Hospital Scenario failed! Screenshot is saved in the target folder as:- ', screenshotName
    * print "Validation and Test Case Passed! Adding New Hospital Failed due to Invalid Hospital ID"



  @ignore
  @negative_scenario_2
  Scenario: User should not able to Add New Hospital with Invalid Hospital Name
    Given waitFor(AHPage_locators.SupersetSection).click()
    Then waitFor(AHPage_locators.HospitalSection).click()
    When waitFor(AHPage_locators.addHospitalPage)
    * assert exists(AHPage_locators.addHospitalPage) ? true : karate.fail("Validation Failed! Add Hospital Page is not Accessable")
    * def required_Fields =
      """
      exists(AHPage_locators.fieldGroupSystem) &&
      exists(AHPage_locators.fieldHospitalID) &&
      exists(AHPage_locators.fieldHospitalName)

      """
    * print required_Fields
    * assert required_Fields ? true : karate.fail("One or more Fields are Missing! Please check the Elements")
    #-----------------------Adding New Hospital with Invalid Hospital Name---------------------------------
    * select(AHPage_locators.GroupSystemDropDown, "{}Test Hospital")
    * input(AHPage_locators.HospitalIDSection, dummyNumber)
    * input(AHPage_locators.HospitalNameSection, dummyNumber)
    * click(AHPage_locators.btnAdd)
    * def isErrormsgExists = delay(2000).exists(AHPage_locators.InvalidHospitalNameError)
    * print "Is the Error Message Element Exists" ,isErrormsgExists
    * assert exists(AHPage_locators.InvalidHospitalNameError) ? true : karate.fail("System should throw a Error Message when Invalid Details added to Hospital Name Field")
    * print text(AHPage_locators.InvalidHospitalNameError)
    * script("document.querySelector('.error.text-danger').style.border='3px solid red';")
    * def screenshotName = screenShotPath + 'InvalidHospitalNameError_' + formattedTime + '.png'
    * if(exists(AHPage_locators.InvalidHospitalNameError)) karate.write(screenshot(false), screenshotName)
    * print 'Adding New Hospital Scenario failed! Screenshot is saved in the target folder as:- ', screenshotName
    * print "Validation and Test Case Passed! Adding New Hospital Failed due to Invalid Hospital Name"



  @ignore
  @negative_scenario_3
  Scenario: User should not able to Add New Hospital without selection of GroupSystem
    Given waitFor(AHPage_locators.SupersetSection).click()
    Then waitFor(AHPage_locators.HospitalSection).click()
    When waitFor(AHPage_locators.addHospitalPage)
    * assert exists(AHPage_locators.addHospitalPage) ? true : karate.fail("Validation Failed! Add Hospital Page is not Accessable")
    * def required_Fields =
      """
      exists(AHPage_locators.fieldGroupSystem) &&
      exists(AHPage_locators.fieldHospitalID) &&
      exists(AHPage_locators.fieldHospitalName)

      """
    * print required_Fields
    * assert required_Fields ? true : karate.fail("One or more Fields are Missing! Please check the Elements")
    #-----------------------Adding New Hospital without GroupSystem---------------------------------
    * input(AHPage_locators.HospitalIDSection, dummyNumber)
    * input(AHPage_locators.HospitalNameSection, dummyHospitalName)
    * click(AHPage_locators.btnAdd)
    * def isErrormsgExists = delay(2000).exists(AHPage_locators.UnselectedGroupSystemError)
    * print "Is the Error Message Element Exists" ,isErrormsgExists
    * assert exists(AHPage_locators.UnselectedGroupSystemError) ? true : karate.fail("System should throw a Error Message when when GroupSystem Field is left Unselected")
    * print text(AHPage_locators.UnselectedGroupSystemError)
    * script("document.querySelector('.error.text-danger').style.border='3px solid red';")
    * def screenshotName = screenShotPath + 'UnselectedGroupSystemError_' + formattedTime + '.png'
    * if(exists(AHPage_locators.UnselectedGroupSystemError)) karate.write(screenshot(false), screenshotName)
    * print 'Adding New Hospital Scenario failed! Screenshot is saved in the target folder as:- ', screenshotName
    * print "Validation and Test Case Passed! Adding New Hospital Failed due to Unselected GroupSystem Field"



  @ignore
  @negative_scenario_4
  Scenario: User should not able to Add New Hospital without HospitalID
    Given waitFor(AHPage_locators.SupersetSection).click()
    Then waitFor(AHPage_locators.HospitalSection).click()
    When waitFor(AHPage_locators.addHospitalPage)
    * assert exists(AHPage_locators.addHospitalPage) ? true : karate.fail("Validation Failed! Add Hospital Page is not Accessable")
    * def required_Fields =
      """
      exists(AHPage_locators.fieldGroupSystem) &&
      exists(AHPage_locators.fieldHospitalID) &&
      exists(AHPage_locators.fieldHospitalName)

      """
    * print required_Fields
    * assert required_Fields ? true : karate.fail("One or more Fields are Missing! Please check the Elements")
    #-----------------------Adding New Hospital without HospitalID---------------------------------
    * select(AHPage_locators.GroupSystemDropDown, "{}Test Hospital")
    * input(AHPage_locators.HospitalNameSection, dummyHospitalName)
    * click(AHPage_locators.btnAdd)
    * def isErrormsgExists = delay(2000).exists(AHPage_locators.BlankHospitalIDError)
    * print "Is the Error Message Element Exists" ,isErrormsgExists
    * assert exists(AHPage_locators.BlankHospitalIDError) ? true : karate.fail("System should throw a Error Message when when Hospital ID Field is Blank")
    * print text(AHPage_locators.BlankHospitalIDError)
    * script("document.querySelector('.error.text-danger').style.border='3px solid red';")
    * def screenshotName = screenShotPath + 'BlankHospitalIDError_' + formattedTime + '.png'
    * if(exists(AHPage_locators.BlankHospitalIDError)) karate.write(screenshot(false), screenshotName)
    * print 'Adding New Hospital Scenario failed! Screenshot is saved in the target folder as:- ', screenshotName
    * print "Validation and Test Case Passed! Adding New Hospital Failed due to Blank Hospital ID Field"



  @ignore
  @negative_scenario_5
  Scenario: User should not able to Add New Hospital without Hospital Name
    Given waitFor(AHPage_locators.SupersetSection).click()
    Then waitFor(AHPage_locators.HospitalSection).click()
    When waitFor(AHPage_locators.addHospitalPage)
    * assert exists(AHPage_locators.addHospitalPage) ? true : karate.fail("Validation Failed! Add Hospital Page is not Accessable")
    * def required_Fields =
      """
      exists(AHPage_locators.fieldGroupSystem) &&
      exists(AHPage_locators.fieldHospitalID) &&
      exists(AHPage_locators.fieldHospitalName)

      """
    * print required_Fields
    * assert required_Fields ? true : karate.fail("One or more Fields are Missing! Please check the Elements")
    #-----------------------Adding New Hospital without Hospital Name---------------------------------
    * select(AHPage_locators.GroupSystemDropDown, "{}Test Hospital")
    * input(AHPage_locators.HospitalIDSection, dummyNumber)
    * click(AHPage_locators.btnAdd)
    * def isErrormsgExists = delay(2000).exists(AHPage_locators.BlankHospitalNameError)
    * print "Is the Error Message Element Exists" ,isErrormsgExists
    * assert exists(AHPage_locators.BlankHospitalNameError) ? true : karate.fail("System should throw a Error Message when when Hospital Name Field is Blank")
    * print text(AHPage_locators.BlankHospitalNameError)
    * script("document.querySelector('.error.text-danger').style.border='3px solid red';")
    * def screenshotName = screenShotPath + 'BlankHospitalNameError_' + formattedTime + '.png'
    * if(exists(AHPage_locators.BlankHospitalNameError)) karate.write(screenshot(false), screenshotName)
    * print 'Adding New Hospital Scenario failed! Screenshot is saved in the target folder as:- ', screenshotName
    * print "Validation and Test Case Passed! Adding New Hospital Failed due to Blank Hospital Name Field"


