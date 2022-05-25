class JobsController < ApplicationController
  before_action :authenticate_user!
  # before_action :set_project
  # skip_before_action :set_job, only: [:users_jobs], raise: false
  before_action :set_job, only: [:show, :edit, :update, :destroy]

  def index 
  end 

  def fetch_jobs 
    jobs = Job.all.order(created_at:"desc")
    search_string = []

    # Check if Search Keyword is Present & Write it's Query
    if params.has_key?('search') && params[:search].has_key?('value') && params[:search][:value].present?
      search_columns.each do |term|
        search_string << "#{term} ILIKE :search"
      end
      jobs = jobs.where(search_string.join(' OR '), search: "%#{params[:search][:value]}%")
    end

    jobs = jobs.page(datatable_page).per(datatable_per_page)
    render json: {
      jobs: jobs.as_json,
      recordsTotal: jobs.count,
      recordsFiltered: jobs.total_count
    }
  end 

  def users_jobs 
    @userid = params[:id]
    @jobs = User.where(id: params[:id]).first.jobs

  end

  def fetch_users_jobs 
    jobs = User.find(params[:userid]).jobs.order(created_at:"desc")
    search_string = []

    # Check if Search Keyword is Present & Write it's Query
    if params.has_key?('search') && params[:search].has_key?('value') && params[:search][:value].present?
      search_columns.each do |term|
        search_string << "#{term} ILIKE :search"
      end
      jobs = jobs.where(search_string.join(' OR '), search: "%#{params[:search][:value]}%")
    end

    jobs = jobs.page(datatable_page).per(datatable_per_page)
    render json: {
      jobs: jobs.as_json,
      recordsTotal: jobs.count,
      recordsFiltered: jobs.total_count
    }
  end 

  def new 
    @job = Job.new
  end 

  def create 
    @job = Job.new(jobs_params)
      
      if @job.save 
        JobCreatedMailer.job_assign(@job).deliver
        redirect_to(jobs_url, :notice => 'Job was sucessfully added.')
      else
        format.html{ render :new , status: :unprocessable_entity }
      end 
  end 

  def update 
    if @job.update!(jobs_params)
      redirect_to jobs_path
    else  
      redirect_to root_path 
    end
  end 

  def show 
    redirect_to users_url
  end 
  private 
  
  # def set_project 
  #   @project = Project.find_by(:name => params[:name])
  # end 

  def set_job 
    @job = Job.find(params[:id])
  end 

  def jobs_params 
    params.require(:job).permit(:name, :is_active, :project_id,user_ids: [])
  end 
end
