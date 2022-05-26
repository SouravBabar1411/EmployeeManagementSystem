class ProjectsController < ApplicationController
  # before_action :authenticate_user!
  # before_action :set_company
  load_and_authorize_resource
  before_action :set_project, only: [:show, :edit, :update, :create, :destroy]

  def index
    @project = Project.find_by(params[:id])
  end 

  def fetch_projects 
    if current_user.emp_admin? 
     projects = Project.all.order(created_at:"desc")
    else 
      projects = current_user.projects.order(created_at:"desc")
    end 
    search_string = []

    # Check if Search Keyword is Present & Write it's Query
    if params.has_key?('search') && params[:search].has_key?('value') && params[:search][:value].present?
      search_columns.each do |term|
        search_string << "#{term} ILIKE :search"
      end
      projects = projects.where(search_string.join(' OR '), search: "%#{params[:search][:value]}%")
    end

    projects = projects.page(datatable_page).per(datatable_per_page)
    render json: {
      projects: projects.as_json,
      recordsTotal: projects.count,
      recordsFiltered: projects.total_count
    }
  end 

  def projects_jobs 
    @projectid = params[:id]
  end 
  
  def fetch_projects_jobs 
    @project = Project.find_by(params[:id])
    project_jobs = @project.jobs if @project.present?
    
    jobs = Project.find(params[:projectid]).jobs.order(created_at:"desc")
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

  def projects_users 
    @projectid = params[:id]
  end 

  def fetch_projects_users 
    users = Project.find(params[:projectid]).users.order(created_at:"desc")
    search_string = []

    # Check if Search Keyword is Present & Write it's Query
    if params.has_key?('search') && params[:search].has_key?('value') && params[:search][:value].present?
      search_columns.each do |term|
        search_string << "#{term} ILIKE :search"
      end
      users = users.where(search_string.join(' OR '), search: "%#{params[:search][:value]}%")
    end

    users = users.page(datatable_page).per(datatable_per_page)
    render json: {
      users: users.as_json,
      recordsTotal: users.count,
      recordsFiltered: users.total_count
    }
  end 

  def new 
    @project = Project.new
  end 

  def create 
<<<<<<< HEAD
    @project = Project.new(project_params)
=======
    @project = Project.new(project_create_params)
    @project.save
>>>>>>> active-admin
    respond_to do |format|
      if @project.save 
        format.html{ redirect_to projects_url , success: "Project was sucessfully added." }
      else
        format.html{ render :new , status: :unprocessable_entity }
      end 
    end 
  end 

  def edit 
    # authorize! :read, @project
  end 

  def update 
    respond_to do |format|
      if @project.update(project_params)
        ProjectAssignMailer.project_assign(@project).deliver
        format.html { redirect_to projects_url, success: "Project was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end 

  def destroy 
    @project.destroy
   
   respond_to do |format|
      format.html { redirect_to projects_url }
   end
  end 
  private 

  def search_columns
    %w(name)
  end

  def sort_column
    columns = %w(name)
    columns[params[:order]['0'][:column].to_i - 1]
  end

  def set_project 
    @project = Project.find(params[:id])
  rescue ActiveRecord::RecordNotFound => error
    redirect_to root_path, notice: "You are fetching the records that are not exists in database."
  end 

  def project_create_params 
     params.require(:project).permit(:name, :start_date, :end_date, :is_active, :company_id)
  end 

  def project_params 
    params.require(:project).permit(:name, :start_date, :end_date, :is_active, :company_id, user_ids:[])
  end 
end