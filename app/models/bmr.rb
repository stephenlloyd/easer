  # Harris-Benedict Principle
  # men -BMR = 66 + ( 6.23 x weight in pounds ) + ( 12.7 x height in inches ) - ( 6.76 x age in years)
  #	women - BMR = 655 + ( 4.35 x weight in pounds ) + ( 4.7 x height in inches ) - ( 4.7 x age in years )
class Bmr

  def calc_bmr(weight_lb, height_cm, age, sex)

    @age = Time.now.year - age.year
    
     if sex == "1"   #male
         (66 + ( 6.23 * weight_lb )) + ( 12.7 * (height_cm / 2.54)) - ( 6.76 * @age)
     else
          (655 + ( 4.35 * weight_lb )) + ( 4.7 * (height_cm / 2.54))  - ( 4.7 * @age)
     end

  end

  def calc_bmr_for_session(session_id)

    @all_weights = Weight.find(:all, :order => "updated_at ASC", :conditions => {:email => session_id})
        @current_user = User.find(:first, :conditions => {:email => session_id})

          @all_weights.each do |weight|
            @weight_and_date =  {:weight => weight.weight_lb, :update_time => weight.updated_at};
          end

     @date = 2010
     @age = 2010 - @current_user.dob.year
     if @current_user.sex == "1"   #male
         (66 + ( 6.23 * @weight_and_date[:weight] )) + ( 12.7 * (@current_user.height_cm / 2.54)) - ( 6.76 * @age)
     else
          (655 + ( 4.35 * @weight_and_date[:weight] )) + ( 4.7 * (@current_user.height_cm / 2.54))  - ( 4.7 * @age)
     end
  end
  
end






