Feature: Tasks reflect event date status
  As a VFI Project Manager
  In order to plan wholesaler events effectively
  I need to have the task due dates accurately reflect changes to the event date

  Background: 
    Given I am signed in as the VFI project manager

  Scenario: Change to event date changes Task due date
    Given a task template "Contact Owner" due 2 weeks prior to its event
    And a wholesaler "Joe's Wholesaler" with a "May 3" event
    When I change the event date for wholesaler "Joe's Wholesaler" to "May 21"
    Then the "Contact Owner" task for "Joe's Wholesaler" should be due on "May 7"

