class RegistrationsController < Devise::RegistrationsController
  skip_before_filter :complete_profile
  #   before_action :after_update_path_for(resource)
  # protected
  #
  # def after_update_path_for(resource)
  #   resource.profile_completeness == 100 ? :root : edit_user_registration_path
  # end
end
