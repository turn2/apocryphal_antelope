class WaterSaving < ActiveRecord::Base
  validates_presence_of :gallons
  validates_numericality_of :gallons
  attr_accessible :gallons
end
