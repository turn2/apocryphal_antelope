require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TaskTemplate do
  before(:each) do 
    @task_template = Factory(:task_template)
  end
  
  describe "dates" do
    it "should allow due dates between 1 and 10" do
      [1,2,10].each do |number|
        @task_template.due_week = number
        @task_template.valid?
        @task_template.errors[:due_week].should be_nil
      end
    end

    it "should not allow due dates less than 1 or greater than 10" do
      [-1,0, 11].each do |number|
        @task_template.due_week = number
        @task_template.valid?
        @task_template.errors[:due_week].should == "Must be between 1 and 10"
      end
    end
  end

  [:due_week, :title, :description].each do |attr|
    it { should validate_presence_of(attr) }
  end

  it { should have_many(:tasks).dependent(:destroy) }
  
  it "should update all wholesaler tasks after a task template is created" do
    task_template = Factory.build(:task_template)
    Wholesaler.should_receive(:create_tasks_from_task_template).with(task_template)
    task_template.save!
  end  
end
