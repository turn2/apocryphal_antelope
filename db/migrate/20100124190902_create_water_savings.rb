class CreateWaterSavings < ActiveRecord::Migration
  def self.up
    create_table(:water_savings) do |t|
      t.integer :gallons
    end
  end

  def self.down
    drop_table :water_savings
  end
end
