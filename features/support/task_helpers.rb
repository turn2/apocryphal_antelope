module TaskHelpers
  def create_task_with_title(title, args={})
    wholesaler = Factory(:wholesaler)
    template = Factory(:task_template, :title => title)
    wholesaler.should have(1).tasks
  end
end

World(TaskHelpers)