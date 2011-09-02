class AddExportedToPlumbers < ActiveRecord::Migration
  def self.up
    add_column :plumbers, :exported, :boolean, :default => false
  end

  def self.down
    remove_column :plumbers, :exported
  end
end
