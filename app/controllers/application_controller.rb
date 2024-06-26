class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def current_user
    @current_user ||= super
  end

  private

    def configure_permitted_parameters               
      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:avatar, :email, :password, :password_confirmation, :current_password) } 
    end
end
