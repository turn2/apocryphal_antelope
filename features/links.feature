@backlog
Feature: Links to external sites
  In order to receive information relevant to conservation and related products
  As a member of the general public
  I want to have links to other relevant sites

  Scenario: View links
    Given I am on the Links page
    Then I should see logos for and links to sites such as:
      | name                              |
      | Nature Conservancy                |
      | Water Efficiency Pages            |
      | Products                          |
      | Rebate Locator                    |
      | LEED                              |
      | WATERSENSE                        |

  Scenario: Opening links in new tabs
    Given I am on the Links page
    Then the LEED link should be set to open in a new window

  Scenario: Go to external calculator page
    Given I am on the Calculator tab
    When I click the American Standard Water Savings Calculator link
    Then I should be on the American Standard Savings Calculator page

