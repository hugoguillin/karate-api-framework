Feature: Articles

    Background: Define URL
        Given url baseUrl

    Scenario: Create a new article
        Given path 'articles'
        And request {article: {tagList: ["test", "pruebas"],title: "A title",description: "Article created from IDE",body: "Let's see if this works"}}
        When method Post
        Then status 200
        And match response.article.title == 'A title'

        * def articleTitle = response.article.slug

    Scenario: Create and delete an article
        Given path 'articles'
        And request {article: {tagList: ["deletion", "borrado"],title: "An article to delete",description: "Article created from IDE",body: "Let's see if this works"}}
        When method Post
        Then status 200
        * def articleId = response.article.slug

        Given path 'articles'
        When method Get
        Then match response.articles[*].title contains 'An article to delete'

        Given path 'articles', articleId
        When method Delete
        Then status 204

        Given path 'articles'
        When method Get
        Then match response.articles[*].title != "An article to delete"

