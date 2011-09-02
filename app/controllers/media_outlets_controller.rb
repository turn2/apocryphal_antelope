class MediaOutletsController < ApplicationController
  resource_controller
  
  belongs_to :region

  update.wants.html do
    flash[:notice] = "#{object.media_outlet_name} has been updated"
    redirect_to smart_url(parent_url_options)
  end

  create.wants.html do
    flash[:notice] = "#{object.media_outlet_name} Added to #{parent_object.region_name}"
    redirect_to smart_url(parent_url_options) 
  end
end
