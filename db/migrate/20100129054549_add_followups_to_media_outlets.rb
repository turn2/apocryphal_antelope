class AddFollowupsToMediaOutlets < ActiveRecord::Migration
  def self.up
    add_column :followups, :media_outlet_id, :integer
  end

  def self.down
    remove_column :followups, :media_outlet_id
  end
end
