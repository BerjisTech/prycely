# frozen_string_literal: true

class DepositController < ApplicationController
  before_action :authenticate_user!
  before_action :set_global
  before_action :set_amount_currency, except: %i[amount_and_currency]
  skip_before_action :verify_authenticity_token, only: %i[conversions]

  def amount_and_currency
    @platform = params[:platform]
  end

  def mpesa; end

  def bank; end

  def paypal; end

  def set_amount_currency
    @amount = params[:amount]
    @origin = params[:origin].upcase
    @recepient = params[:recepient].upcase
  end

  def set_global
    @account = params[:account]
    @level = params[:level]

    @active_currency = Transact.active_currency(@level, @account)
    @active_flag = @active_currency[0...2].downcase
    @assets_path = 'https://assets.prycely.com/images/flags/'
    @currencies = Transact.all_currencies(Money::Currency.table)
    @account_name = Transact.acount_name(@level, @account)
  end
end
