require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RegionsController do
  it "should be resourceful" do
    controller.class.should include(ResourceController::Controller)
  end

  before do
    Region.stub!(:find).and_return(mock_model(Region, :media_outlets => ["one"], :wholesalers => ["ONE"]))
    MediaOutlet.stub!(:unassigned).and_return(["two"])
    Wholesaler.stub!(:unassigned).and_return(["TWO"])
    sign_in_as_manager
  end

  describe "GET index" do
    it "should assign upcoming incomplete followups for media outlets to followups" do
      Followup.stub_chain(:for_media, :incomplete, :upcoming).and_return(["upcoming ones"])
      get :index
      assigns[:followups].should == ["upcoming ones"]
    end
  end

  describe "GET show" do

    it "should assign the region's media outlets" do
      get :show, "id" => "1"
      assigns[:media_outlets].should == ["one"]
    end
    
    it "should assign the region's wholesalers" do
      get :show, "id" => "1"
      assigns[:wholesalers].should == ["ONE"]
    end
  end

  describe "GET edit" do
    it "should make available the region's media outlets, wholesalers, and unassigned ones" do
      get :edit, "id" => "1"
      assigns[:media_outlets].should == ["one", "two"]
      assigns[:wholesalers].should == ["ONE", "TWO"]
    end
  end

  describe "GET new" do
    it "should make available unassigned media outlets and wholesalers" do
      get :new, "id" => "1"
      assigns[:media_outlets].should == ["two"]
      assigns[:wholesalers].should == ["TWO"]
    end
  end

  describe "PUT create" do
    it "should make available unassigned media outlets and wholesalers" do
      get :new, "id" => "1"
      assigns[:media_outlets].should == ["two"]
      assigns[:wholesalers].should == ["TWO"]
    end
  end
end


