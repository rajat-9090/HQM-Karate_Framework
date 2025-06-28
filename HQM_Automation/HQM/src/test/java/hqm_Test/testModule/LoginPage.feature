Feature: Login Function Scenarios

  Background:

    * configure driver = { timeout: 40000 }

    #Getting the Configuration Details of Chrome from "karate-config.js"
    * configure driver = ChromeDriver
    * def loginUrl = URL + "/auth/login"
    #-------------Fetching JSON File for all the LogIN Page Elements Details--------------
    * def locators = read("classpath:hqm_Test/testData/LoginPage_ElementList.json")
    #-------------Fetching the excel sheet for Validation Purposes-------------
    * def path = karate.toAbsolutePath("classpath:hqm_Test/testData/All_HQM_Details.xlsx")
    * def fetch_Excel = Java.type("hqm_Test.utilities.Excelutility")
    * def HQM_Details = new fetch_Excel(path)
    #--------------Calling TimeFormat File for Adding TimeStamp Format for the Error ScreenShots----------------
    * def timestamp = Java.type("hqm_Test.utilities.TimeFormat")
    * def formattedTime = timestamp.getFormattedTimestamp()
    #--------------Fetching the Title details----------------
    * def app_Title = HQM_Details.getCellData("LogIN_DDT", 5, 0)
    * print app_Title
    #---------------Fetching Valid Scenario Details-----------------
    * def valid_Email = HQM_Details.getCellData("LogIN_DDT", 1, 0)
    * def valid_Pass = HQM_Details.getCellData("LogIN_DDT", 1, 1)
    * print valid_Email
    * print valid_Pass
    #---------------Fetching Invalid Scenario Details-----------------
    * def wrong_Email = HQM_Details.getCellData("LogIN_DDT", 2, 0)
    * def wrong_Pass = HQM_Details.getCellData("LogIN_DDT", 2, 1)
    * def invalid_Email = HQM_Details.getCellData("LogIN_DDT", 3, 0)
    * def invalid_Pass = HQM_Details.getCellData("LogIN_DDT", 3, 1)
    * print wrong_Email
    * print wrong_Pass
    * print invalid_Email
    * print invalid_Pass
    #-------------Adding the Path of LoginPage where all the Error Sceenshots will store-----------------
    * def screenShotPath = "errorScreenShots/LoginPage/"



  #@ignore
  @positive_scenario_1
  @Login
  Scenario: User should login successfully with valid Credentials
    Given driver loginUrl
    * delay(2000).maximize()
    And input(locators.txtEmail, valid_Email)
    And input(locators.txtPassword, valid_Pass)
    Then click(locators.btnSubmit)
    And waitForUrl("/payout/calculate-payout")
    * print driver.title
    * print "Validation and Test Case Passed! User Logged IN Successfully with Valid Credentials"


  @ignore
  @negative_scenario_1
  Scenario: User should not able to login with Wrong Email and Password
    Given driver loginUrl
    * delay(2000).maximize()
    And input(locators.txtEmail, wrong_Email)
    And input(locators.txtPassword, wrong_Pass)
    Then click(locators.btnSubmit)
    * if(!exists(locators.invalidCredentialError)) karate.fail("Validation Failed! Unable to find the invalidCredentialError Element")
    * print text(locators.invalidCredentialError)
    * script("document.querySelector('.alert.alert-danger.alert-dismissible.fade.show').style.border='3px solid red';")
    * def screenshotName = screenShotPath + 'invalidCredentialError_' + formattedTime + '.png'
    * if(exists(locators.invalidCredentialError)) karate.write(screenshot(false), screenshotName)
    * print 'Login Scenario failed! Screenshot is saved in the target folder as:- ', screenshotName
    * print "Validation and Test Case Passed! Login Failed due to Wrong Email and Password"



  @ignore
  @negative_scenario_2
  Scenario: User should not able to login with Wrong Email and Valid Password
    Given driver loginUrl
    * delay(2000).maximize()
    And input(locators.txtEmail, wrong_Email)
    And input(locators.txtPassword, valid_Pass)
    Then click(locators.btnSubmit)
    * if(!exists(locators.invalidCredentialError)) karate.fail("Validation Failed! Unable to find the invalidCredentialError Element")
    * print text(locators.invalidCredentialError)
    * script("document.querySelector('.alert.alert-danger.alert-dismissible.fade.show').style.border='3px solid red';")
    * def screenshotName = screenShotPath + 'wrongEmailError_' + formattedTime + '.png'
    * if(exists(locators.invalidCredentialError)) karate.write(screenshot(false), screenshotName)
    * print 'Login Scenario failed! Screenshot is saved in the target folder as:- ', screenshotName
    * print "Validation and Test Case Passed! Login Failed due to Wrong Email"



  @ignore
  @negative_scenario_3
  Scenario: User should not able to login with Wrong Password and Valid Email
    Given driver loginUrl
    * delay(2000).maximize()
    And input(locators.txtEmail, valid_Email)
    And input(locators.txtPassword, wrong_Pass)
    Then click(locators.btnSubmit)
    * if(!exists(locators.invalidCredentialError)) karate.fail("Validation Failed! Unable to find the invalidCredentialError Element")
    * print text(locators.invalidCredentialError)
    * script("document.querySelector('.alert.alert-danger.alert-dismissible.fade.show').style.border='3px solid red';")
    * def screenshotName = screenShotPath + 'wrongPassError_' + formattedTime + '.png'
    * if(exists(locators.invalidCredentialError)) karate.write(screenshot(false), screenshotName)
    * print 'Login Scenario failed! Screenshot is saved in the target folder as:- ', screenshotName
    * print "Validation and Test Case Passed! Login Failed due to Wrong Password"


  @ignore
  @negative_scenario_4
  Scenario: User should not able to login with Invalid Email
    Given driver loginUrl
    * delay(2000).maximize()
    And input(locators.txtEmail, invalid_Email)
    And input(locators.txtPassword, valid_Pass)
    Then click(locators.btnSubmit)
    * assert exists(locators.invalidEmailFormatError) ? true : karate.fail("Validation Failed! Unable to find the invalidEmailFormatError Element")
    * print text(locators.invalidEmailFormatError)
    * script("document.querySelector('.error.text-danger').style.border='3px solid red';")
    * def screenshotName = screenShotPath + 'invalidEmailFormatError_' + formattedTime + '.png'
    * if(exists(locators.invalidEmailFormatError)) karate.write(screenshot(false), screenshotName)
    * print 'Login Scenario failed! Screenshot is saved in the target folder as:- ', screenshotName
    * print "Validation and Test Case Passed! Login Failed due to Invalid Email"


  @ignore
  @negative_scenario_5
  Scenario: User should not able to login with Invalid Password(Minimum length 8 character!)
    Given driver loginUrl
    * delay(2000).maximize()
    And input(locators.txtEmail, valid_Email)
    And input(locators.txtPassword, invalid_Pass)
    Then click(locators.btnSubmit)
    * assert exists(locators.invalidPassLengthError) ? true : karate.fail("Validation Failed! Unable to find the invalidPassLengthError Element")
    * print text(locators.invalidPassLengthError)
    * script("document.querySelector('.error.text-danger').style.border='3px solid red';")
    * def screenshotName = screenShotPath + 'invalidPassLengthError_' + formattedTime + '.png'
    * if(exists(locators.invalidPassLengthError)) karate.write(screenshot(false), screenshotName)
    * print 'Login Scenario failed! Screenshot is saved in the target folder as:- ', screenshotName
    * print "Validation and Test Case Passed! Login Failed due to Invalid Password"


  @ignore
  @negative_scenario_6
  Scenario: User should not able to login with Blank Email Field
    Given driver loginUrl
    * delay(2000).maximize()
    And input(locators.txtPassword, valid_Pass)
    Then click(locators.btnSubmit)
    * assert exists(locators.blankEmailError) ? true : karate.fail("Validation Failed! Unable to find the blankEmailError Element")
    * print text(locators.blankEmailError)
    * script("document.querySelector('.error.text-danger').style.border='3px solid red';")
    * def screenshotName = screenShotPath + 'blankEmailError_' + formattedTime + '.png'
    * if(exists(locators.blankEmailError)) karate.write(screenshot(false), screenshotName)
    * print 'Login Scenario failed! Screenshot is saved in the target folder as:- ', screenshotName
    * print "Validation and Test Case Passed! Login Failed due to Blank Email Field"


  @ignore
  @negative_scenario_7
  Scenario: User should not able to login with Blank Password Field
    Given driver loginUrl
    * delay(2000).maximize()
    And input(locators.txtEmail, valid_Email)
    Then click(locators.btnSubmit)
    * assert exists(locators.blankPassError) ? true : karate.fail("Validation Failed! Unable to find the blankPassError Element")
    * print text(locators.blankPassError)
    * script("document.querySelector('.error.text-danger').style.border='3px solid red';")
    * def screenshotName = screenShotPath + 'blankPassError_' + formattedTime + '.png'
    * if(exists(locators.blankPassError)) karate.write(screenshot(false), screenshotName)
    * print 'Login Scenario failed! Screenshot is saved in the target folder as:- ', screenshotName
    * print "Validation and Test Case Passed! Login Failed due to Blank Password Field"


