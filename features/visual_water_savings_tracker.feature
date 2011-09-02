Feature: Visual water savings tracker
  In order to demonstrate the success of this promotion to wholesalers and the general public
  I want to see a visual device indicating the water saved by items purchased as a result of the promotion

  Scenario: Enter water savings data into system
    Given I am signed in as the VFI project manager
    When I go to the water savings edit page
    Then I should be able to update the number of gallons saved

  Scenario: Get water savings data from the system
    Given I am a member of the general public
    And there have been 5150 gallons saved
    When I go to the water savings page
    Then I should see "5150"

  @backlog
  Scenario: View water savings visually
    Given I am a member of the general public
    When I go to the promotion home page 
    #What is the promotion home page?  the root of the site?
    Then I should see a graphic filled in proportionally to the amount of water saved
    And I should see a ticker with the exact number of gallons saved
