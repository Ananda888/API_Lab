Feature: Get vehicle details - from source
  Background:

    Given url 'http://localhost:8500'
    And path 'data/regos'
    When method GET
    Then status 200
    * def values = response.data
    * def data = karate.map(values, function(value, index) { return { registrationNumber: value} })


    Scenario Outline: 200 response from data source
      Given path '/data/<registrationNumber>'
      When method GET
      Then status 200
      Examples:
        | data |

    Scenario Outline: 404 response
      Given path '/data/<!registrationNumber>'
      When method GET
      Then status 404
      And match response ==
      """
      {
      "message": "No vehicle found!"
       }
      """
      Examples:
        | data |

    Scenario: 502 response
      Given path '/'
      When method GET
      Then status 502

