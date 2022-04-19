Feature: View all students
  Background:

    * def students = call read('classpath:Features/student/CreateStudent.feature@201Response')
    * def auth_token = students.auth_token
    * def studentDetails = students.studentDetails
    * def student_ID = students.student_ID

    Given url 'http://localhost:8500'


    Scenario: 200 response
      Given header Client-Id = !null
      Given header Authorization = auth_token
      And path '/students'
      When method GET
      Then status 200

      * def studentDetails = students.studentDetails
      * def studentDetailsJSON =
    """
    function()
    {
    var convert = JSON.parse(studentDetails)
    return convert
    }
    """
      * def studentDetails = studentDetailsJSON()
      And match response.students contains
    """
   {
       "id": #(student_ID),
       "firstName": #(studentDetails.firstName),
       "lastName": #(studentDetails.lastName),
       "nationality": #(studentDetails.nationality),
       "dateOfBirth": #(studentDetails.dateOfBirth),
       "email": #(studentDetails.email),
       "mobileNumber": #(studentDetails.mobileNumber)

}
    """



    Scenario: 401 response - Invalid Client-Id
      Given header Client-Id = null
      Given header Authorization = auth_token
      And path '/students'
      When method GET
      Then status 401

      And match response ==
      """
        {
    "message": "Unauthorized request."
}
      """

    Scenario: 401 response - Invalid token
      Given header Client-Id = !null
      Given header Authorization = !auth_token
      And path '/students'
      When method GET
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
      And path '/'
      When method GET
      Then status 502

