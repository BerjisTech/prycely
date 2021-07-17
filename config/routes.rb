Rails.application.routes.draw do
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
  devise_for :users
  get "home/index"

  root "home#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
