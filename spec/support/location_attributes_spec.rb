require File.dirname(__FILE__) + '/../spec_helper'

describe "Location Attributes" do
  shared_examples_for "a Location" do
    describe "Mass assignment" do
      it { should allow_mass_assignment_of(:street_address) }
      it { should allow_mass_assignment_of(:city) }
      it { should allow_mass_assignment_of(:state) }
      it { should allow_mass_assignment_of(:postal_code) }
    end
  
    describe "Validations" do
      
      it "should require a state from the Geography list" do
        Geography::STATE_AND_PROVINCE_CODES.each do |code|
          subject.state = code
          subject.valid?
          subject.errors.on(:state).should be_nil
        end
      end

      it "should not accept other things for state" do
        ["France", 0, 12334, "1024"].each do |state|
          subject.state = state
          subject.valid?
          subject.errors.on(:state).should == "must be a state or province"
        end
      end
    end

    describe "Postal codes" do
      it "should prepend zeroes as necessary to numeric short postal codes when saving" do
        ["123", "00123", "0123"].each do |postal_code|
          subject.postal_code = postal_code
          subject.postal_code.should == "00123"
        end
      end

      it "should leave blank and non-numeric postal codes alone" do
        [nil, '', "HI"].each do |bad_code|
          subject.postal_code = bad_code
          subject.postal_code.should == bad_code
        end
      end

      it "should allow both US and Canadian formats" do
        ["12345", "90210", "A1C2A2", "B2R 5M8"].each do |code|
          subject.postal_code = code
          subject.valid?
          subject.errors.on(:postal_code).should be_nil
        end
      end
    end

    describe "Geography" do
      it "should translate state codes into state names" do
        subject.state = "MI"
        subject.state_name.should == "Michigan"
      end

      it "should translate blank state codes to nil" do
        [nil, ""].each do |state|
          subject.state = state
          subject.state_name.should == nil
        end
      end

      it "should attempt to translate state names into codes" do
        subject.state = "Michigan"
        subject.state.should == "MI"
      end
    end
  end
end
