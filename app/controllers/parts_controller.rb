class PartsController < ApplicationController
  resource_controller
 
  allow_wholesaler :new, :create

  belongs_to :wholesaler

  create.flash "Sales data received. You will receive an entry into the sweepstakes for each approved sale."
  create do
    before do
      @part.wholesaler = current_user.wholesaler
    end
    wants.html { redirect_to dashboard_path }
  end

  index do
    before do
      @wholesaler = parent_object
    end
    wants.html { @parts = @wholesaler.parts.paginate :page => params[:page] }
    wants.csv do
      send_data Part.csv_for(@wholesaler.parts), :type => 'text/csv',
        :filename => "parts.csv", :disposition => "attachment"
    end
  end
end
