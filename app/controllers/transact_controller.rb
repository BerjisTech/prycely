# frozen_string_literal: true

class TransactController < ApplicationController
  before_action :authenticate_user!
  before_action :set_global, except: %i[conversions]
  skip_before_action :verify_authenticity_token, only: %i[conversions]

  def deposit
    # render json: @currencies
  end

  def withdraw; end

  def conversions
    amount = params[:amount].to_i
    origin = params[:origin].upcase
    recepient = params[:recepient].upcase

    Transact.request_amount if [0, ''].include?(amount)
    Transact.request_origin if origin.nil?
    Transact.request_recepient if recepient.nil?

    converted_amount = Concurrency.convert(amount, origin, recepient)
    fee = converted_amount * 0.01

    render json: Transact.format_conversion(amount, origin, recepient, converted_amount, fee)
  end

  def set_global
    @account = params[:account]
    @level = params[:level]
    @active_currency = Transact.active_currency(@level, @account)
    @active_flag = @active_currency[0...2].downcase
    @assets_path = 'https://assets.prycely.ams3.digitaloceanspaces.com/images/flags/'
    @currencies = Transact.all_currencies(Money::Currency.table)
    @acount_name = Transact.acount_name(@level, @account)
  end
end
