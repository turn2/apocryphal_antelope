Feature: Task Template Management
  In order to establish and change the event workflow as the event progresses
  As a VFI project manager
  I want to be able to manage boilerplate tasks that must be completed for each wholesaler

  Background:
    Given I am signed in as the VFI project manager
  
  Scenario: Create a Template Task
    Given a task template "Buy banners"
    And I am on the new task template page
    When I fill in "Title" with "Order banners"
    And I fill in "Description" with "Use local vendor for printing"
    And I choose "1" for "Due Week"
    And I press "Save"
    Then I should see "Task Template created successfully"
    And there should be 2 task templates

  Scenario: Creating a task template creates a task on wholesalers with upcoming events
    Given a wholesaler "Joe's Wholesaler" with an upcoming event
    When I create a new task template "Buy Banners"
    Then the wholesaler "Joe's Wholesaler" should have a "Buy Banners" task

  Scenario: New tasks are not assigned to wholesalers with past events
    Given a wholesaler "Joe's Wholesaler" whose event is over
    When I create a new task template "Buy Banners"
    Then the wholesaler "Joe's Wholesaler" should not have a "Buy Banners" task

  Scenario: Edit a Task Template
    Given a task template "Buy banners"
    And I am on the "Buy banners" task template edit page
    When I fill in "Title" with "Order banners"
    And I press "Save"
    Then I should see "Order banners"
    And I should not see "Buy banners"

  Scenario: Deleting a Task Template deletes the associated tasks
    Given a task template "Buy banners"
    And a wholesaler "Joe's Wholesaler"
    And I am on the "Buy banners" task template page
    When I follow "Delete Task"
    Then I should see "Task Template has been deleted"
    And the wholesaler "Joe's Wholesaler" should have 0 tasks
