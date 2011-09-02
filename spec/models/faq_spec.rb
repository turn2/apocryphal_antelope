require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Faq do
  it { should allow_mass_assignment_of(:question) }
  it { should allow_mass_assignment_of(:answer) }
  it { should allow_mass_assignment_of(:visible) }
  it { should validate_presence_of(:question) }
  it { should validate_presence_of(:answer) }

  it "should list visible faqs" do
    visible = Factory(:faq, :visible => true)
    Faq.visible.should == [visible]
  end
end
