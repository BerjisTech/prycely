# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :set_dashboard
  before_action :check_default_wallets

  def index
    @recent_transactions = Dashboard.recent_transactions(current_user.id)
  end

  def join
    render json: params
  end

  def set_dashboard
    session[:user_id] = current_user.id
    user_id = session[:user_id]

    @account = Account.find_or_create_by(user_id: current_user.id)

    if @account.default_currency.nil?
      redirect_to edit_account_path(@account.id), notice: 'Choose a default currency to proceed'
    else
      @my_groups = Group.mine(user_id, 4)
      @my_invites = Invite.mine(user_id)
      @my_wallets = Wallet.mine(current_user.id, 4)
      @this_month_savings = User.range_savings(current_user.id, Date.today, 30)
      @user_loans = OpenStruct.new User.loans(current_user.id)

      @my_groups_numbers = OpenStruct.new Dashboard.group_numbers(current_user.id)
      @my_groups_savings = Dashboard.my_group_savings(@my_groups, current_user.id)
    end
  end

  def check_default_wallets
    if @account.default_currency.present?
      Wallet.find_or_create_by(user_id: current_user.id, currency: @account.default_currency.upcase)
    end
    Wallet.find_or_create_by(user_id: current_user.id, currency: 'USD')
    Wallet.find_or_create_by(user_id: current_user.id, currency: 'GBP')
    Wallet.find_or_create_by(user_id: current_user.id, currency: 'EUR')
  end
end
