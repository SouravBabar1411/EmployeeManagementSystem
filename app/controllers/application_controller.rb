class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  # before_action :configure_permitted_parameters, if: :devise_controller?


  rescue_from CanCan::AccessDenied do
   flash[:error] = 'Access denied!'
   redirect_to root_url
  end

  protected
  ## To permit additional parameters
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email,:first_name,:last_name,:date_of_birth,:is_active,:role,:gender,:image,:company_id ])
    devise_parameter_sanitizer.permit(:account_update, keys: [:email,:first_name,:last_name,:date_of_birth,:is_active,:role,:gender,:image,:company_id])
  end
end
