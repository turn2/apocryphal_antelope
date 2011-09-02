Feature: Overall progress summary
  In order to get a sense of what the overall task progress is systemwide
  As a VFI Project Manager
  I want to be able to see a week-by-week task list
    for all wholesalers and all of the weeks
    for which they have outstanding tasks

  Background:
    Given there are already several wholesalers
    And every wholesaler has a bunch of tasks
    And some of those tasks have already been completed
    And I am signed in as the VFI project manager
    When I go to the "Wholesalers at a Glance" page
    Then I should see a list of all of the wholesalers whose events are coming up

  @backlog
  Scenario: View task list for wholesalers whose events are coming up
    Then there should be check boxes for weeks one through ten for each wholesaler
    And there should be a checkbox indicating how soon the event is
    And a checkbox indicating whether there is any conquest data available
    And a checkbox indicating whether postcards have been generated

  @backlog
  Scenario: View task list for wholesalers whose events aren't for a while
    Then I should see links to subsequent pages of wholesaler tasks
    And when I click on a link to one of those pages
    Then I should be able to see wholesalers whose events are later in the year

  @backlog
  Scenario: View detailed wholesaler information
    When I click on the name of a wholesaler
    Then I should see a page with more detailed information
  
  @backlog
  Scenario Outline: Tasks and weeks color-coded by task completion and severity
    Given that the tasks are organized into these columns:
      | Event Date | Wholesaler      | 10 | 9 | 8 | 7 | Conquest | Postcards | 
      | 09/20      | Kunde-Smith     |  0 | 0 | 0 | 0 |   80     |   Sent    |
      | 10/30      | Klocko and Sons |  1 | 0 | 2 | 0 |    0     |  Not Sent |
      | 11/04      | Otto Trzos Co.  |  2 | 1 | 0 | 0 |    0     |   Sent    |
    Then the box for the wholesaler <wholesaler> in the column <column> should be <color>

    Examples:
      | Wholesaler      | Column       | Color         |
      | Kunde-Smith     | Event Date   | Gray          |
      | Kunde-Smith     | 10           | Green         |
      | Kunde-Smith     | Conquest     | Green         |
      | Klocko and Sons | Event Date   | Yellow        |
      | Klocko and Sons | 10           | Yellow        |
      | Klocko and Sons | 9            | Green         |
      | Klocko and Sons | 8            | Red           |
      | Klocko and Sons | Conquest     | Red           |
      | Klocko and Sons | Postcards    | Red           |
      | Klocko and Sons | Tasks        | Yellow        |
      | Otto Trzos Co.  | Event Date   | Green         |
      | Otto Trzos Co.  | 10           | Red           |
      | Otto Trzos Co.  | 9            | Yellow        |
      | Otto Trzos Co.  | 8            | Green         |
      | Otto Trzos Co.  | Postcards    | Green         |
