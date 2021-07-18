Rails.application.routes.draw do
  resources :grouptypes
  get "dashboard/index"
  get "api/index"
  get "home/index"
  get "home/about"
  get "home/pricing"
  get "home/about"

  resources :liabilities
  resources :assets
  resources :activities
  devise_for :admins
  resources :loans
  resources :loancategories
  resources :paymentcategories
  resources :projects
  resources :errors
  resources :paybills
  resources :stks
  resources :logins
  resources :currencies
  resources :countries
  resources :transactions
  resources :members
  resources :groups
  resources :wallets
  devise_for :users, controllers: { confirmations: "confirmations" }, :path => "", :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "register" }

  root "home#index"

  match "dashboard", to: "dashboard#index", via: [:get, :post]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
