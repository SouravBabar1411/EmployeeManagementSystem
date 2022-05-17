Rails.application.routes.draw do
  ## super admin routes
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Root route of the application
  root to: "home#index"
end
