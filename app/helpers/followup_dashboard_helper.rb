module FollowupDashboardHelper
  def followup_row_attributes(followup)
    klasses = [ "followup" ]
    klasses << "#{'in' unless followup.complete}complete"
    klasses << cycle("light","dark", :name => "followup_dashboard_rows")
    klasses << "media_outlet_followup" if followup.media_outlet
    klasses << "task_followup" if followup.task

    return {:class => klasses.join(" "), :id => "followup_#{followup[:id]}"}
  end

  def followup_container_path(followup)
    if followup.task
      wholesaler_task_path(followup.task.wholesaler, followup.task)
    else
      if followup.media_outlet.region
        region_media_outlet_path(followup.media_outlet.region, followup.media_outlet)
      else
        media_outlet_path(followup.media_outlet)
      end
    end
  end
end
