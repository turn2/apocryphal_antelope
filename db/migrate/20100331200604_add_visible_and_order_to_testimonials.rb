class AddVisibleAndOrderToTestimonials < ActiveRecord::Migration
  def self.up
    add_column :testimonials, :visible, :boolean, :default => false
    add_column :testimonials, :position, :integer
    Testimonial.all.each do |t|
      t.position = nil
      t.save!
    end
  end

  def self.down
    remove_column :testimonials, :position
    remove_column :testimonials, :visible
  end
end
