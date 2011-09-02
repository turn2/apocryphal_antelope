Feature: Public Relations Admin
  In order to create media buzz about the promotion before it arrives in each town
  As a VFI project manager
  I want to be able to manage a list of PR regions and media outlets countrywide

  Background:
    Given I am signed in as the VFI project manager

  Scenario: Create a PR region
    Given I go to the public relations dashboard
    And I follow "new"
    When I fill in "Awesomeville" for "Name"
    And I press "Create Region"
    Then I should see "Region Awesomeville Created"

  Scenario: Create a PR region without name
    Given I go to the public relations dashboard
    And I follow "new"
    When I press "Create Region"
    Then I should see "Region name can't be blank"
    
  Scenario: Add a Media Outlet to a PR Region
    Given a region "Awesomeville"
    And I go to the "Awesomeville" region page
    And I follow "Add new Media Outlet"
    When I fill in "Media Outlet Name" with "Channel 4"
    And I press "Create Media Outlet"
    Then I should see "Channel 4 Added to Awesomeville"
    And I should be on the "Awesomeville" region page

  Scenario: View PR regions in a list
    Given a region "Awesomeville"
    And a region "Sweettown"
    When I go to the public relations dashboard
    Then I should see "Awesomeville"
    And I should see "Sweettown"

  Scenario: View detailed PR region information
    Given a region "Radville" with media outlets and wholesalers
    When I go to the page for the region "Radville"
    Then I should see the "Radville" region's media outlets and wholesalers
  
  Scenario: Modifying a PR region
    Given a region "Awesomeville"
    When I go to the public relations dashboard
    And I follow "Edit"
    Then I should be able to change the region details

  Scenario: Delete a PR region with no media outlets
    Given a region "Awesomeville"
    When I go to the public relations dashboard
    Then I should be able to delete the region "Awesomeville"

  Scenario: Delete a PR region with media outlets
    Given a region "Radville" with media outlets and wholesalers
    When I go to the public relations dashboard
    Then I should be able to delete the region "Radville"
    And the media outlets for region "Radville" should become standalone media outlets
  
  Scenario: Delete a PR region with wholesalers
    Given a region "Radville" with media outlets and wholesalers
    When I go to the public relations dashboard
    Then I should be able to delete the region "Radville"
    And the wholesalers for region "Radville" should not be affiliated with a region

  Scenario: Send an email to a media outlet
    Given a region "Radville" with media outlets and wholesalers
    When I go to the public relations dashboard
    And I follow "Radville"
    And I follow the link to the first media outlet for the region "Radville"
    Then I should be able to click on a media contact's email address and send them an email

  Scenario: Creating a standalone media outlet
    Given I go to the public relations dashboard
    And I follow "Standalone Media Outlets"
    When I follow "Add New Standalone Media Outlet"
    And I fill in "Media Outlet Name" with "Channel 4"
    And I press "Create Media Outlet"
    Then I should see "Channel 4"

  Scenario: Adding wholesalers to a region
    Given a region "Sweettown"
    And a region "Awesomeville"
    And 2 wholesalers which do not belong to any region
    And 3 wholesalers which belong to "Awesomeville"
    And 4 wholesalers which belong to "Sweettown"
    When I go to the edit page for the region "Sweettown"
    Then I should be able to add the wholesalers which are regionless  
    And I should be able to remove the wholesalers which belong to "Sweettown"
    But I should not be able to add the wholesalers which belong to "Awesomeville"
