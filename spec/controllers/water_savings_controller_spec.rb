require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe WaterSavingsController do
  describe "GET show" do
    it "should find the first WaterSaving" do
      WaterSaving.create!(:gallons => 1)
      get :show
      assigns(:water_savings).should == WaterSaving.first
    end

    it "should create a new WaterSaving if none has been created yet" do
      WaterSaving.should_receive(:create!).with(:gallons => 0)
      get :show
    end
  end

  describe "GET edit" do
    before do
      sign_in_as_manager
    end

    it "should find the first WaterSaving" do
      WaterSaving.create!(:gallons => 1)
      get :edit
      assigns(:water_savings).should == WaterSaving.first
    end

    it "should create a new WaterSaving if none has been created yet" do
      WaterSaving.should_receive(:create!).with(:gallons => 0)
      get :edit
    end
  end

  describe "PUT update" do
    before do
      sign_in_as_manager
      @mock_water_savings = mock_model(WaterSaving).as_null_object
      WaterSaving.stub!(:first).and_return(@mock_water_savings)
    end

    it "should update attributes for the first water savings" do
      @mock_water_savings.should_receive(:update_attributes).with("gallons" => "5").and_return(true)
      put :update, :water_saving => {"gallons" => '5'}
    end

    it "should redirect to the show page on success" do
      put :update, :water_saving => {"gallons" => '5'}
      response.should redirect_to(water_saving_path)
    end

    it "should redirect to the edit page on failure" do
      @mock_water_savings.stub!(:update_attributes).and_return(false)
      put :update, :water_saving => {"gallons" => "A bunch" }
      response.should redirect_to(edit_water_saving_path)
    end
  end
end
