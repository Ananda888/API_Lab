Feature: As a user, I am able to view the details of a vehicle when I specify its registration

  Background:
    Given url baseUrl

    #call csv file
    * def dataFile = read(testDataFile)
    #extract car registration numbersGET_vehicleDetails_usingCSV.feature
    * def carRegos = $dataFile.rego
    #map car rego numbers to their index so karate can loop through the test data
    * def testData = karate.map(carRegos, function(value, index) { return { registrationNumber: value} })

    Scenario Outline: Vehicle details are successfully returned
      Given path '/vehicle/<registrationNumber>/details'
      When method GET
      Then status 200
      Examples:
        | testData |

    Scenario Outline: Incorrect registration number results in no vehicle being found in the system
      Given path '/vehicle/<!registrationNumber>/details'
      When method GET
      Then status 404
      And match response ==
      """
      {
      "message": "#string"
       }
      """

      Examples:
        | testData |

    Scenario: The web server is unable to perform the request
      Given path '/'
      When method GET
      Then status 502



