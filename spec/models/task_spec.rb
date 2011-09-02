require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Task do
  it "should list all tasks according to their due date" do
    later_task = Factory(:task, :due_date => 1.week.from_now.to_date)
    earlier_task = Factory(:task, :due_date => 1.day.from_now.to_date)
    tasks = Task.all
    tasks.index(earlier_task).should < tasks.index(later_task)
  end
  
  it "should list complete and incomplete tasks" do
    complete = Factory(:task, :complete => true)
    incomplete = Factory(:task)
    Task.complete.should == [complete]
    Task.incomplete.should == [incomplete]
  end

  it { should belong_to(:task_template) }
  it { should belong_to(:wholesaler) }
  it { should have_many(:followups) }
  
  it { should allow_mass_assignment_of(:complete) }
  
  it "should have the same title as its task template" do
    task = Factory(:task)
    task.title.should == task.task_template.title
  end

  it "should have the same due week as its task template" do
    task = Factory(:task)
    task.due_week.should == task.task_template.due_week
  end

  it "should be urgent if due tomorrow and incomplete" do
    task = Factory(:task, :due_date => Date.tomorrow)
    task.should be_urgent
  end
  
  it "should be urgent if it is past due" do
    task = Factory(:task, :due_date => Date.yesterday)
    task.should be_urgent
  end

  it "should not be urgent if due tomorrow and complete" do
    task = Factory(:task, :due_date => Date.tomorrow, :complete => true)
    task.should_not be_urgent
  end

  it "should have a status of incomplete when not complete" do
    task = Factory(:task)
    task.status.should == "Incomplete"
  end

  it "should have a status of complete when complete" do
    task = Factory(:task, :complete => true)
    task.status.should == "Complete"
  end

  context "resetting due date" do
    it "should set the task due date to be the task template's 'due week' weeks before the wholesaler's event date" do
      task = Factory(:task, :due_date => Date.today - 1.year)
      task.stub!(:wholesaler).and_return(mock_model(Wholesaler, :event_date => Date.tomorrow))
      task.stub!(:task_template).and_return(mock_model(Task, :due_week => 3))
      task.reset_due_date!
      task.due_date.should == (Date.tomorrow - 3.weeks)
    end
  end
end
