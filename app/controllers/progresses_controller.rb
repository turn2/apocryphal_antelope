class ProgressesController < ApplicationController

  def show
    @wholesalers = Wholesaler.event_upcoming.paginate :page => params[:page], :per_page => 25
  end
end
