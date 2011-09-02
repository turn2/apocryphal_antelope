class AddWholesalerToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :wholesaler_id, :integer
  end

  def self.down
    remove_column :users, :wholesaler_id
  end
end
