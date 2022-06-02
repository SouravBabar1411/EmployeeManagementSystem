class Api::V1::JobsController < ApplicationController 
  before_action :set_job, only: [:update, :show, :destroy]

  def index 
    jobs = Job.all
  end 

  def create 
    @job = Job.new(jobs_params)
    if @job.save 
      render_success 200, true, 'Job created successfully.', @job.as_json
    else  
      if @job.errors
        errors = @job.errors.full_messages.join(", ")
      else 
        errors = 'Job creation failed'
      end 
    end 
  end 

  def update 
    if @job.update(jobs_params)
      render_success 200, true, 'Job updated successfully', @job.as_json
    else
      if @job.errors
        errors = @job.errors.full_messages.join(", ")
      else
        errors = 'Job update failed'
      end

      return_error 500, false, errors, {}
    end
  end 

  def destroy 
    @job.destroy 
    render_success 200, true, 'Job deleted successfully.'
  end 

  def show 
    render_success 200, true, 'Job fetch sucessfully.', @job.as_json
  end 
  private 
  def jobs_params 
    params.require(:job).permit(:name, :is_active, :project_id, user_ids: [])
  end 

  def set_job 
    @job = Job.find(params[:id])
  end 
end 