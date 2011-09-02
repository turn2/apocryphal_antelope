Given /^a task template "(.+)"$/ do |title|
  Factory(:task_template, :title => title)
end

Given /^a task template "(.+)" due (\d) weeks prior to its event$/ do |title, due|
  Factory(:task_template, :title => title, :due_week => due.to_i)
end

Given /^there are wholesalers, task templates, and tasks$/ do
  steps %Q{
    Given there is 1 wholesaler
    And there is 1 task template
    And there should be 1 task
  }
end

When /^I choose "(.+)" for "(.+)"$/ do |field, selector|
  choose("task_template_" + selector.gsub(/ /,'_').downcase + "_#{field}")
end

When /^I add a new task template$/ do
  steps %Q{
    When I am on the new task template page
    And I enter valid task template details
    And I press "Save"
  }
end

When /^I create a new task template "(.+)"$/ do |name|
  steps %Q{
    When I am on the new task template page
    And I fill in "Title" with "#{name}"
    And I fill in "Description" with "Task template description"
    And I choose "1" for "Due Week"
    And I press "Save"
  }
end

When /^I enter valid task template details$/ do 
  steps %Q{
    When I fill in "Title" with "Order banners"
    And I fill in "Description" with "Use local vendor for printing"
    And I choose "1" for "Due Week"
  }
end

Then /^I should see that the existing task has changed$/ do
  steps %Q{
    Then I should see "Order banners"
    And I should see "Use local vendor for printing"
  }
end

Then /^the corresponding tasks should be removed from all wholesalers$/ do
  Task.count.should == 0
end
