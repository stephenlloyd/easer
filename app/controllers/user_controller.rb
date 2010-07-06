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

        @all_weights_count = @all_weights.length

        @current_bmi = Bmi.calc_bmi(@weight_and_date[:weight], @current_user.height_cm)
        @current_bmr = @current_user.get_bmr.calculate
        
        @current_bmr2 = @current_user.get_bmr.calculate
   end


      def signup
	  if session[:user_id]
		  reset_session
		  redirect_to :action=> 'signup'
      end
      end

      def authenticate_new_user
        all_users = User.find(:all, :conditions => {:email => params[:userform][:email]})
        if !all_users.empty?
          flash[:notice] = "we already have that email address sorry"
          render :action => 'signup'
          return
        end

       if params[:userform][:weight_lb].blank?
        flash[:notice] = 'You must give a weight'
        redirect_to :action => 'signup'
        return
       end

        if params[:userform][:height_cm].blank?
        flash[:notice] = 'You must give a height'
        redirect_to :action => 'signup'
        return
        end

        if params[:userform][:firstname].blank?
        flash[:notice] = 'You must give a first name'
        redirect_to :action => 'signup'
        return
        end

        if params[:userform][:password].blank? ||  params[:userform_confirm][:password_two].blank?
        flash[:notice] = 'You must give a password'
        redirect_to :action => 'signup'
        return
        end

        if params[:userform][:password] != params[:userform_confirm][:password_two]
        flash[:notice] = 'Your passwords do not match'
        redirect_to :action => 'signup'
        return
        end

        params[:userform][:ip] = request.remote_ip
		user = User.new(params[:userform])
		weight = Weight.new(:email => params[:userform][:email], :weight_lb => params[:userform][:weight_lb])
		weight.save
		user.save
        valid_user = User.find(:first,:conditions => ["email = ? and password = ?",user.email, user.password])
        session[:user_id]=valid_user.email
         redirect_to :action=> 'thankyou'
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





