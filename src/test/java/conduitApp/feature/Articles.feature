Feature: Articles

    Background: Define URL
        Given url baseUrl
        * def newArticleBody = read('classpath:conduitApp/fixtures/postNewArticle.json')
        * def articleGenerator = Java.type('helpers.DataGenerator')
#       It's possible to change the values of the json object for each request using a random data generator method
        * set newArticleBody.article.title = articleGenerator.getRandomArticlesData().title
        * set newArticleBody.article.tagList = articleGenerator.getRandomArticlesData().tagList
        * set newArticleBody.article.description = articleGenerator.getRandomArticlesData().description
        * set newArticleBody.article.body = articleGenerator.getRandomArticlesData().body

    Scenario: Create a new article
        Given path 'articles'
        And request newArticleBody
#       You can print to the console whatever you need to debug your tests
        * print newArticleBody.article.title
        When method Post
        Then status 200
        And match response.article.title == newArticleBody.article.title


    Scenario: Create and delete an article
        Given path 'articles'
        And request newArticleBody
        When method Post
        Then status 200
        * print newArticleBody.article.title
        * def articleId = response.article.slug

        Given path 'articles'
        When method Get
        Then match response.articles[*].title contains newArticleBody.article.title

        Given path 'articles', articleId
        When method Delete
        Then status 200

        Given path 'articles'
        When method Get
        Then match response.articles[*].title != newArticleBody.article.title

