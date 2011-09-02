class TaskDashboardController < ApplicationController
  def index
    @complete = params[:complete]
    if @complete
      @tasks = Task.complete.paginate :page => params[:page]
    else
      @tasks = Task.incomplete.paginate :page => params[:page]
    end
  end

  def complete
    Task.mark_complete(params[:task_ids])
    flash[:notice] = "Selected asks were successfully completed"
    redirect_to task_dashboard_path
  end
    
  def complete_single
    Task.mark_complete(params[:id])
    flash[:notice] = "Task was successfully completed"
    redirect_to request.referrer 
  end
  
  def restart
    Task.mark_incomplete(params[:id])
    flash[:notice] = "Task was successfully restarted"
    redirect_to request.referrer 
  end
end
