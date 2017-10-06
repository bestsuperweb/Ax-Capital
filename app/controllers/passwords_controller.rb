class PasswordsController < Devise::PasswordsController
  skip_before_filter :complete_profile

  def create
    if verify_recaptcha
      super
    else
    	if params[:user][:email].blank?
    		redirect_to :back, alert:"Email can't be blank, Captcha Test Failed. Please Retry."
    	else
    		redirect_to :back, alert:"Captcha Test Failed. Please Retry."
    	end      
    end
  end

end
