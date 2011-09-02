require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe FaqsController do
  it "should be resourceful" do
    controller.class.should include(ResourceController::Controller)
  end

  before do
    sign_in_as_manager
  end

  describe "Responding to GET index" do
    it "should fetch all the visible faqs" do
      Faq.should_receive(:visible)
      get :index
    end

    it "should allow anonymous users" do
      sign_out
      get :index
      response.should be_success
    end
  end

  describe "Responding to POST create" do
    it "should redirect to the management page" do
      post :create, :faq => {:question => "Hi?", :answer => "No."}
      response.should redirect_to(manage_faqs_path)
    end
  end

  describe "Responding to PUT update" do
    it "should redirect to the management page" do
      Faq.stub!(:find).and_return(mock("Coupon", :update_attributes => true))
      put :update, :id => 2, :faq => {:question => "Hi?", :answer => "No."}
      response.should redirect_to(manage_faqs_path)
    end
  end

  describe "Responding to GET manage" do
    it "should get all the faqs" do
      Faq.should_receive(:all)
      get :manage
    end
  end

  describe "Responding to GET index" do
    it "should get all the visible faqs" do
      Faq.should_receive(:visible)
      get :index
    end
  end

  describe "Responding to PUT approve" do
    before do
      Faq.stub!(:mark_visible).with('3').and_return(true)
    end

    it "should mark a faq visible" do 
      Faq.should_receive(:mark_visible).with('3')
      put :approve, {:id => 3}
    end

    it "should redirect to manage faqs" do
      put :approve, {:id => 3}
      response.should redirect_to(manage_faqs_path)
    end
  end

  describe "Responding to PUT hide" do
    before do
      Faq.stub!(:mark_hidden).with('3').and_return(true)
    end

    it "should mark a faq hidden" do 
      Faq.should_receive(:mark_hidden).with('3')
      put :hide, {:id => 3}
    end

    it "should redirect to manage faqs" do
      put :hide, {:id => 3}
      response.should redirect_to(manage_faqs_path)
    end
  end

  describe "Sorting" do
    before(:each) do
      @faq1 = Factory.create(:faq)
      @faq2 = Factory.create(:faq)
      Faq.stub!(:all).and_return([@faq1, @faq2])
    end

    it "should get all the faqs" do
      Faq.should_receive(:all)
      put :sort, {"faq" => ["1","2"]}
    end

    it "should update the position of a faq with its index from a list" do
      @faq2.should_receive(:position=).with(1)
      put :sort, {"faq" => [@faq2.id.to_s,@faq1.id.to_s]}
    end
  end
end


