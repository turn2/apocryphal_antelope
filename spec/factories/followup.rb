Factory.define :followup do |followup|
  followup.association :task
  followup.description "This task needs following up on"
  followup.due_date Date.tomorrow
end

