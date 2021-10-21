# frozen_string_literal: true

class Currency < ApplicationRecord
  def self.amount_from_cents(cents)
    cents / 100
  end

  def self.calculate_and_convert(user_id, transaction)
    Concurrency.convert(amount_from_cents(transaction.amount.to_f) || 0, transaction.currency.downcase,
                        Account.find_by_user_id(user_id).default_currency.downcase)
  end
end
