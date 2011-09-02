require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Photo do
  it { should belong_to(:wholesaler) }

  [:picture].each do |attr|
    it { should allow_mass_assignment_of(attr) }
  end
  
  [:picture_file_name, :picture_content_type, :picture_file_size].each do |attr|
    Photo.new.attribute_names.include?(attr.to_s).should == true 
    it { should_not allow_mass_assignment_of(attr)}
  end
end
