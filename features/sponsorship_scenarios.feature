Feature: Sponsors
  In order to modify sponsorship connections as needed
  I want to be able to add sponsors to a given consultant

  Scenario: add a consultant
    Given there is a consultant named "Sophie" with employee ID "99991"
    Given there is a consultant named "Mridula" with employee ID "99992"
    Given I am on the consultant page for employee ID "99991"
    When I click on the sponsorship tab
    And I add "Mridula" as a new sponsee
    Then I should see "Mridula" show up as a sponsee on the page
