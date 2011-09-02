require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Wholesaler do
  before do 
    @wholesaler = Factory.build(:wholesaler)
  end

  it_should_behave_like "a Location"
  it_should_behave_like "a Contact"

  it { should allow_mass_assignment_of(:wholesaler_name) }
  it { should allow_mass_assignment_of(:owner) }
  it { should allow_mass_assignment_of(:event_date) }
  it { should allow_mass_assignment_of(:event_start) }
  it { should allow_mass_assignment_of(:event_end) }
  it { should allow_mass_assignment_of(:truck) }
  it { should allow_mass_assignment_of(:region_id) }
  it { should allow_mass_assignment_of(:completed_certification_sheet) }
  it { should allow_mass_assignment_of(:as_rep_name) }
  it { should allow_mass_assignment_of(:as_rep_email) }
  it { should allow_mass_assignment_of(:as_rep_phone) }
  it { should allow_mass_assignment_of(:as_rep_cell_phone) }
  it { should allow_mass_assignment_of(:as_rep_fax) }
  
  it { should validate_format_of(:as_rep_email).with(/(\S+)@(\S+)/) }
  it { should ensure_length_of(:as_rep_phone).is_equal_to(10) }
  it { should ensure_length_of(:as_rep_cell_phone).is_equal_to(10) }
  it { should ensure_length_of(:as_rep_fax).is_equal_to(10) }
  it { should validate_numericality_of(:as_rep_phone) }
  it { should validate_numericality_of(:as_rep_cell_phone) }
  it { should validate_numericality_of(:as_rep_fax) }

  it { should validate_presence_of(:wholesaler_name) }
  it { should validate_presence_of(:postal_code) }
  it { should validate_presence_of(:event_date) }


  it { should have_many(:tasks) }
  it { should have_many(:testimonials).dependent(:destroy) }
  it { should have_many(:photos).dependent(:destroy) }
  it { should have_many(:plumbers) }
  
  it { should belong_to(:region) }
  it { should have_many(:media_outlets).through(:region) }

  it { should have_many(:parts) }
  it { should have_one(:user) }

  describe "Phone numbers" do
    it "should strip out punctuation when saving" do
      ["as_rep_phone", "as_rep_cell_phone", "as_rep_fax"].each do |attr|
        subject.send(attr + "=", "(313) 444-1234")
        subject.attributes[attr].should == '3134441234'
      end
    end
  end
  
  it "should have lists of Wholesalers with upcoming and passed events" do
    upcoming = Factory(:wholesaler, :event_date => Date.tomorrow)
    passed = Factory(:wholesaler, :event_date => Date.yesterday)
    Wholesaler.event_upcoming.should == [upcoming]
    Wholesaler.event_passed.should == [passed]
  end
  
  it "should include Wholesaler events happening today in the list of upcoming events" do
    today = Factory(:wholesaler, :event_date => Date.today)
    Wholesaler.event_upcoming.should == [today]
  end
  
  it "should order Wholesalers by ascending event date by default" do
    later = Factory(:wholesaler, :event_date => 2.weeks.from_now)
    earlier = Factory(:wholesaler, :event_date => 1.day.from_now)
    Wholesaler.all.should == [earlier, later]
  end

  it "should order Wholesalers by name when asked" do
    z = Factory(:wholesaler, :wholesaler_name => "Zed")
    a = Factory(:wholesaler, :wholesaler_name => "Aaron")
    Wholesaler.by_name.should == [a, z]
  end

  it "should have lists of Wholesalers with event dates" do
    upcoming_event = Factory(:wholesaler, :event_date => Date.tomorrow)
    old_event = Factory(:wholesaler, :event_date => Date.yesterday)
    Wholesaler.with_event.should == [old_event, upcoming_event]
  end

  it "should have lists of Wholesalers not assigned to a region" do
    no_region = Factory(:wholesaler)
    region    = Factory(:wholesaler, :region => Factory(:region))
    Wholesaler.unassigned.should == [no_region]
  end
  
  it "should create tasks from the task templates for the wholesaler" do
    @wholesaler.should_receive(:create_tasks_from_task_templates)
    @wholesaler.save!
  end
  
  describe "building tasks" do
    before(:each) do 
      @wholesaler = Factory(:wholesaler, :event_date => Date.today)
    end

    it "should build an associated task from a task template" do
      @wholesaler.build_new_task(Factory.stub(:task_template))
      @wholesaler.tasks.count.should == 1
    end

    it "should set the task due date to be 'due week' weeks before its event date" do
      @wholesaler.build_new_task(Factory.stub(:task_template, :due_week => 3))
      @wholesaler.tasks.last.due_date.should == Date.today - 3.weeks
    end
  end

  describe "counting outstanding tasks" do
    before(:each) do
      @wholesaler = Factory(:wholesaler)
    end

    it "should tell how many outstanding tasks it has" do
      3.times { t = Task.create!(:description => "ToDo", :complete => false, :due_date => Date.tomorrow); t.wholesaler = @wholesaler; t.save! }
      2.times { t = Task.create!(:description => "ToDo", :complete => true, :due_date => Date.tomorrow); t.wholesaler = @wholesaler; t.save! }
      @wholesaler.reload.outstanding_tasks.should == 3
    end
  end

  describe "building photos" do
    before(:each) do
      @wholesaler = Factory(:wholesaler)
      @filelist = [] << File.open(RAILS_ROOT + "/spec/fixtures/test_image.jpg") << File.open(RAILS_ROOT + "/spec/fixtures/test_image2.jpg")
    end

    it "should build photos from a list of files" do
      @wholesaler.build_photos(@filelist)
      @wholesaler.photos.size.should == 2
    end

    it "should tell you how many photos were uploaded" do
      @wholesaler.build_photos(@filelist).should == 2
    end

    it "should ignore non-image files" do
      @filelist << File.open(RAILS_ROOT + "/spec/fixtures/one_image.zip")
      @wholesaler.build_photos(@filelist).should == 2
      @wholesaler.photos.size.should == 2
    end
  end

  describe "tasks per week" do
    it "should get collect incomplete tasks grouped by the week they are due" do
      @wholesaler.stub_chain(:tasks, :incomplete, :all).and_return([a = mock_model(Task, :due_week => 3), b = mock_model(Task, :due_week => 5)])
      @wholesaler.incomplete_tasks_per_week[3].should == [a]
      @wholesaler.incomplete_tasks_per_week[5].should == [b]
      @wholesaler.incomplete_tasks_per_week.keys.should == [3,5]
    end
  end

  describe "csv_for" do
    it "should provide nice headers" do
      Wholesaler.csv_for([]).should == "Wholesaler Name,Contact Name,Email,Phone,Address,City,State,Zip,Cell,Fax,Other Phone\n"
    end
  end

  describe "resetting task due dates" do
    it "should reset all task due dates" do
      mock_task = mock_model(Task)
      @wholesaler.stub!(:tasks).and_return([mock_task])
      mock_task.should_receive(:reset_due_date!)
      @wholesaler.reset_task_due_dates!
    end
  end
end
