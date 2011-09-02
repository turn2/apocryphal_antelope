class Followup < ActiveRecord::Base
  attr_accessible :complete, :description, :task_id, :media_outlet_id, :due_date
  
  validates_presence_of :description, :due_date

  belongs_to :task
  belongs_to :media_outlet
  has_one :region, :through => :media_outlet

  #NOTE: need to sort on specific table because chaining other named scopes
  # introduces ambiguous column names for complete
  default_scope :order => ["followups.complete, followups.due_date"] 

  named_scope :complete, :conditions => {:complete => true}
  named_scope :incomplete, :conditions => {:complete => false}
  named_scope :for_media, :include => :media_outlet, :conditions => ["task_id IS NULL"]

  named_scope :upcoming, lambda {{ :conditions => ["due_date < ?", Date.today + 8.days] }}

  def status
    complete? ? "Complete" : "Incomplete"
  end

  class << self
    def mark_complete(ids)
      update_all(["complete=?", true], :id => ids)
    end

    def restart(ids)
      update_all(["complete=?", false], :id => ids)
    end
  end
end
