Feature: Wholesaler Dashboard
  In order to manage wholesalers
  As a VFI project manager
  I want to be able to view and sort through all of those wholesalers

  Background:
    Given I am signed in as the VFI project manager

  Scenario: Wholesalers are listed from earliest event to latest
    Given the following wholesalers are created:
      | Wholesaler Name | Event date        |
      | Kunde-Smith     | 5 weeks from now  |
      | Klocko and Sons | 3 weeks from now  |
      | Otto Trzos Co.  | 10 weeks from now |
    When I go to the wholesaler dashboard
    Then the wholesaler "Klocko and Sons" should be listed first
    And the wholesaler "Kunde-Smith" should be listed second
    And the wholesaler "Otto Trzos Co." should be listed third

  @backlog @js
  Scenario Outline: Sort wholesalers
    At first each wholesaler was also sorted by region, event date, tasks and follow-ups, but it is
    easier for the time being to stick to the attributes that exist directly on the wholesaler. 
    
    Given the following wholesalers are created:
      | Wholesaler Name | State | Postal code |
      | Kunde-Smith     | NY    | 11020       |
      | Klocko and Sons | CA    | 90123       |
      | Otto Trzos Co.  | MI    | 48386       |
    And I go to the wholesaler dashboard
    When I click on the column heading named <column>
    Then the first value in that column should be <first_value>
    And the last value in that column should be <last_value>

    Examples:
      | column          | first_value     | last_value     |
      | Wholesaler Name | Klocko and Sons | Otto Trzos Co. |
      | State           | CA              | NY             |
      | Postal code     | 11020           | 90123          |
      | region     | Greater Albany  | Orange County  |
      | event_date | September 3rd   | November 12th  |
      | tasks      | 9               | 32             |
      | follow-ups | 1               | 18             |
