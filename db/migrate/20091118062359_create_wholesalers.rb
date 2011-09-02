class CreateWholesalers < ActiveRecord::Migration
  def self.up
    create_table(:wholesalers) do |t|
      t.string       :wholesaler_name
      t.string       :contact_name
      t.string       :email
      t.string       :phone
      t.string       :street_address
      t.string       :city
      t.string       :state
      t.string       :postal_code
      t.date         :event_date
      t.integer      :truck
    end
  end

  def self.down
    drop_table :wholesalers
  end
end
