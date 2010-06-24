class UserController < ApplicationController
require 'bmi'
require 'bmr'

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
          session.clear
		  redirect_to :action=> 'login'
	  end
  end
  
    def yourpage
        session[:user_id]
		redirect_to :action=> 'mypage'
    end

    def mypage
        if session[:user_id].nil?
		  redirect_to :action=> 'login'
          return 
        end
        @all_weights = Weight.find(:all, :order => "updated_at ASC", :conditions => {:email => session[:user_id]})
        @current_user = User.find(:first, :conditions => {:email => session[:user_id]})
          @all_weights.each { |weight|  @weight_and_date = {:weight => weight.weight_lb, :update_time => weight.updated_at}}
        @newBmr = Bmr.new()
        @newBmre = Bmr.new()
        @current_bmi = Bmi.calc_bmi(@weight_and_date[:weight], @current_user.height_cm)
        @current_bmr = @newBmr.calc_bmr(@weight_and_date[:weight], @current_user.height_cm, @current_user.dob, @current_user.sex)
        @current_bmr2 = @newBmre.calc_bmr_for_session(session[:user_id])

   end


      def signup
	  if session[:user_id]
		  reset_session
		  redirect_to :action=> 'signup'
      end
      end

def authenticate_new_user
        @allusers = User.find(:all, :conditions => {:email => params[:userform][:email]})
        if !@allusers.empty?
          flash[:notice] = "we already have that email address sorry"
          redirect_to :action=> 'signup'
        else
        params[:userform][:ip] = request.remote_ip
		@user = User.new(params[:userform])
		@weight = Weight.new(:email => params[:userform][:email], :weight_lb => params[:userform][:weight_lb])
		@weight.save
		@user.save
        valid_user = User.find(:first,:conditions => ["email = ? and password = ?",@user.email, @user.password])
        session[:user_id]=valid_user.email
         redirect_to :action=> 'thankyou'
        end
end

	def thankyou
          session[:user_id]
    end
  
    def newweight
      @weight =  Weight.new(:email => session[:user_id], :weight_lb =>params[:updateform][:weight_lb])
      @weight.save
      flash[:notice] = "updated"
      redirect_to :action=> 'mypage'
    end


  end




