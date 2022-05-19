class ProjectsController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_company
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
  end 

  def new 
    @project = Project.new
  end 

  def create 
    @project = Project.new(project_params)
      
    respond_to do |format|
      if @project.save 
        format.html{ redirect_to projects_url , success: "Project was sucessfully added." }
      else
        format.html{ render :new , status: :unprocessable_entity }
      end 
    end 
  end 

  def edit 
  end 

  def update 
  end 

  def destroy 
  end 
  private 

  def set_company 
    @company = Company.find_by(params[:id])
  end 

  def set_project 
    @project = Project.find(params[:id])
  rescue ActiveRecord::RecordNotFound => error
    redirect_to root_path, notice: "You are fetching the records that are not exists in database."
  end 

  def project_params 
    params.require(:project).permit(:name, :start_date, :end_date, :is_active, :company_id,user_ids: [])
  end 
end
