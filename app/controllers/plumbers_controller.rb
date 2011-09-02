class PlumbersController < ApplicationController
  resource_controller

  allow_wholesaler :new, :create

  belongs_to :wholesaler

  create.flash "Data received."
  create do
    before do
      @plumber.user = current_user
      @plumber.wholesaler = current_user.wholesaler
    end
    wants.html { redirect_to dashboard_path }
  end

  index do
    before do
      @wholesaler = parent_object
    end
    wants.html { @plumbers = @wholesaler.plumbers.paginate :page => params[:page] }
    wants.csv do
      send_data Plumber.csv_for(@wholesaler.plumbers), :type => 'text/csv',
        :filename => "plumbers.csv", :disposition => "attachment"
    end
  end
end
