class Testimonials::PublishedTestimonialsController < ApplicationController

  resource_controller

  def index
    @testimonials = Testimonial.visible 
  end

  def hide
    Testimonial.mark_hidden(params[:id])
    redirect_to :back
  end

  def sort
    Testimonial.visible.each do |t|
      t.position = params["testimonial"].index(t.id.to_s)+1 
      t.save
    end
    render :nothing => true
  end
end
