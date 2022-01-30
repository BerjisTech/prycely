# frozen_string_literal: true

Rails.application.routes.draw do
  resources :designations
  resources :group_assets
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get 'api', controller: :api, action: :index

  get 'index', controller: :home, action: :index
  get 'about', controller: :home, action: :about
  get 'pricing', controller: :home, action: :pricing
  get 'about', controller: :home, action: :about
  get 'purge/errors', controller: :errors, action: :clear

  get 'dashboard/load/:data_set', controller: :dashboard, action: :load

  match 'join/:id', to: 'redeems#redeem', via: %i[get post], as: :join_group
  match 'accept', to: 'redeems#accept_invite', via: %i[get post]
  get 'contributions', controller: :transactions, action: :contributions
  post 'convert', controller: :transact, action: :conversions

  # WITHDRAWALS
  get 'withdraw/:level/:account', controller: :transact, action: :withdraw
  get 'withdraw/mpesa/:level/:account', controller: :withdraw, action: :mpesa
  get 'withdraw/bank/:level/:account', controller: :withdraw, action: :bank
  get 'withdraw/paypal/:level/:account', controller: :withdraw, action: :paypal

  # DEPOSITS
  get 'deposit/:level/:account', controller: :transact, action: :deposit
  get 'deposit/:platform/:level/:account', controller: :deposit, action: :amount_and_currency
  get 'deposit/mpesa/:level/:account/:amount/:origin/:recepient', controller: :deposit, action: :mpesa
  get 'deposit/bank/:level/:account/:amount/:origin/:recepient', controller: :deposit, action: :bank
  get 'deposit/paypal/:level/:account/:amount/:origin/:recepient', controller: :deposit, action: :paypal

  # NCBA
  post 'bank/ncba/account_opening', controller: :ncba, action: :account_opening
  post 'bank/ncba/credit_details', controller: :ncba, action: :credit_details
  post 'bank/ncba/credit_transfer', controller: :ncba, action: :credit_transfer
  post 'bank/ncba/mpesa_verification', controller: :ncba, action: :mpesa_verification
  post 'bank/ncba/transaction_query', controller: :ncba, action: :transaction_query
  post 'bank/ncba/push_notif', controller: :ncba, action: :push_notif

  # MPESA
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

  # GROUP MANAGEMENT LINKS
  get 'members/:group/:group_id_digest/:group_id', controller: :members, action: :group, as: :group_members
  get 'transactions/g/:group_id_digest/:group_id', controller: :transactions, action: :group, as: :group_transactions
  get 'projects/g/:group_id_digest/:group_id', controller: :projects, action: :group, as: :group_projects
  get 'loans/g/:group_id_digest/:group_id', controller: :loans, action: :group, as: :group_loans
  get 'group_assets/g/:group_id_digest/:group_id', controller: :group_assets, action: :group, as: :active_group_assets
  get 'liabilities/g/:group_id_digest/:group_id', controller: :liabilities, action: :group, as: :group_liabilities
  get 'activities/g/:group_id_digest/:group_id', controller: :activities, action: :group, as: :group_activities

  # FETCH GROUP DATA
  post 'fetch_group_transactions', controller: :groups, action: :transactions
  post 'fetch_group_graph_data', controller: :groups, action: :bar_line_charts
  post 'fetch_group_projects', controller: :groups, action: :projects
  post 'fetch_group_loans', controller: :groups, action: :loans
  post 'fetch_group_liabilities', controller: :groups, action: :liabilities
  post 'fetch_group_assets', controller: :groups, action: :assets
  post 'fetch_group_activities', controller: :groups, action: :activities

  # LOANS
  get 'loan/payment', controller: :loans, action: :pay, as: :loan_payment
  get 'own_guarantor/:guarantors/:user_id', controller: :loans, action: :own_guarantor
  get 'guarantor_limit/:guarantor_count/:loan_category', controller: :loans, action: :guarantor_limit
  post 'i_approve', controller: :loans, action: :i_approve
  post 'i_disapprove', controller: :loans, action: :i_disapprove

  resources :liabilities,
            :activities,
            :loans,
            :loancategories,
            :paymentcategories,
            :projects,
            :errors,
            :paybills,
            :stks,
            :logins,
            :currencies,
            :countries,
            :transactions,
            :members,
            :requests,
            :redeems,
            :invites,
            :accounts,
            :grouptypes,
            :siris,
            :logs,
            :groups,
            :wallets,
            :payment_methods,
            :group_assets

  devise_for :admins
  devise_for :users, controllers: { confirmations: 'confirmations' }, path: '',
                     path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }

  root 'home#index'

  get 'dashboard', controller: :dashboard, action: :index

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
