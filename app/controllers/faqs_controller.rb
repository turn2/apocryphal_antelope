class FaqsController < ApplicationController
  resource_controller
  allow_public :index

  def manage
    @faqs = Faq.all
  end

  create do
    wants.html { redirect_to manage_faqs_path }
  end

  update do
    wants.html { redirect_to manage_faqs_path }
  end

  def index
    @faqs = Faq.visible
    render :layout => "microsite"
  end

  def approve
    Faq.mark_visible(params[:id])
    redirect_to manage_faqs_path
  end

  def hide
    Faq.mark_hidden(params[:id])
    redirect_to manage_faqs_path
  end

  def sort
    Faq.all.each do |f|
      f.position = params["faq"].index(f.id.to_s)+1
      f.save
    end
    render :nothing => true
  end
end
