Feature: As a user, I am able to view all students
  Background:

    * def students = call read('CreateStudent.feature@201Response')
    * def auth_token = students.auth_token
    * def studentDetails = students.studentDetails
    * def student_ID = students.student_ID

    Given url 'http://localhost:8500'


    Scenario: Student details are returned to the user successfully
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



    Scenario: Access to student details is unauthorised due to invalid Client Id
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

    Scenario: Access to student details is unauthorised due to invalid token
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

  Scenario: Web server is unable to make the request to view all students
      Given header Client-Id = !null
      Given header Authorization = auth_token
      And path '/'
      When method GET
      Then status 502

