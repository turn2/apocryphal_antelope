class TestimonialsController < ApplicationController

  resource_controller

  allow_wholesaler :create

  belongs_to :wholesaler

  create do
    flash "Testimonial added!"
    wants.html { redirect_to :back }
    failure.flash "A Quote is required to create a testimonial"
    failure.wants.html { redirect_to :back }
  end

  destroy.wants.html { redirect_to :back }

  def approve
    Testimonial.mark_visible(params[:id])
    redirect_to :back
  end
end
