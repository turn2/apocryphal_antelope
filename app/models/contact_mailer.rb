class ContactMailer < ActionMailer::Base
  class InvalidEmailError < ArgumentError; end
  class InvalidMessageError < ArgumentError; end
  
  default_url_options[:host] = HOST

  def message(name, email, message)
    raise InvalidMessageError if (name.blank? or message.blank?)
    raise InvalidEmailError unless EmailValidator.probable_email?(email)
    reply_to     email
    from         "admin@" + HOST
    recipients   DO_NOT_REPLY
    subject      "The Responsible Bathroom Tour - Was sent a message!"
    body         :name => name, :email => email, :message => message
    content_type "text/html"
  end

  def mailing_list_change(prospect)
    reply_to     prospect.email
    from         "admin@" + HOST
    recipients   DO_NOT_REPLY
    subject      "Change in subscribers for The Responsible Bathroom Tour"
    body         :prospect => prospect
    content_type "text/html"
  end
end
