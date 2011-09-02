class StandaloneMediaOutletsController < ApplicationController
  resource_controller

  create.wants.html do
    redirect_to media_outlets_path
  end

  update.wants.html do
    redirect_to media_outlets_path
  end
  
  private

  def collection
    MediaOutlet.unassigned
  end

  def model_name
    'media_outlet'
  end

  def object_name
    'media_outlet'
  end

  def route_name
    'media_outlet'
  end
end
