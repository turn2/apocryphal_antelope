Feature: Testimonial Management
  In order to convince the public to attend future events and demonstrate the success of the program
  As a VFI project manager
  I want to be able to manage testimonials for my wholesalers

  Background:
    Given I am signed in as the VFI project manager
    And a wholesaler "Your Tap is Running"

  Scenario: Add published testimonial for an event through management screen
    Given I am on the published testimonials page 
    And I follow "Add New Testimonial"
    And I fill in "Quote" with "Awesome!"
    And I select "Your Tap is Running" from "Wholesaler"
    And I check "Publish!"
    And I press "Create Testimonial"
    Then I should see the new testimonial on the wholesaler page for "Your Tap is Running"
    And the "Awesome!" testimonial should be published

  Scenario: Add unpublished testimonial for an event through management screen
    Given I am on the published testimonials page 
    And I follow "Add New Testimonial"
    And I fill in "Quote" with "Awesome!"
    And I select "Your Tap is Running" from "Wholesaler"
    And I press "Create Testimonial"
    Then the "Awesome!" testimonial should not be published
    
  Scenario: Unpublish a testimonial
    Given there is a published testimonial "Fantastic" for wholesaler "Your Tap is Running"
    When I go to the published testimonials page
    And I press "Remove from media tab"
    Then the "Fantastic" testimonial should not be published

  @js 
  Scenario: Reordering testimonials
    Given multiple published testimonials
    When I go to the published testimonials page
    And I drag the second testimonial above the first testimonial
    Then the testimonials should be reordered

  Scenario: Recent unpublished wholesaler testimonials
    Given there is an unpublished testimonial "Not too bad" for wholesaler "Your Tap is Running"
    When I go to the wholesalers testimonials page
    Then I should see "Not too bad"

  Scenario: Publishing testimonial from the wholesalers testimonials page
    Given there is an unpublished testimonial "Not too bad" for wholesaler "Your Tap is Running"
    When I go to the wholesalers testimonials page
    And I press "Add to media tab"
    Then the "Not too bad" testimonial should be published
  
  Scenario: Publishing testimonial from unpublished testimonials page
    Given there is an unpublished testimonial "Not too bad" that doesn't belong to a wholesaler
    When I go to the unpublished testimonials page
    And I press "Add to media tab"
    Then the "Not too bad" testimonial should be published

  Scenario: Deleting testimonial from unpublished testimonials page
    Given there is an unpublished testimonial "Not too bad" that doesn't belong to a wholesaler
    When I go to the unpublished testimonials page
    And I press "Delete Testimonial"
    Then the "Not too bad" testimonial should be deleted
    
  Scenario: Publishing testimonial from wholesaler page
    Given there is an unpublished testimonial "Not too bad" for wholesaler "Your Tap is Running"
    When I go to the wholesaler page for "Your Tap is Running"
    And I press "Add to media tab"
    Then the "Not too bad" testimonial should be published

  Scenario: Unpublishing testimonial from wholesaler page
    Given there is a published testimonial "Not too bad" for wholesaler "Your Tap is Running"
    When I go to the wholesaler page for "Your Tap is Running"
    And I follow "Manage published testimonials"
    And I press "Remove from media tab" 
    Then the "Not too bad" testimonial should not be published

  Scenario: Deleting testimonial from a wholesaler page
    Given there is a published testimonial "Not too bad" for wholesaler "Your Tap is Running"
    When I go to the wholesaler page for "Your Tap is Running"
    And I follow "Delete Testimonial"
    Then the "Not too bad" testimonial should be deleted
