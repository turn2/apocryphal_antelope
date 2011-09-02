Given /^I create a new wholesaler "(.+)"$/ do |name|
  steps %Q{  
    Given I am on the new wholesaler page
    When I fill in "Wholesaler Name" with "#{name}"
    And I fill in "Contact name" with "Joe D. Wholesaler"
    And I fill in "Email" with "joed@wholesalin.com"
    And I fill in "Phone" with "(313) 555-1212"
    And I fill in "Address" with "12345 Main Street Suite 123"
    And I fill in "City" with "Detroit"
    And I fill in "State" with "MI"
    And I fill in "Postal code" with "12345"
    And I select "03/01/2010" as the date
    And I fill in "Truck" with "1"
    And I press "Create wholesaler"
  }
end

Given /^a wholesaler "(.+)"$/ do |name|
  Factory(:wholesaler, :wholesaler_name => name)
end

Given /^a wholesaler "(.+)" with an upcoming event$/ do |name|
  Factory(:wholesaler, :wholesaler_name => name)
end

Given /^a wholesaler "(.+)" with a "(.+)" event$/ do |name, date|
  Factory(:wholesaler, :wholesaler_name => name, :event_date => Date.parse(date))
end

Given /^a wholesaler "(.+)" whose event is over$/ do |name|
  Factory(:wholesaler_whose_event_is_over, :wholesaler_name => name)
end

Given /^a wholesaler "(.+)" with the following information:$/ do |wholesaler_name, info|
  convert_headers_to_attr_names!(info)
  args = { :wholesaler_name => wholesaler_name }.merge(info.hashes.first)
  Factory(:wholesaler, args)
end

Given /^I batch import "(.+)"$/ do |name|
  attach_file("Upload batch", "#{RAILS_ROOT}/features/support/tmp_files/#{name}")
  click_button("Upload")
end

Given /^I am signed in with the account for the (wholesaler "[^\"]*")$/ do |wholesaler|
  Given %{I am signed up and confirmed as "joe@example.com/letmein"}
  And %{the user "joe@example.com" has the wholesaler role}
  u = User.find_by_email("joe@example.com")
  u.wholesaler = wholesaler
  u.save
  And %{I sign in as "joe@example.com/letmein"}
end

When /^I change the event date for (wholesaler ".+") to "(.+)"$/ do |wholesaler, date|
  visit(edit_wholesaler_path(wholesaler))
  select_date(date, :from => "Event date")
  click_button("Update wholesaler")
end

Then /^the (wholesaler ".+") should have a "(.+)" task$/ do |wholesaler, task_title|
  wholesaler.tasks.collect(&:title).should include(task_title)
end

Then /^the (wholesaler ".+") should not have a "(.+)" task$/ do |wholesaler, task_title|
  wholesaler.tasks.collect(&:title).should_not include(task_title)
end

Then /^the (wholesaler ".+") should have (\d+) tasks$/ do |wholesaler, number|
  wholesaler.should have(number.to_i).tasks
end

Then /^the (wholesaler ".+") should be (listed \w+)$/ do |wholesaler, order|
  response.should have_selector("#wholesalers .wholesaler:nth-child(#{order})") do |content|
    content.should contain(wholesaler.wholesaler_name)
  end
end

Then /^the (wholesaler ".+") should have "(.+)" as the "(.+)"$/ do |wholesaler, value, attribute|
  wholesaler.send(attribute.gsub(/ /,"_")).should == value
end

Transform /^table:Wholesaler Name,Event date$/ do |table|
  table.map_column!("Event date") do |date|
    Date.today + date.match(/\d+/).to_s.to_i.weeks
  end
  table
end

Transform /^table:Wholesaler Name,event date$/ do |table|
  table.map_column!("event date") do |date|
    Date.parse(date)
  end
  table
end

Transform /^wholesaler "(.+)"$/ do |name|
  Wholesaler.find_by_wholesaler_name(name)
end
