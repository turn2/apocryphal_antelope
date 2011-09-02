class AddMessageToProspect < ActiveRecord::Migration
  def self.up
    add_column :prospects, :message, :text
  end

  def self.down
    remove_column :prospects, :message
  end
end
