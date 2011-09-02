class AddWinners < ActiveRecord::Migration
  def self.up
    create_table :winners do |t|
      t.string  :winner_name
      t.integer :wholesaler_id
      t.integer :position
    end
  end

  def self.down
    drop_table :winners
  end
end
