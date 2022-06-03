class Api::V1::ProjectsController < ApplicationController 
  before_action :set_project, only: [:update, :show, :destroy]

  def index 
    projects = Project.all
    render_success 200, true, 'Projects fetched successfully', projects.as_json
  end  

  def create 
    @project = Project.new(projects_params)
    if @project.save
      render_success 200, true, 'Project created successfully', @project.as_json
    else
      if @project.errors
        errors = @project.errors.full_messages.join(", ")
      else
        errors = 'Project creation failed'
      end

      return_error 500, false, errors, {}
    end
  end 

  def update 
    if @project.update(projects_params)
      render_success 200, true, 'Project updated successfully', @project.as_json
    else
      if @project.errors
        errors = @project.errors.full_messages.join(", ")
      else
        errors = 'Project update failed'
      end

      return_error 500, false, errors, {}
    end
  end 

  def destroy 
    @project.destroy
    
    render_success 200, true, 'Project deleted successfully', {}
  end 

  def show 
    render_success 200, true, 'Project fetched successfully', @@project.as_json
  end 
  
  private 
  def projects_params 
    params.require(:project).permit(:name, :start_date, :end_date, :is_active, :company_id, user_ids:[])
  end 

  def set_project 
    @project = Project.find(params[:id])
  end 
end 