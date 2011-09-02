Given /^I select a photo for upload$/ do
  attach_file("Upload Photo", "#{RAILS_ROOT}/spec/fixtures/test_image.jpg", "image/jpeg")
end

Given /^I select a zip file with photos for upload$/ do
  attach_file("Upload Photo", "#{RAILS_ROOT}/spec/fixtures/images_in_folders.zip", "application/zip") #application/x-zip-compressed
end

Given /^the (wholesaler ".+") has one photo$/ do |wholesaler|
  steps %Q{
    Given I am on the new photo page for "#{wholesaler.wholesaler_name}"
    When I select a photo for upload
    And I press "Upload"
    Then the wholesaler "#{wholesaler.wholesaler_name}" should have a thumbnail, medium, and full resolution photo
  }
end

Then /^the (wholesaler ".+") should have a thumbnail, medium, and full resolution photo$/ do |wholesaler|
  wholesaler.photos.last.picture.styles.keys.should include(:medium)
  wholesaler.photos.last.picture.styles.keys.should include(:thumb)
  wholesaler.photos.last.picture.default_style.should == :original
end

Then /^the (wholesaler ".+") shouldn't have any photos$/ do |wholesaler|
  wholesaler.photos.size.should == 0
end

Then /^the (wholesaler ".+") should have (\d+) photos$/ do |wholesaler, number|
  wholesaler.photos.size.should == number.to_i
end

Then /^I should see 1 photo$/ do
  within "#photos" do |div|
    div.should have_selector("a img")
  end
end
