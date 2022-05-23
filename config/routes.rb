Rails.application.routes.draw do
  
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
  get 'list_users', to: 'jobs#list_users'

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
  
  resources :users 

  get 'fetch_employees', to: 'users#fetch_employees'

  # Routes for timesheets module
  resources :timesheets
  get '/fetch_timesheets', to: 'timesheets#fetch_timesheets'

end
