Rails.application.routes.draw do
   #in routes
  devise_for :users,:controllers => { 
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  
  ## super admin routes
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Root route of the application
  root to: "home#index"
end
