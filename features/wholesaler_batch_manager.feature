Feature: Wholesaler Batch Manager
  In order to save time and money
  As a VFI Project Manager
  I want to be able to create and update many wholesalers at once from a CSV

  Background:
    Given I am signed in as the VFI project manager
    And I go to the wholesaler batch upload page

  Scenario: Import new batch
    Given there are 0 wholesalers
    And a CSV named "batch.csv" with the following content:
      | Dealer Name | Address                | Owner                | City | State | Zip   | Event date | Email   | Phone      | Truck |
      | Foocets     | 12345 Awesometown Ave. | Conquestadorio Jones | Mint | MI    | 12340 | 1/30/2010  | a@a.com | 3135551234 | 1     |
      | WWorks      | 54321 Flowville        | Mike Smith           | Fall | OH    | 34567 | 2/04/2010  | b@a.com | 3134721212 | 2     |
    When I batch import "batch.csv"
    Then I should see "Batch uploaded successfully. 2 Wholesaler(s) added" 
    And there should be 2 wholesalers
    And I should see "Foocets"
    And I should see "WWorks"

  Scenario: Overwrite wholesalers
    Given the following wholesalers are created:
      | Wholesaler name | Street Address | Postal code | Event date |
      | Joe's WSaler    | 112 Main St.   | 44112       | 3/4/2010   |
    And a CSV named "new_records.csv" with the following content: 
      | Dealer Name  | Address      | Owner     | City     | State | Zip   | Event date | Email   | Phone      | Truck |
      | Joe's WSaler | 113 Main St. | Joe Jones | Harrison | MI    | 44112 | 3/15/2010  | a@a.com | 3135551234 | 1     |
    When I batch import "new_records.csv"
    Then I should see "Batch uploaded successfully. 0 Wholesaler(s) added. 1 Wholesaler(s) updated."
    And I should see "Joe's WSaler"
    And I should see "2010-03-15"
  
  Scenario: Error messages when I upload a CSV without Dealer Name and Zip and Event date
    Given a CSV named "bad_batch.csv" with the following content:
      | Store Name | Address     | Owner | City | State | Postal Code | Date      | Email   | Phone     | Truck |
      | Foocets    | 1234 Street | Me    | Dbn. | MI    | 48124       | 1/30/2010 | a@a.com | 123456890 | 2     |
    When I batch import "bad_batch.csv"
    Then I should see "Batch upload failed."
    And I should see "Missing required column(s) Dealer Name, Zip, Event date"

  Scenario: Error messages when I upload a csv with invalid Wholesaler information in it.
    Given a CSV named "bad_data.csv" with the following content:
      | Dealer Name | Address | Owner | City | State | Zip   | Event date | Email   | Phone      | Truck |
      | Foocets     |         |       | Dbn. | MI    | 1234  | Tomorrow   | a@a.com | 1234567890 | 2     |  
    When I batch import "bad_data.csv"
    Then I should see "Batch upload failed."
    And I should see "Wholesaler data is not formatted properly or is missing for row(s) 1"

  Scenario: Don't overwrite existing wholesaler details with empty fields from the CSV
    Given the following wholesalers are created:
      | Wholesaler name | Street Address | Postal code | Event date |
      | Joe's WSaler    | 112 Main St.   | 44112       | 3/4/2010   |
    And a CSV named "new_records.csv" with the following content: 
      | Dealer Name  | Zip   | Event date | Street Address |
      | Joe's WSaler | 44112 | 3/15/2010  |                |
    When I batch import "new_records.csv"
    Then I should see "Batch uploaded successfully. 0 Wholesaler(s) added. 1 Wholesaler(s) updated."
    And the wholesaler "Joe's WSaler" should have "112 Main St." as the "street address"

  Scenario: Create account column content controls account creation
    Given a CSV named "wholesalers.csv" with the following content:
      | Dealer Name | Address | Owner | City | State | Zip   | Event date | Email           | Truck | Create account |
      | A's         | 1 A     | A     | A    | MI    | 12345 | 12/12/2010 | a@blurby.domain | 1     | Y              |
      | B's         | 2 B     | B     | B    | MI    | 12345 | 12/12/2010 | b@blurby.domain | 2     | Yes            |
      | C's         | 3 C     | C     | C    | MI    | 12345 | 12/12/2010 | c@blurby.domain | 3     | T              |
      | D's         | 4 D     | D     | D    | MI    | 12345 | 12/12/2010 | d@blurby.domain | 4     | True           |
      | E's         | 5 E     | E     | E    | MI    | 12345 | 12/12/2010 | e@blurby.domain | 5     |                |
      | F's         | 6 F     | F     | F    | MI    | 12345 | 12/12/2010 | f@blurby.domain | 6     | No thanks      |
    When I batch import "wholesalers.csv"
    Then "a@blurby.domain" should receive 1 email
    And  "b@blurby.domain" should receive 1 email
    And  "c@blurby.domain" should receive 1 email
    And  "d@blurby.domain" should receive 1 email
    And  "e@blurby.domain" should receive 0 emails
    And  "f@blurby.domain" should receive 0 emails

  Scenario: Missing create account column
    Given a CSV named "wholesalers.csv" with the following content:
      | Dealer Name | Address | Owner | City | State | Zip   | Event date | Email           | Truck |
      | A's         | 1 A     | A     | A    | MI    | 12345 | 12/12/2010 | a@blurby.domain | 1     |
    When I batch import "wholesalers.csv"
    Then "a@blurby.domain" should receive 0 emails

  Scenario: Wholesaler receives account creation email
    Given a CSV named "wholesalers.csv" with the following content:
      | Dealer Name | Address | Owner | City | State | Zip   | Event date | Email           | Truck | Create account | Password |
      | A's         | 1 A     | A     | A    | MI    | 12345 | 12/12/2010 | a@blurby.domain | 1     | Y              | p4ssw0rd |
    When I batch import "wholesalers.csv"
    And "a@blurby.domain" opens the email
    Then they should see "American Standard The Responsible Bathroom Tour Account Creation" in the email subject
    And they should see "Username: a@blurby.domain" in the email body
    And they should see "Password: p4ssw0rd" in the email body
    When they click the first link in the email
    And I sign in as "a@blurby.domain/p4ssw0rd"
    Then I should see "Signed in"

  Scenario: Manager receives digest account creation email 
    Given a CSV named "wholesalers.csv" with the following content:
      | Dealer Name | Address | Owner | City | State | Zip   | Event date | Email           | Truck | Create account | Password |
      | A's         | 1 A     | A     | A    | MI    | 12345 | 12/12/2010 | a@blurby.domain | 1     | Y              | pw1      |
      | B's         | 1 B     | B     | B    | MI    | 12345 | 12/12/2010 | b@blurby.domain | 2     | Y              | pw2      |
    When I batch import "wholesalers.csv"
    Then "admin@vfimarketing.com" should receive 1 email
    When "admin@vfimarketing.com" opens the email
    Then they should see "2 wholesaler account(s) created" in the email body
    And they should see "a@blurby.domain: pw1" in the email body
    And they should see "b@blurby.domain: pw2" in the email body
