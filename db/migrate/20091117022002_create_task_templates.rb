class CreateTaskTemplates < ActiveRecord::Migration
  def self.up
    create_table(:task_templates) do |t|
      t.string    :title
      t.string    :description
      t.integer   :due_week
      t.integer   :end_week
    end
  end

  def self.down
    drop_table :task_templates
  end
end
