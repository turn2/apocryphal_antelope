class AddAsRepInfoToWholesaler < ActiveRecord::Migration
  def self.up
    add_column :wholesalers, :as_rep_name,       :string
    add_column :wholesalers, :as_rep_email,      :string
    add_column :wholesalers, :as_rep_phone,      :string
    add_column :wholesalers, :as_rep_cell_phone, :string
    add_column :wholesalers, :as_rep_fax,        :string
  end

  def self.down
    remove_column :wholesalers, :as_rep_fax
    remove_column :wholesalers, :as_rep_cell_phone
    remove_column :wholesalers, :as_rep_phone
    remove_column :wholesalers, :as_rep_email
    remove_column :wholesalers, :as_rep_name
  end
end
