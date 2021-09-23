# frozen_string_literal: true

Rails.application.routes.draw do
  resources :payment_methods
  get 'dashboard/index'
  get 'api', controller: :api, action: :index

  get 'index', controller: :home, action: :index
  get 'about', controller: :home, action: :about
  get 'pricing', controller: :home, action: :pricing
  get 'about', controller: :home, action: :about
  get 'purge/errors', controller: :errors, action: :clear

  match 'join/:id', to: 'redeems#redeem', via: %i[get post]
  match 'accept', to: 'redeems#accept_invite', via: %i[get post]
  get 'contributions', controller: :transactions, action: :contributions
  post 'convert', controller: :transact, action: :conversions

  get 'withdraw/:level/:account', controller: :transact, action: :withdraw
  get 'withdraw/mpesa/:level/:account', controller: :withdraw, action: :mpesa
  get 'withdraw/bank/:level/:account', controller: :withdraw, action: :bank
  get 'withdraw/paypal/:level/:account', controller: :withdraw, action: :paypal

  get 'deposit/:level/:account', controller: :transact, action: :deposit
  get 'deposit/:platform/:level/:account', controller: :deposit, action: :amount_and_currency
  get 'deposit/mpesa/:level/:account/:amount/:origin/:recepient', controller: :deposit, action: :mpesa
  get 'deposit/bank/:level/:account/:amount/:origin/:recepient', controller: :deposit, action: :bank
  get 'deposit/paypal/:level/:account/:amount/:origin/:recepient', controller: :deposit, action: :paypal

  match 'activation', to: 'mpesa#activation', via: %i[get post]
  match 'b2c', to: 'mpesa#b2c', via: %i[get post]
  match 'c2b', to: 'mpesa#c2b', via: %i[get post]
  post 'stk', controller: :mpesa, action: :stk
  match 'paybill', to: 'mpesa#paybill', via: %i[get post]
  match 'register-url', to: 'mpesa#register_url', via: %i[get post]
  match 'b2c-callback', to: 'mpesa#callback_b2c', via: %i[get post]
  match 'c2b-callback', to: 'mpesa#callback_c2b', via: %i[get post]
  match 'stk-callback', to: 'mpesa#callback_stk', via: %i[get post]
  match 'access-token', to: 'mpesa#access_token', via: %i[get post]

  resources :liabilities
  resources :assets
  resources :activities
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
  resources :siris
  resources :logs
  resources :groups
  resources :wallets

  devise_for :admins
  devise_for :users, controllers: { confirmations: 'confirmations' }, path: '',
                     path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }

  root 'home#index'

  get 'dashboard', controller: :dashboard, action: :index

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
