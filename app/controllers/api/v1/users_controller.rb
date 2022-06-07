class Api::V1::UsersController < ApplicationController
  # Default employee list and search
  # GET /users
  def index
    ## Search
    if params.has_key?(:q) && params[:q].present?
      @users = User.where('lower(first_name) LIKE(?)', "%#{params[:q].downcase}%").order(id: :asc)
    else
      @users = User.all.order(id: :asc)
    end
    render 'api/v1/users/index'
    end
end
