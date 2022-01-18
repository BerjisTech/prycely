# frozen_string_literal: true

Rails.application.routes.draw do
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

  post 'bank/ncba/account_opening', controller: :ncba, action: :account_opening
  post 'bank/ncba/credit_details', controller: :ncba, action: :credit_details
  post 'bank/ncba/credit_transfer', controller: :ncba, action: :credit_transfer
  post 'bank/ncba/mpesa_verification', controller: :ncba, action: :mpesa_verification
  post 'bank/ncba/transaction_query', controller: :ncba, action: :transaction_query
  post 'bank/ncba/push_notif', controller: :ncba, action: :push_notif

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
  get 'members/g/:group_id_digest/:group_id', controller: :members, action: :group
  get 'transactions/g/:group_id_digest/:group_id', controller: :transactions, action: :group
  get 'projects/g/:group_id_digest/:group_id', controller: :projects, action: :group
  get 'loans/g/:group_id_digest/:group_id', controller: :loans, action: :group
  get 'assets/g/:group_id_digest/:group_id', controller: :assets, action: :group
  get 'liabilities/g/:group_id_digest/:group_id', controller: :liabilities, action: :group
  post 'fetch_group_transactions', controller: :groups, action: :transactions
  post 'fetch_group_graph_data', controller: :groups, action: :bar_line_charts
  post 'fetch_group_projects', controller: :groups, action: :projects
  post 'fetch_group_loans', controller: :groups, action: :loans
  get 'own_guarantor/:guarantors/:user_id', controller: :loans, action: :own_guarantor
  get 'guarantor_limit/:guarantor_count/:loan_category', controller: :loans, action: :guarantor_limit

  resources :liabilities,
            :assets,
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
            :payment_methods

  devise_for :admins
  devise_for :users, controllers: { confirmations: 'confirmations' }, path: '',
                     path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }

  root 'home#index'

  get 'dashboard', controller: :dashboard, action: :index

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
