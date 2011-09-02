Given /^all the wholesalers have completed their certification sheets$/ do
  Wholesaler.all.each do |w|
    w.completed_certification_sheet = true
    w.save!
  end
end


When /^the project manager runs the sweepstakes$/ do
  steps %Q{
    Given I am signed in as the VFI project manager
    And I go to the wholesaler management page
    And I follow "Generate Winner List"
  }

end

Then /^(wholesaler ".+") should have (\d+) entries in the sweepstakes$/ do |wholealer, count|
  Sweepstakes.find_entries.select { |x| x == wholealer}.size.should == count.to_i
end

Then /^the system will generate 14 winner entries and 6 alternate entries$/ do 
  response.should contain("Wholesaler Name,Contact Name,Email,Phone,Address,City,State,Zip")
  Wholesaler.all.each do |w|
    response.should contain(w.wholesaler_name)
  end
  response.headers["Content-Type"].should == "text/csv"
  response.body.split("\n").size.should == 21
end
