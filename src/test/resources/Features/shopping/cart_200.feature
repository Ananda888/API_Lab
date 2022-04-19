Feature: Shopping Cart
  Background:
    Given url 'http://localhost:8500'

  Scenario: Obtain 200 response
    Given header Client-id = "DPE-QE"
    And path '/shoppingcart/items'
    And param Type = "Fresh"
    And param Discount = "Applied"
    When method GET
    Then status 200
    And match response ==
    """
    {
    "basket": [
        {
              "name": "Milk",
              "quantity": "2",
              "price": "$4"
        },
        {
              "name": "Bread",
              "quantity": "1",
              "price": "$5"
        },
        {
              "name": "Eggs",
              "quantity": "1",
              "price": "$6.5"
        }
 ]
    }

    """
    Scenario: Obtain 401 response
      Given header Client-id = !"DPE-QE"
      And path '/shoppingcart/items'
      And param Type = "Fresh"
      And param Discount = "Applied"
      When method GET
      Then status 401
      And match response ==
      """
      { "message": "Unauthorized request! Client-Id is missing or invalid."}

      """
    Scenario: Obtain 400 response

      Given header Client-id = "DPE-QE"
      And path '/shoppingcart/items'
      And param Type = !"Fresh"
      And param Discount = !"Applied"
      When method GET
      Then status 400
      And match response ==

      """
      {
         "message": "Invalid request! Parameters are missing or invalid."
      }

      """


    Scenario: Obtain 502 response

      Given header Client-id = "DPE-QE"
      And path '/'
      And param Type = "Fresh"
      And param Discount = "Applied"
      When method GET
      Then status 502
