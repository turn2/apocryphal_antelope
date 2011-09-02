require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TestimonialsController do
  it "should be resourceful" do
    controller.class.should include(ResourceController::Controller)
  end

  before do
    sign_in_as_manager
  end

  describe "Responding to PUT approve" do
    before do
      Testimonial.stub!(:mark_visible).with('3').and_return(true)
      @request.env['HTTP_REFERER'] = 'http://whatever.com'
    end

    it "should mark a testimonial visible" do 
      Testimonial.should_receive(:mark_visible).with('3')
      put :approve, {:id => 3}
    end

    it "should redirect back" do
      put :approve, {:id => 3}
      response.should redirect_to('http://whatever.com')
    end
  end

  describe "Responding to POST create" do
    before do
      @request.env['HTTP_REFERER'] = 'http://whatever.com'
      @testimonial = mock_model(Testimonial)
      Testimonial.stub!(:new).and_return(@testimonial)
    end

    it "should redirect back on success" do
      @testimonial.stub!(:save).and_return(true)
      post :create, {:quote => "hi"}
      response.should redirect_to("http://whatever.com")
    end

    it "should redirect back on failure" do
      @testimonial.stub!(:save).and_return(false)
      post :create, {:quote => ""}
      response.should redirect_to("http://whatever.com")
    end
  end
end
