class RenameMediaOutletAddressToStreetAddress < ActiveRecord::Migration
  def self.up
    rename_column :media_outlets, :address, :street_address
  end

  def self.down
    rename_column :media_outlets, :street_address, :address
  end
end
