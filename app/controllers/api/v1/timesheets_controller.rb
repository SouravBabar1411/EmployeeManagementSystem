class Api::V1::TimesheetsController < ApplicationController
	before_action :set_timesheet, only: %i[ edit update destroy ]
  def index
    @timesheets = Timesheet.all
    # respond_to do |format|
    #   format.json { render :json => @timesheets.to_json, status => :ok }
    # end
    render_success 200, true, 'timesheets fetched successfully', @timesheets.as_json
  end

  def create
    timesheet = Timesheet.new(timesheet_params)

    if timesheet.save
      render_success 200, true, 'timesheet created successfully', timesheet.as_json
    else
      if timesheet.errors
        errors = timesheet.errors.full_messages.join(", ")
      else
        errors = 'timesheet creation failed'
      end

      return_error 500, false, errors, {}
    end
  end
  
  def update                                                    
    if @timesheet.update(timesheet_params)
      render_success 200, true, 'timesheet updated successfully', @timesheet.as_json
    else
      if @timesheet.errors
        errors = @timesheet.errors.full_messages.join(", ")
      else
        errors = 'timesheet update failed'
      end

      return_error 500, false, errors, {}
    end
  end

  def destroy
    @timesheet.destroy

    render_success 200, true, 'timesheet deleted successfully', {}
  end
  
  def show
    render_success 200, true, 'timesheet fetched successfully', @timesheet.as_json
  end

  private

  ## Strong Params of timesheet
  def timesheet_params
    params.require(:timesheet).permit(:time, :description, :is_approved, :user_id, :project_id, :job_id)
  end

  ## Set timesheet Object, Return Error if not found
  def set_timesheet
    @timesheet = Timesheet.where(id: params[:id]).first

    unless @timesheet
      return return_error 404, false, 'timesheet not found', {}
    end
  end
end