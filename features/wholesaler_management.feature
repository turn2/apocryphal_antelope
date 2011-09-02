Feature: Wholesaler Management
  In order to manage wholesalers involved in the VFI promotion
  As a VFI Project Manager
  I want to be able to create, delete, and update wholesalers

  Background:
    Given I am signed in as the VFI project manager

  Scenario: Create a new wholesaler
    Given I am on the new wholesaler page
    And there are 0 wholesalers
    When I fill in "Wholesaler Name" with "Joe's Wholesaler"
    And I fill in "Contact name" with "Joe D. Wholesaler"
    And I fill in "Email" with "joed@wholesalin.com"
    And I fill in "Phone" with "(313) 555-1212"
    And I fill in "Address" with "12345 Main Street Suite 123"
    And I fill in "City" with "Detroit"
    And I fill in "State" with "MI"
    And I fill in "Postal code" with "12345"
    And I select "03/01/2010" as the date
    And I fill in "Truck" with "1"
    And I press "Create wholesaler"
    Then there should be 1 wholesaler

  Scenario: New wholesalers have template tasks assigned
    Given I am on the new wholesaler page
    And there are 3 task templates
    When I create a new wholesaler "Joe's Wholesaler"
    Then the wholesaler "Joe's Wholesaler" should have 3 tasks

  Scenario: Adding a user to a wholesaler
    Given a wholesaler "Joe's Wholesaler"
    And I am on the edit page for the wholesaler "Joe's Wholesaler"
    And I follow "Create a user account for this wholesaler"
    And I fill in "Email" with "joe@wholesaler.domain"
    And I fill in "Password" with "letmein"
    And I fill in "Confirm Password" with "letmein"
    And I press "Create user"
    Then I should see "User joe@wholesaler.domain created successfully"
    And I should see "Edit the user account for this wholesaler"
