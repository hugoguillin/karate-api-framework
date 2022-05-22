package helpers;

import com.github.javafaker.Faker;
import net.minidev.json.JSONObject;

public class DataGenerator
{
    public static String getRandomEmail()
    {
        Faker faker = new Faker();
        String email = faker.name().firstName().toLowerCase() + faker.random().nextInt(0, 100) + "@test.com";
        return email;
    }

    public static String getRandomUsername()
    {
        Faker faker = new Faker();
        String username = faker.name().username();
        return username;
    }

    public static JSONObject getRandomArticlesData()
    {
        Faker faker = new Faker();
        String[] tagList = {faker.howIMetYourMother().character()};
        String title = faker.funnyName().name();
        String description = faker.howIMetYourMother().catchPhrase();
        String body = faker.backToTheFuture().quote();
        JSONObject json = new JSONObject();
        json.put("tagList", tagList);
        json.put("title", title);
        json.put("description", description);
        json.put("body", body);
        return json;
    }
}
