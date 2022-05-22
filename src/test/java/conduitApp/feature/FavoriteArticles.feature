Feature: Favorite articles

    Background: Precondition
        * url baseUrl

    Scenario: Fav an article and changes are saved
        * def isValidDateFormat = read('classpath:helpers/TimeValidator.js')

        Given path 'articles'
        And method Get
        * def favoritesCount = response.articles[0].favoritesCount
        * def firstFavArticleId = response.articles[0].slug

        Given path 'articles', firstFavArticleId, 'favorite'
        When method Post
        Then status 200
        And match response.article.favoritesCount == favoritesCount + 1
        And match response ==
        """
            {
                "article": {
                    "slug": "#string",
                    "title": "#string",
                    "description": "#string",
                    "body": "#string",
                    "tagList": "#array",
                    "createdAt": "#? isValidDateFormat(_)",
                    "updatedAt": "#? isValidDateFormat(_)",
                    "favorited": "#boolean",
                    "favoritesCount": "#number",
                    "author": {
                        "username": "#string",
                        "bio": "##string",
                        "image": "#string",
                        "following": "#boolean"
                    }
                }
            }
        """
        Given params {"favorited": #(userName)}
        Given path 'articles'
        When method Get
        Then match response.articlesCount == 1
        And match response.articles[*].slug contains firstFavArticleId

#       Clean up (the same user can only fav the same article once)
        Given path 'articles', firstFavArticleId, 'favorite'
        When method Delete
        Then status 200