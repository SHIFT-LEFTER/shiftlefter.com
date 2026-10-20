Feature: Checkout

  Scenario: Buy a widget
    Given I am logged in as a shopper
    When I add a widget to my cart
    And I check out
    Then I should see my order number
