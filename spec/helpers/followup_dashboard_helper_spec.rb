require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "FollowupDashboardHelper" do
  include FollowupDashboardHelper

  describe "followup_container_path" do
    before(:each) do
      @followup = Factory(:followup, :media_outlet => nil, :task => nil)
    end

    it "should be the path for the task if the followup belongs to a task" do
      wholesaler = Factory(:wholesaler)
      task = Factory(:task, :wholesaler => wholesaler)
      @followup.task = task
      followup_container_path(@followup).should == wholesaler_task_path(wholesaler, task)
    end

    it "should be the path for the standalone media outlet if the followup belongs to a standalone media outlet" do
      media_outlet = Factory(:media_outlet, :region => nil)
      @followup.media_outlet = media_outlet
      followup_container_path(@followup).should == media_outlet_path(media_outlet)
    end

    it "should be the region-media outlet path if the followup belongs to a region/media-outlet" do
      region = Factory(:region)
      media_outlet = Factory(:media_outlet, :region => region)
      @followup.media_outlet = media_outlet
      followup_container_path(@followup).should == region_media_outlet_path(region, media_outlet)
    end
  end
end
