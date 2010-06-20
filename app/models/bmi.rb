class Bmi
  def self.calc_bmi  (weight_cm, height_lb)
         (weight_cm.to_f * 703) / ((height_lb.to_f / 2.54)* (height_lb.to_f / 2.54))
    end
end