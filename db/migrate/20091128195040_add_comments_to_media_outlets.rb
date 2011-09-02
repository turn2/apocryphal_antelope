class AddCommentsToMediaOutlets < ActiveRecord::Migration
  def self.up
    add_column :media_outlets, :comments, :text
  end

  def self.down
    remove_column :media_outlets, :comments
  end
end
