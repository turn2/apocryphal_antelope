Given /^a region "([^\"]*)"$/ do |region_name|
  Factory(:region, :region_name => region_name)
end

When /^I select "([^\"]*)" from the media outlet drop down menu$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Given /^a region "(.+)" with media outlets and wholesalers$/ do |region_name|
  region = Factory(:region, :region_name => region_name)
  3.times do
    media_outlet = Factory(:media_outlet)
    wholesaler = Factory(:wholesaler)
    media_outlet.region = wholesaler.region = region
    media_outlet.save!
    wholesaler.save!
  end
end

Given /^(\d+) wholesalers which do not belong to any region$/ do |number|
  number.to_i.times { Factory(:wholesaler) }
end

Given /^(\d+) wholesalers which belong to "(.+)"$/ do |number, region_name|
  number.to_i.times do
    w = Factory(:wholesaler, :region => Region.find_by_region_name(region_name))
  end
end

Given /^I follow the link to the first media outlet for the region "(.+)"$/ do |region_name|
  region = Region.find_by_region_name(region_name)
  click_link(region.media_outlets.first.media_outlet_name)
end

Then /^I should see the "(.+)" region's media outlets and wholesalers$/ do |region_name|
  region = Region.find_by_region_name(region_name)
  region.wholesalers.each do |wholesaler|
    Then "I should see \"#{wholesaler.wholesaler_name}\""
  end
  region.media_outlets.each do |media_outlet|
    Then "I should see \"#{media_outlet.media_outlet_name}\""
  end
end

Then /^I should be able to change the region details$/ do
  fill_in "Name", :with => "Even Better Region"
  click_button("Update Region")
  Then "I should see \"Even Better Region\""
end

Then /^I should be able to delete the region "(.+)"$/ do |region_name|
  click_link("Delete")
  Then "I should not see \"#{region_name}\""
end

Then /^the media outlets for region "([^\"]*)" should become standalone media outlets$/ do |region|
  MediaOutlet.all.each do |m|
    m.region.should be_nil
  end
end

Then /^the wholesalers for region "([^\"]*)" should not be affiliated with a region$/ do |region|
  Wholesaler.all.each do |w|
    w.region.should be_nil
  end
end

Then /^I should be able to click on a media contact's email address and send them an email$/ do
  response.should have_selector "a[href='mailto:email@example.com']"
end

Then /^I should be able to add the wholesalers which are regionless$/ do
  # I would much prefer to actually select an element and submit, 
  # but labels on region_wholesaler_ids_ is tough with webrat
  Wholesaler.unassigned.each do |w|
    response.should have_selector "input[type='checkbox'][value='#{w.id}']"
  end
end

Then /^I should be able to remove the wholesalers which belong to "(.+)"$/ do |region_name|
  Region.find_by_region_name(region_name).wholesalers.each do |w|
    response.should have_selector "input[type='checkbox'][value='#{w.id}'][checked]"
  end
end

Then /^I should not be able to add the wholesalers which belong to "(.+)"$/ do |region_name|
  Region.find_by_region_name(region_name).wholesalers.each do |w|
    response.should_not have_selector "input[type='checkbox'][value='#{w.id}']"
  end
end

Then /^(wholesaler ".+") should belong to "(.+)"$/ do |wholesaler, region_name|
  wholesaler.region.should == Region.find_by_region_name(region_name)
end

Then /^I should see a list of PR regions$/ do
  Region.all.each do |r|
    response.should contain(r.region_name)
  end
end

Then /^I should see a list of event weeks$/ do
  pending
end
