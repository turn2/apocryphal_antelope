class WinnersController < ApplicationController
  resource_controller

  create.success.wants.html { redirect_to winners_path }

  def sort
    Winner.all.each do |w|
      w.position = params["winner"].index(w.id.to_s)+1
      w.save
    end
    render :nothing => true
  end
end
