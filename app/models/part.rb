require 'fastercsv'

class Part < ActiveRecord::Base

  validates_presence_of :part_name, :quantity, :total_sale_price, :part_number, :date_of_sale
  validates_numericality_of :quantity, :only_integer => true, :greater_than => 0, :message => "must be a whole number greater than 0"

  validates_numericality_of :total_sale_price_in_cents, :only_integer => true, :greater_than => 0, :message => "must be greater than 0"
  
  attr_accessible :part_name, :quantity, :total_sale_price, :part_number, :date_of_sale
  
  belongs_to :wholesaler

  money :total_sale_price, :cents => :total_sale_price_in_cents, :currency => false

  class << self
    def csv_for(parts)
      FasterCSV.generate do |csv|
        csv << [ "Product Name", "Quantity", "Total Sale Price", "Part Number", "Date of Sale", "Wholesaler"]
        parts.each do |part|
          csv << [ part.part_name, part.quantity, part.total_sale_price.format, part.part_number, part.date_of_sale, part.wholesaler.wholesaler_name]
        end
      end
    end

    def csv
      csv_for(all)
    end
  end
end
