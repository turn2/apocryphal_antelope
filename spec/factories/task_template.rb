Factory.sequence :template_title do |n|
  "Template Title #{n}"
end

Factory.define :task_template do |template|
  template.title { Factory.next :template_title }
  template.description "Description"       
  template.due_week 1
end
