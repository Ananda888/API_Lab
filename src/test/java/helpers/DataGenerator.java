package helpers;
import com.github.javafaker.Faker;
import com.oracle.truffle.js.runtime.builtins.JSON;

import java.util.Date;


public class DataGenerator{

    public String getRandomEmail() {
        Faker faker = new Faker();
        String email = faker.name().firstName().toLowerCase() + faker.random().nextInt(0, 100) + "@test.com";
        return email;

    }

    public String getRandomFirstName() {
        Faker faker = new Faker();
        String FirstName = faker.name().firstName();
        return FirstName;
    }

    public String getRandomLastName() {
        Faker faker = new Faker();
        String LastName = faker.name().lastName();
        return LastName;
    }

    public String getRandomNationality() {
        Faker faker = new Faker();
        String nationality = faker.nation().nationality();
        return nationality;
    }

    public String getRandomdoB() {
        Faker faker = new Faker();
        String doB = String.valueOf(faker.date().birthday());
        return doB;
    }

    public String getRandomMobile() {
        Faker faker = new Faker();
        String mobile = faker.phoneNumber().phoneNumber();
        return mobile;
    }

    public String getRandomEmailOnce() {
        Faker faker = new Faker();
        String email = faker.name().firstName().toLowerCase() + faker.random().nextInt(0, 100) + "@test.com";
        return email;

    }

}


