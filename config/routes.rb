Rails.application.routes.draw do
  resources :accounts
  resources :grouptypes

  get "dashboard/index"
  get "api/index"
  get "home/index"
  get "home/about"
  get "home/pricing"
  get "home/about"
  match "groups/:id/members", to: "groups#members", via: [:get, :post]
  match "groups/:id/transactions", to: "groups#transactions", via: [:get, :post]
  match "groups/:id/projects", to: "groups#projects", via: [:get, :post]
  match "groups/:id/activities", to: "groups#activities", via: [:get, :post]
  match "groups/:id/loans", to: "groups#loans", via: [:get, :post]
  match "groups/:id/income", to: "groups#income", via: [:get, :post]
  match "groups/:id/assets", to: "groups#assets", via: [:get, :post]
  match "groups/:id/liabilites", to: "groups#liabilites", via: [:get, :post]

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
