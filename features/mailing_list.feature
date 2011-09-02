Feature: Subscribing to the mailing list
  In order to allow VFI and American Standard to keep me informed in the future
  As a prospective or current customer, plumber, wholesaler, or member of the general public
  I want to be able to submit my contact information

  Scenario: Opt in to VFI mailing list
    Given I am on the follow the tour page
    When I fill in my contact information
    And I opt-in to receive communication about the tour
    And I press "Submit"
    Then I should see "Thank you for your interest."
    And I should be added to the prospects opt in list

  Scenario: Send an email notifying VFI of opt-in
    Given I am on the follow the tour page
    When I fill in my contact information
    And I fill in "Email Address:" with "me@example.com"
    And I opt-in to receive communication about the tour
    And I press "Submit"
    Then "admin@vfimarketing.com" should receive 1 email
    When "admin@vfimarketing.com" opens the email
    Then they should see "(me@example.com) has subscribed to the Follow the Tour mailing list" in the email body
    
  Scenario: Send an email notifying VFI of opt-out
    Given I have opted-in to receive updates from American Standard as "me@example.com"
    And I am on the follow the tour page
    When I fill in my contact information
    And I fill in "Email Address:" with "me@example.com"
    And I opt-out of receiving communication about the tour
    And I press "Submit"
    Then "admin@vfimarketing.com" should receive 1 email
    When "admin@vfimarketing.com" opens the email
    Then they should see "(me@example.com) has unsubscribed from the Follow the Tour mailing list" in the email body
    
  Scenario: Change opt-in settings
    Given I have opted-in to receive updates from American Standard as "email@example.com"
    When I go to the follow the tour page
    And I fill in my contact information
    And I opt-out of receiving communication about the tour
    And I press "Submit"
    Then I should see "unsubscribed"
    And the prospect for "email@example.com" should not be opted-in

  Scenario: Error message if I try to submit without opting in for the first time
    Given I go to the follow the tour page
    And I fill in my contact information
    And I opt-out of receiving communication about the tour
    And I press "Submit"
    Then I should see "You must opt-in if you wish us to contact you about The Responsible Bathroom Tour"
    And there shouldn't be any new prospects
    And "admin@vfimarketing.com" should receive 0 emails

  Scenario: Require all options to be selected for opt-in or opt-out
    Given I go to the follow the tour page
    And I fill in my contact information
    And I fill in "Name" with ""
    And I opt-in to receive communication about the tour
    And I press "Submit"
    Then I should see "Sorry, there was a problem with your submission. Name, valid email, and visitor type are required"
    And there shouldn't be any new prospects

