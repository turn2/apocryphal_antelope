class CreateFaqs < ActiveRecord::Migration
  def self.up
    create_table :faqs do |t|
      t.string :question
      t.string :answer
      t.string :link
      t.boolean :visible, :default => false
    end
  end

  def self.down
    drop_table :faqs
  end
end
