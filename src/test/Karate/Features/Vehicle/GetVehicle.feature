Feature: As a user, I am able to view the details of a vehicle when I specify its registration

  Background:
    Given url 'http://localhost:8500'
    And path 'data/regos'
    When method GET
    Then status 200
    * def values = response.data
    * def data = karate.map(values, function(value, index) { return { registrationNumber: value} })

    Scenario Outline: Vehicle details are successfully returned
      Given path '/vehicle/<registrationNumber>/details'
      When method GET
      Then status 200
      Examples:
        | data |



    Scenario Outline: Incorrect registration number results in no vehicle being found in the system
      Given path '/vehicle/<!registrationNumber>/details'
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

    Scenario: The web server is unable to perform the request
      Given path '/'
      When method GET
      Then status 502



