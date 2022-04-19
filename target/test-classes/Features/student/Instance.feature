Feature: One instance of an email generation
  Scenario: Call email once
    * def jsFunction =
    """
      function() {
      var DataGenerator = Java.type('helpers.DataGenerator')
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
    * print inputDetails








