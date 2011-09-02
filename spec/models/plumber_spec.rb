require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Plumber do
  it { should belong_to(:user) }
  it { should belong_to(:wholesaler) }

  it_should_behave_like "a Contact"
  it_should_behave_like "a Location"

  it { should allow_mass_assignment_of(:company_name) }

  it "should require the presence of what?" do
    subject.valid?
    [:contact_name, :phone, :street_address, :city, :state, :postal_code].each do |attr|
      subject.errors.on(attr).should include("can't be blank")
    end
  end

  describe "csv_for" do
    it "should provide nice headers" do
      Plumber.csv_for([]).should == "Company Name,Contact Name,Email,Phone,Address,City,State,Zip,Cell,Fax,Other Phone,Wholesaler,Added Date,Previously Exported\n"
    end

    it "should mark a plumber exported if they are included in the csv" do
      p = Factory(:plumber)
      p.should_not be_exported
      Plumber.csv_for([p])
      p.should be_exported
    end
  end
end
