Feature: View student details
  Background:

  #* def new_student = call read('classpath:Features/student/token.feature@200Response')
  #* def create_student_feature = call read('classpath:Features/student/CreateStudent.feature')

  * def createdStudent = call read('classpath:Features/student/CreateStudent.feature@201Response')

  * def auth_token = createdStudent.student_token
  * def student_ID = createdStudent.student_ID


  Given url 'http://localhost:8500'



  Scenario: 200 response
    Given path '/student/' + student_ID + '/details'
    Given header Client-Id = !null
    And header Authorization = auth_token

    When method GET
    Then status 200
    * def studentDetails = createdStudent.studentDetails
    * def studentDetailsJSON =
    """
    function()
    {
    var convert = JSON.parse(studentDetails)
    return convert
    }
    """
    * def studentDetails = studentDetailsJSON()
    And match response ==
    """
   {
  "data": {
       "id": #(student_ID),
       "firstName": #(studentDetails.firstName),
       "lastName": #(studentDetails.lastName),
       "nationality": #(studentDetails.nationality),
       "dateOfBirth": #(studentDetails.dateOfBirth),
       "email": #(studentDetails.email),
       "mobileNumber": #(studentDetails.mobileNumber)
  }
}
    """




  Scenario: 401 response - invalid Client-Id
    Given path '/student/' + student_ID + '/details'
    Given header Client-Id = null
    And header Authorization = auth_token

    When method GET
    Then status 401
    And match response ==
    """
    {
    "message": "Unauthorized request."
}
    """



  Scenario: 401 response - invalid token
    Given path '/student/' + student_ID + '/details'
    Given header Client-Id = !null
    And header Authorization = !auth_token


    When method GET
    Then status 401
    And match response ==
    """
    {
    "message": "Unauthorized request."
}
    """



    Scenario: 404 response
      Given path '/student/' + !student_ID + '/details'
      Given header Client-ID = !null
      And header Authorization = auth_token
      When method GET
      Then status 404

      And match response ==
    """
    {
    "message": "No student found!"
}
    """



    Scenario: 502 response
      Given header Client-Id = !null
      Given header Authorization = !auth_token
      And path '/'
      When method GET
      Then status 502






