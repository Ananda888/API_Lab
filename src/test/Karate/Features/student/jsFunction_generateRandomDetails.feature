Feature: As an API tester, I want different student details to be input as the request body each time I call the create student API

  @callOnce
  Scenario: Generate unique student details
    * def jsFunction =
    """
      function() {
      var DataGenerator = Java.type('helpers.StudentDetailsGenerator')
      var generator = new DataGenerator()

      var userDetails = {
     "firstName": generator.getRandomFirstName(),
     "lastName": generator.getRandomLastName(),
     "nationality": generator.getRandomNationality(),
     "dateOfBirth": generator.getRandomdoB(),
     "email": generator.getRandomEmailOnce(),
     "mobileNumber": generator.getRandomMobile()
     }
     var userDetailsJSON = JSON.stringify(userDetails)
     return userDetailsJSON
      }
    """
    * def randomDetails = call jsFunction
    * def inputDetails = randomDetails








