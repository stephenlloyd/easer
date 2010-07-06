class ToolsController < ApplicationController
  require 'bmi'

  def calculate
    if params[:toolsform][:weight_lb].blank?
      flash[:notice] = "Please enter a correct weight"
    if params[:toolsform][:weight_lb].blank?
      flash[:notice] = "Please enter a correct weight"
      redirect_to :action=>''
      return
    end
      end
    @weight = params[:toolsform][:weight_lb].to_f
    @height = params[:toolsform][:height_cm].to_f
	session[:bmi] = Bmi.calc_bmi(@weight, @height)
    redirect_to :action=>''
  end

end