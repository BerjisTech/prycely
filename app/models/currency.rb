# frozen_string_literal: true

class Currency < ApplicationRecord
  def self.amount_from_cents(cents)
    cents / 100
  end

  def self.calculate_and_convert(amount, origin, recepient)
    Concurrency.convert(amount, origin, recepient)
  end
end
