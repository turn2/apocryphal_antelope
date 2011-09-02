class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.integer :due_week
      t.integer :end_week
      t.integer :task_template_id
      t.integer :wholesaler_id
      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end
