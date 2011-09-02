class CreateProspects < ActiveRecord::Migration
  def self.up
    create_table(:prospects) do |t|
      t.string :name
      t.string :email
      t.boolean :opted_in, :default => true
      t.boolean :receive_product_updates, :default => false
      t.boolean :receive_tour_updates, :default => false
      t.boolean :receive_updates_in_one_day, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :prospects
  end
end
