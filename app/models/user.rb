class User < ActiveRecord::Base
  include Clearance::User
 
  has_many :plumbers
  belongs_to :wholesaler

  attr_accessible :role

  ROLES = ["manager", "wholesaler"]
  validates_inclusion_of :role, :in => ROLES, :allow_blank => true

  def has_role?(role)
    self.role == role
  end

  ROLES.each do |r|
    send(:define_method, "#{r}?") { self.role.eql? r }
  end

end
