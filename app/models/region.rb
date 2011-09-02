class Region < ActiveRecord::Base
  attr_accessible :region_name, :wholesaler_ids, :media_outlet_ids
  
  validates_presence_of :region_name
  
  has_many :media_outlets
  has_many :wholesalers

  class << self 
    def for_select
      Region.all.collect { |p| [p.region_name, p.id] }
    end
  end

  def earliest_event
    wholesalers.collect(&:event_date).sort.first
  end

  def number_of_wholesalers
    wholesalers.size
  end

  def outstanding_tasks
    wholesalers.inject(0) { |sum, w| sum + w.outstanding_tasks }
  end
end
