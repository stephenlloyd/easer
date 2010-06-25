class ToolsController < ApplicationController
  require 'bmi'

  def calculate
	@bmi = Bmi.calc_bmi(:weight => params[:toolsform][:weight_lb], :height => params[:toolsform][:height_cm])
  end

end