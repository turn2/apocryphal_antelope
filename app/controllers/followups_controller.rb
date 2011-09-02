class FollowupsController < ApplicationController
  resource_controller

  create do
    wants.html { redirect_to :back }
  end

  destroy do
    wants.html { redirect_to :back }
  end

  index.before do
    @complete = params[:complete]
  end

  def mark_complete
    Followup.mark_complete(params[:id])
    flash[:notice] = "Follow-up was successfully completed"
    redirect_to request.referrer
  end

  def restart
    Followup.restart(params[:id])
    flash[:notice] = "Follow-up was successfully restarted"
    redirect_to request.referrer
  end

  private

  def collection
    if params[:complete]
      @collection ||= end_of_association_chain.complete.paginate :page => params[:page]
    else
      @collection ||= end_of_association_chain.incomplete.paginate :page => params[:page]
    end
  end
end
