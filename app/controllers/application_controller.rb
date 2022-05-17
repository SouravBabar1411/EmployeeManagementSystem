class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  ## To permit additional parameters
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email,:first_name,:last_name,:date_of_birth,:is_active,:role,:gender,:image,:company_id ])
    devise_parameter_sanitizer.permit(:account_update, keys: [:email,:first_name,:last_name,:date_of_birth,:is_active,:role,:gender,:image,:company_id])
  end
end
