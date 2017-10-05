class SessionsController < Devise::SessionsController
skip_before_filter :complete_profile
end
