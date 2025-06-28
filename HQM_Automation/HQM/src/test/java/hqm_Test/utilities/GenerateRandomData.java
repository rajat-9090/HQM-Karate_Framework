package hqm_Test.utilities;

import net.datafaker.Faker;

import java.util.Locale;

public class GenerateRandomData {


    static Faker faker = new Faker(new Locale("en-US"));

    public static String getRandomInteger(int size) {

        return faker.number().digits(size);
    }

    public static String getRandomFirstName() {

        return faker.name().firstName();
    }

    public static String getRandomLastName() {

        return faker.name().lastName();
    }

    public static String getRandomEmail() {

        return faker.internet().emailAddress();
    }

    public static String getRandomUserName() {

        return faker.name().username();
    }

    public static String getRandomCompanyName() {

        return faker.company().name();
    }
}
