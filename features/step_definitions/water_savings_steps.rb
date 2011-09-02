Given /^there have been (\d+) gallons saved$/ do |gallons|
  WaterSaving.create!(:gallons => gallons.to_i)
end

Then /^I should be able to update the number of gallons saved$/ do
  steps %Q{
    When I fill in "gallons" with "1001"
    And I press "Save changes"
  }
  WaterSaving.first.gallons.should == 1001
end
