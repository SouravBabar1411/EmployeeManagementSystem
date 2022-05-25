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

  get 'projects_jobs/:id', to: 'projects#projects_jobs' 
  get 'fetch_projects_jobs', to: 'projects#fetch_projects_jobs'

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

  resources :addresses
  
  # Routes for Employee module
  resources :users, only: [:index, :new, :edit, :destroy, :update]
  get 'fetch_employees', to: 'users#fetch_employees'
  post 'signup', to: 'users#create'
  put  'updateuser', to: 'users#update'

# >>>>>>> features/employees
  # Routes for timesheets module
  resources :timesheets do 
    member do
      patch :toggle_approve_status
    end 
  end 
  get '/fetch_timesheets', to: 'timesheets#fetch_timesheets'
  

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
  get 'dashboard', to: 'dashboards#index'
end
