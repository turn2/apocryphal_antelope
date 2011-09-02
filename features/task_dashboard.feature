Feature: Task Dashboard
  In order to effectively handle and respond to tasks related to wholesalers
  As a VFI project manager
  I want to be able to see all available outstanding tasks and follow-ups 
  
  Background:
    Given I am signed in as the VFI project manager

  Scenario: Getting an overview
    Given the following task templates are created:
      | Title                      | Due week |
      | Contact Wholesaler         | 1        |
      | Conduct followup interview | 10       |
    And the following wholesalers are created:
      | Wholesaler Name             | Event date        |
      | Joe's Wholesaler            | 11 weeks from now |
      | Steve's Wholesaler          | 21 weeks from now |
    When I go to the task dashboard
    Then the "Contact Wholesaler" task for "Joe's Wholesaler" should be due 2 weeks from now
    And the "Conduct followup interview" task for "Joe's Wholesaler" should be due 11 weeks from now
    And the "Contact Wholesaler" task for "Steve's Wholesaler" should be due 12 weeks from now
    And the "Conduct followup interview" task for "Steve's Wholesaler" should be due 21 weeks from now


  Scenario: Tasks requiring immediate action
    Given a task "Buy Banners" is due tomorrow
    When I go to the task dashboard
    Then the task "Buy Banners" should be marked urgent

  Scenario: Completing a task
    Given a task "Contact Wholesaler"
    And I am on the task dashboard
    When I mark the "Contact Wholesaler" task complete
    And I press "Mark Complete"
    Then the task "Contact Wholesaler" should be marked complete   

  Scenario: Restarting a task
    Given a task "Contact Wholesaler"
    And the "Contact Wholesaler" task is complete
    And I am on the task dashboard
    When I follow "View complete tasks"
    And I restart the "Contact Wholesaler" task
    Then the task "Contact Wholesaler" should be marked incomplete
