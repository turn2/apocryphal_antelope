Given /^I have opted\-in to receive updates from American Standard as "([^\"]*)"$/ do |email_address|
  Prospect.create(:email => email_address, :name => "my name", :opted_in => true, :visitor_type => "Wholesaler")
end

When /^I fill in my contact information$/ do
  fill_in("Name:",:with => "My Name")
  fill_in("Email Address:",:with => "email@example.com")
  choose("prospect_visitor_type_retailer")
end

When /^I opt-in to receive communication about the tour$/ do
  check("I would like to receive communication about The Responsible Bathroom Tour")
end

When /^I opt-out of receiving communication about the tour$/ do
  uncheck("I would like to receive communication about The Responsible Bathroom Tour")
end

Then /^I should see those prospects$/ do
  Prospect.all.each do |p|
    "Then I should see \"#{p.email}\""
  end
end

Then /^I should be able to update their opt\-in status$/ do
  uncheck("Opted in")
  click_button("Save changes")
  response.should contain("Successfully updated!")
  Prospect.first.opted_in?.should be_false
end

Then /^I should receive a csv with all the prospects$/ do
  response.content_type.should == "text/csv"
  Prospect.all.each do |prospect|
    response.should contain(prospect.email)
  end
end

Then /^I should be added to the prospects opt in list$/ do
  Prospect.last.email.should == "email@example.com"
end

Then /^the prospect for "(.+)" should not be opted-in$/ do |email|
  Prospect.find_by_email(email).should_not be_opted_in
end

Then /^there shouldn't be any new prospects$/ do 
  Prospect.count.should == 0
end

