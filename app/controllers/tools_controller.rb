class ToolsController < ApplicationController
  require 'bmi'

  def calculate
    @weight = params[:toolsform][:weight_lb].to_f
    @height = params[:toolsform][:height_cm].to_f
	@bmi = Bmi.calc_bmi(@weight, @height)
    redirect_to :action=>''
  end

end