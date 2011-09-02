class CreatePlumbers < ActiveRecord::Migration
  def self.up
    create_table(:plumbers) do |t|
      t.string       :contact_name
      t.string       :email
      t.string       :phone
      t.string       :street_address
      t.string       :city
      t.string       :state
      t.string       :postal_code
      t.integer      :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :plumbers
  end
end
