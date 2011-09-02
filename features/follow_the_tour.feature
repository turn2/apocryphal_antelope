Feature: Follow the tour
  In order to generate enthusiasm for this event
  As a participant in the event 
  I want to be able to get all of the details about the tour
  # What's the role here...does participant differ from general public?

  Background:
    Given the following wholesalers are created:
      | Wholesaler Name     | Event date       |
      | Joe's Wholesaler    | 2 weeks ago      |
      | Jack's Wholesaler   | 5 weeks from now |
      | Steve's Wholesaler  | 2 weeks from now |

  Scenario: View event information
    Given I am on the Schedules page
    Then I should see all the event dates in ascending order for those wholesalers for the entire program period
    And I should see the event locations
    And I should see the status of those events
    # What is an event status

  Scenario: View photos of the event
    Given I am on the Schedules page
    And there are photos for an event
    When I click on that event
    # Right? You don't want to show all photos right on the main page
    Then I should see the photos

  @backlog
  Scenario: Share photos of the event
    Given I am on the Schedules page
    And there are photos for an event
    When I click on that event
    And I follow "Share pictures" 
    And I enter an email address
    Then an email should be sent to that address with a link to the pictures

  Scenario: Read testimonials from the event
    Given I am on the Schedules page
    And there are testimonials for an event
    When I click on that event
    Then I should see testimonials
