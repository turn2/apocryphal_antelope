class TaskDueWeekToDueDate < ActiveRecord::Migration
  def self.up
    add_column :tasks, :due_date, :date
    add_column :tasks, :end_date, :date
    remove_column :tasks, :due_week
    remove_column :tasks, :end_week
  end

  def self.down
    add_column :tasks, :end_week, :integer
    add_column :tasks, :due_week, :integer
    remove_column :tasks, :end_date
    remove_column :tasks, :due_date
  end
end
