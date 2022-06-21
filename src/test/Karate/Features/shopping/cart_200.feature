#Feature: Shopping Cart #describe functionality like a user story
#
#  Background:
#    Given url 'http://localhost:8500'
#
#  Scenario: Obtain 200 response
#    Given header Client-id = "DPE-QE"
#    And path '/shoppingcart/items'
#    And param Type = "Fresh"
#    And param Discount = "Applied"
#    When method GET
#    Then status 200
#    And match response ==
#    """
#    {
#    "basket": [
#        {
#              "name": "Milk",
#              "quantity": "2",
#              "price": "$4"
#        },
#        {
#              "name": "Bread",
#              "quantity": "1",
#              "price": "$5"
#        },
#        {
#              "name": "Eggs",
#              "quantity": "1",
#              "price": "$6.5"
#        }
#               ]
#    }
#
#    """
#
#  Scenario: User cannot view shopping cart items because client-id is missing or invalid
#    Given header Client-id = "DPE"
#    And path '/shoppingcart/items'
#    And param Type = "Fresh"
#    And param Discount = "Applied"
#    When method GET
#    Then status 401
#    And match response ==
#      """
#      { "message": "Unauthorized request! Client-Id is missing or invalid."}
#
#      """
#
#  Scenario: User cannot view shopping cart items because parameters are missing or invalid
#    Given header Client-id = "DPE-QE"
#    And path '/shoppingcart/items'
#    And param Type = !"Fresh"
#    And param Discount = !"Applied"
#    When method GET
#    Then status 400
#    And match response ==
#
#      """
#      {
#         "message": "Invalid request! Parameters are missing or invalid."
#      }
#
#      """
#
#
#  Scenario: Web server is unable to perform request
#
#    Given header Client-id = "DPE-QE"
#    And path '/'
#    And param Type = "Fresh"
#    And param Discount = "Applied"
#    When method GET
#    Then status 502
