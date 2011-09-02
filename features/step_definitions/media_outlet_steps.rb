Given /^a media outlet "([^\"]*)"$/ do |media_outlet_name|
  Factory(:media_outlet, :media_outlet_name => media_outlet_name)
end

Given /^a media outlet "(.+)" has a follow-up "(.+)"$/ do |media_outlet, followup_description|
  steps %Q{
    Given a media outlet "#{media_outlet}"
    And the media outlet "#{media_outlet}" has a follow-up "#{followup_description}"
  }
end

Given /^the (media outlet ".+") has a follow-up "(.+)"$/ do |media_outlet, followup_description|
  media_outlet.followups.build(:description => followup_description, :due_date => Date.tomorrow)
  media_outlet.save!
end

Transform /^media outlet "(.+)"$/ do |media_outlet_name|
  MediaOutlet.find_by_media_outlet_name(media_outlet_name)
end 
