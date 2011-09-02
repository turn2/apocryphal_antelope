Given /^a task "(.+)" is due tomorrow$/ do |task_title|
  create_task_with_title(task_title, :due_date => Date.tomorrow)
end

Given /^a task "(.+)"$/ do |task_title|
  create_task_with_title(task_title)
end

Given /^the following tasks exist:$/ do |table|
  table.hashes.each do |hash|
    template = Factory(:task_template, :title => hash['Title'], :description => hash['Description'])
    wholesaler = Factory(:wholesaler, :wholesaler_name => hash['Wholesaler'])
    task = wholesaler.tasks.last
    task.due_date = Date.parse(hash['Due Date'])
    task.save!
  end
end

Given /^the (".+" task) is complete$/ do |task|
  task.update_attribute(:complete, true)
end

Given /^the (".+" task) has a follow-up "(.+)"$/ do |task, followup_description|
  task.followups.build(:description => followup_description, :due_date => Date.tomorrow)
  task.save!
end

Given /^I mark the (".+" task) complete$/ do |task|
  within("#task_#{task.id}") do
    check("task_ids[]")
  end
end

Given /^I mark the (".+" follow-up) complete$/ do |followup|
  within("#followup_#{followup.id}") do
    click_link("Mark Complete")
  end
end

Given /^I restart the (".+" task)$/ do |task|
  click_link_within("#task_#{task.id}", "Restart")
end

Then /^the (".+" task) for "(.+)" should be due (\d+) weeks from now$/ do |task, wholesaler_name, num_weeks|
  within("#task_#{task.id}") do |content|
    content.should have_selector(".title", :content => task.title)
    content.should have_selector(".wholesaler", :content => wholesaler_name)
    content.should have_selector(".due_date", :content => (Date.today + num_weeks.to_i.weeks).strftime )
  end
end

Then /^the task "(.+)" should be marked (\w+)$/ do |task_title, status|
  if status == 'complete'
    steps %Q{
      When I go to the task dashboard
      And I follow "View complete tasks"
      Then I should see "#{task_title}"
      }
  else
    steps %Q{
      When I go to the task dashboard
      Then I should see "#{task_title}"
      }
  end
end

Then /^the (".+" task) should have (\d+) follow-ups?$/ do |task, num|
  task.should have(num.to_i).followups
end

Then /^I should see "(.+)" for the (".+" follow-up)$/ do |message, followup|
  within("#followup_#{followup.id}") do |content|
    content.should contain(message)
  end
end

Then /^I should see that the task status is "(.+)"$/ do |status|
  Then "I should see \"#{status}\" within \"#task_status\""
end

Then /^the (".+" task) for "(.+)" should be due on "(.+)"$/ do |task, wholesaler, date|
  task.due_date.should == Date.parse(date)
end

Transform /^"(.+)" task$/ do |task_name|
  Task.find_by_title(task_name)
end 

Transform /^"(.+)" follow-up$/ do |followup_name|
  Followup.find_by_description(followup_name)
end
