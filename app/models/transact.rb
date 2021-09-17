# frozen_string_literal: true

class Transact < ApplicationRecord
  include ActionView::Helpers::NumberHelper
  def self.format_conversion(amount, origin, recepient, converted_amount, fee)
    actual_amount = converted_amount - fee
    {
      status: 'done',
      message: 'All good',
      amount: amount.round(2),
      origin: origin.upcase,
      recepient: recepient.upcase,
      fee: fee.round(2),
      converted: converted_amount.round(2),
      time: DateTime.now.to_i,
      rate: Concurrency.conversion_rate(origin, recepient),
      actual_amount: actual_amount.round(2),
    }
  end

  def self.request_amount
    {
      status: 'failed',
      message: 'Kindly add an amount',
      fee: 0,
      converted: 0,
      time: DateTime.now.to_i
    }
  end

  def self.request_origin
    {
      status: 'failed',
      message: 'We need an origin currency to perform the transaction',
      fee: 0,
      converted: 0,
      time: DateTime.now.to_i
    }
  end

  def self.request_recepient
    {
      status: 'failed',
      message: 'We need a recepient currency to perform the transaction',
      fee: 0,
      converted: 0,
      time: DateTime.now.to_i
    }
  end
end
