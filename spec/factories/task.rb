Factory.define :task do |task|
  task.association :task_template
  task.title       "Task Title"
  task.description "Task Description"
  task.due_date    Date.today + 9.weeks
end

Factory.define :task_due_tomorrow, :parent => :task do |task|
  task.due_date Date.tomorrow
end
