Given /^I enter information for a plumber from my event$/ do 
  steps %Q{
    Given I fill in "Name" with "Jack Smythe"
    And I fill in "Email" with "jsmythe@example.com"
    And I fill in "Phone" with "(313) 555 1234"
    And I fill in "Street Address" with "1234 Main Street"
    And I fill in "City" with "Jackson"
    And I fill in "State or Province" with "TN"
    And I fill in "Postal code" with "12354"
  }
end

Given /^(wholesaler ".+") has the following plumbers:$/ do |wholesaler, table|
  table.hashes.each do |row|
    p = Factory(:plumber, :contact_name => row["Contact Name"], :company_name => row["Company"])
    p.wholesaler = wholesaler
    p.save!
  end
end

Given /^I download the plumbers for "([^\"]*)"$/ do |wholesaler_name|
  steps %Q{
    Given I go to the wholesaler page for "#{wholesaler_name}"
    And I follow "Conquest Data"                          
    And I follow "Download"                         
  }
end

Then /^the plumber conquest should be attributed to "(.+)"$/ do |wholesaler_name|
  Plumber.last.wholesaler.should == Wholesaler.find_by_wholesaler_name(wholesaler_name)
end

Then /^I should receive a csv of the plumbers$/ do
  Then %Q{I should see "Company Name,Contact Name,Email,Phone,Address,City,State,Zip,Cell,Fax,Other Phone,Wholesaler,Added Date,Previously Exported"}
  And %Q{I should see "Steve Snabb"}
  And %Q{I should see "We Fix It"}
  And %Q{I should see "Marty Fowler"}
end

Then /^I see that the plumbers have not been previously exported$/ do
  Then %Q{I should see "false"}
  And %Q{I should not see "true"}
end

Then /^I should see that the plumbers have been previously exported$/ do
  Then %Q{I should see "true"}
  And %Q{I should not see "false"}
end
