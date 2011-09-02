class CreateParts < ActiveRecord::Migration
  def self.up
    create_table(:parts) do |t|
      t.string      :part_name
      t.integer     :quantity
      t.integer     :total_sale_price_in_cents
      t.string      :part_number
      t.date        :date_of_sale
      t.integer     :wholesaler_id
    end
  end

  def self.down
    drop_table :parts
  end
end
