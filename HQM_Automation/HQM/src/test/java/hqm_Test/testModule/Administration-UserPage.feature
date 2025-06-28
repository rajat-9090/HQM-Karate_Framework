Feature: User Page Scenarios

  Background:

    * configure driver = { type: 'chrome', timeout: 60000 }

    #-------------Fetching JSON File for all the UserPage Elements Details--------------
    * def UserPage_locators = read("classpath:hqm_Test/testData/UserPage_ElementList.json")
    #-------------Calling the Login Scenario from LoginPage Feature File-----------------
    * call read("classpath:hqm_Test/testModule/LoginPage.feature@Login")
    #--------------Calling DataFaker Java Library to create new User when Needed-------------
    * def dummyUser = Java.type("hqm_Test.utilities.GenerateRandomData")
    * def dummyFirstName = dummyUser.getRandomFirstName()
    * def dummyLastName = dummyUser.getRandomLastName()
    * def dummyEmail = dummyUser.getRandomEmail()
    * def invalidEntry = dummyUser.getRandomInteger(10)
    * print invalidEntry
    * print dummyFirstName
    * print dummyLastName
    * print dummyEmail
    #--------------Calling TimeFormat File for Adding TimeStamp Format for the Error ScreenShots----------------
    * def timestamp = Java.type("hqm_Test.utilities.TimeFormat")
    * def formattedTime = timestamp.getFormattedTimestamp()
    #-------------Adding the Path of UserPage where all the Error Sceenshots will store-----------------
    * def screenShotPath = "errorScreenShots/UserPage/"

  @ignore
  @positive_scenario_1
  Scenario: User should access the User Page successfully
    Given waitFor(UserPage_locators.administrationSection).click()
    Then waitFor(UserPage_locators.userSection).click()
    When waitFor(UserPage_locators.addUserPage)
    * assert exists(UserPage_locators.addUserPage) ? true : karate.fail("Validation Failed! AddUserPage Element is not Accessable")
    * def required_Fields =
      """
      exists(UserPage_locators.fieldFirstName) &&
      exists(UserPage_locators.fieldLastName) &&
      exists(UserPage_locators.fieldEmail) &&
      exists(UserPage_locators.fieldRole)
      """
    * print required_Fields
    * assert required_Fields ? true : karate.fail("One or more Fields are Missing! Please check the Elements")
    * print "Validation and Test Case Passed!  UserPage accessed successfully and Required Fields are Present in the Screen"


  @ignore
  @positive_scenario_2
  Scenario: User should able to "Add" the New User with the respective individual Role
    Given waitFor(UserPage_locators.administrationSection).click()
    Then waitFor(UserPage_locators.userSection).click()
    When waitFor(UserPage_locators.addUserPage)
    * assert exists(UserPage_locators.addUserPage) ? true : karate.fail("Validation Failed! AddUserPage Element is not Accessable")
    * def required_Fields =
      """
      exists(UserPage_locators.fieldFirstName) &&
      exists(UserPage_locators.fieldLastName) &&
      exists(UserPage_locators.fieldEmail) &&
      exists(UserPage_locators.fieldRole)
      """
    * print required_Fields
    * assert required_Fields ? true : karate.fail("One or more Fields are Missing! Please check the Elements")
    #-----------------------Adding New User---------------------------------
    * input(UserPage_locators.firstNameSection, dummyFirstName)
    * input(UserPage_locators.lastNameSection, dummyLastName)
    * input(UserPage_locators.emailSection, dummyEmail)
    * select(UserPage_locators.roleDropdown, "{}View_Role")
    * click(UserPage_locators.btnAdd)
    * def isSuccessmsgExists = delay(2000).exists(UserPage_locators.successMSG)
    * print "Is the Success Message Element Exists" ,isSuccessmsgExists
    * assert exists(UserPage_locators.successMSG) ? true : karate.fail("Adding New User Mechanism is Failed and Not able to find the Success Message")
    * print text(UserPage_locators.successMSG)
    #----------------------Validating Newly Added User Details---------------------------
    * scroll(UserPage_locators.showDropdown)
    * select(UserPage_locators.showDropdown, "{}100")
    #------------------Fetching Last Row Details from the Add User Table using CSS Selectors Pseudo-class------------------------
    * def LastRow = delay(3000).script("return document.querySelector('tbody tr:nth-last-child(2)').innerText;")
    * print "Newly Added User Details", LastRow
    * match LastRow contains dummyFirstName
    * match LastRow contains dummyLastName
    * match LastRow contains dummyEmail
    * match LastRow contains "View_Role"
    * print "Validation and Test Case Passed! New User is Added Successfully and All the New User Details avaialble in the AddUserPage"


  @ignore
  @positive_scenario_3
  Scenario: User should able to "Update" any User Details by accessing the "Edit" Button
    Given waitFor(UserPage_locators.administrationSection).click()
    Then waitFor(UserPage_locators.userSection).click()
    When waitFor(UserPage_locators.addUserPage)
    * assert exists(UserPage_locators.addUserPage) ? true : karate.fail("Validation Failed! AddUserPage Element is not Accessable")
    * def required_Fields =
      """
      exists(UserPage_locators.fieldFirstName) &&
      exists(UserPage_locators.fieldLastName) &&
      exists(UserPage_locators.fieldEmail) &&
      exists(UserPage_locators.fieldRole)
      """
    * print required_Fields
    * assert required_Fields ? true : karate.fail("One or more Fields are Missing! Please check the Elements")
    #------------------------Updating the Details of Existing User from the AddUserPage Table---------------------------------
    * scroll(UserPage_locators.showDropdown)
    * select(UserPage_locators.showDropdown, "{}100")
    #------------Fetching Last Row Edit Button from the AddUserPage Table using CSS Selectors "Pseudo-class"-------------
    * delay(2000).script("document.querySelector('tbody tr:nth-last-child(2) button:nth-child(1)').scrollIntoView({ behavior: 'smooth', block: 'center' });")
    * click(UserPage_locators.btnEdit)
    * scroll(UserPage_locators.firstNameSection)
    * clear(UserPage_locators.firstNameSection)
    * input(UserPage_locators.firstNameSection, dummyFirstName)
    * clear(UserPage_locators.lastNameSection)
    * input(UserPage_locators.lastNameSection, dummyLastName)
    * click(UserPage_locators.btnUpdate)
    * def isSuccessmsgExists = delay(2000).exists(UserPage_locators.successMSG)
    * print "Is the Success Message Element Exists" ,isSuccessmsgExists
    * assert exists(UserPage_locators.successMSG) ? true : karate.fail("Updating User Details Mechanism is Failed and Not able to find the Success Message")
    * print text(UserPage_locators.successMSG)
    * delay(2000).scroll(UserPage_locators.showDropdown)
    * select(UserPage_locators.showDropdown, "{}100")
    #-------------Fetching Updated Last Row Details from the AddUserPage using CSS Selectors Pseudo-class--------------
    * def updateRow = delay(3000).script("return document.querySelector('tbody tr:nth-last-child(2)').innerText;")
    * print "Updated User Details", updateRow
    * match updateRow contains dummyFirstName
    * match updateRow contains dummyLastName
    * print "Validation and Test Case Passed! Existing User Details are Updated Successfully"


  @ignore
  @positive_scenario_4
  Scenario: User should able to stop the Edit Mechanism by accessing "Cancel" Button
    Given waitFor(UserPage_locators.administrationSection).click()
    Then waitFor(UserPage_locators.userSection).click()
    When waitFor(UserPage_locators.addUserPage)
    * assert exists(UserPage_locators.addUserPage) ? true : karate.fail("Validation Failed! AddUserPage Element is not Accessable")
    * def required_Fields =
      """
      exists(UserPage_locators.fieldFirstName) &&
      exists(UserPage_locators.fieldLastName) &&
      exists(UserPage_locators.fieldEmail) &&
      exists(UserPage_locators.fieldRole)
      """
    * print required_Fields
    * assert required_Fields ? true : karate.fail("One or more Fields are Missing! Please check the Elements")
    #---------------------------------Edit Mechanism Flow Started-------------------------
    * scroll(UserPage_locators.showDropdown)
    * select(UserPage_locators.showDropdown, "{}100")
    * def beforeEdit = delay(3000).script("return document.querySelector('tbody tr:nth-last-child(2)').innerText;")
    * print "User Details Before Edit", beforeEdit
    #------------Fetching Last Row Edit Button from the AddUserPage Table using CSS Selectors "Pseudo-class"-------------
    * script("document.querySelector('tbody tr:nth-last-child(2) button:nth-child(1)').scrollIntoView({ behavior: 'smooth', block: 'center' });")
    * click(UserPage_locators.btnEdit)
    * scroll(UserPage_locators.btnCancel)
    #--------------------------Clicking Cancel Button in the middle of Edit Mechanism Flow----------------------
    * click(UserPage_locators.btnCancel)
    * scroll(UserPage_locators.showDropdown)
    * select(UserPage_locators.showDropdown, "{}100")
    #-------------Fetching Last Row Details from the AddUserPage using CSS Selectors Pseudo-class--------------
    * def afterEdit = delay(3000).script("return document.querySelector('tbody tr:nth-last-child(2)').innerText;")
    * print "User Details After Edit", afterEdit
    * assert beforeEdit == afterEdit ? true : karate.fail("Validation Failed! Canceling Edit Mechanism Flow is not working")
    * print "Validation and Test Case Passed! Canceling Edit Mechanism Flow is working Successfully"


  #@ignore
  @negative_scenario_1
  Scenario: User should not able to Add New User with Invalid FirstName
    Given waitFor(UserPage_locators.administrationSection).click()
    Then waitFor(UserPage_locators.userSection).click()
    When waitFor(UserPage_locators.addUserPage)
    * assert exists(UserPage_locators.addUserPage) ? true : karate.fail("Validation Failed! AddUserPage Element is not Accessable")
    * def required_Fields =
      """
      exists(UserPage_locators.fieldFirstName) &&
      exists(UserPage_locators.fieldLastName) &&
      exists(UserPage_locators.fieldEmail) &&
      exists(UserPage_locators.fieldRole)
      """
    * print required_Fields
    * assert required_Fields ? true : karate.fail("One or more Fields are Missing! Please check the Elements")
    #-----------------------Adding New User with Invalid FirstName---------------------------------
    * input(UserPage_locators.firstNameSection, invalidEntry)
    * input(UserPage_locators.lastNameSection, dummyLastName)
    * input(UserPage_locators.emailSection, dummyEmail)
    * select(UserPage_locators.roleDropdown, "{}View_Role")
    * click(UserPage_locators.btnAdd)
    * def isErrormsgExists = delay(2000).exists(UserPage_locators.firstNameError)
    * print "Is the Error Message Element Exists" ,isErrormsgExists
    * assert exists(UserPage_locators.firstNameError) ? true : karate.fail("System should throw a Error Message when Invalid Details added to FirstName Field")
    * print text(UserPage_locators.firstNameError)
    * script("document.querySelector('.error.text-danger').style.border='3px solid red';")
    * def screenshotName = screenShotPath + 'firstNameError_' + formattedTime + '.png'
    * if(exists(UserPage_locators.firstNameError)) karate.write(screenshot(false), screenshotName)
    * print 'Adding New User Scenario failed! Screenshot is saved in the target folder as:- ', screenshotName
    * print "Validation and Test Case Passed! Adding New User Failed due to Invalid FirstName"


  #@ignore
  @negative_scenario_2
  Scenario: User should not able to Add New User with Invalid LastName
    Given waitFor(UserPage_locators.administrationSection).click()
    Then waitFor(UserPage_locators.userSection).click()
    When waitFor(UserPage_locators.addUserPage)
    * assert exists(UserPage_locators.addUserPage) ? true : karate.fail("Validation Failed! AddUserPage Element is not Accessable")
    * def required_Fields =
      """
      exists(UserPage_locators.fieldFirstName) &&
      exists(UserPage_locators.fieldLastName) &&
      exists(UserPage_locators.fieldEmail) &&
      exists(UserPage_locators.fieldRole)
      """
    * print required_Fields
    * assert required_Fields ? true : karate.fail("One or more Fields are Missing! Please check the Elements")
    #-----------------------Adding New User with Invalid LastName---------------------------------
    * input(UserPage_locators.firstNameSection, dummyFirstName)
    * input(UserPage_locators.lastNameSection, invalidEntry)
    * input(UserPage_locators.emailSection, dummyEmail)
    * select(UserPage_locators.roleDropdown, "{}View_Role")
    * click(UserPage_locators.btnAdd)
    * def isErrormsgExists = delay(2000).exists(UserPage_locators.lastNameError)
    * print "Is the Error Message Element Exists" ,isErrormsgExists
    * assert exists(UserPage_locators.lastNameError) ? true : karate.fail("System should throw a Error Message when Invalid Details added to LastName Field")
    * print text(UserPage_locators.lastNameError)
    * script("document.querySelector('.error.text-danger').style.border='3px solid red';")
    * def screenshotName = screenShotPath + 'lastNameError_' + formattedTime + '.png'
    * if(exists(UserPage_locators.lastNameError)) karate.write(screenshot(false), screenshotName)
    * print 'Adding New User Scenario failed! Screenshot is saved in the target folder as:- ', screenshotName
    * print "Validation and Test Case Passed! Adding New User Failed due to Invalid LastName"


  #@ignore
  @negative_scenario_3
  Scenario: User should not able to Add New User with Invalid Email ID
    Given waitFor(UserPage_locators.administrationSection).click()
    Then waitFor(UserPage_locators.userSection).click()
    When waitFor(UserPage_locators.addUserPage)
    * assert exists(UserPage_locators.addUserPage) ? true : karate.fail("Validation Failed! AddUserPage Element is not Accessable")
    * def required_Fields =
      """
      exists(UserPage_locators.fieldFirstName) &&
      exists(UserPage_locators.fieldLastName) &&
      exists(UserPage_locators.fieldEmail) &&
      exists(UserPage_locators.fieldRole)
      """
    * print required_Fields
    * assert required_Fields ? true : karate.fail("One or more Fields are Missing! Please check the Elements")
    #-----------------------Adding New User with Invalid Email ID---------------------------------
    * input(UserPage_locators.firstNameSection, dummyFirstName)
    * input(UserPage_locators.lastNameSection, dummyLastName)
    * input(UserPage_locators.emailSection, invalidEntry)
    * select(UserPage_locators.roleDropdown, "{}View_Role")
    * click(UserPage_locators.btnAdd)
    * def isErrormsgExists = delay(2000).exists(UserPage_locators.emailError)
    * print "Is the Error Message Element Exists" ,isErrormsgExists
    * assert exists(UserPage_locators.emailError) ? true : karate.fail("System should throw a Error Message when Invalid Details added to Email Field")
    * print text(UserPage_locators.emailError)
    * script("document.querySelector('.error.text-danger').style.border='3px solid red';")
    * def screenshotName = screenShotPath + 'emailError_' + formattedTime + '.png'
    * if(exists(UserPage_locators.emailError)) karate.write(screenshot(false), screenshotName)
    * print 'Adding New User Scenario failed! Screenshot is saved in the target folder as:- ', screenshotName
    * print "Validation and Test Case Passed! Adding New User Failed due to Invalid Email ID"


  #@ignore
  @negative_scenario_4
  Scenario: User should not able to Add New User without FirstName
    Given waitFor(UserPage_locators.administrationSection).click()
    Then waitFor(UserPage_locators.userSection).click()
    When waitFor(UserPage_locators.addUserPage)
    * assert exists(UserPage_locators.addUserPage) ? true : karate.fail("Validation Failed! AddUserPage Element is not Accessable")
    * def required_Fields =
      """
      exists(UserPage_locators.fieldFirstName) &&
      exists(UserPage_locators.fieldLastName) &&
      exists(UserPage_locators.fieldEmail) &&
      exists(UserPage_locators.fieldRole)
      """
    * print required_Fields
    * assert required_Fields ? true : karate.fail("One or more Fields are Missing! Please check the Elements")
    #-----------------------Adding New User without FirstName---------------------------------
    * input(UserPage_locators.lastNameSection, dummyLastName)
    * input(UserPage_locators.emailSection, dummyEmail)
    * select(UserPage_locators.roleDropdown, "{}View_Role")
    * click(UserPage_locators.btnAdd)
    * def isErrormsgExists = delay(2000).exists(UserPage_locators.blankFirstNameError)
    * print "Is the Error Message Element Exists" ,isErrormsgExists
    * assert exists(UserPage_locators.blankFirstNameError) ? true : karate.fail("System should throw a Error Message when FirstName Field is Blank")
    * print text(UserPage_locators.blankFirstNameError)
    * script("document.querySelector('.error.text-danger').style.border='3px solid red';")
    * def screenshotName = screenShotPath + 'blankFirstNameError_' + formattedTime + '.png'
    * if(exists(UserPage_locators.blankFirstNameError)) karate.write(screenshot(false), screenshotName)
    * print 'Adding New User Scenario failed! Screenshot is saved in the target folder as:- ', screenshotName
    * print "Validation and Test Case Passed! Adding New User Failed due to Blank FirstName Field"


  #@ignore
  @negative_scenario_5
  Scenario: User should not able to Add New User without LastName
    Given waitFor(UserPage_locators.administrationSection).click()
    Then waitFor(UserPage_locators.userSection).click()
    When waitFor(UserPage_locators.addUserPage)
    * assert exists(UserPage_locators.addUserPage) ? true : karate.fail("Validation Failed! AddUserPage Element is not Accessable")
    * def required_Fields =
      """
      exists(UserPage_locators.fieldFirstName) &&
      exists(UserPage_locators.fieldLastName) &&
      exists(UserPage_locators.fieldEmail) &&
      exists(UserPage_locators.fieldRole)
      """
    * print required_Fields
    * assert required_Fields ? true : karate.fail("One or more Fields are Missing! Please check the Elements")
    #-----------------------Adding New User without LastName---------------------------------
    * input(UserPage_locators.firstNameSection, dummyFirstName)
    * input(UserPage_locators.emailSection, dummyEmail)
    * select(UserPage_locators.roleDropdown, "{}View_Role")
    * click(UserPage_locators.btnAdd)
    * def isErrormsgExists = delay(2000).exists(UserPage_locators.blankLastNameError)
    * print "Is the Error Message Element Exists" ,isErrormsgExists
    * assert exists(UserPage_locators.blankLastNameError) ? true : karate.fail("System should throw a Error Message when LastName Field is Blank")
    * print text(UserPage_locators.blankLastNameError)
    * script("document.querySelector('.error.text-danger').style.border='3px solid red';")
    * def screenshotName = screenShotPath + 'blankLastNameError_' + formattedTime + '.png'
    * if(exists(UserPage_locators.blankLastNameError)) karate.write(screenshot(false), screenshotName)
    * print 'Adding New User Scenario failed! Screenshot is saved in the target folder as:- ', screenshotName
    * print "Validation and Test Case Passed! Adding New User Failed due to Blank LastName Field"


  #@ignore
  @negative_scenario_6
  Scenario: User should not able to Add New User without Email ID
    Given waitFor(UserPage_locators.administrationSection).click()
    Then waitFor(UserPage_locators.userSection).click()
    When waitFor(UserPage_locators.addUserPage)
    * assert exists(UserPage_locators.addUserPage) ? true : karate.fail("Validation Failed! AddUserPage Element is not Accessable")
    * def required_Fields =
      """
      exists(UserPage_locators.fieldFirstName) &&
      exists(UserPage_locators.fieldLastName) &&
      exists(UserPage_locators.fieldEmail) &&
      exists(UserPage_locators.fieldRole)
      """
    * print required_Fields
    * assert required_Fields ? true : karate.fail("One or more Fields are Missing! Please check the Elements")
    #-----------------------Adding New User without Email ID---------------------------------
    * input(UserPage_locators.firstNameSection, dummyFirstName)
    * input(UserPage_locators.lastNameSection, dummyLastName)
    * select(UserPage_locators.roleDropdown, "{}View_Role")
    * click(UserPage_locators.btnAdd)
    * def isErrormsgExists = delay(2000).exists(UserPage_locators.blankEmailError)
    * print "Is the Error Message Element Exists" ,isErrormsgExists
    * assert exists(UserPage_locators.blankEmailError) ? true : karate.fail("System should throw a Error Message when Email ID Field is Blank")
    * print text(UserPage_locators.blankEmailError)
    * script("document.querySelector('.error.text-danger').style.border='3px solid red';")
    * def screenshotName = screenShotPath + 'blankEmailError_' + formattedTime + '.png'
    * if(exists(UserPage_locators.blankEmailError)) karate.write(screenshot(false), screenshotName)
    * print 'Adding New User Scenario failed! Screenshot is saved in the target folder as:- ', screenshotName
    * print "Validation and Test Case Passed! Adding New User Failed due to Blank Email ID Field"


  #@ignore
  @negative_scenario_7
  Scenario: User should not able to Add New User without selection of Role
    Given waitFor(UserPage_locators.administrationSection).click()
    Then waitFor(UserPage_locators.userSection).click()
    When waitFor(UserPage_locators.addUserPage)
    * assert exists(UserPage_locators.addUserPage) ? true : karate.fail("Validation Failed! AddUserPage Element is not Accessable")
    * def required_Fields =
      """
      exists(UserPage_locators.fieldFirstName) &&
      exists(UserPage_locators.fieldLastName) &&
      exists(UserPage_locators.fieldEmail) &&
      exists(UserPage_locators.fieldRole)
      """
    * print required_Fields
    * assert required_Fields ? true : karate.fail("One or more Fields are Missing! Please check the Elements")
    #-----------------------Adding New User without Selected of Role---------------------------------
    * input(UserPage_locators.firstNameSection, dummyFirstName)
    * input(UserPage_locators.lastNameSection, dummyLastName)
    * input(UserPage_locators.emailSection, dummyEmail)
    * click(UserPage_locators.btnAdd)
    * def isErrormsgExists = delay(2000).exists(UserPage_locators.unselectedRoleError)
    * print "Is the Error Message Element Exists" ,isErrormsgExists
    * assert exists(UserPage_locators.unselectedRoleError) ? true : karate.fail("System should throw a Error Message when Role Field is left Unselected")
    * print text(UserPage_locators.unselectedRoleError)
    * script("document.querySelector('.error.text-danger').style.border='3px solid red';")
    * def screenshotName = screenShotPath + 'unselectedRoleError_' + formattedTime + '.png'
    * if(exists(UserPage_locators.unselectedRoleError)) karate.write(screenshot(false), screenshotName)
    * print 'Adding New User Scenario failed! Screenshot is saved in the target folder as:- ', screenshotName
    * print "Validation and Test Case Passed! Adding New User Failed due to Unselected Role Field"
