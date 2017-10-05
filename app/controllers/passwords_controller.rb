class PasswordsController < Devise::PasswordsController
  skip_before_filter :complete_profile

  def create
    if verify_recaptcha
      super
    else
      redirect_to :back, alert:"Captcha Test Failed. Please Retry."
    end
  end

end
