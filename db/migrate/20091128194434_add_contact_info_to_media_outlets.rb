class AddContactInfoToMediaOutlets < ActiveRecord::Migration
  def self.up
    add_column :media_outlets, :contact_name, :string
    add_column :media_outlets, :phone, :string
    add_column :media_outlets, :address, :string
    add_column :media_outlets, :city, :string
    add_column :media_outlets, :state, :string
    add_column :media_outlets, :postal_code, :string
    add_column :media_outlets, :close_date, :date
    add_column :media_outlets, :release_date, :date
  end

  def self.down
    remove_column :media_outlets, :release_date
    remove_column :media_outlets, :close_date
    remove_column :media_outlets, :postal_code
    remove_column :media_outlets, :state
    remove_column :media_outlets, :city
    remove_column :media_outlets, :address
    remove_column :media_outlets, :phone
    remove_column :media_outlets, :contact_name
  end
end
