class ApplicationController < ActionController::Base
   before_action :configure_authentication

   before_action :configure_permitted_parameters, if: :devise_controller?

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
        devise_parameter_sanitizer.permit(:invite, keys: [:email, :name])
        devise_parameter_sanitizer.permit(:accept_invitation, keys: [:password, :password_confirmation, :invitation_token, :name])
    end
# def check_users_authorization
  # if repuest.path.start_with?('/users')

   private


  def configure_authentication
    if admin_controller?
      authenticate_admin!
    else
      authenticate_user! unless action_is_public?
    end
  end

  def admin_controller?
    self.class.module_parent_name == 'Admin'
  end

   def action_is_public?
    (controller_name == 'homes' && (action_name == 'top' || action_name == 'about'))
   end

   def authenticate_admin!
   end

   #def authenticate_user!
   #end
end

