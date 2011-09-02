Feature: Task Detailed View
  In order to see all of the data and follow-ups for a given task
  As a VFI Project Manager
  I want to be able to view a page just for a specific task

  Background:
    Given I am signed in as the VFI project manager
    And the following tasks exist:
      | Title              | Description          | Wholesaler       | Due Date  |
      | Contact Wholesaler | Make initial contact | Joe's Wholesaler | 3/14/2010  |   

  Scenario: View detailed task information
    When I am on the "Contact Wholesaler" task page
    Then I should see "Make initial contact"
    And I should see "Incomplete"

  Scenario: Edit a task
    Given I am on the "Contact Wholesaler" task page
    When I select "April 13, 2010" as the "Due date" date
    And I press "Update"
    Then I should see "Successfully updated!"
    And the selected date for "task[due_date]" should be "April 13, 2010"
 
  Scenario: View Task Follow-Ups
    Given the "Contact Wholesaler" task has a follow-up "Call back Thursday"
    When I am on the "Contact Wholesaler" task page
    Then I should see "Call back Thursday"

  Scenario: Go Back to the Wholesaler
    When I am on the "Contact Wholesaler" task page
    And I follow "Joe's Wholesaler"
    Then I should be on the wholesaler page for "Joe's Wholesaler"
   
  Scenario: Go Back to the task dashboard
    When I am on the "Contact Wholesaler" task page
    When I follow "Task Dashboard"
    Then I should be on the task dashboard
    
  Scenario: Completing a task
    Given I am on the "Contact Wholesaler" task page
    When I check "Complete?"
    And I press "Update"
    Then I should be on the "Contact Wholesaler" task page
    And I should see that the task status is "Complete"
    # And I should see "Completed by vfimanager@domain.com"
 
  Scenario: Restarting a task
    Given the "Contact Wholesaler" task is complete
    And I am on the "Contact Wholesaler" task page
    When I uncheck "Complete?"
    And I press "Update"
    Then I should be on the "Contact Wholesaler" task page
    And I should see that the task status is "Incomplete"
    # And I should see some indication of who restarted the task
