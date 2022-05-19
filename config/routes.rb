Rails.application.routes.draw do
  
  ## super admin routes
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Root route of the application
  root to: "home#index"

  ## projects routes 
  resources :projects
  
  #in routes
  devise_for :users,:controllers => { 
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  
  # Routes for Employee module
  resources :users, only: [:index, :new, :edit, :destroy]
  get 'fetch_employees', to: 'users#fetch_employees'

  # Routes for timesheets module
  resources :timesheets
  get '/fetch_timesheets', to: 'timesheets#fetch_timesheets'

end
