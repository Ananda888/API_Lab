
Feature: As a user, I am able to create a new student in the system by specifying their details
  Background:

    * def new_student = call read('POST_generateToken.feature@200Response')
    * def auth_token = new_student.auth_token
    * def randomDetails = callonce read('jsFunction_generateEmailOnce.feature@callOnce')
    * def userDetails = randomDetails.inputDetails

    Given url baseUrl
    Given path '/student/create'
  @201Response
  Scenario: New student is successfully created
    Given header Client-Id = !null
    And header Authorization = auth_token

    Given request userDetails
    When method POST
    Then status 201
    * def student_ID = response["id"]
    * def student_token = auth_token
    And match response ==
    """
    {
    "id": "#string",
    "message": "#string"
    }
    """
    * def studentDetails = userDetails






#  Scenario: Student cannot be created because they are already in the system
#    Given header Client-Id = !null
#    And header Authorization = auth_token
#    Given request userDetails
#    When method POST
#    Then status 400
#    And match response ==
#    """
#        {
#
#    "message": "ERROR! Student exists!"
#}
#
#    """
#    Scenario: Student cannot be created because the client id is invalid or missing
#
#      Given header Client-Id = null
#      And header Authorization = auth_token
#      And request userDetails
#      When method POST
#      Then status 401
#      And match response ==
#    """
#        {
#    "message": "Unauthorized request."
#}
#
#    """
#
#  Scenario: Student cannot be created because the token is invalid or missing
#    Given header Client-Id = !null
#    And header Authorization = !auth_token
#
#    And request userDetails
#    When method POST
#    Then status 401
#    And match response ==
#    """
#        {
#    "message": "Unauthorized request."
#}
#
#    """
#
#  Scenario: The web server is unable to perform the request
#    Given header Client-Id = !null
#    Given header Authorization = auth_token
#    And request !userDetails
#    And path '/student/create'
#    When method GET
#    Then status 502
#
