require File.dirname(__FILE__) + '/../spec_helper'

describe "Contact Attributes" do
  shared_examples_for "a Contact" do
    describe "Mass assignment" do
      it { should allow_mass_assignment_of(:contact_name) }
      it { should allow_mass_assignment_of(:phone) }
      it { should allow_mass_assignment_of(:cell_phone) }
      it { should allow_mass_assignment_of(:other_phone) }
      it { should allow_mass_assignment_of(:fax) }
      it { should allow_mass_assignment_of(:email) }
    end
  
    describe "Validations" do
      it { should ensure_length_of(:phone).is_equal_to(10) }
      it { should ensure_length_of(:cell_phone).is_equal_to(10) }
      it { should ensure_length_of(:other_phone).is_equal_to(10) }
      it { should ensure_length_of(:fax).is_equal_to(10) }
      it { should validate_numericality_of(:phone) }
      it { should validate_numericality_of(:cell_phone) }
      it { should validate_numericality_of(:other_phone) }
      it { should validate_numericality_of(:fax) }
      it { should validate_format_of(:email).with(/(\S+)@(\S+)/) }
    end

    describe "Phone numbers" do
      it "should strip out punctuation when saving" do
        ["phone", "cell_phone", "other_phone", "fax"].each do |attr|
          subject.send(attr + "=", "(313) 555-1212")
          subject.send(attr).should == '3135551212'
        end
      end
    end
  end
end
