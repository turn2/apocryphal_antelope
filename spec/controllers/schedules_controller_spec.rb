require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SchedulesController do

  describe "Responding to GET index" do
    it "should render the index template" do
      get :index
      response.should render_template("index")
    end

    it "should find all wholesalers with event dates" do
      Wholesaler.should_receive(:with_event).and_return(:some_wholesalers)
      get :index
      assigns(:wholesalers).should equal(:some_wholesalers)
    end
  end

  describe "Responding to GET show" do
    before do
      @mock_wholesaler = mock_model(Wholesaler)
      Wholesaler.stub!(:find).with("1").and_return(@mock_wholesaler)
    end

    it "should assign the wholesaler by id" do
      get :show, :id => "1"
      assigns(:wholesaler).should equal(@mock_wholesaler)
    end
  end
end
