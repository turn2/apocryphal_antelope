Given /^there are already several wholesalers$/ do
  9.times do |num|
    Factory(:wholesaler, :event_date => (Date.today - 5.days + num.days)) 
  end
end

Given /every wholesaler has a bunch of tasks$/ do
  Wholesaler.all.each_with_index do |ws, index|
    t = Factory(:task, :complete => index % 2 == 0 ? true : false, :wholesaler => ws)
  end
end

And /some of those tasks have already been completed$/ do
end

Then /^I should see a list of all of the wholesalers whose events are coming up$/ do
  Wholesaler.event_upcoming.all.each do |ws|
    Then "I should see \"#{ws.wholesaler_name}\""
  end
  Wholesaler.event_passed.all.each do |ws|
    Then "I should not see \"#{ws.wholesaler_name}\""
  end
end
