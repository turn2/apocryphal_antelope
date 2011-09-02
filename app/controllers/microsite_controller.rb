class MicrositeController < ApplicationController
  include Auth::AllowAnonymous

  def links
  end

  def calculator
  end

  def our_goal
  end

  def follow_the_tour
    @prospect = Prospect.new
    @wholesalers  = Wholesaler.event_upcoming.paginate :page => params[:page], :per_page => 15
  end

  def contact
  end

  def prizes
    @winners = Winner.all
  end

  def send_message
    begin
      ContactMailer.deliver_message(params[:name], params[:email], params[:message])
      flash[:notice] = "Your message has been sent!  We'll get back to you soon!"
    rescue ContactMailer::InvalidEmailError => e
      flash[:warning] = "Please enter a valid email address"
    rescue ContactMailer::InvalidMessageError => e
      flash[:warning] = "Please completely fill out the form before sending a message"
    end
    redirect_to :back
  end

  def faqs
    @faqs = Faq.visible
  end

  def media
    @testimonials = Testimonial.visible
  end
end
