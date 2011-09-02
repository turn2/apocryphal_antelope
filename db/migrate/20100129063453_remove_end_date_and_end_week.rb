class RemoveEndDateAndEndWeek < ActiveRecord::Migration
  def self.up
    remove_column :tasks, :end_date
    remove_column :task_templates, :end_week
  end

  def self.down
    add_column :task_templates, :end_week, :integer
    add_column :tasks, :end_date, :date
  end
end
