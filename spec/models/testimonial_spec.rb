require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Testimonial do
  
  it { should belong_to(:wholesaler) }
  
  it { should allow_mass_assignment_of(:quote) }
  it { should allow_mass_assignment_of(:author) }
  it { should allow_mass_assignment_of(:wholesaler_id) }
  it { should validate_presence_of(:quote) }

  it "should list visible testimonials" do
    visible = Factory(:testimonial, :visible => true)
    Testimonial.visible.should == [visible]
  end

  it "should list recent testimonials" do
    first  = Factory(:testimonial, :visible => false)
    nope = Factory(:testimonial, :visible => true)
    third = Factory(:testimonial, :visible => false)
    Testimonial.recent.should == [third, first] 
  end
end
