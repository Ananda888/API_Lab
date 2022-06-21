#When there are the details of vehicle,
# the data returning from the response must be correct,
# and the field mappings follow data mapping table.
# This should be done for every element within the Test data automatically.

  Feature: As a user, I am able to verify that the vehicle data obtained when I request it matches the vehicle data from its source
    Background:
      Given url 'http://localhost:8500'
      And path 'data/regos'
      When method GET
      Then status 200
      * def values = response.data
      * def data = karate.map(values, function(value, index) { return { registrationNumber: value} })
      * def convertedDate =
    Scenario Outline: Validate that the response vehicle details matches the source data vehicle details

      Given path '/data/<registrationNumber>/details'
      When method GET
      Then status 200
      * def source_data = response
      * def dob_source = $response.owner[*].dob

      Given path '/vehicle/<registrationNumber>/details'
      When method GET
      Then status 200

      * def response_data = response
      * print response_data
      * def convertedDate = call read('jsFunction_convertDateFormat.feature')
      * def responseDoB = convertedDate.dateConvert(response_data)
      * print responseDoB


      And match response_data.data.vehicle.year == source_data.year
      And match response_data.data.vehicle.make == source_data.make
      And match response_data.data.vehicle.model == source_data.model
      And match response_data.data.vehicle.transmission == source_data.transmission
      And match response_data.data.vehicle.odometer == source_data.odometer
      And match response_data.data.registration.registrationNumber == source_data.rego
      And match response_data.data.registration.address[*].addressType == $source_data.addressModel[*].addressType
      And match response_data.data.registration.address[*].addressLine1 == $source_data.addressModel[*].address1
      And match response_data.data.registration.address[*].addressLine2 == $source_data.addressModel[*].address2
      And match response_data.data.registration.address[*].state == $source_data.addressModel[*].state
      And match response_data.data.registration.address[*].country == $source_data.addressModel[*].country
      And match response_data.data.owner[*].fullName == $source_data.owner[*]fullName
      And match response_data.data.owner[*].driverLicense == $source_data.owner[*].license
      And match response_data.data.owner[*].isCurrentOwner == $source_data.owner[*].isCurrentOwner
      And match responseDoB[*].dateOfBirth == $source_data.owner[*].dob


      Examples:
        | data |












