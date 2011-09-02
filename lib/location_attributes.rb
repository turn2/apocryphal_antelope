module LocationAttributes
  include Geography

  def self.included(base)
    base.validates_format_of :postal_code, :with => US_AND_CANADA_POSTAL_CODE_FORMAT, :allow_blank => true
    base.attr_accessible :street_address, :city, :state, :postal_code
    base.validates_inclusion_of :state, :in => STATE_AND_PROVINCE_CODES, :allow_blank => true, :message => "must be a state or province"
  end

  def postal_code=(number)
    if number.nil?
      self[:postal_code] = nil
    else
      number.match(/^\d{1,4}$/) ? self[:postal_code] = number.rjust(5,"0") : self[:postal_code] = number
    end
  end

  def state_name
    STATE_AND_PROVINCE_NAME_LOOKUP[self.state]
  end

  def state=(name)
    self[:state] = (STATE_AND_PROVINCE_CODE_LOOKUP[name] || name)
  end
end
