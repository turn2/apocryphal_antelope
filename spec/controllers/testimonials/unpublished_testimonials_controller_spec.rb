require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Testimonials::UnpublishedTestimonialsController do
  it "should be resourceful" do
    controller.class.should include(ResourceController::Controller)
  end

  before do
    sign_in_as_manager
    @request.env['HTTP_REFERER'] = 'http://whatever.com'
  end

  describe "Responding to GET index" do
    it "should fetch all the recent assigned testimonials" do
      Testimonial.should_receive(:recent).and_return(Testimonial)
      Testimonial.should_receive(:unassigned).and_return(Testimonial)
      Testimonial.should_receive(:paginate)
      get :index
    end
  end

  describe "Responding to PUT approve" do
    it "should mark a testimonial visible" do
      Testimonial.should_receive(:mark_visible).with("4")
      put :approve, {:id => '4'}
    end

    it "should redirect to back" do
      Testimonial.stub!(:mark_visible).and_return(true)
      put :approve, {:id => '4'}
      response.should redirect_to('http://whatever.com')      
    end
  end
end
