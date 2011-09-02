require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe WinnersController do
  it "should be resourceful" do
    controller.class.should include(ResourceController::Controller)
  end

  before do
    sign_in_as_manager
  end

  describe "Responding to POST create" do
    it "should redirect to the index" do
      post :create, :winner => {:winner_name => "Dave", :wholesaler_id => "4"}
      response.should redirect_to(winners_path)
    end
  end

  describe "Sorting" do
    before(:each) do
      @winner1 = Factory.create(:winner)
      @winner2 = Factory.create(:winner)
      Winner.stub!(:all).and_return([@winner1, @winner2])
    end

    it "should get all the winners" do
      Winner.should_receive(:all)
      put :sort, {"winner" => ["1","2"]}
    end

    it "should update the position of a faq with its index from a list" do
      @winner2.should_receive(:position=).with(1)
      put :sort, {"winner" => [@winner2.id.to_s,@winner1.id.to_s]}
    end
  end
end


