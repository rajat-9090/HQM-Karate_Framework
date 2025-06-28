package hqm_Test.testModule;

import com.intuit.karate.junit5.Karate;
import org.junit.jupiter.api.RepeatedTest;

public class HQMTestRunner {


//    @RepeatedTest(2)
    @Karate.Test
    Karate Verify_LoginPage() {

        return Karate.run("classpath:hqm_Test/testModule/LoginPage.feature");
    }

//    @RepeatedTest(2)
    @Karate.Test
    Karate Verify_UserPage() {

        return Karate.run("classpath:hqm_Test/testModule/Administration-UserPage.feature");
    }

//    @RepeatedTest(2)
    @Karate.Test
    Karate Verify_AddGroupSystemPage() {

        return Karate.run("classpath:hqm_Test/testModule/Supersets-Hospital_Group_System.feature");
    }



    @Karate.Test
    Karate Verify_AddHospitalPage() {

        return Karate.run("classpath:hqm_Test/testModule/Supersets-Hospital.feature");
    }


    @Karate.Test
    Karate Verify_AddMeasureGroupPage() {

        return Karate.run("classpath:hqm_Test/testModule/Supersets-Measure_Group.feature");
    }


    @Karate.Test
    Karate Verify_AddMeasureIDPage() {

        return Karate.run("classpath:hqm_Test/testModule/Supersets-MeasureID.feature");
    }


    @Karate.Test
    Karate Verify_CalculatePayoutPage() {

        return Karate.run("classpath:hqm_Test/testModule/Payout-CalculatePayout.feature");
    }



}
