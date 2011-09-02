Given /^I am signed in as the VFI project manager$/ do
  steps %Q{
    Given I am signed up and confirmed as "vfimanager@domain.com/letmein"
    And the user "vfimanager@domain.com" has the manager role
    And I sign in as "vfimanager@domain.com/letmein"
  }
end

Given /^I am signed in as a Wholesaler for (wholesaler ".+")$/ do |wholesaler|
  steps %Q{
    Given I am signed up and confirmed as "wholesaler@example.com/letmein"
    And the user "wholesaler@example.com" has the wholesaler role
  }
  u = User.find_by_email("wholesaler@example.com")
  u.wholesaler = wholesaler
  u.save!
  And "I sign in as \"wholesaler@example.com/letmein\""
end

Given /^the (user ".+") has the (.+) role$/ do |user, role|
  user.update_attributes!(:role => role)
end

Given /^a user "(.+)" for the wholesaler "(.+)"$/ do |email, name|
  steps %Q{
    Given a wholesaler "#{name}"
    And I am signed up and confirmed as "#{email}/letmein"
    And the user "#{email}" has the wholesaler role
  }
  wholesaler = Wholesaler.find_by_wholesaler_name(name)
  wholesaler.user = User.find_by_email(email)
  wholesaler.save!
end

Then /^the password for "(.+)" should be "(.+)"$/ do |email, password|
  User.authenticate(email, password).should be_an_instance_of(User)
end

Transform /^user "(.+)"$/ do |email|
  User.find_by_email(email) || raise("Cannot find user by #{email}")
end
