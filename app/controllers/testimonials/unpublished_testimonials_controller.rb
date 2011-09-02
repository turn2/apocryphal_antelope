class Testimonials::UnpublishedTestimonialsController < ApplicationController

  resource_controller

  def index
    @testimonials = Testimonial.recent.unassigned.paginate :page => params[:page], :per_page => 18
  end

  destroy.wants.html { redirect_to :back }

  def approve
    Testimonial.mark_visible(params[:id])
    redirect_to :back
  end

  private

  def model_name
    'testimonial'
  end
end
