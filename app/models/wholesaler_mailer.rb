class WholesalerMailer < ActionMailer::Base
  default_url_options[:host] = HOST

  def creation(user)
    from         DO_NOT_REPLY
    recipients   user.email
    subject      "American Standard The Responsible Bathroom Tour Account Creation"
    body         :user => user
    content_type "text/html"
  end

  def creation_summary(users)
    from         DO_NOT_REPLY
    recipients   DO_NOT_REPLY
    subject      "Wholesaler Account Creation Summary"
    body         :users => users
    content_type "text/html"
  end
  
  def contact_manager(user, message)
    from         user.email
    recipients   DO_NOT_REPLY
    subject      "Wholesaler Contact Form Submission"
    body         :user => user, :message => message, :wholesaler => user.wholesaler
    content_type "text/html"
  end
end
