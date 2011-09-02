class Faq < ActiveRecord::Base

  attr_accessible :question, :answer, :visible
  
  validates_presence_of :question, :answer

  default_scope :order => :position

  named_scope :visible, :conditions => {:visible => true }
 
  acts_as_list

  class << self
    def mark_visible(id)
      update(id, :visible => true)
    end

    def mark_hidden(id)
      update(id, :visible => false)
    end
  end
end
