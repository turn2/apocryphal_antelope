require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Testimonials::PublishedTestimonialsController do
  it "should be resourceful" do
    controller.class.should include(ResourceController::Controller)
  end

  before do
    sign_in_as_manager
  end

  describe "Responding to GET index" do
    it "should fetch visible testimonials" do
      Testimonial.should_receive(:visible)
      get :index
    end
  end

  describe "Responding to POST sort" do
    before(:each) do
      @testimonial1 = Factory.create(:testimonial)
      @testimonial2 = Factory.create(:testimonial)
      Testimonial.stub!(:visible).and_return([@testimonial1, @testimonial2])
    end

    it "should retrieve all the visible testimonials" do
      Testimonial.should_receive(:visible)
      put :sort, {"testimonial" => ["1","2"]}
    end

    it "should update the position of a testimonial with its index from a list" do
      @testimonial2.should_receive(:position=).with(1)
      put :sort, {"testimonial" => [@testimonial2.id.to_s,@testimonial1.id.to_s]}
    end
  end

  describe "Responding to PUT hide" do
    before do
      Testimonial.stub!(:mark_hidden).with('3').and_return(true)
      @request.env['HTTP_REFERER'] = 'http://whatever.com'
    end

    it "should mark a testimonial hidden" do 
      Testimonial.should_receive(:mark_hidden).with('3')
      put :hide, {:id => 3}
    end

    it "should redirect to back" do
      put :hide, {:id => 3}
      response.should redirect_to('http://whatever.com')
    end
  end
end
