class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :complete_profile
  # by default we want all users to be authenticated
  before_filter :authenticate_user!

  # configure permitted params for devise
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
      keys: [:email, :mobile, :password, :password_confirmation, :accept_terms_of_service])
    devise_parameter_sanitizer.permit(:account_update,
      keys: [:email, :mobile, :password, :password_confirmation, :security_setting, :current_password,
      gen_info_attributes: [:id, :first_name, :last_name, :date_of_birth, :uk_resident],
      address_attributes: [:id, :address_line, :city, :state, :zip],
      finance_attributes: [:id, :finance_plan_id]
      ])
  end

  def check_admin
    redirect_to :root unless current_user.admin?
  end

  def check_sub_admin
    redirect_to :root unless (current_user.admin? || current_user.sub_admin?)
  end
private

def complete_profile
  if  (user_signed_in? && current_user.full_name == nil || user_signed_in? && current_user.address == nil || user_signed_in? && current_user.security_setting == nil || user_signed_in? && current_user.finance == nil)
redirect_to edit_user_registration_path,     alert: "You must complete your Profile"
  end
end
end
