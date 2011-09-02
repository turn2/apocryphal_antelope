Feature: Prospect Management
  In order to quickly respond to people who may want to buy our products
  As a VFI Project Manager
  I need to be able to view and update information for those prospects

  Background: 
    Given there are 3 prospects
    And I am signed in as the VFI project manager

  Scenario: Viewing the list of prospects
    When I go to the prospects page
    Then I should see those prospects

  Scenario: Exporting a csv of the prospects
    When I go to the prospects page
    And I follow "Export Subscriber List"
    Then I should receive a csv with all the prospects

  Scenario: Updating a prospect's information
    When I go to the edit page for a prospect
    Then I should be able to update their opt-in status
