class CreateTestimonials < ActiveRecord::Migration
  def self.up
    create_table :testimonials do |t|
      t.string :quote
      t.string :author
      t.integer :wholesaler_id
    end
  end

  def self.down
    drop_table :testimonials
  end
end
