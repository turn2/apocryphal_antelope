class Task < ActiveRecord::Base
  attr_accessible :due_date, :complete
  default_scope :order => 'due_date ASC', :include => :task_template

  validates_presence_of :due_date

  belongs_to :task_template
  delegate :title, :to => :task_template
  delegate :due_week, :to => :task_template

  belongs_to :wholesaler
  has_many :followups

  named_scope :complete, :conditions => { :complete => true }
  named_scope :incomplete, :conditions => { :complete => false }
  named_scope :for_week,  lambda { |week| {
    :conditions => ["due_date BETWEEN ? and ?", week.beginning_of_week, week.end_of_week]
   }
  }
  class << self    
    def mark_complete(ids)
      update_all(["complete=?", true], :id => ids)
    end
    
    def mark_incomplete(ids)
      update_all(["complete=?", false], :id => ids)
    end    
  end
  
  def urgent?
    due_date <= Date.tomorrow and not complete
  end

  def status
    complete? ? "Complete" : "Incomplete"
  end

  def reset_due_date!
    update_attribute(:due_date, wholesaler.event_date - task_template.due_week.weeks)
  end
end
