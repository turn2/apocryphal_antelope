class AddStartAndEndTimesToWholesaler < ActiveRecord::Migration
  def self.up
    add_column :wholesalers, :event_start, :string
    add_column :wholesalers, :event_end, :string
  end

  def self.down
    remove_column :wholesalers, :event_start
    remove_column :wholesalers, :event_end
  end
end
