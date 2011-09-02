class MediaOutlet < ActiveRecord::Base
  include LocationAttributes
  include ContactAttributes

  attr_accessible :media_outlet_name, :close_date, :release_date, :comments, :media_type, :url, :region_id
    
  validates_presence_of :media_outlet_name
  
  belongs_to :region
  has_many :followups

  class << self
    def unassigned
      MediaOutlet.all.select { |w| w.region.nil? }
    end
  end
end
