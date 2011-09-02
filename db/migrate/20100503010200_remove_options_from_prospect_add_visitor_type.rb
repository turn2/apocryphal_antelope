class RemoveOptionsFromProspectAddVisitorType < ActiveRecord::Migration
  def self.up
    remove_column :prospects, :receive_product_updates
    remove_column :prospects, :receive_tour_updates
    remove_column :prospects, :receive_updates_in_one_day
    remove_column :prospects, :message
    add_column    :prospects, :visitor_type, :string 
  end

  def self.down
    remove_column :prospects, :visitor_type
    add_column :prospects, :message, :text
    add_column :prospects, :receive_updates_in_one_day, :boolean, :default => false
    add_column :prospects, :receive_tour_updates,       :boolean, :default => false
    add_column :prospects, :receive_product_updates,    :boolean, :default => false
  end
end
