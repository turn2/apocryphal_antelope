Given /^I enter information about an approved part sale$/ do
  fill_in("Product name", :with => "A Cool Part")
  fill_in("Quantity", :with => "2")
  fill_in("Total sale price", :with => "$35.45")
  fill_in("Part number", :with => "ABC123")
  And "I select \"12/24/2010\" as the \"Date of sale\" date"
end

Then /^the approved part sale should be attributed to the (wholesaler ".+")$/ do |wholesaler|
  Part.last.wholesaler.should == wholesaler
end
