class AddUrgentToFollowups < ActiveRecord::Migration
  def self.up
    add_column :followups, :urgent, :boolean, :default => false
  end

  def self.down
    remove_column :followups, :urgent
  end
end
