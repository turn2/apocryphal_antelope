module ContactAttributes
  def self.included(base)
    base.validates_numericality_of :phone, :cell_phone, :other_phone, :fax, :allow_blank => true, :only_integer => true
    base.validates_length_of :phone, :cell_phone, :other_phone, :fax, :is => 10, :allow_blank => true
    base.validates_format_of :email, :with => EmailValidator::EMAIL_FORMAT, :allow_blank => true
    base.attr_accessible :contact_name, :phone, :cell_phone, :other_phone, :fax, :email
  end

  def phone=(number)
    self[:phone] = strip_phone(number)
  end

  def cell_phone=(number)
    self[:cell_phone] = strip_phone(number)
  end

  def other_phone=(number)
    self[:other_phone] = strip_phone(number)
  end

  def fax=(number)
    self[:fax] = strip_phone(number)
  end

  private
  
  def strip_phone(number)
    number.nil? ? nil : number.gsub(/[^\w]/, '')
  end
end
