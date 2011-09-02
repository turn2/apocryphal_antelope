Given /^I enter a new question and answer$/ do
  fill_in 'Question', :with => "x + 3 = 5.  Find x"
  fill_in 'Answer', :with => "x = 2"
  click_button 'Create FAQ'
end

Given /^a frequently asked question has been created$/ do
  steps %Q{
    Given I go to the new faq page
    Given I enter a new question and answer
  }
end

Given /^the faq answer contains "(.+)"$/ do |contents|
  f = Faq.last
  f.answer = contents
  f.save!
end

Given /^I change the answer$/ do
  fill_in 'Answer', :with => "Here it is!"
  click_button "Save Changes to FAQ"
end

Given /^it is approved$/ do
  Faq.mark_visible(Faq.last)
end

Given /^I mark the question Approved$/ do
  click_button 'Send Live'
end

Given /^I mark the question Hidden$/ do
  click_button 'Hide From Public'
end

Then /^I should see the new question and answer$/ do
  steps %Q{
    Then I should see "x = 2"
  }
end

Then /^the question should be updated$/ do
  steps %Q{
    Then I should see "Here it is"
  }
end

Then /^it should be visible on the public page$/ do
  steps %Q{
    When I go to the public faq page
    Then I should see "x = 2"
  }
end 

Then /^it should not be visible on the public page$/ do
  steps %Q{
    When I go to the public faq page
    Then I should not see "x + 3 = 5.  Find x"
  }
end

Then /^I should see an external link to "(.+)"$/ do |url|
  response_body.should have_selector("a[href='#{url}'][class='external']")
  response_body.should contain url
end
