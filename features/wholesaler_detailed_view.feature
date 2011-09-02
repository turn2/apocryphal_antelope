Feature: Wholesaler Detailed View
  In order to get more detailed information about a wholesaler
  As a VFI Project Manager
  I want to be able to see all the data for a wholesaler at once

  Background:
    Given I am signed in as the VFI project manager

  Scenario: View wholesaler contact information
    Given a wholesaler "Farrah's Faucets" with the following information:
      | Contact name | Phone          | Email                | Street address  | City     | State | Postal code |
      | Dr. Spaceman | (313) 555-1212 | spaceman@faucets.com | 123 Main Street | New York | NY    | 12345       |
    When I go to the wholesaler page for "Farrah's Faucets"
    Then I should see the following: 
      """
      Dr. Spaceman
      (313) 555-1212
      spaceman@faucets.com
      123 Main Street
      New York
      New York
      12345
      """

  Scenario: View all tasks for one wholesaler
    Given the following task templates are created:
      | Title                      | Due week |
      | Contact Wholesaler         | 1        |
      | Conduct followup interview | 10       |
    And a wholesaler "Farrah's Faucets"
    When I go to the wholesaler page for "Farrah's Faucets"
    Then I should see the following:
      """
      Contact Wholesaler
      Conduct followup interview
      """
  
  @backlog
  Scenario: Urgent tasks listed first
  
  @backlog
  Scenario: Incomplete tasks listed before complete tasks
    When I click on the name of a wholesaler on the wholesaler dashboard
    Then I should be able to see all of the tasks for that wholesaler
    And the outstanding ones should be on top
    And the completed ones should be on the bottom
    And the tasks should be color-coded based on how soon they're due
    And the tasks should have all of the information that's available on the task dashboard

  Scenario: Assign wholesaler to a PR Region
    Given a wholesaler "Farrah's Faucets"
    And a region "North by Northwest"
    When I go to the edit page for the wholesaler "Farrah's Faucets"
    And I select "North by Northwest" from "PR Region"
    And I press "Update wholesaler"
    And I go to the page for the region "North by Northwest"
    Then I should see "Farrah's Faucets"

  Scenario: Viewing a wholesalers' media contacts
    Given a wholesaler "Joe's Wholesaler"
    And a region "South"
    And the following media outlets belong to "South":
      | Media outlet name |
      | DCT               |
      | 101.4             |
    And the wholesaler "Joe's Wholesaler" belongs to the "South" region
    When I go to the wholesaler page for "Joe's Wholesaler"
    Then I should see "DCT"
    And I should see "101.4"
