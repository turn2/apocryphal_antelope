class RemoveLinkFromFaq < ActiveRecord::Migration
  def self.up
    remove_column :faqs, :link
  end

  def self.down
    add_column :faqs, :link, :string
  end
end
