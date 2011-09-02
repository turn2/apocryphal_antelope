require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe StandaloneMediaOutletsController do
  it "should be resourceful" do
    controller.class.should include(ResourceController::Controller)
  end

  before do
    sign_in_as_manager
  end

  describe "POST create" do
    it "should redirect to the standalone media outlets page" do
      post :create, :media_outlet => {"media_outlet_name" => "BBC3"}
      response.should redirect_to(media_outlets_path)
    end
  end

  describe "GET index" do
    it "should assign only media outlets with no region to @media_outlets" do
      MediaOutlet.should_receive(:unassigned).and_return("Standalone ones!")
      get :index
      assigns(:media_outlets).should == "Standalone ones!"
    end
  end
end
