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

    fee = amount * 0.01
    converted_amount = Transact.convert(amount, origin, recepient)

    render json: Transact.format_conversion(amount, origin, recepient, converted_amount, fee)
  end

  def all_currencies(hash)
    hash.keys
  end

  def major_currencies(hash)
    hash.each_with_object([]) do |(id, attributes), array|
      priority = attributes[:priority]
      if priority && priority < 10
        array[priority] ||= []
        array[priority] << id
      end
    end.compact.flatten
  end

  def set_global
    @account = params[:account]
    @level = params[:level]
    @active_currency = get_active_currency(@level, @account)
    @active_flag = @active_currency[0...2].downcase
    @assets_path = 'https://assets.prycely.com/images/flags/'
    @currencies = all_currencies(Money::Currency.table)
  end

  def get_active_currency(level, account)
    if level == Digest::SHA1.hexdigest(1.to_s)
      Group.find(account).currency
    else
      Wallet.find(account).currency
    end
  end
end
