class CreateMediaOutlets < ActiveRecord::Migration
  def self.up
    create_table :media_outlets do |t|
      t.string :media_outlet_name

      t.timestamps
    end
  end

  def self.down
    drop_table :media_outlets
  end
end
