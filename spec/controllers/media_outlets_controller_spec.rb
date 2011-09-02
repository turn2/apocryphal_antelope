require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MediaOutletsController do
  before do
    sign_in_as_manager
  end

  it "should be resourceful" do
    controller.class.should include(ResourceController::Controller)
  end

  def mock_region(stubs = {})
    @mock_region ||= mock_model(Region, stubs)
  end

  def mock_media_outlet(stubs = {})
    @mock_media_outlet ||= mock_model(MediaOutlet, stubs)
  end

  describe "POST create" do
   
    context "job saves successfully" do
    end
    before(:each) do
      Region.stub!(:find).and_return(mock_region(:region_name => "Tibet"))
      mock_region.stub_chain(:media_outlets, :build).and_return(mock_media_outlet(:save => true, :media_outlet_name => "BBC3"))
    end

    it "should redirect to the parent region page" do
      post :create, :media_outlet => {"media_outlet_name" => "BBC3"}, :region_id => "1"
      response.should redirect_to(region_path(mock_region))
    end

    it "should flash information about what outlet was added to what region" do
      post :create, :media_outlet => {"media_outlet_name" => "BBC3"}, :region_id => "1"
      flash[:notice].should == "BBC3 Added to Tibet"
    end
  end
  
  describe "PUT update" do
    before(:each) do
      Region.stub!(:find).and_return(mock_region(:region_name => "Tibet"))
      mock_region.stub_chain(:media_outlets).and_return(mock_media_outlet(:update_attributes => true, :media_outlet_name => "BBC3"))
      mock_media_outlet.stub!(:find).and_return(mock_media_outlet)
    end

    it "should redirect to the parent region page" do
      put :update, :media_outlet => {"media_outlet_name" => "BBC3"}, :id => "1", :region_id => "1"
      response.should redirect_to(region_path(mock_region))
    end

    it "should flash information about the updated outlet" do
      put :update, :media_outlet => {"media_outlet_name" => "BBC3"}, :id => "1", :region_id => "1"
      flash[:notice].should == "BBC3 has been updated"
    end
  end
end
