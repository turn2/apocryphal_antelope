require 'fastercsv'

class Plumber < ActiveRecord::Base
  include LocationAttributes
  include ContactAttributes

  validates_presence_of :contact_name, :phone, :street_address, :city, :state, :postal_code

  attr_accessible :company_name

  belongs_to :user
  belongs_to :wholesaler

  named_scope :not_exported, :conditions => {:exported => false}

  class << self
    def csv_for(plumbers)
      FasterCSV.generate do |csv|
        csv << [ "Company Name", "Contact Name", "Email", "Phone", "Address", "City", "State", "Zip", "Cell", "Fax", 
                 "Other Phone", "Wholesaler", "Added Date", "Previously Exported"]
        plumbers.each do |plumber|
          csv << [ plumber.company_name, plumber.contact_name, plumber.email, plumber.phone, plumber.street_address,
                   plumber.city, plumber.state, plumber.postal_code, plumber.cell_phone, plumber.fax, plumber.other_phone,
                   plumber.wholesaler.wholesaler_name, plumber.created_at, plumber.exported?]
          plumber.exported = true
          plumber.save!
        end
      end
    end

    def csv
      csv_for(all)
    end
  end
end
