class AddContactFieldsToMediaOutlets < ActiveRecord::Migration
  def self.up
    add_column :media_outlets, :email,        :string
    add_column :media_outlets, :cell_phone,   :string
    add_column :media_outlets, :fax,          :string
    add_column :media_outlets, :other_phone,  :string
  end

  def self.down
    remove_column :media_outlets, :other_phone
    remove_column :media_outlets, :fax
    remove_column :media_outlets, :cell_phone
    remove_column :media_outlets, :email
  end
end
