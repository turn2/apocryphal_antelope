class AddTitleToTask < ActiveRecord::Migration
  def self.up
    add_column :tasks, :title, :string
  end

  def self.down
    remove_column :tasks, :title
  end
end
