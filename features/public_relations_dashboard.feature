Feature: Public Relations Dashboard
  In order to organize the tasks I have for different media outlets
  As a VFI project manager
  I want to be able to view all of the media outlets by region

  Background:
    Given the following regions are created:
      | region name |
      | South       |
      | West        |
      | North East  |
    And the following wholesalers are created:
      | Wholesaler Name | event date |
      | Faucets R Us    | 4/05/2010  |
      | Dolittle        | 4/07/2010  |
      | Foocets         | 5/13/2010  |
    And the wholesaler "Faucets R Us" belongs to the "South" region
    And the following media outlets belong to "South":
      | Media outlet name |
      | DCT               |
      | 101.4             |
    And the "DCT" media outlet has the following followups:
      | description             |
      | Call at 1PM             |
      | Fax over event schedule |
      | Get phone contact info  |
    And I am signed in as the VFI project manager

  Scenario: Viewing overview information
    When I go to the public relations dashboard
    Then I should see a list of PR regions
    And I should see a list of event weeks

  Scenario: View all media outlets
    Given I go to the public relations dashboard
    When I click on the name of a PR region 
    Then I should see station information for all of the media outlets in that region
    And I should see which wholesalers are connected to each media outlet

  Scenario: View media outlets comments and followups
    Given I go to the public relations dashboard
    When I follow "South"
    And I follow "DCT"
    Then I should see "Call at 1PM"
    And I should see "Fax over event schedule"
    
   
  Scenario: Show alerts tied to close dates
    Given the "DCT" media outlet has a close date of tomorrow
    And the "Call at 1PM" follow-up is not complete
    And the "Call at 1PM" follow-up is due 3 days from now
    And the "Fax over event schedule" follow-up is complete
    And the "Get phone contact info" follow-up is due 8 days from now
    When I go to the public relations dashboard
    Then I should see "Call at 1PM"
    But I should not see "Fax over event schedule"
    And I should not see "Get phone contact info"
    
  Scenario: View detailed media outlet information
    Given I am on the public relations dashboard
    When I follow "South"
    And I follow "DCT"
    Then I should be on the page for the "DCT" media outlet for the "South" region
