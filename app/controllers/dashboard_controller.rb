# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :set_dashboard
  before_action :check_default_wallets

  def index
    # render json: @wallets.map
  end

  def join
    render json: params
  end

  def set_dashboard
    session[:user_id] = current_user.id
    user_id = session[:user_id]

    @account = Account.where(user_id: current_user.id)
    @groups = Group.mine(user_id)
    @invites = Invite.mine(user_id)
    @wallets = Wallet.mine(current_user.id)
  end

  def check_default_wallets
    Wallet.find_or_create_by(user_id: current_user.id, currency: 'USD')
    Wallet.find_or_create_by(user_id: current_user.id, currency: 'GBP')
    Wallet.find_or_create_by(user_id: current_user.id, currency: 'EUR')
  end
end
