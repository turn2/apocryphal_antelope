require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MicrositeController do
  describe "responding to get links" do
    it "should render the links page" do
      get :links
      response.should render_template(:links)
    end
  end

  describe "responding to get follow the tour" do
    it "should render the follow the tour page" do
      get :follow_the_tour
      response.should render_template(:follow_the_tour)
    end

    it "should assign a new prospect to @prospect" do
      Prospect.stub!(:new).and_return(:a_prospect)
      get :follow_the_tour
      assigns(:prospect).should equal(:a_prospect)
    end
  end

  describe "displaying winners on the prizes page" do
    it "should assign an ordered list of winners to @winners" do
      all_winners = [:winner1, :winner2, :winner3]
      Winner.stub!(:all).and_return(all_winners)
      get :prizes
      assigns(:winners).should equal(all_winners)
    end
  end
  
end
