Given /^I enter a new testimonial$/ do
  fill_in "Quote", :with => "This is the best ever!"
  fill_in "Author", :with => "Doug - Plumber"
  click_button "Create Testimonial"
end

Given /^there is a published testimonial "(.+)" for (wholesaler ".+")$/ do |quote, wholesaler|
  t = wholesaler.testimonials.build(:quote => quote)
  t.visible = true
  t.save!
end

Given /^there is an unpublished testimonial "(.+)" for (wholesaler ".+")$/ do |quote, wholesaler|
  t = wholesaler.testimonials.build(:quote => quote)
  t.save!
end

Given /^there is an unpublished testimonial "(.+)" that doesn't belong to a wholesaler$/ do |quote|
  Testimonial.create!(:quote => quote)
end

Then /^I should see the new testimonial$/ do 
  Then "I should see \"This is the best ever!\""
end

Then /^the "(.+)" testimonial should be published$/ do |quote|
  Testimonial.find_by_quote(quote).should be_visible
end

Then /^the "(.+)" testimonial should not be published$/ do |quote|
  Testimonial.find_by_quote(quote).should_not be_visible
end

Then /^the "(.+)" testimonial should be deleted$/ do |quote|
  Testimonial.find_by_quote(quote).should be_nil
end

Then /^I should see the new testimonial on the wholesaler page for "(.*)"$/ do |wholesaler|
  steps %Q{
    Given I go to the wholesaler page for "#{wholesaler}"
    Then I should see "#{Testimonial.last.quote}"
  }
end

Then /^I should see the new testimonial on the public event page for "(.*)"$/ do |wholesaler|
  pending
end
