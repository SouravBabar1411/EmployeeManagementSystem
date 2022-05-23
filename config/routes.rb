Rails.application.routes.draw do
  
  ## super admin routes
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Root route of the application
  root to: "home#index"
  
  #in routes
  devise_for :users,:controllers => { 
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  
  # Routes for Employee module
  resources :users, only: [:index, :new, :edit, :destroy, :updaste]
  get 'fetch_employees', to: 'users#fetch_employees'
  post 'signup', to: 'users#create'
  put  'updateuser', to: 'users#update'

  # Routes for timesheets module
  resources :timesheets
  get '/fetch_timesheets', to: 'timesheets#fetch_timesheets'

end
