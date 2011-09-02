class DashboardsController < ApplicationController
  resource_controller
  include Auth::AllowWholesaler

  create.flash "Wholesaler created successfully"

  def contact_manager
    @wholesaler = current_user.wholesaler
    if params[:message].empty?
      flash[:warning] = "Contact form message cannot be blank.  Please enter a message and resubmit."
    else
      WholesalerMailer.deliver_contact_manager(current_user, params[:message])
      flash[:notice] = "Your message was successfully delivered!  We'll get back to you soon!"
    end
    redirect_to dashboard_path
  end

  private

  def object_name
    'wholesaler'
  end
  
  def object
    current_user.wholesaler
  end
end
