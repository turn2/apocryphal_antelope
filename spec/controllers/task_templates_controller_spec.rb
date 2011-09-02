require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TaskTemplatesController do
  it "should be resourceful" do
    controller.class.should include(ResourceController::Controller)
  end
end
