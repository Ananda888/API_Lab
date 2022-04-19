Feature: Create token
  Background:

    Given url 'http://localhost:8500'
    And path '/token'
    * def clientID = !null
    Given header Client-Id = clientID

  @200Response
  Scenario: 200 Response


    Given request {"key": "quality-engineering"}
    When method POST
    Then status 200

    * def auth_token = response["token"]
    And match response ==

    """

    {
    "token": "#string"
    }
    """


  Scenario: 400 response

    Given request {"key": !"quality-engineering"}
    When method POST
    Then status 400
    And match response ==

    """
    {
      "error": "Invalid key!"
    }
    """




