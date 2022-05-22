Feature: Sing up new user
    
    Background: Precondition
#       Reading a helper .java class
        * def dataGenerator = Java.type('helpers.DataGenerator')
        * def randomEmail = dataGenerator.getRandomEmail()
        * def randomUsername = dataGenerator.getRandomUsername()
        Given url baseUrl
        
    Scenario: New user sing up
        Given path 'users'
        And request
        """
            {
                user: {
                    email: #(randomEmail),
                    username: #(randomUsername),
                    password: "karate"
                }
            }
        """
        When method Post
        Then status 200
        And match response ==
        """
            {
                "user": {
                    "email": #(randomEmail),
                    "username": #(randomUsername),
                    "bio": null,
                    "image": null,
                    "token": "#string"
                }
            }
        """

    Scenario: Sign up with existing email fails with appropriate error message
        Given path 'users'
#       The "userEmail" parameter is set in the "karate-config.js" file at a global level.
        And request
        """
            {
                user: {
                    email: #(userEmail),
                    username: #(randomUsername),
                    password: "karate"
                }
            }
        """
        When method Post
        Then status 422
        And match response.errors.email contains "has already been taken"

    Scenario: Sign up with existing username fails with appropriate error message
        Given path 'users'
#       The userName (set in karate-config.js) is the one I used when signed up. You should change it for yours.
        And request
        """
            {
                user: {
                    email: #(randomEmail),
                    username: #(userName),
                    password: "karate"
                }
            }
        """
        When method Post
        Then status 422
        And match response.errors.username contains "has already been taken"

#   This is the way of creating a Data Driven Scenario. This one replaces the two previous ones.
    Scenario Outline: Validate sign up error messages
        Given path 'users'
        And request
        """
            {
                user: {
                    email: "<email>",
                    username: "<username>",
                    password: "<password>"
                }
            }
        """
        When method Post
        Then status <errorStatus>
        And match response == <errorMessage>

#       The userName "karatehugo" is the one I used when signed up. You should change it for yours.
#       There seems to be a little bug in the app, since the response when an invalid email is sent is not appropriate
        Examples:
            | email          | password    | username          | errorStatus | errorMessage                                       |
            | #(userEmail)   | #(userPass) | #(randomUsername) | 422         | {"errors":{"email":["has already been taken"]}}    |
            | #(randomEmail) | #(userPass) | #(userName)       | 422         | {"errors":{"username":["has already been taken"]}} |
            | email          | #(userPass) | #(randomUsername) | 422         | {"errors":{"email":["has already been taken"]}}    |
            |                | #(userPass) | #(randomUsername) | 422         | {"errors":{"email":["can't be blank"]}}            |
            | #(randomEmail) |             | #(randomUsername) | 422         | {"errors":{"password":["can't be blank"]}}         |
            | #(randomEmail) | #(userPass) |                   | 422         | {"errors":{"username":["can't be blank"]}}         |