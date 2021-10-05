# frozen_string_literal: true

class Currency < ApplicationRecord
  def self.amount_from_cents(cents)
    cents / 100
  end
end
