require 'fastercsv'

class Prospect < ActiveRecord::Base

  VISITOR_TYPES = [ "Wholesaler",
                    "Retailer",
                    "Plumber", 
                    "Consumer/End User" ]

  attr_accessible :name, :email, :opted_in, :visitor_type
  
  validates_presence_of :name, :email, :visitor_type
  validates_format_of   :email, :with => EmailValidator::EMAIL_FORMAT
  validates_uniqueness_of :email
  validates_inclusion_of :visitor_type, :in => VISITOR_TYPES

  class << self
    def to_csv
      FasterCSV.generate do |csv|
        csv << ["Name", "Email", "Opted-in?", "Visitor Type"]
        all.each do |prospect|
          csv << [prospect.name, prospect.email, prospect.opted_in?, prospect.visitor_type]
        end
      end
    end
  end
end
