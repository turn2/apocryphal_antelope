class Testimonials::WholesalersTestimonialsController < ApplicationController

  resource_controller

  def index
    @testimonials = Testimonial.recent.assigned.paginate :page => params[:page], :per_page => 18
  end

  def approve
    Testimonial.mark_visible(params[:id])
    redirect_to :back
  end
end
