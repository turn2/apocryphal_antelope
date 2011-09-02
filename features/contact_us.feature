Feature: Contact Us Tab
  In order to provide important messages to VFI and American Standard
  As a visitor to the Responsible Bathroom Tour website
  I want to be able to easily send messages without using a mail client

  Scenario: Send an email to VFI
    Given I am on the contact us page
    When I fill in "Name" with "Greg"
    And I fill in "Email" with "test@example.com"
    And I fill in "Message" with "I love your faucets!"
    And I press "Submit"
    Then I should see "Your message has been sent!"
    And "admin@vfimarketing.com" should receive 1 email
    When "admin@vfimarketing.com" opens the email
    Then they should see "A message has been submitted" in the email body
    Then they should see "Greg" in the email body
    Then they should see "test@example.com" in the email body
    And they should see "I love your faucets!" in the email body
    And they should see the email delivered from "admin@localhost"
    And they should see "test@example.com" in the email "reply-to" header

  Scenario: Reject non-emailish addresses
    Given I am on the contact us page
    When I fill in "Name" with "anonymous"
    And I fill in "Email" with "anonymous"
    And I fill in "Message" with "I love your faucets!"
    And I press "Submit"
    Then I should see "Please enter a valid email address"
    And "admin@vfimarketing.com" should receive 0 emails
