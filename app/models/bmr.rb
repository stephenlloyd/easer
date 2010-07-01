  # Harris-Benedict Principle
  # men -BMR = 66 + ( 6.23 x weight in pounds ) + ( 12.7 x height in inches ) - ( 6.76 x age in years)
  #	women - BMR = 655 + ( 4.35 x weight in pounds ) + ( 4.7 x height in inches ) - ( 4.7 x age in years )
class Bmr
  def initialize(weight_lb, height_cm, age, sex)
    @weight_lb = weight_lb
    @height_cm = height_cm
    @age = age
    @sex = sex
  end

  def calculate
     if @sex == "1"   #male
         (66 + ( 6.23 * @weight_lb )) + ( 12.7 * (@height_cm / 2.54)) - ( 6.76 * @age)
     else
          (655 + ( 4.35 * @weight_lb )) + ( 4.7 * (@height_cm / 2.54))  - ( 4.7 * @age)
     end
  end

  def self.calc_bmr_for_user(user)
    all_weights = Weight.find(:all, :order => "updated_at ASC", :conditions => {:email => user.email})
    return Bmr.new(all_weights.last.weight_lb, user.height_cm, age = Time.now.year - user.dob.year, user.sex)
  end
end






