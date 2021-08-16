# frozen_string_literal: true

Rails.application.routes.draw do
  get "dashboard/index"
  get "api/index"
  get "home/index"
  get "home/about"
  get "home/pricing"
  get "home/about"

  match "join/:id", to: "redeems#redeem", via: %i[get post]
  match "accept", to: "redeems#accept_invite", via: %i[get post]

  match "activation", to: "mpesa#activation", via: %i[get post]
  match "b2c", to: "mpesa#b2c", via: %i[get post]
  match "c2b", to: "mpesa#c2b", via: %i[get post]
  match "stk", to: "mpesa#stk", via: %i[get post]
  match "paybill", to: "mpesa#paybill", via: %i[get post]
  match "register-url", to: "mpesa#register_url", via: %i[get post]
  match "b2c-callback", to: "mpesa#callback_b2c", via: %i[get post]
  match "c2b-callback", to: "mpesa#callback_c2b", via: %i[get post]
  match "stk-callback", to: "mpesa#callback_stk", via: %i[get post]
  match "access-token", to: "mpesa#access_token", via: %i[get post]

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
  resources :requests
  resources :redeems
  resources :invites
  resources :accounts
  resources :grouptypes

  resources :groups

  resources :wallets
  devise_for :users, controllers: { confirmations: "confirmations" }, path: "",
                     path_names: { sign_in: "login", sign_out: "logout", sign_up: "register" }

  root "home#index"

  match "dashboard", to: "dashboard#index", via: %i[get post]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
