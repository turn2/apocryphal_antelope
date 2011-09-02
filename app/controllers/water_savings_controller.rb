class WaterSavingsController < ApplicationController
  allow_public :show

  def show
    @water_savings = WaterSaving.first || WaterSaving.create!(:gallons => 0)

    respond_to do |format|
      format.html
      format.xml {render :xml => @water_savings }
    end
  end

  def edit
    @water_savings = WaterSaving.first || WaterSaving.create!(:gallons => 0)
  end

  def update
    @water_savings = WaterSaving.first
    if @water_savings.update_attributes(params[:water_saving])
      flash[:notice] = "Water Savings updated!"
      redirect_to(water_saving_path)
    else
      flash[:warning] = "There was a problem updating the gallons saved"
      redirect_to(edit_water_saving_path)
    end
  end
end
