# frozen_string_literal: true

class Transact < ApplicationRecord
  def self.convert(amount, _origin, _recepient)
    amount * Random.rand(10)/100
  end

  def self.format_conversion(amount, origin, recepient, converted_amount, fee)
    {
      status: 'done',
      message: 'All good',
      amount: amount,
      origin: origin.upcase,
      recepient: recepient.upcase,
      fee: fee,
      converted: converted_amount,
      time: DateTime.now.to_i,
      rate: 0
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
