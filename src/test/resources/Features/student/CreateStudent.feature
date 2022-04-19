
Feature: Create new student
  Background:

    * def new_student = call read('classpath:Features/student/token.feature@200Response')
    * def auth_token = new_student.auth_token
    And def randomDetails = callonce read('classpath:Features/student/Instance.feature')
    And def userDetails = randomDetails.inputDetails

    Given url 'http://localhost:8500'
    Given path '/student/create'

    #And header Client-Id = client_id



  @201Response
  Scenario: 201 response
    Given header Client-Id = !null
    And header Authorization = auth_token

    Given request userDetails
    When method POST
    Then status 201
    * def student_ID = response["id"]
    * def student_token = auth_token
    * print student_token

    And match response ==
    """
    {

    "id": "#string",
    "message": "New student was created successfully!"
    }
    """
    * def studentDetails = userDetails


  Scenario: 400 response
    Given header Client-Id = !null
    And header Authorization = auth_token
    Given request userDetails
    When method POST
    Then status 400
      And match response ==
    """
        {

    "message": "ERROR! Student exists!"
}

    """
    Scenario: Missing or invalid client id

      Given header Client-Id = null
      And header Authorization = auth_token
      Given header Client-Id = null
      And request userDetails
      When method POST
      Then status 401
      And match response ==
    """
        {
    "message": "Unauthorized request."
}

    """

  Scenario: Invalid token
    Given header Client-Id = !null
    And header Authorization = !auth_token

    And request userDetails
    When method POST
    Then status 401
    And match response ==
    """
        {
    "message": "Unauthorized request."
}

    """

  Scenario: 502 response
    Given header Client-Id = !null
    Given header Authorization = auth_token
    And request !userDetails
    And path '/student/create'
    When method GET
    Then status 502

