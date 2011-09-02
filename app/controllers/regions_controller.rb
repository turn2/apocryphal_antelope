class RegionsController < ApplicationController
  resource_controller

  before_filter :load_unassigned_collections, :only => [:new, :create]
  before_filter :load_available_collections, :only => [:edit, :update]
  before_filter :load_assigned_collections, :only => [:show]
  
  create.flash { "Region #{@region.region_name} Created" }

  index.before do
    @followups = Followup.for_media.incomplete.upcoming
  end

  private

  def load_unassigned_collections
    @wholesalers = Wholesaler.unassigned
    @media_outlets = MediaOutlet.unassigned
  end

  def load_assigned_collections
    @media_outlets = object.media_outlets
    @wholesalers = object.wholesalers
  end
  
  def load_available_collections
    @wholesalers = object.wholesalers + Wholesaler.unassigned
    @media_outlets = object.media_outlets + MediaOutlet.unassigned
  end
end
