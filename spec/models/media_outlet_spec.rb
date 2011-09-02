require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MediaOutlet do
  it_should_behave_like "a Location"
  it_should_behave_like "a Contact"

  it { should have_many(:followups) }

  it { should allow_mass_assignment_of(:media_outlet_name) }
  it { should allow_mass_assignment_of(:url) }
  it { should allow_mass_assignment_of(:media_type) }
  
  it { should validate_presence_of(:media_outlet_name) }
  
  it { should belong_to(:region) }
  
  it { should allow_mass_assignment_of(:close_date) }
  
  it { should allow_mass_assignment_of(:release_date) }
  
  it { should allow_mass_assignment_of(:comments) }

  describe "unassigned" do
    it "should return media outlets which have no region" do
      stand_alone = [Factory(:media_outlet)]
      not_stand_alone = Factory(:media_outlet, :region => Region.create!(:region_name => "My Region"))
      MediaOutlet.unassigned.should == stand_alone
    end
  end
  
end
