module TaskDashboardHelper
  def task_row_attributes(task)
    klasses = [ "task" ]
    klasses << "#{'in' unless task.complete}complete"
    klasses << cycle("light","dark", :name => "task_dashboard_rows")
    klasses << "urgent" if task.urgent?

    return {:class => klasses.join(" "), :id => "task_#{task[:id]}"}
  end

  def task_cell_priority(num)
    priority_color = case num
      when nil
        "green"
      when 1
        "yellow"
      else
        "red"
      end
    haml_tag :td, {:class => priority_color} do
      haml_concat num.nil? ? 0 : num
    end
  end

  def conquest_cell_priority(size)
    #FIXME: what determines priority of conquest data?
    priority_color = 'gray' # case size
    haml_tag :td, {:class => priority_color} do
      haml_concat size == 0 ? "No" : "Yes"
    end
  end

  def event_date_cell_priority(date)
    #FIXME: what determines color of event?
    priority_color = 'gray' #case date
    haml_tag :td, {:class => priority_color + ' event nowrap'} do
      haml_concat date
    end
  end

  def not_exported_priority(size)
    haml_tag :td, {:class => ( size > 0 ? 'yellow' : 'gray' )} do
      haml_concat size
    end
  end
end
