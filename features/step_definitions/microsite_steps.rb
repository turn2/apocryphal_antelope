Given /^I am a member of the general public$/ do
  visit sign_out_path  
end

Then /^I should see logos for and links to sites such as:$/ do |table|
  table.hashes.each do |h|
    response_body.should have_xpath("//a/img[@alt='#{h[:name]}']")
  end
end

Then /^the (.+) link should be set to open in a new window$/ do |name|
  response_body.should have_xpath("//a[@target='_blank']/img[@alt='#{name}']")
end

When /^I click the American Standard Savings Calculator link$/ do
  steps %q{
    When I follow "as_calculator"
  }
end

