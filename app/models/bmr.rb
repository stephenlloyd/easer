  # Harris-Benedict Principle
  # men -BMR = 66 + ( 6.23 x weight in pounds ) + ( 12.7 x height in inches ) - ( 6.76 x age in years)
  #	women - BMR = 655 + ( 4.35 x weight in pounds ) + ( 4.7 x height in inches ) - ( 4.7 x age in years )
class Bmr

  def calculate_bmr(weight_lb, height_cm, age, sex)
     @age = 2010 - age.year
     if sex == "1"   #male
         (66 + ( 6.23 * weight_lb )) + ( 12.7 * (height_cm / 2.54)) - ( 6.76 * @age)
     else
         (655 + ( 4.35 * weight_lb )) + ( 4.7 * (height_cm / 2.54))  - ( 4.7 * @age)
     end
  end
end






