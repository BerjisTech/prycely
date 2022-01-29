# frozen_string_literal: true

class Transact < ApplicationRecord
  include ActionView::Helpers::NumberHelper

  class << self
    def amount_from_cents(cents)
      cents / 100
    end

    def level_to_int(_level)
      if level = Digest::SHA1.hexdigest(1.to_s) # 2 group/ 1 personal
        1
      else
        2
      end
    end

    def acount_name(level, account)
      name = if level == Digest::SHA1.hexdigest(1.to_s)
               Group.find(account).name
             else
               "your #{Wallet.find(account).currency} wallet"
             end

      name.humanize
    end

    def active_currency(level, account)
      if level == Digest::SHA1.hexdigest(1.to_s)
        Group.find(account).currency
      else
        Wallet.find(account).currency
      end
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

    def format_conversion(amount, origin, recepient, converted_amount, fee)
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
        actual_amount: actual_amount.round(2)
      }
    end

    def request_amount
      {
        status: 'failed',
        message: 'Kindly add an amount',
        fee: 0,
        converted: 0,
        time: DateTime.now.to_i
      }
    end

    def request_origin
      {
        status: 'failed',
        message: 'We need an origin currency to perform the transaction',
        fee: 0,
        converted: 0,
        time: DateTime.now.to_i
      }
    end

    def request_recepient
      {
        status: 'failed',
        message: 'We need a recepient currency to perform the transaction',
        fee: 0,
        converted: 0,
        time: DateTime.now.to_i
      }
    end
  end
end
