class AddCompletedCertificationSheetToWholesaler < ActiveRecord::Migration
  def self.up
    add_column :wholesalers, :completed_certification_sheet, :boolean, :default => false
  end

  def self.down
    remove_column :wholesalers, :completed_certification_sheet
  end
end
