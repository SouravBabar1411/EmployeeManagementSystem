Rails.application.routes.draw do
  # Root route of the application
  root to: "home#index"

  #in routes
  devise_for :users,:controllers => { 
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  
  ## super admin routes
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  # Routes for Employee module
  resources :users, only: [:index, :new, :edit, :destroy]
  get 'fetch_employees', to: 'users#fetch_employees'

end
