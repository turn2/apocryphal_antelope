require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Followup do
  it { should belong_to(:task) }
  it { should belong_to(:media_outlet) }
  it { should have_one(:region).through(:media_outlet) }

  it { should validate_presence_of(:due_date) }
  it { should allow_mass_assignment_of(:due_date) }
  it { should allow_mass_assignment_of(:complete) }
  it { should allow_mass_assignment_of(:description) }
  it { should allow_mass_assignment_of(:task_id) }
  it { should allow_mass_assignment_of(:media_outlet_id) }

  it "should have a status of incomplete when not complete" do
    followup = Factory(:followup)
    followup.status.should == "Incomplete"
  end

  it "should have a status of complete when complete" do
    followup = Factory(:followup, :complete => true)
    followup.status.should == "Complete"
  end

  it "should require the presence of description" do
    followup = Followup.new
    followup.valid?
    followup.errors[:description].should include("can't be blank")
  end

  it "should sort followups so that incomplete ones are first by default" do
    followup1 = Factory(:followup, :complete => false)
    followup2 = Factory(:followup, :complete => true)
    followup3 = Factory(:followup, :complete => false)
    Followup.all.should == [followup1, followup3, followup2]
  end

  it "should have upcoming followups based on a due date within the next week" do
    followup1 = Factory(:followup, :due_date => Date.yesterday)
    followup2 = Factory(:followup, :due_date => Date.today + 7.days)
    followup3 = Factory(:followup, :due_date => Date.today + 8.days)
    Followup.upcoming.should == [followup1,followup2]
  end
end
