class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[ edit update destroy ]
  before_action :address_params, only: [:update]
  # load_and_authorize_resource


  def index
    user = User.find_by(params[:id])
    @users = user.projects
  end
  def fetch_employees
    users = User.where(company_id: current_user.company_id).order(created_at:"desc")
    search_string = []
    filter_query = ''
    ## Check if Search Keyword is Present & Write it's Query
    if params.has_key?('search') && params[:search].has_key?('value') && params[:search][:value].present?
    terms = params[:search][:value].split(' ')

    search_columns.each do |column|
      terms.each do |term|
      search_string << "#{column} LIKE '%#{term}%'"
      end
    end
    users = users.where(search_string.join(' OR '))
    end

    if params["filters"].present?
      filters = JSON.parse(params["filters"].gsub("=>", ":").gsub(":nil,", ":null,"))
      users = users.side_bar_filter(filters)
    end
    users = users.order("#{sort_column} #{datatable_sort_direction}") unless sort_column.nil?
    users = users.page(datatable_page).per(datatable_per_page)
    render json: {
      users: users.as_json,
      recordsTotal: users.count,
      recordsFiltered: users.total_count,
    }
  end

  # New Employee to be added
  def new
    @user = User.new
    @user.addresses.build
  end

  def create
    @user = User.new(user_params)
    @user.save
    # @address = Address.new(build_address_params)
    if @user.save #&& @address.save
      session[:user_id] = @user.id
      flash[:notice] = "Employee #{@user.first_name} added successfully"
      redirect_to users_path
    else
      render 'new'
    end
  end

  def edit
    # @user.addresses.build unless @user.addresses.present?
    @user = User.where(id: params[:id]).first
    @address = Address.where(addressable_id: params[:id]).first
  end

  def update
    @user = User.where(id: params[:format])
    @address = Address.where(id: params[:user][:addresses_attributes]["0"][:id])
    if @user.update(update_user_params) && @address.update(address_params)
      session[:user_id] = @user[0].id
      flash[:notice] = "Employee #{@user[0].first_name} updated successfully"
      redirect_to users_path
    else
      render 'edit'
    end
  end

  def update 
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to root_path, notice: "user was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @user.is_active
      response = toggle_user(false)
    else
      response = toggle_user(true)
    end
    render json: response
  end

  ## Enable / Disable User
  def toggle_user(approve_status)
    @user.is_active = approve_status
    if @user.save
      response = {
        success: true,
        title: "#{@user.is_active ? 'Enable' : 'Disable'} a User",
        message: "User #{@user.is_active ? 'enabled' : 'disabled'} successfully!"
      }
    else
      response = {
        success: false,
        title: "#{@user.is_active ? 'Enable' : 'Disable'} a User",
        message: "#{@user.is_active ? 'Approving' : 'Disabling'} user failed, Try again later!"
      }
    end
    response
  end

  private
  
  def set_user
    @user = User.find(params[:id])
  end

  ## Returns Datatable Sorting Direction
  def datatable_sort_direction
    params[:order]['0'][:dir] == 'desc' ? 'desc' : 'asc'
  end

  def sort_column
    columns = [%w[first_name], ['email'], ['created_at']]
    columns[params[:order]['0'][:column].to_i - 1].join(', ')
  end

  ## Returns Datatable Page Number
  def datatable_page
    params[:start].to_i / datatable_per_page + 1
  end

  ## Returns Datatable Per Page Length Count
  def datatable_per_page
    params[:length].to_i > 0 ? params[:length].to_i : 10
  end

  # Search with mentioned column names
  def search_columns
    %w(first_name last_name email)
  end 

  def address_params
    addr_params = {}
    if params[:user].has_key?('addresses_attributes')
      addres_params = params[:user][:addresses_attributes]["0"]
      addres_params.each do |key, c_param|
        addr_params[key] = c_param
      end
     addr_params["addressable_id"] = params[:format]
    end
    addr_params
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :date_of_birth, :gender, :image, :email, :password, :company_id, addresses_attributes: [:address_line_1, :address_line_2, :city, :state, :country, :zipcode, :addressable_type])
  end

  def update_user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :date_of_birth, :gender, :image, :email, :password, :company_id)
  end

  ## Build Parameters for User
  def build_address_params
    addr_params = {}
    if params[:user].has_key?('addresses_attributes')
      addres_params = params[:user][:addresses_attributes]["0"]
      addres_params.each do |key, c_param|
        addr_params[key] = c_param
      end
     addr_params["addressable_id"] = @user.id
    end
    addr_params
  end

  def set_user
    @user = User.find(params[:id])
  end
end
