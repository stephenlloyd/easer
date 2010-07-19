class UserController < ApplicationController
require 'bmi'
require 'bmr'
require 'model_validation'

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

        validation = ModelValidation.new

        if !all_users.empty?
          validation.add_validation_message("we already have that email address")
        end

       if params[:userform][:weight_lb].blank?
        validation.add_validation_message('You must give a weight')
       end

       if params[:userform][:email].blank? || params[:userform][:email].to_s.length < 9 || !params[:userform][:email].to_s.include?("@")
        validation.add_validation_message('You must give valid email e.g. "yourname@domain.com"')
       end

        if params[:userform][:height_cm].blank?
        validation.add_validation_message('You must give a height')
        end

        if !params[:userform][:height_cm].blank? && params[:userform][:height_cm].to_i < 100 || params[:userform][:height_cm].to_i > 250
        validation.add_validation_message('Your height must be between 100 and 250cm')
        end

        if !params[:userform][:weight_lb].blank? && params[:userform][:weight_lb].to_i < 72 || params[:userform][:weight_lb].to_i > 360
        validation.add_validation_message('Please check your weight and re-enter')
        end

        if params[:userform][:firstname].blank?
        validation.add_validation_message('You must give a first name')
        end

        if params[:userform][:password].blank?
        validation.add_validation_message('You must give a password')
        end

        if !params[:userform][:password].blank? && params[:userform][:password].to_s.length < 5
          validation.add_validation_message('Your password must be over 5 characters in length')
        end
        
        if params[:userform][:password] != params[:userform_confirm][:password_two]
         validation.add_validation_message('Your passwords do not match')
        end

        if !validation.is_valid?
          flash[:notice] = validation.formatted_messages
          redirect_to :action=> 'signup'
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
      
      validation = ModelValidation.new

        if !params[:updateform][:weight_lb].blank? && params[:updateform][:weight_lb].to_i < 72 || params[:updateform][:weight_lb].to_i > 360
          validation.add_validation_message('Please check your weight and re-enter')
        end

        if params[:updateform][:weight_lb].blank?
         validation.add_validation_message('You must give a weight')
        end
        
        if !validation.is_valid?
          flash[:notice] = validation.formatted_messages
          redirect_to :action=> 'mypage'
          return
        end

      @weight =  Weight.new(:email => session[:user_id], :weight_lb =>params[:updateform][:weight_lb])
      @weight.save
      flash[:updated] = "updated"
      redirect_to :action=> 'mypage'
    end

  end





