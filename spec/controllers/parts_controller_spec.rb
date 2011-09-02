require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PartsController do
  it "should be resourceful" do
    controller.class.should include(ResourceController::Controller)
  end

  before do
    sign_in_as_manager
  end
end
