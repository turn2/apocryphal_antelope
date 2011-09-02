class AddRegionIdToMediaOutlet < ActiveRecord::Migration
  def self.up
    add_column :media_outlets, :region_id, :integer
  end

  def self.down
    remove_column :media_outlets, :region_id
  end
end
