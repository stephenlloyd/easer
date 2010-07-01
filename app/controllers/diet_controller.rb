class DietController < ApplicationController
  require 'bmr'

  def mydiet
    if !session[:user_id]
      redirect_to :controller=>'user', :action=> 'login'
      return
    end
        current_user = User.find(:first, :conditions => {:email => session[:user_id]})
        @bmr = current_user.get_bmr.calculate - 500
  end

end