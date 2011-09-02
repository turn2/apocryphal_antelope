class TaskTemplate < ActiveRecord::Base
  attr_accessible :title, :description, :due_week

  validates_presence_of :title, :description, :due_week

  validates_inclusion_of :due_week, :in => (1..10), :message => "Must be between 1 and 10"

  has_many :tasks, :dependent => :destroy
  
  protected
  
  def after_create
    Wholesaler.create_tasks_from_task_template(self)
  end
end
