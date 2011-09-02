require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Region do
  it { should allow_mass_assignment_of(:region_name) }
  it { should allow_mass_assignment_of(:wholesaler_ids) }
  it { should allow_mass_assignment_of(:media_outlet_ids) }
  
  it { should validate_presence_of(:region_name) }
  
  it { should have_many(:media_outlets) }
  it { should have_many(:wholesalers) }

  describe "for_select" do
    it "should return a nice array of options" do
      r1 = Factory(:region)
      r2 = Factory(:region)
      Region.for_select.should == [[r1.region_name, r1.id],[r2.region_name, r2.id]]
    end
  end

  describe "earliest event" do
    it "should tell you the earliest event date for wholesalers belonging to it" do
      f = Factory(:region)
      w = Factory(:wholesaler, :region => f, :event_date => Date.tomorrow)
      w2 = Factory(:wholesaler, :region => f, :event_date => Date.tomorrow + 1.day)
      f.earliest_event.should == Date.tomorrow
    end

    it "should be nil if there are no wholesalers" do
      f = Factory(:region)
      f.earliest_event.should == nil
    end
  end

  describe "number of wholesalers" do
    it "should tell how many wholesalers belong to the region" do
      f = Factory(:region)
      3.times { Factory(:wholesaler, :region => f) }
      f.number_of_wholesalers.should == 3
    end
  end

  describe "outstanding tasks" do
    it "should tell how many outstanding tasks their are" do
      f = Factory(:region)
      f.stub!(:wholesalers).and_return([mock_model(Wholesaler, :outstanding_tasks => 3), mock_model(Wholesaler, :outstanding_tasks => 5)])
      f.outstanding_tasks.should == 8
    end
  end
end
