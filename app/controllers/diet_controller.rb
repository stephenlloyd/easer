class DietController < ApplicationController
  require 'bmr'

  def mydiet
    if !session[:user_id]
      redirect_to :controller=>'user', :action=> 'login'
      return
    end
        @bmr = Bmr.new()
        @bmr = @bmr.calc_bmr_for_session(session[:user_id]) - 500

  end

end