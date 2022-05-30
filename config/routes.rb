Rails.application.routes.draw do
  
  get 'dashboard/index'
  ## super admin routes
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Root route of the application
  root to: "dashboards#index"

  ## projects routes 
  resources :projects do 
    collection do
      get 'fetch_projects', to: 'projects#fetch_projects'
    end
  end 
  get 'users_projects/:id', to: 'projects#users_projects' 
  get 'fetch_users_projects', to: 'projects#fetch_users_projects'
  get 'projects_jobs/:id', to: 'projects#projects_jobs' 
  get 'fetch_projects_jobs', to: 'projects#fetch_projects_jobs'
  get 'projects_users/:id', to: 'projects#projects_users'
  get 'fetch_projects_users', to: 'projects#fetch_projects_users'
  get 'jobs_users/:id', to: 'jobs#jobs_users'
  get 'fetch_jobs_users', to: 'jobs#fetch_jobs_users'

  ## jobs routes 
  resources :jobs do 
    collection do 
      get 'fetch_jobs', to: 'jobs#fetch_jobs'
    end 
  end
  get 'users_jobs/:id', to: 'jobs#users_jobs' 
  get 'fetch_users_jobs', to: 'jobs#fetch_users_jobs'
  
  #in routes
  devise_for :users,:controllers =>  {  
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  # Routes for Employee module
  resources :users, only: [:index, :new, :edit, :destroy, :update]
  get 'fetch_employees', to: 'users#fetch_employees'
  post 'signup', to: 'users#create'
  put  'updateuser', to: 'users#update'

  # Routes for Configuration module
  resources :global_configurations
  post 'global_configurations/update_config_value', to: "global_configurations#update_config_value"
    

  # Routes for timesheets module
  resources :timesheets do
    collection do
      get '/fetch_timesheets', to: 'timesheets#fetch_timesheets'
    end
  end
  get '/fetch_timesheets', to: 'timesheets#fetch_timesheets'

  # LeaveTracker routes
  resources :leave_trackers
  get '/fetch_leaves', to: 'leave_trackers#fetch_leaves' 
  get '/fetch_leaveapplication', to: 'leave_trackers#fetch_leaveapplication'
  
  #dashboard routes
  get 'dashboards', to: 'dashboards#index'

end
