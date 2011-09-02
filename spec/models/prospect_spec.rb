require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Prospect do
  describe "Model" do

    before do
      Prospect.create!(:name => "Name", :email => "email@example.com", :visitor_type => "Wholesaler")
    end

    it { should allow_mass_assignment_of :email }
    it { should allow_mass_assignment_of :name }
    it { should allow_mass_assignment_of :opted_in }
    it { should allow_mass_assignment_of :visitor_type }
  
    it { should validate_format_of(:email).with(/(\S+)@(\S+)/) }
    it { should validate_presence_of :email }
    it { should validate_presence_of :name }
    it { should validate_presence_of :visitor_type }
    it { should validate_uniqueness_of :email }
  end

  describe "to_csv" do
    it "should return a csv string with all prospects" do
      Prospect.create!(:name => "Name, Jr", :email => "one@example.com", :opted_in => true, :visitor_type => "Wholesaler")
      Prospect.create!(:name => "Name2", :email => "one@e.com", :opted_in => false, :visitor_type => "Wholesaler")
      Prospect.create!(:name => "Name3", :email => "one@e2.com", :visitor_type => "Wholesaler")
      Prospect.to_csv.should == 
        %Q{Name,Email,Opted-in?,Visitor Type
\"Name, Jr\",one@example.com,true,Wholesaler
Name2,one@e.com,false,Wholesaler
Name3,one@e2.com,true,Wholesaler
}
    end

    it "should return just the headers if there are no prospects" do
      Prospect.to_csv.should ==
        "Name,Email,Opted-in?,Visitor Type\n"
    end
  end
end
