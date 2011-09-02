# Overkill?
Given /^there (is|are) (\d+) (.*)$/ do |_, number, model|
  (number.to_i -  model.singularize.titleize.gsub(/ /,'').constantize.count).times do 
    Factory(model.singularize.gsub(/ /,'_').to_sym)
  end
end

Given /^the following (.*) (is|are) created:$/ do |model, _, table|
  table.hashes.each do |hash|
    m = Factory.build(model.singularize.gsub(/ /,'_').to_sym)
    hash.each { |k,v|  m.send(k.downcase.gsub(/ /,'_') + "=", v) }
    m.save!
  end
end

Given /^a CSV named "(.+)" with the following content:$/ do |name, table|
  csv_contents = table.raw.map{|row| row.join(",")}.join("\n")
  File.open("#{RAILS_ROOT}/features/support/tmp_files/#{name}", "w") do |f|
    f.write(csv_contents)
  end
end

Then /^there should be (\d+) (.*)$/ do |number, model|
  model.singularize.titleize.gsub(/ /,'').constantize.count.should == number.to_i
end

Then /^I should see the "(.+)" button$/ do |button_name|
  response.should have_selector("input[type=submit]", :value => button_name)
end

# http://felipero.posterous.com/a-simple-dateselect-matcher-for-cucumber-with
# We can improve on this, but it works well for now
Then /^the selected date for "([^"]*)" should be "([^"]*)"$/ do |field, date|
  field = field.tr('[]', '_')
  year, month, day = %w(1 2 3).map{|n| field + n + "i" }
 
  date = Date.parse(date)
 
  field_with_id(year).element.search(".//option[@selected = 'selected']").inner_html.should =~ /#{date.year}/
  field_with_id(month).element.search(".//option[@selected = 'selected']").inner_html.should =~ /#{date.strftime('%B')}/
  field_with_id(day).element.search(".//option[@selected = 'selected']").inner_html.should =~ /#{date.day}/
end

Then /^I should see the following:$/ do |content|
  content.split("\n").each do |line|
    response.should contain(line)
  end
end

Then /^I should see a warning$/ do
  steps %Q{
    Then I should see "Please select"
  }
end
