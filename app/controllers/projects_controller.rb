class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
  end 

  def new 
    @project = Project.new
  end 

  def create 
  end 

  def edit 
  end 

  def update 
  end 

  def destroy 
  end 
  private 

  def set_project 
    @project = Project.find(params[:id])
  rescue ActiveRecord::RecordNotFound => error
    redirect_to root_path, notice: "You are fetching the records that are not exists in database."
  end 

  def project_params 
    params.require(:project).permit(:name, :start_date, :end_date, :is_active, :company_id)
  end 
end
