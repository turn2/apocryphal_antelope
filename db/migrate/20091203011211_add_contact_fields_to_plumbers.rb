class AddContactFieldsToPlumbers < ActiveRecord::Migration
  def self.up
    add_column :plumbers, :company_name, :string
    add_column :plumbers, :cell_phone,   :string
    add_column :plumbers, :fax,          :string
    add_column :plumbers, :other_phone,  :string
  end

  def self.down
    remove_column :plumbers, :other_phone
    remove_column :plumbers, :fax
    remove_column :plumbers, :cell_phone
    remove_column :plumbers, :company_name
  end
end
