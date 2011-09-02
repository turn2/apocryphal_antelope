class AddMediaTypeToMediaOutlet < ActiveRecord::Migration
  def self.up
    add_column :media_outlets, :media_type, :string
    add_column :media_outlets, :url, :string
  end

  def self.down
    remove_column :media_outlets, :url
    remove_column :media_outlets, :media_type
  end
end
