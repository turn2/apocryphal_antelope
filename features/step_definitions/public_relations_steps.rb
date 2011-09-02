Given /^the following media outlets belong to "(.+)":$/ do |region_name, table|
  r = Region.find_by_region_name(region_name)
  table.hashes.each do |hash|
    Factory(:media_outlet, :media_outlet_name => hash["Media outlet name"], :region => r)
  end
end

Given /^the "(.+)" media outlet has the following followups:$/ do |name, table|
  mo = MediaOutlet.find_by_media_outlet_name(name)
  table.hashes.each do |hash|
    Factory(:followup, :description => hash["description"], :task => nil, :media_outlet => mo)
  end
end

Given /^the (wholesaler ".+") belongs to the "(.+)" region$/ do |wholesaler, region_name|
  wholesaler.region = Region.find_by_region_name(region_name)
  wholesaler.save!
end

Given /^the "([^\"]*)" media outlet has a close date of tomorrow$/ do |media_outlet_name|
  MediaOutlet.find_by_media_outlet_name(media_outlet_name).update_attributes(:close_date => Date.tomorrow)
end

Given /^the (".+" follow-up) is not complete$/ do |followup|
  followup.update_attributes(:complete => false)
end

Given /^the (".+" follow-up) is complete$/ do |followup|
  followup.update_attributes(:complete => true)
end

Given /^the (".+" follow-up) is due (\d+) days from now$/ do |followup, days|
  followup.update_attributes(:due_date => Date.today + days.to_i.days)
end
      
When /^I click on the name of a PR region$/ do
  click_link("South")
end

Then /^I should see station information for all of the media outlets in that region$/ do
  Then "I should see \"DCT\""
end

Then /^I should see which wholesalers are connected to each media outlet$/ do
  Then "I should see \"Faucets R Us\""
end
