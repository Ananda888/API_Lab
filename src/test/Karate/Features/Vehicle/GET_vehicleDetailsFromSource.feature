Feature: As a user, I am able to view the details of a vehicle from its data source when I specify its registration
  Background:

    Given url 'http://localhost:8500'
    And path 'data/regos'
    When method GET
    Then status 200
    * def values = response.data
    * def data = karate.map(values, function(value, index) { return { registrationNumber: value} })


    Scenario Outline: Vehicle details are successfully returned to the user
      Given path '/data/<registrationNumber>'
      When method GET
      Then status 200
      Examples:
        | data |

#    Scenario Outline: 404 response
#      Given path '/data/<!registrationNumber>'
#      When method GET
#      Then status 404
#      And match response ==
#      """
#      {
#      "message": "No vehicle found!"
#       }
#      """
#      Examples:
#        | data |
#
#    Scenario: 502 response
#      Given path '/'
#      When method GET
#      Then status 502

