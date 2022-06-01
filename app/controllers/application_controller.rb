class ApplicationController < ActionController::Base
  # before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  # before_action :configure_permitted_parameters, if: :devise_controller?


  rescue_from CanCan::AccessDenied do
   flash[:error] = 'Access denied!'
   redirect_to root_url
  end

  ## Set Page Number
  def page
    @page ||= params[:page] || 1
  end

  ## Set Per Page Records Length
  def per_page
    @per_page ||= params[:per_page] || 20
  end

  ## Set Total Records Count in Response Header
  def set_pagination_header(resource)
    headers['X-Total-Count'] = resource.total_count
  end

  protected
  ## To permit additional parameters
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email,:first_name,:last_name,:date_of_birth,:is_active,:role,:gender,:image,:company_id ])
    devise_parameter_sanitizer.permit(:account_update, keys: [:email,:first_name,:last_name,:date_of_birth,:is_active,:role,:gender,:image,:company_id])
  end

  ## Returns Datatable Page Number
  def datatable_page
    params[:start].to_i / datatable_per_page + 1
  end

  ## Returns Datatable Per Page Length Count
  def datatable_per_page
    params[:length].to_i > 0 ? params[:length].to_i : 10
  end

  ## Returns Datatable Sorting Direction
  def datatable_sort_direction
    params[:order]['0'][:dir] == 'desc' ? 'desc' : 'asc'
  end

  ## Return Success Response
  def render_success(code, status, message, data = {})
    render json: {
        code: code,
        status: status,
        message: message,
        data: data
    }, status: code
  end

  ## Return Error Response
  def return_error(code, status, message, data = {})
    render json: {
        code: code,
        status: status,
        message: message,
        data: data
    }, status: code
  end

end
