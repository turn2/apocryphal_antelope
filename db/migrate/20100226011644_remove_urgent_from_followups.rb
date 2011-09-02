class RemoveUrgentFromFollowups < ActiveRecord::Migration
  def self.up
    remove_column :followups, :urgent
  end

  def self.down
    add_column :followups, :urgent, :boolean, :default => false
  end
end
