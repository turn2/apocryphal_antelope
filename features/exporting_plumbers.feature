Feature: Exporting Conquest Data
  As someone running and hoping for a successful event
  In order to drum up excitement for the event
  I want to be able to contact plumbers that wholesalers 
     have indicated they'd like to invite

  Background: Some conquest data exists
    Given a wholesaler "Joe's Wholesaler"
    And wholesaler "Joe's Wholesaler" has the following plumbers:
      | Contact Name | Company           |
      | Steve Snabb  | We Fix It         |
      | Marty Fowler | Plumbing Patterns |
    And I am signed in as the VFI project manager

  Scenario: Exporting a list of plumbers for a wholesaler
    Given I go to the wholesaler page for "Joe's Wholesaler"
    And I follow "Conquest Data"
    When I follow "Download"
    Then I should receive a csv of the plumbers

  Scenario: Plumbers marked as exported after being exported
    Given I download the plumbers for "Joe's Wholesaler"
    And I see that the plumbers have not been previously exported
    When I download the plumbers for "Joe's Wholesaler"
    Then I should see that the plumbers have been previously exported
