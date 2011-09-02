Feature: Upload Photos and Testimonials
  In order to show everybody how successful all of the events were
  As a VFI project manager
  I want to be able to upload photos and testimonials from each event.

  Background:
    Given I am signed in as the VFI project manager
    And a wholesaler "Your Tap is Punning"

  Scenario: Add testimonials for an event
    Given I am on the wholesaler page for "Your Tap is Punning"
    When I enter a new testimonial
    Then I should see the new testimonial on the wholesaler page for "Your Tap is Punning"
    
  Scenario: Upload a photo
    Given I am on the new photo page for "Your Tap is Punning"
    When I select a photo for upload
    And I press "Upload"
    Then the wholesaler "Your Tap is Punning" should have a thumbnail, medium, and full resolution photo

  #Webrat bug, submits "" as file field value:  http`://webrat.lighthouseapp.com/projects/10503/tickets/298
  @backlog
  Scenario: Trying to upload without attaching a file
    Given I am on the new photo page for "Your Tap is Punning"
    When I press "Upload"
    Then I should see a warning 

  Scenario: Removing a photo
    Given the wholesaler "Your Tap is Punning" has one photo
    And I am on that photo page for "Your Tap is Punning"
    When I follow "Edit Photo"
    And I press "Delete Photo"
    Then the wholesaler "Your Tap is Punning" shouldn't have any photos

  Scenario: Viewing the photos
    Given the wholesaler "Your Tap is Punning" has one photo
    And I am on the photos page for "Your Tap is Punning"
    Then I should see 1 photo
 
  Scenario: Uploading multiple photos from a zip file
    Given I am on the new photo page for "Your Tap is Punning"
    When I select a zip file with photos for upload
    And I press "Upload"
    Then the wholesaler "Your Tap is Punning" should have 3 photos
