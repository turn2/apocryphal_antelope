Feature: Adding and sorting winners
  In order to encourage people to participate in the program
  As a VFI Manager
  I want to be able to tell the public about winners of the monthly sweepstakes

  Background: 
    Given I am signed in as the VFI project manager
    And a wholesaler "Joe's Wholesaler"

  Scenario: Adding a new sweepstakes winner
    Given I go to the winners page
    When I follow "Add Winner"
    And I fill in "Winner name" with "John Smythe"
    And I select "Joe's Wholesaler" from "Wholesaler"
    And I press "Create Winner"
    Then I should see "John Smythe"

  Scenario: Removing a sweepstakes winner
    Given the following winners are created:
      | winner name | 
      | John Smythe |
    When I go to the winners page
    And I follow "Delete Winner"
    Then I should not see "John Smythe"

  @javascript
  Scenario: Sorting sweepstakes winners
    Given the following winners are created:
      | winner name | 
      | John Smythe |
      | Bitsy Jones |
      | Steve Snabb |
      | Carl Castle |
    When I go to the winners page
    And I drag winner "Steve Snabb" above "John Smythe"
    And I drag winner "John Smythe" below "Bitsy Jones"
    Then the winners should be in the following order:
      | winner name |
      | Steve Snabb |
      | Bitsy Jones |
      | John Smythe |
      | Carl Castle |
    
    
