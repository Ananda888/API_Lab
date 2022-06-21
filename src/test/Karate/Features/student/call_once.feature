Feature: Call random details function only once
  Background:

    Given def new_student = call read('classpath:Features/student/token.feature@200Response')
    And def auth_token = new_student.auth_token
    * def randomDetails = call read('classpath:Features/student/Instance.feature')
    * def userDetails = randomDetails.inputDetails
    Given url 'http://localhost:8500'
    Given path '/student/create'

  Scenario: Get random details to run on one instance








