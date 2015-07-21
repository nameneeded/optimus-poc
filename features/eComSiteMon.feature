Feature: Site Monitoring
  Scenario: Page Loads
    Given That I am testing BestBuy
    When I test remotely
    And I time the main page
    And I time the sign-in page
    And I time sign-in as a registered user
    And I time complete sign-in as a registered user
    And I do a search for Go Pro Hero
    Then I write the results to the results file