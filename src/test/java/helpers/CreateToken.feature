Feature: Articles

    Scenario: Create token
        Given url baseUrl
        Given path 'users/login'
        And request {"user": {email: "#(userEmail)", password: "#(userPass)"}}
        When method Post
        Then status 200
        * def authToken = response.user.token
