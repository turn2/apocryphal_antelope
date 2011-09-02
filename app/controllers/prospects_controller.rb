class ProspectsController < ApplicationController
  resource_controller
  allow_public :subscribe

  update do
    wants.html { redirect_to edit_prospect_path(@prospect)}
  end

  index do
    wants.csv do
      send_data Prospect.to_csv, :type => "text/csv", :disposition => "attachment"
    end
  end

  def subscribe
    prospect = Prospect.find_or_create_by_email(params[:prospect][:email])
    
    if prospect.new_record? and params[:prospect][:opted_in] == '0'
      flash[:notice] = "You must opt-in if you wish us to contact you about The Responsible Bathroom Tour"
    elsif prospect.update_attributes(params[:prospect])
      ContactMailer.deliver_mailing_list_change(prospect)
      flash[:notice] = prospect.opted_in? ? "Thank you for your interest." : "Thank you for your request.  You have been unsubscribed"
    else
      flash[:notice] = "Sorry, there was a problem with your submission. Name, valid email, and visitor type are required."
    end
    redirect_to follow_the_tour_path
  end
end
