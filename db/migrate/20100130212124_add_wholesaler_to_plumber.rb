class AddWholesalerToPlumber < ActiveRecord::Migration
  def self.up
    add_column :plumbers, :wholesaler_id, :integer
  end

  def self.down
    remove_column :plumbers, :wholesaler_id
  end
end
