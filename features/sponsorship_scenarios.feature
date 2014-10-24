Feature: Sponsors
  In order to modify sponsorship connections as needed
  I want to be able to add sponsors to a given consultant

  Background: consultants
    Given there is a consultant named "Sophie" with employee ID "99991"
    Given there is a consultant named "Mridula" with employee ID "99992"

  Scenario: add a consultant
    Given I am on the consultant page for employee ID "99991"
    When I click on the sponsorship tab
    And I add "Mridula" as a new sponsee
    Then I should see "Mridula" show up as a sponsee on the page

  Scenario: show an error if I add a consultant that doesnt exist
    Given I am on the consultant page for employee ID "99991"
    When I click on the sponsorship tab
    And I add "Derek" as a new sponsee
    Then I should see an error on the page

  Scenario: show an error if I add a blank consultant name
    Given I am on the consultant page for employee ID "99991"
    When I click on the sponsorship tab
    And I add "" as a new sponsee
    Then I should see an error on the page

  Scenario: delete a consultant
    Given there is a sponsorship between employee IDs "99992" and "99991"
    Given I am on the consultant page for employee ID "99992"
    When I click on the sponsorship tab
    Then I should see "Sophie" in the list of sponsees
    And I remove the first sponsee on their list of sponsees
    Then I should not see "Sophie" in the list of sponsees
