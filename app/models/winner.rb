class Winner < ActiveRecord::Base
  attr_accessible :winner_name, :wholesaler_id

  validates_presence_of :winner_name

  default_scope :order => :position

  acts_as_list

  belongs_to :wholesaler
end
