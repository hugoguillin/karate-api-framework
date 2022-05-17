Feature: Sing up new user
    
    Background: Precondition
        Given url baseUrl
        
    Scenario: New user sing up
        Given def userData = {email: "someuserñ@karate.com", username: "someuserñ"}
        Given path 'users'
        And request
        """
            {
                user: {
                    email: #(userData.email),
                    username: #(userData.username),
                    password: "karate"
                }
            }
        """
        When method Post
        Then status 200