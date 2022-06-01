module Api
 module V1
  class LeaveTrackersController < ApplicationController
    before_action :set_leavetracker, only: %i[ edit update destroy ]

    def index
      @leavetrackers = LeaveTracker.all
      render_success 200, true, 'LeaveTracker fetched successfully', @leavetrackers.as_json
    end

    def create
      @leavetracker = LeaveTracker.new(leavetracker_params)

      if @leavetracker.save
        render_success 200, true, 'leavetracker created successfully', @leavetracker.as_json
      else
        if @leavetracker.errors
          errors = @leavetracker.errors.full_messages.join(", ")
        else
          errors = 'leavetracker creation failed'
        end

        return_error 500, false, errors, {}
      end
    end
  
    def update                                                    
      if @leavetracker.update(leavetracker_params)
        render_success 200, true, 'leavetracker updated successfully', @leavetracker.as_json
      else
        if @leavetracker.errors
          errors = @leavetracker.errors.full_messages.join(", ")
        else
          errors = 'leavetracker update failed'
        end

        return_error 500, false, errors, {}
      end
    end

    def destroy
      @leavetracker.destroy

      render_success 200, true, 'leavetracker deleted successfully', {}
    end
  
    def show
      render_success 200, true, 'leavetracker fetched successfully', @leavetracker.as_json
    end

    private

    def set_leavetracker
      @leavetracker = LeaveTracker.find(params[:id])
    end


    def leavetracker_params
      params.require(:leave_tracker).permit(:from_date, :to_date, :reason, :is_approved, :user_id )
    end
  end
 end
end