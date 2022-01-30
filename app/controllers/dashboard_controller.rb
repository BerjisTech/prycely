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

  def load
    @data = Dashboard.load(params[:data_set], current_user.id)
    html_file = case params[:data_set]
                when 'groups'
                  '<%= render "dashboard/data/groups" %>'
                when 'wallets'
                  '<%= render "dashboard/data/wallets" %>'
                when 'invites'
                  '<%= render "dashboard/data/invites" %>'
                when 'requests'
                  '<%= render "dashboard/data/requests" %>'
                end
    render inline: html_file
  end

  def set_dashboard
    @account = Account.find_or_create_by(user_id: current_user.id)

    if @account.default_currency.nil?
      redirect_to edit_account_path(@account.id), notice: 'Choose a default currency to proceed'
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
