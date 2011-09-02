Given /^there are photos for an event$/ do
  w = Wholesaler.find_by_wholesaler_name("Joe's Wholesaler")
  w.build_photos([File.open(RAILS_ROOT + "/spec/fixtures/test_image.jpg")])
end

Given /^there are testimonials for an event$/ do
  w = Wholesaler.find_by_wholesaler_name("Joe's Wholesaler")
  Factory(:testimonial, :wholesaler => w)
end

Given /^I click on that event$/ do
  click_link "Joe's Wholesaler"
end

Then /^I should see all the event dates in ascending order for those wholesalers for the entire program period$/ do
  {"Joe's Wholesaler" => 1, "Steve's Wholesaler" => 2, "Jack's Wholesaler" => 3}.each do |wholesaler_name, order|
    response.should have_selector("#events .wholesaler:nth-child(#{order.to_i})") do |content|
      content.should contain(wholesaler_name)
    end
  end
end

Then /^I should see the event locations$/ do
  Wholesaler.with_event.each do |wholesaler|
    response.should contain(wholesaler.street_address)
  end
end

Then /^I should see the photos$/ do
  within "#photos" do |div|
    div.should have_selector("img", :alt => "Test_image")
  end
end

Then /^I should see testimonials$/ do
  within "#testimonials" do |div|
    div.should contain Testimonial.last.quote
    div.should contain Testimonial.last.author
  end
end
