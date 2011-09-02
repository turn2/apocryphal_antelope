class EmailValidator
  EMAIL_FORMAT = /^.+@.+\..+$/

  def self.probable_email?(email)
    EMAIL_FORMAT === email
  end
end
