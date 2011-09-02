class SchedulesController < ApplicationController
  include Auth::AllowAnonymous

  def index
    @wholesalers = Wholesaler.with_event
  end

  def show
    @wholesaler = Wholesaler.find(params["id"])
  end
end
