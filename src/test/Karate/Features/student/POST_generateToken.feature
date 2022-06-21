Feature: As a user, I require an authentication token to be able to interact with the student system

  Background:

    Given url baseUrl
    And path '/token'
    * def clientID = !null
    Given header Client-Id = clientID

  @200Response
  Scenario: Token is created successfully


    Given request {"key": "quality-engineering"}
    When method POST
    Then status 200


    And match response ==

    """

    {
    "token": "#string"
    }
    """
    * def auth_token = response["token"]


  Scenario: Token cannot be created due to incorrect request parameters

    Given request {"key": "quality-enggineering"}
    When method POST
    Then status 400
    And match response ==

    """
    {
      "error": "Invalid key!"
    }
    """

  Scenario: The web server cannot perform the request
    Given path '/'
    Given request {"key": "quality-engineering"}
    When method POST
    Then status 502




