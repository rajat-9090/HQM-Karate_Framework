Feature: Calculate Payout Page Scenarios

  Background:

    * configure driver = { timeout: 40000 }

    #-------------Fetching JSON File for all the Calculate Payout Page Elements Details--------------
    * def CPPage_locators = read("classpath:hqm_Test/testData/Calculate_Payout_Elements.json")
    #-------------Calling the Login Scenario from LoginPage Feature File-----------------
    * call read("classpath:hqm_Test/testModule/LoginPage.feature@Login")
    #----------------Calling GenerateRandomData External File to create Dummy Entries---------------
    * def dummyDetails = Java.type("hqm_Test.utilities.GenerateRandomData")
    * def dummyNumber = dummyDetails.getRandomInteger(5)
    * print dummyNumber
    * def dummyBatchName = "Test-Automation-" + dummyNumber
    * print dummyBatchName
    #--------------Calling TimeFormat File for Adding TimeStamp Format for the Error ScreenShots----------------
    * def timestamp = Java.type("hqm_Test.utilities.TimeFormat")
    * def formattedTime = timestamp.getFormattedTimestamp()
    #-------------Adding the Path of CalculatePayoutPage where all the Error Sceenshots will store-----------------
    * def screenShotPath = "errorScreenShots/CalculatePayoutPage/"



  @ignore
  @positive_scenario_1
  Scenario: User should access the "CalculatePayout" Page Successfully
    Given waitFor(CPPage_locators.PayoutSection)
    Then waitFor(CPPage_locators.CalculatePayoutSection)
    When waitFor(CPPage_locators.CalculatePayoutPage)
    * assert exists(CPPage_locators.CalculatePayoutPage) ? true : karate.fail("Validation Failed! CalculatePayout Page is not Accessible")
    * def required_Fields =
      """
      exists(CPPage_locators.fieldBatchName) &&
      exists(CPPage_locators.fieldProgramYear) &&
      exists(CPPage_locators.fieldHospital) &&
      exists(CPPage_locators.fieldMeasureGroup) &&
      exists(CPPage_locators.fieldAllocation)
      """
    * print required_Fields
    * assert required_Fields ? true : karate.fail("One or more Fields are Missing! Please check the Elements")
    * print "Validation and Test Case Passed! CalculatePayout Page accessed successfully and Required Fields are Present in the Screen"



  @ignore
  @positive_scenario_2
  Scenario: User should able to Calculate the Measure Contribution using Mapped Hospital and Measure Group with New Batch Name
    Given waitFor(CPPage_locators.PayoutSection)
    Then waitFor(CPPage_locators.CalculatePayoutSection)
    When waitFor(CPPage_locators.CalculatePayoutPage)
    * assert exists(CPPage_locators.CalculatePayoutPage) ? true : karate.fail("Validation Failed! CalculatePayout Page is not Accessible")
    * def required_Fields =
      """
      exists(CPPage_locators.fieldBatchName) &&
      exists(CPPage_locators.fieldProgramYear) &&
      exists(CPPage_locators.fieldHospital) &&
      exists(CPPage_locators.fieldMeasureGroup) &&
      exists(CPPage_locators.fieldAllocation)
      """
    * print required_Fields
    * assert required_Fields ? true : karate.fail("One or more Fields are Missing! Please check the Elements")
    #-----------------------Calculating Measure-Contribution--------------------------------
    * mouse(CPPage_locators.btnAdd).click()
    * delay(2000).waitFor(CPPage_locators.BatchNameSection)
    * input(CPPage_locators.BatchNameSection, dummyBatchName)
    * select(CPPage_locators.YearDropDown, "{}2023")
    * delay(2000).select(CPPage_locators.HospitalDropDown, "{^}Kent")
    * delay(2000).select(CPPage_locators.MeasureGroupDropDown, "{^}HAI")
    * delay(3000).scroll(CPPage_locators.btnCalculateMeasureContribution)
    * click(CPPage_locators.btnCalculateMeasureContribution)
    * assert waitUntil(CPPage_locators.successMSG, "_.innerText.includes('Hospital Payout is successfully calculated')") ? true : karate.log("Instead of Success Message system found this Error Message:- " + text(CPPage_locators.errorMSG))
    * print text(CPPage_locators.successMSG)
    * match text(CPPage_locators.successMSG) contains "Hospital Payout is successfully calculated"
    * print "Validation and Test Case Passed! Measure-Contribution is Successfully Calculated"




  @ignore
  @positive_scenario_3
  Scenario: User should able to Calculate the Measure Contribution for different Measure Groups with Existing Batch Name
            using Mapped Hospital and Year
    Given waitFor(CPPage_locators.PayoutSection)
    Then waitFor(CPPage_locators.CalculatePayoutSection)
    When waitFor(CPPage_locators.CalculatePayoutPage)
    * assert exists(CPPage_locators.CalculatePayoutPage) ? true : karate.fail("Validation Failed! CalculatePayout Page is not Accessible")
    * def required_Fields =
      """
      exists(CPPage_locators.fieldBatchName) &&
      exists(CPPage_locators.fieldProgramYear) &&
      exists(CPPage_locators.fieldHospital) &&
      exists(CPPage_locators.fieldMeasureGroup) &&
      exists(CPPage_locators.fieldAllocation)
      """
    * print required_Fields
    * assert required_Fields ? true : karate.fail("One or more Fields are Missing! Please check the Elements")
    #-----------------------Calculating Measure-Contribution--------------------------------
    * mouse(CPPage_locators.btnAdd).click()
    * delay(2000).waitFor(CPPage_locators.BatchNameSection)
    * input(CPPage_locators.BatchNameSection, dummyBatchName)
    * select(CPPage_locators.YearDropDown, "{}2023")
    * delay(2000).select(CPPage_locators.HospitalDropDown, "{^}Kent")
    * delay(2000).select(CPPage_locators.MeasureGroupDropDown, "{^}HAI")
    * delay(3000).scroll(CPPage_locators.btnCalculateMeasureContribution)
    * click(CPPage_locators.btnCalculateMeasureContribution)
    * assert waitUntil(CPPage_locators.successMSG, "_.innerText.includes('Hospital Payout is successfully calculated')") ? true : karate.log("Instead of Success Message system found this Error Message:- " + text(CPPage_locators.errorMSG))
    * print text(CPPage_locators.successMSG)
    * match text(CPPage_locators.successMSG) contains "Hospital Payout is successfully calculated"
    #--------------------------------Calculating Measure-Contribution with Existing Batch Name------------------------
    * delay(3000).scroll(CPPage_locators.btnCancel)
    * click(CPPage_locators.btnCancel)
    * mouse(CPPage_locators.BatchNameDropDown).click()
    * delay(2000).waitFor(CPPage_locators.BatchNameSearchSection)
    * input(CPPage_locators.BatchNameSearchSection, dummyBatchName)
    * waitFor("//div[contains(text(),'"+dummyBatchName+"')]").click()
    * delay(3000).select(CPPage_locators.MeasureGroupDropDown, "{^}HCAHPS")
    * delay(3000).scroll(CPPage_locators.btnCalculateMeasureContribution)
    * click(CPPage_locators.btnCalculateMeasureContribution)
    * assert waitUntil(CPPage_locators.successMSG, "_.innerText.includes('Hospital Payout is successfully calculated')") ? true : karate.log("Instead of Success Message system found this Error Message:- " + text(CPPage_locators.errorMSG))
    * print text(CPPage_locators.successMSG)
    * match text(CPPage_locators.successMSG) contains "Hospital Payout is successfully calculated"
    * print "Validation and Test Case Passed! Measure-Contribution is Successfully Calculated with Existing Batch Name"



  #@ignore
  @positive_scenario_4
  Scenario: User should able to Verify all the Table Details
    Given waitFor(CPPage_locators.PayoutSection)
    Then waitFor(CPPage_locators.CalculatePayoutSection)
    When waitFor(CPPage_locators.CalculatePayoutPage)
    * assert exists(CPPage_locators.CalculatePayoutPage) ? true : karate.fail("Validation Failed! CalculatePayout Page is not Accessible")
    * def required_Fields =
      """
      exists(CPPage_locators.fieldBatchName) &&
      exists(CPPage_locators.fieldProgramYear) &&
      exists(CPPage_locators.fieldHospital) &&
      exists(CPPage_locators.fieldMeasureGroup) &&
      exists(CPPage_locators.fieldAllocation)
      """
    * print required_Fields
    * assert required_Fields ? true : karate.fail("One or more Fields are Missing! Please check the Elements")
    * mouse(CPPage_locators.btnAdd).click()
    * delay(2000).waitFor(CPPage_locators.BatchNameSection)
    * input(CPPage_locators.BatchNameSection, dummyBatchName)
    * select(CPPage_locators.YearDropDown, "{}2023")
    * delay(2000).select(CPPage_locators.HospitalDropDown, "{^}Kent")
    * delay(2000).select(CPPage_locators.MeasureGroupDropDown, "{^}HAI")
    * def calculateTable = delay(3000).script("return document.querySelector('tbody tr:nth-child(n)').innerText;")
    * print calculateTable



  @ignore
  @negetive_scenario_1
  Scenario: User should able to Indentify the Error Message when duplicate Batch added to the Batch section
    Given waitFor(CPPage_locators.PayoutSection)
    Then waitFor(CPPage_locators.CalculatePayoutSection)
    When waitFor(CPPage_locators.CalculatePayoutPage)
    * assert exists(CPPage_locators.CalculatePayoutPage) ? true : karate.fail("Validation Failed! CalculatePayout Page is not Accessible")
    * def required_Fields =
      """
      exists(CPPage_locators.fieldBatchName) &&
      exists(CPPage_locators.fieldProgramYear) &&
      exists(CPPage_locators.fieldHospital) &&
      exists(CPPage_locators.fieldMeasureGroup) &&
      exists(CPPage_locators.fieldAllocation)
      """
    * print required_Fields
    * assert required_Fields ? true : karate.fail("One or more Fields are Missing! Please check the Elements")
    #-----------------------Calculating Measure-Contribution--------------------------------
    * mouse(CPPage_locators.btnAdd).click()
    * delay(2000).waitFor(CPPage_locators.BatchNameSection)
    * input(CPPage_locators.BatchNameSection, dummyBatchName)
    * select(CPPage_locators.YearDropDown, "{}2023")
    * delay(2000).select(CPPage_locators.HospitalDropDown, "{^}Kent")
    * delay(2000).select(CPPage_locators.MeasureGroupDropDown, "{^}HAI")
    * delay(3000).scroll(CPPage_locators.btnCalculateMeasureContribution)
    * click(CPPage_locators.btnCalculateMeasureContribution)
    * assert waitUntil(CPPage_locators.successMSG, "_.innerText.includes('Hospital Payout is successfully calculated')") ? true : karate.log("Instead of Success Message system found this Error Message:- " + text(CPPage_locators.errorMSG))
    * print text(CPPage_locators.successMSG)
    * match text(CPPage_locators.successMSG) contains "Hospital Payout is successfully calculated"
    #----------------------------Trying to Add a Duplicate Batch Name-----------------------------
    * delay(3000).scroll(CPPage_locators.btnCancel)
    * click(CPPage_locators.btnCancel)
    * mouse(CPPage_locators.btnAdd).click()
    * delay(2000).waitFor(CPPage_locators.BatchNameSection)
    * input(CPPage_locators.BatchNameSection, dummyBatchName)
    * def isErrormsgExists = delay(2000).exists(CPPage_locators.duplicateBatchName)
    * print "Is the Error Message Element Exists" ,isErrormsgExists
    * assert exists(CPPage_locators.duplicateBatchName) ? true : karate.fail("System should throw a Error Message when Invalid Details added to LastName Field")
    * print text(CPPage_locators.duplicateBatchName)
    * script("document.querySelector('.error.text-danger').style.border='3px solid red';")
    * def screenshotName = screenShotPath + 'duplicateBatchName_' + formattedTime + '.png'
    * if(exists(CPPage_locators.duplicateBatchName)) karate.write(screenshot(false), screenshotName)
    * print 'Calulating Measure Contribution with Batch Name Scenario failed! Screenshot is saved in the target folder as:- ', screenshotName
    * print "Validation and Test Case Passed! Calulating Measure Contribution Failed due to Duplicate Batch Name"

