Feature: Follow-ups
  In order to ensure that events are successful
  As a VFI project manager with lots of work to do to prepare for an event
  I need to manage individual steps that are necessary for each Task that an event depends on

  Background: 
    Given I am signed in as the VFI project manager
    And a task "Contact Wholesaler"

  Scenario:  Adding a follow-up to a task
    Given I am on the "Contact Wholesaler" task page
    When I fill in "Description" with "No response.  Call back on Thursday"
    And I select "September 24, 2010" as the "due date" date
    And I press "Create follow-up"
    Then I should see "Call back on Thursday"
    And the "Contact Wholesaler" task should have 1 follow-up

  @backlog
  Scenario:  Deleting a follow-up to a task
    Given the "Contact Wholesaler" task has a follow-up "Call back Thursday"
    And I am on the "Contact Wholesaler" task page
    When I follow "Delete"
    Then I should not see "Call back Thursday"

  Scenario:  Completing a follow-up to a task
    Given the "Contact Wholesaler" task has a follow-up "Call back Thursday"
    And I am on the "Contact Wholesaler" task page
    When I mark the "Call back Thursday" follow-up complete
    Then I should see "Complete" for the "Call back Thursday" follow-up
  
  Scenario:  Task followups on followup dashboard
    Given the "Contact Wholesaler" task has a follow-up "Call back Thursday"
    And the "Contact Wholesaler" task has a follow-up "Update wholesaler contact information"
    When I go to the follow-up dashboard
    Then I should see "Call back Thursday"
    And I should see "Update wholesaler contact information"
    And I should see "My Wholesaler"
  
  Scenario:  Media outlet followups on the followup dashboard
    Given a media outlet "ABC Network"
    And the media outlet "ABC Network" has a follow-up "Send event package"
    When I go to the follow-up dashboard
    Then I should see "Send event package"
    And I should see "ABC Network"

  Scenario: View complete followups
    Given a media outlet "ABC Network"
    And the media outlet "ABC Network" has a follow-up "Send event package"
    And the media outlet "ABC Network" has a follow-up "Call about event package"
    And the "Call about event package" follow-up is complete
    When I go to the follow-up dashboard
    And I follow "View complete follow-ups"
    Then I should see "Call about event package"
    But I should not see "Send event package"

  Scenario: Restarting complete followups
    Given a media outlet "ABC Network" has a follow-up "Send event package"
    And the "Send event package" follow-up is complete
    When I go to the complete follow-up dashboard
    And I follow "Restart"
    And I go to the incomplete follow-up dashboard
    Then I should see "Send event package"
