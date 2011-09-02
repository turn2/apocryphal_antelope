class SessionsController < Clearance::SessionsController
  include Auth::AllowAnonymous

  def url_after_create
    (current_user.manager? and task_dashboard_path) || dashboard_path
  end
end
