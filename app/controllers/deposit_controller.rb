# frozen_string_literal: true

class DepositController < ApplicationController
  before_action :authenticate_user!
  before_action :set_global, except: %i[conversions]
  skip_before_action :verify_authenticity_token, only: %i[conversions]

  def platform; end

  def mpesa; end

  def bank; end

  def set_global
    @account = params[:account]
    @level = params[:level]
    @amount = params[:amount]
    @origin = params[:origin].upcase
    @recepient = params[:recepient].upcase

    @active_currency = Transact.active_currency(@level, @account)
    @active_flag = @active_currency[0...2].downcase
    @assets_path = 'https://assets.prycely.com/images/flags/'
    @currencies = Transact.all_currencies(Money::Currency.table)
    @acount_name = Transact.acount_name(@level, @account)
  end
end
