Feature: Test for the home page

  Background: Define URL
      Given url baseUrl

  Scenario: Get all tags
      Given path 'tags'
      When method Get
      Then status 200
      And match response.tags contains ['welcome', 'codebaseShow']
      And match response.tags !contains 'hello'
  #   Fuzzy matching: https://karatelabs.github.io/karate/#fuzzy-matching
      And match response.tags == '#array'
      And match each response.tags == '#string'

  Scenario: Get articles from the page
      * def isValidDateFormat = read('classpath:helpers/TimeValidator.js')

  #   params is where query params are specified
      Given params {limit: 10, offset: 0}
      Given path 'articles'
      When method Get
      Then status 200
  #   #[number] is the way of checking the length of the array
      And match response.articles == '#[5]'
      And match response.articlesCount == "#number"
#     ##string (with 2#) means that the field type may be null or string. Also may mean this field is optional in the response
      And match response.author[*].bio == '##string'
#     Schema validation. Implementation examples: https://github.com/karatelabs/karate/tree/master/karate-junit4/src/test/java/com/intuit/karate/junit4/demos
      And match each response.articles ==
      """
        {
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
      """
