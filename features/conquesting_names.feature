Feature: Conquesting names
  In order to be entered in the promotion raffle
  As a wholesaler participating in the event
  I want to get plumber names and addresses back to VFI

  Background:
    Given a wholesaler "Joe's Wholesaler"
    And I am signed in with the account for the wholesaler "Joe's Wholesaler"

  Scenario: Enter conquesting information
    Given I go to my dashboard
    And I follow "Enter Conquest Plumbers"
    When I enter information for a plumber from my event
    And I press "Submit"
    Then I should see "Data received"
    And the plumber conquest should be attributed to "Joe's Wholesaler"
