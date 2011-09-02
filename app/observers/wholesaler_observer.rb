class WholesalerObserver < ActiveRecord::Observer
  def after_update(wholesaler)
    if wholesaler.event_date_changed?
      wholesaler.reset_task_due_dates!
    end
  end
end
