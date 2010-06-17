class UserController < ApplicationController

def authenticate
		@user = User.new(params[:userform])
		valid_user = User.find(:first,:conditions => ["email = ? and password = ?",@user.email, @user.password])

		if valid_user
			session[:user_id]=valid_user.email
			redirect_to :action => 'mypage'
		else
			flash[:notice] = "Invalid Email/Password"
			redirect_to :action=> 'login'
		end
end

  def login
  end

    def logout
	  if session[:user_id]
		  reset_session
		  redirect_to :action=> 'login'
	  end
  end
  
    def yourpage
        session[:user_id]
		redirect_to :action=> 'mypage'
    end

    def mypage
        if !session[:user_id]
		redirect_to :action=> 'login'
        end
        @all_weights = Weight.find(:all, :order => "updated_at ASC", :conditions => {:email => session[:user_id]})
        @height_user = User.find(:first, :conditions => {:email => session[:user_id]})
        @height = @height_user.height_cm;
        @all_weights.each do |weight|
          @weight_and_date =  {:weight => weight.weight_lb, :update_time => weight.updated_at};
          puts 'weight = ' + @weight_and_date[:weight].to_s + ' update = ' + @weight_and_date[:update_time].to_s 
          puts 'first = ' + @weight_and_date[:weight].to_s
          puts 'height = ' + @height.to_s
        end                                                                
   end


      def signup
	  if session[:user_id]
		  reset_session
		  redirect_to :action=> 'signup'
	  end
  end

	def thankyou
        params[:userform][:ip] = request.remote_ip 
		@user = User.new(params[:userform])
		@weight = Weight.new(:email => params[:userform][:email], :weight_lb => params[:userform][:weight_lb])
		@weight.save
		@user.save
        valid_user = User.find(:first,:conditions => ["email = ? and password = ?",@user.email, @user.password])
        session[:user_id]=valid_user.email
    end

  def newweight
    @weight =  Weight.new(:email => session[:user_id], :weight_lb =>params[:updateform][:weight_lb])
    @weight.save
    flash[:notice] = "updated"
    redirect_to :action=> 'mypage'
  end

  def bmi
    @currentemail = session[:user_id]
    @user = User.find(:all, :conditions => {:email => @currentemail})
    @allweights = Weight.find(:all, :conditions => {:email => @currentemail})
    flash[:test]  = @user
  end

  end




