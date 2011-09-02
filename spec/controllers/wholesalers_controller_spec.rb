require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe WholesalersController do
  before do
    user = Factory(:email_confirmed_user, :role => "manager")
    sign_in_as_manager
  end

  it "should be resourceful" do
    controller.class.should include(ResourceController::Controller)
  end

  describe "Responding to GET upload" do
    it "should render the upload template" do
      get :upload
      response.should render_template("upload")
    end
  end

  describe "Responding to GET winners" do
    it "should request winning wholesalers" do
      Sweepstakes.should_receive(:winners).and_return([])
      get :winners
    end

    it "should request the csv for the winners" do
      Wholesaler.should_receive(:csv_for).with([]).and_return("")
      get :winners
    end

    it "should send the CSV as a file" do
      Wholesaler.stub(:csv_for).and_return("A CSV!")
      controller.should_receive(:send_data).with("A CSV!", :type => "text/csv", :disposition => "attachment", :filename => "sweepstakes_winners.csv")
      get :winners
    end
  end
end
