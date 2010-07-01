require 'bmr'

class User < ActiveRecord::Base

  def get_bmr
    Bmr.calc_bmr_for_user(self)
  end
end
