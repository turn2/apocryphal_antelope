class WholesalerBelongsToRegion < ActiveRecord::Migration
  def self.up
    add_column :wholesalers, :region_id, :integer
  end

  def self.down
    remove_column :wholesalers, :regions_id
  end
end
