class WholesalersController < ApplicationController
  
  include CSVImports
  
  resource_controller

  create.flash "Wholesaler created successfully"

  def upload
    render :upload
  end

  def index
    @wholesalers = Wholesaler.all.paginate :page => params[:page], :per_page => 18
  end

  def import
    respond_to do |format|
      if params[:import][:upload_csv]
        begin
          results = WholesalerImporter.import(params[:import][:upload_csv].read)
          if results.succeeded?
            flash[:notice] = results.to_s
            format.html { redirect_to(wholesalers_path) }
          else
            flash[:warning] = results.to_s 
            format.html { redirect_to(upload_wholesalers_path) }
          end
        rescue FasterCSV::MalformedCSVError
          flash[:warning] = "This file is not a properly formatted CSV"
          format.html { redirect_to(upload_wholesalers_path) }
        end
      else
        flash[:warning] = "Please select a file for upload"
        format.html { redirect_to(upload_wholesalers_path) }
      end
    end
  end

  def winners
    csv = Wholesaler.csv_for(Sweepstakes.winners)
    send_data csv, :type => "text/csv", :disposition => "attachment", :filename => "sweepstakes_winners.csv"
  end
end
