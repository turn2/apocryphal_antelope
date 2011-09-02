class AddOwnerAndContactFieldsToWholesalers < ActiveRecord::Migration
  def self.up
    add_column :wholesalers, :owner,       :string
    add_column :wholesalers, :cell_phone,  :string
    add_column :wholesalers, :fax,         :string
    add_column :wholesalers, :other_phone, :string
  end

  def self.down
    remove_column :wholesalers, :other_phone
    remove_column :wholesalers, :fax
    remove_column :wholesalers, :cell_phone
    remove_column :wholesalers, :owner
  end
end
