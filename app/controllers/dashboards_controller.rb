class DashboardsController < ApplicationController
  
  def index
    @birthdays = User.where(date_of_birth:  (Time.now)).select(:first_name).pluck(:first_name)
  end

end
