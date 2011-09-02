class Photo < ActiveRecord::Base
  belongs_to :wholesaler
  
  has_attached_file :picture, :styles => {:medium => "300x300>", :thumb => "100x100>"}
  
  attr_accessible :picture
  
  validates_attachment_presence :picture
  validates_attachment_content_type :picture, :content_type => ['image/jpeg', 'image/pjpeg'], :message => "Image must be a jpeg"
end
