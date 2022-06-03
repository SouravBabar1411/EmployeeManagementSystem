class DashboardsController < ApplicationController
  
  def index
    @birthdays = User.where(date_of_birth: (Time.now)).select(:first_name).pluck(:first_name)
    @leaves = LeaveTracker.where(is_approved:'false').count
  end

end
