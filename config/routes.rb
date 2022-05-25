Rails.application.routes.draw do
  
  get 'dashboard/index'
  ## super admin routes
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Root route of the application
  root to: "home#index"

  ## projects routes 
  resources :projects do 
    collection do
      get 'fetch_projects', to: 'projects#fetch_projects'
    end
  end 

  get 'fetch_projects_jobs', to: 'projects#fetch_projects_jobs'
  ## jobs routes 
  resources :jobs do 
    collection do 
      get 'fetch_jobs', to: 'jobs#fetch_jobs'
    end 
  end 
  
  #in routes
  devise_for :users,:controllers =>  {  
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :addresses
  
  resources :users do 
    collection do
      get 'fetch_employees', to: 'users#fetch_employees'
    end
  end

  # Routes for timesheets module
  resources :timesheets do
    collection do
      get '/fetch_timesheets', to: 'timesheets#fetch_timesheets'
    end
  end

  #dashboard routes
  get 'dashboards', to: 'dashboards#index'

end
