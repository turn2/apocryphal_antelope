class Testimonial < ActiveRecord::Base
  attr_accessible :quote, :author, :visible, :position, :wholesaler_id

  validates_presence_of :quote

  belongs_to :wholesaler

  default_scope :order => :position

  named_scope :visible, :conditions => {:visible => true }
  named_scope :invisible, :conditions => {:visible => false }
  named_scope :unassigned, :conditions => {:wholesaler_id => nil }
  named_scope :assigned, :conditions => ["wholesaler_id NOT NULL"]

  named_scope :recent, :conditions => {:visible => false }, :order => 'id DESC'

  acts_as_list

  class << self
    def mark_visible(id)
      update(id, :position => next_position)
      update(id, :visible => true)
    end

    def mark_hidden(id)
      update(id, :visible => false)
      update(id, :position => nil)
    end

    def next_position
      (maximum(:position, :conditions => {:visible => true}) || 0) + 1
    end
  end
end
