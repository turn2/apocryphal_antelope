class CreateFollowups < ActiveRecord::Migration
  def self.up
    create_table :followups do |t|
      t.string     :description
      t.boolean    :complete, :default => false
      t.integer    :task_id
      t.timestamps
    end
  end

  def self.down
    drop_table :followups
  end
end
