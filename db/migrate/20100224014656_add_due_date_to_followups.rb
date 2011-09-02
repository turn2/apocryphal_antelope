class AddDueDateToFollowups < ActiveRecord::Migration
  def self.up
    add_column :followups, :due_date, :date
  end

  def self.down
    remove_column :followups, :due_date
  end
end
