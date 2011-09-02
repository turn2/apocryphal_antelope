require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ProspectsController do
  before do
    sign_in_as_manager
  end

  it "should be resourceful" do
    controller.class.should include(ResourceController::Controller)
  end

  describe "responding to GET index" do
    context "csv" do
      it "should get a csv from Prospects when asked for" do
        Prospect.should_receive(:to_csv).and_return("some csv contents")
        get :index, :format => "csv"
      end

      it "should send the data as an attachment in the proper format" do
        Prospect.stub!(:to_csv).and_return("A CSV!")
        controller.should_receive(:send_data).with("A CSV!", :type => "text/csv", :disposition => "attachment")
        get :index, :format => "csv"
      end
    end
  end

  describe "responding to POST subscribe" do
    before do
      @params = {"name" => "Name", "email" => "string@email.com", "opted_in" => true}
      @mock_prospect = mock_model(Prospect, :save => true).as_null_object
    end

    context "Adding or updating" do
      it "should find or create a new prospect" do
        Prospect.should_receive(:find_or_create_by_email).with("string@email.com").and_return(@mock_prospect)
        @mock_prospect.should_receive(:update_attributes).with(@params).and_return(true)
        post :subscribe, :prospect => @params
      end

      it "should redirect back to the follow the tour page" do
        post :subscribe, :prospect => {:name => "Name", :email => "my@email.com"}
        response.should redirect_to( follow_the_tour_path)
      end
    end

    context "Bad input" do
      it "should redirect to the follow the tour path" do
        post :subscribe, :prospect => {:name => "", :email => "notvalid"}
        response.should redirect_to( follow_the_tour_path)
      end
    end
  end
end


